import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/database/database_provider.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/reading_progress/data/drift_reading_progress_repository.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/progress_recorder.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/shared/content/domain/passage_position.dart';
import 'package:siyar_sahaba/shared/content/presentation/reader_scaffold.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

final readingProgressRepositoryProvider = Provider<ReadingProgressRepository>(
  (ref) => DriftReadingProgressRepository(ref.watch(appDatabaseProvider)),
);

/// The saved position in one section or chapter.
final progressProvider = StreamProvider.autoDispose
    .family<ReadingProgress?, (ProgressTarget, String)>(
      (ref, key) =>
          ref.watch(readingProgressRepositoryProvider).watch(key.$1, key.$2),
    );

/// Positions in the passages of one work, by passage id: a companion's
/// sections (`ProgressTarget.section`) or a story's chapters.
final workProgressProvider = StreamProvider.autoDispose
    .family<Map<String, ReadingProgress>, (ProgressTarget, String)>(
      (ref, key) => ref
          .watch(readingProgressRepositoryProvider)
          .watchForParent(key.$1, key.$2)
          .map((list) => {for (final p in list) p.targetId: p}),
    );

/// Finished passages, most recently finished first.
final completedProgressProvider = StreamProvider<List<ReadingProgress>>(
  (ref) => ref.watch(readingProgressRepositoryProvider).watchCompleted(),
);

/// Every position, finished or not.
final allProgressProvider = StreamProvider<List<ReadingProgress>>(
  (ref) => ref.watch(readingProgressRepositoryProvider).watchAll(),
);

/// Unfinished reading, most recent first.
final inProgressProvider = StreamProvider<List<ReadingProgress>>(
  (ref) => ref.watch(readingProgressRepositoryProvider).watchInProgress(),
);

/// A [ReaderScaffold] that restores the saved position on open and records
/// the reader's progress (batched, and flushed when leaving or when the app
/// goes to the background).
///
/// Positions are anchored to blocks (see `PassagePosition`), so they resume
/// at the same text after a change of text size or orientation. A position
/// saved against an older text of the passage (its [revision] changed) is
/// not restored silently: the passage opens at the top and a notice offers
/// to return to the old position.
///
/// A [PassageCompletion] among [children] lets the reader finish the
/// passage or start it again.
class TrackedReaderScaffold extends ConsumerStatefulWidget {
  const TrackedReaderScaffold({
    required this.target,
    required this.targetId,
    required this.revision,
    required this.parentId,
    required this.title,
    required this.children,
    this.actions = const [],
    super.key,
  });

  final ProgressTarget target;
  final String targetId;

  /// The passage's current content revision.
  final String revision;
  final String parentId;
  final String title;
  final List<Widget> actions;
  final List<Widget> children;

  @override
  ConsumerState<TrackedReaderScaffold> createState() =>
      _TrackedReaderScaffoldState();
}

