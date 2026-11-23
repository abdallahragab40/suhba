import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/undo_snack_bar.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/reading_progress/domain/continue_items.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_label.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/presentation/target_description.dart';
import 'package:suhba/shared/content/providers.dart';

/// Where reading can be picked up, most recent first: unfinished sections
/// and chapters, and the next passage of each biography, story or the
/// Seerah read in part (see [continueReadingProvider]). Renders nothing
/// when there are none.
class ContinueReadingList extends ConsumerWidget {
  const ContinueReadingList({this.limit = 3, this.header, super.key});

  final int limit;

  /// Shown above the list when it is not empty.
  final Widget? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(continueReadingProvider).value ?? const [];
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?header,
        for (final item in items.take(limit))
          switch (item.progress) {
            final p? => ContinueReadingTile(
              key: ValueKey(p.targetId),
              progress: p,
            ),
            null => NextPassageTile(key: ValueKey(item.passageId), item: item),
          },
      ],
    );
  }
}

/// The next passage of a work read in part: its title, what it belongs
/// to, and «التالي» where an unfinished passage shows how far it was read.
/// Like [ContinueReadingTile], it keeps its place while its content loads,
/// and is not shown if the passage left the content.
class NextPassageTile extends ConsumerWidget {
  const NextPassageTile({required this.item, super.key});

  final ContinueItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final lookup = ref.watch(targetLookupProvider(item.contentTarget));
    if (lookup case AsyncData(value: TargetMissing())) {
      return const SizedBox.shrink();
    }
    final description = switch (lookup) {
      AsyncData(:final value) => describeTarget(context, value),
      _ => null,
    };
    if (description == null) {
      return Card(
        margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
        child: ListTile(
          title: Text(
            lookup is AsyncError
                ? l10n.savedItemLoadError
                : l10n.savedItemLoading,
            style: TextStyle(color: colors.onSurfaceDim),
          ),
          trailing: lookup is AsyncError
              ? IconButton(
                  tooltip: l10n.retry,
                  icon: const Icon(Icons.refresh),
                  onPressed: () =>
                      ref.invalidate(targetLookupProvider(item.contentTarget)),
                )
              : null,
        ),
      );
    }
    final d = description;
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(d.route),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.parent ?? '',
                      style: SuhbaTextStyles.of(context).kicker,
                    ),
                    Text(
                      d.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.continueNext,
                style: SuhbaTextStyles.of(
                  context,
                ).kicker.copyWith(color: colors.accentText),
              ),
              Icon(Icons.chevron_right, color: colors.accentText),
            ],
          ),
        ),
      ),
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
    final colors = SuhbaColors.of(context);
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
                        Text(parent, style: SuhbaTextStyles.of(context).kicker),
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
                  // The percentage beside it says it, in the reader's
                  // digits; the bar would add a bare Western one.
                  Expanded(
                    child: ExcludeSemantics(
                      child: LinearProgressIndicator(
                        value: p.fraction,
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(2),
                        color: colors.accent,
                        backgroundColor: colors.line,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    readProgressLabel(l10n, format, p.fraction),
                    style: SuhbaTextStyles.of(context).kicker,
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
