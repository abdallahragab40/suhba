import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';

/// How far a reader got in one passage: a check when finished, the share
/// read when started, nothing otherwise. Spoken as such.
class PassageProgressMarker extends StatelessWidget {
  const PassageProgressMarker({required this.progress, super.key});

  final ReadingProgress? progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final p = progress;
    if (p == null) return const SizedBox.shrink();
    if (p.completed) {
      return Icon(
        Icons.check_circle,
        size: 20,
        color: colors.accent,
        semanticLabel: l10n.passageFinished,
      );
    }
    if (p.fraction <= 0) return const SizedBox.shrink();
    final percent = DisplayFormatter.of(
      context,
    ).percent((p.fraction * 100).round());
    return Semantics(
      label: l10n.progressRead(percent),
      excludeSemantics: true,
      child: Text(
        percent,
        style: SuhbaTextStyles.of(
          context,
        ).kicker.copyWith(color: colors.accentText),
      ),
    );
  }
}

/// One passage in a contents list.
typedef ContentsEntry = ({String id, String title, String route});

/// The reader's "contents" button: a sheet listing the work's passages
/// with progress, the open one marked; choosing another replaces the
/// current reader (its position is saved on the way out).
class PassageContentsButton extends StatelessWidget {
  const PassageContentsButton({
    required this.label,
    required this.target,
    required this.parentId,
    required this.currentId,
    required this.entries,
    super.key,
  });

  /// Tooltip and sheet title.
  final String label;
  final ProgressTarget target;
  final String parentId;
  final String currentId;
  final List<ContentsEntry> entries;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: label,
    icon: const Icon(Icons.toc),
    onPressed: () => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => _ContentsSheet(
        label: label,
        target: target,
        parentId: parentId,
        currentId: currentId,
        entries: entries,
        onOpen: (route) {
          Navigator.of(sheetContext).pop();
          context.replace(route);
        },
      ),
    ),
  );
}

class _ContentsSheet extends ConsumerWidget {
  const _ContentsSheet({
    required this.label,
    required this.target,
    required this.parentId,
    required this.currentId,
    required this.entries,
    required this.onOpen,
  });

  final String label;
  final ProgressTarget target;
  final String parentId;
  final String currentId;
  final List<ContentsEntry> entries;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final progress =
        ref.watch(workProgressProvider((target, parentId))).value ?? const {};

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.xl,
        ),
        children: [
          Semantics(
            header: true,
            child: Text(label, style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final (i, e) in entries.indexed)
            ListTile(
              contentPadding: EdgeInsets.zero,
              selected: e.id == currentId,
              selectedColor: colors.accentText,
              leading: ExcludeSemantics(child: Text(format.padded(i + 1))),
              title: Text(e.title),
              subtitle: e.id == currentId ? Text(l10n.readerReadingNow) : null,
              trailing: PassageProgressMarker(progress: progress[e.id]),
              onTap: e.id == currentId
                  ? () => Navigator.of(context).pop()
                  : () => onOpen(e.route),
            ),
        ],
      ),
    );
  }
}