class _TrackedReaderScaffoldState extends ConsumerState<TrackedReaderScaffold>
    with WidgetsBindingObserver {
  final _reader = GlobalKey<ReaderScaffoldState>();
  late final ProgressRecorder _recorder;
  late final ReadingProgressRepository _repository;

  /// Captured during build: the final save runs in dispose, where `ref` may
  /// no longer be used.
  String _contentVersion = 'unknown';
  ScaffoldMessengerState? _messenger;
  String _saveFailedMessage = '';
  bool _noticeShown = false;

  @override
  void initState() {
    super.initState();
    // Read once: saves must keep working while the page is being disposed.
    _repository = ref.read(readingProgressRepositoryProvider);
    final clock = ref.read(clockProvider);
    _recorder = ProgressRecorder(
      save: (position, completed) => _repository.save(
        ReadingProgress(
          target: widget.target,
          targetId: widget.targetId,
          parentId: widget.parentId,
          fraction: position.fraction,
          completed: completed,
          contentVersion: _contentVersion,
          updatedAt: clock(),
          targetRevision: widget.revision,
          blockIndex: position.blockIndex,
          blockOffset: position.blockOffset,
        ),
      ),
      onError: _reportSaveFailure,
    );
    WidgetsBinding.instance.addObserver(this);
  }

  void _reportSaveFailure(Object error, StackTrace stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'reading progress',
      ),
    );
    _messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(_saveFailedMessage)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _messenger = ScaffoldMessenger.maybeOf(context);
    _saveFailedMessage = AppLocalizations.of(context).progressSaveFailed;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) _recorder.flush();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _recorder.flush();
    super.dispose();
  }

  /// Finishes the passage where the reader is now.
  Future<void> _markCompleted() async {
    final position = _reader.currentState?.currentPosition();
    if (position != null) _recorder.report(position);
    await _recorder.markCompleted();
  }

  /// Forgets the passage's progress and goes back to its start.
  Future<void> _restart() async {
    _recorder.reset();
    _reader.currentState?.jumpToPosition(PassagePosition.start);
    try {
      await _repository.remove(widget.target, widget.targetId);
    } on Object catch (error, stackTrace) {
      _reportSaveFailure(error, stackTrace);
    }
  }

  /// Tells the reader the text changed since their last visit, once, with
  /// a way back to where they were.
  void _showChangedNotice(PassagePosition old) {
    if (_noticeShown) return;
    _noticeShown = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      _messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l10n.readerPassageChanged),
            duration: const Duration(seconds: 8),
            action: SnackBarAction(
              label: l10n.readerRestorePosition,
              // Block anchors belong to the old text: use the fraction.
              onPressed: () =>
                  _reader.currentState?.jumpToFraction(old.fraction),
            ),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final manifest = ref.watch(contentManifestProvider);
    _contentVersion = manifest.value?.contentVersion ?? _contentVersion;
    final saved = ref.watch(progressProvider((widget.target, widget.targetId)));

    // Wait for the saved position and the content build before restoring.
    PassagePosition? initial;
    if (saved.hasValue && (manifest.hasValue || manifest.hasError)) {
      final progress = saved.value;
      if (progress == null) {
        initial = PassagePosition.start;
      } else if (progress.fitFor(
            revision: widget.revision,
            contentVersion: manifest.value?.contentVersion,
          ) ==
          PositionFit.current) {
        initial = progress.position;
      } else {
        initial = PassagePosition.start;
        if (progress.fraction > 0) _showChangedNotice(progress.position);
      }
    }

    return _TrackedReader(
      target: widget.target,
      targetId: widget.targetId,
      markCompleted: _markCompleted,
      restart: _restart,
      child: ReaderScaffold(
        key: _reader,
        title: widget.title,
        actions: widget.actions,
        initialPosition: initial,
        onProgress: _recorder.report,
        children: widget.children,
      ),
    );
  }
}

class _TrackedReader extends InheritedWidget {
  const _TrackedReader({
    required this.target,
    required this.targetId,
    required this.markCompleted,
    required this.restart,
    required super.child,
  });

  final ProgressTarget target;
  final String targetId;
  final Future<void> Function() markCompleted;
  final Future<void> Function() restart;

  @override
  bool updateShouldNotify(_TrackedReader old) =>
      old.target != target || old.targetId != targetId;
}

/// The end-of-passage control in a [TrackedReaderScaffold]: "I finished
/// reading" until the passage is finished, then "read it again". This is
/// how a passage too short to scroll gets finished, since opening it does
/// not count.
class PassageCompletion extends ConsumerWidget {
  const PassageCompletion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = context.dependOnInheritedWidgetOfExactType<_TrackedReader>();
    if (reader == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final completed =
        ref
            .watch(progressProvider((reader.target, reader.targetId)))
            .value
            ?.completed ??
        false;

    if (!completed) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: OutlinedButton.icon(
          onPressed: reader.markCompleted,
          icon: const Icon(Icons.check),
          label: Text(l10n.readerMarkComplete),
        ),
      );
    }
    return Row(
      children: [
        Icon(Icons.check_circle, color: colors.accent),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Semantics(liveRegion: true, child: Text(l10n.readerCompleted)),
        ),
        TextButton(
          onPressed: reader.restart,
          child: Text(l10n.readerReadAgain),
        ),
      ],
    );
  }
}
