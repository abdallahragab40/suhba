import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/undo_snack_bar.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/shared/content/domain/content_target.dart';
import 'package:siyar_sahaba/shared/content/presentation/target_description.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// Unfinished sections and chapters, most recent first. Renders nothing
/// when there are none.
class ContinueReadingList extends ConsumerWidget {
  const ContinueReadingList({this.limit = 3, this.header, super.key});

  final int limit;

  /// Shown above the list when it is not empty.
  final Widget? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(inProgressProvider).value ?? const [];
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?header,
        for (final p in items.take(limit))
          ContinueReadingTile(key: ValueKey(p.targetId), progress: p),
      ],
    );
  }
}

/// One unfinished passage: its title, where it belongs, and how far the
/// reader got. While its content loads it keeps its place; if the content
/// fails to load it offers a retry. A passage removed from the content is
/// not shown (its position is deleted by the content reconciliation, never
/// from here).
class ContinueReadingTile extends ConsumerWidget {
  const ContinueReadingTile({required this.progress, super.key});

  final ReadingProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final p = progress;
    final lookup = ref.watch(targetLookupProvider(p.contentTarget));

    final (String title, String parent, String route) = switch (lookup) {
      AsyncData(:final value) => switch (describeTarget(context, value)) {
        final d? => (d.title, d.parent ?? '', d.route),
        null => ('', '', ''),
      },
      AsyncError() => (l10n.savedItemLoadError, '', ''),
      _ => (l10n.savedItemLoading, '', ''),
    };
    if (lookup case AsyncData(value: TargetMissing())) {
      return const SizedBox.shrink();
    }
    if (route.isEmpty) {
      return Card(
        margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
        child: ListTile(
          title: Text(title, style: TextStyle(color: colors.onSurfaceDim)),
          trailing: lookup is AsyncError
              ? IconButton(
                  tooltip: l10n.retry,
                  icon: const Icon(Icons.refresh),
                  onPressed: () =>
                      ref.invalidate(targetLookupProvider(p.contentTarget)),
                )
              : null,
        ),
      );
    }

    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(route),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          parent,
                          style: SahabaTextStyles.of(context).kicker,
                        ),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.continueRemove,
                    icon: const Icon(Icons.close),
                    onPressed: () => resetProgress(context, ref, p, title),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: p.fraction,
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2),
                      color: colors.accent,
                      backgroundColor: colors.line,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    l10n.progressRead(
                      format.percent((p.fraction * 100).round()),
                    ),
                    style: SahabaTextStyles.of(context).kicker,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Forgets the position in one passage (and only that one), offering to
/// put it back exactly as it was.
Future<void> resetProgress(
  BuildContext context,
  WidgetRef ref,
  ReadingProgress progress,
  String title,
) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final l10n = AppLocalizations.of(context);
  final repository = ref.read(readingProgressRepositoryProvider);
  try {
    await repository.remove(progress.target, progress.targetId);
  } on Object {
    messenger?.showSnackBar(SnackBar(content: Text(l10n.progressSaveFailed)));
    return;
  }
  showUndoSnackBar(
    messenger,
    l10n,
    message: l10n.historyResetDone(title),
    onUndo: () => repository.restore(progress),
  );
}
