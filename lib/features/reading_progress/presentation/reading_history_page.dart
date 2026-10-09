import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/continue_reading.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/shared/content/domain/content_target.dart';
import 'package:siyar_sahaba/shared/content/presentation/target_description.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// Finished reading, most recent first (E10). Each passage opens again, or
/// its progress can be reset on its own, with undo.
class ReadingHistoryPage extends ConsumerWidget {
  const ReadingHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(completedProgressProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.historyTitle)),
      body: switch (history) {
        AsyncData(:final value) when value.isEmpty => EmptyState(
          icon: Icons.history,
          title: l10n.historyEmpty,
        ),
        AsyncData(:final value) => ListView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          children: [
            for (final p in value)
              _HistoryTile(key: ValueKey(p.targetId), progress: p),
          ],
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(completedProgressProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(),
        ),
      },
    );
  }
}

class _HistoryTile extends ConsumerWidget {
  const _HistoryTile({required this.progress, super.key});

  final ReadingProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final p = progress;
    final lookup = ref.watch(targetLookupProvider(p.contentTarget));

    final description = switch (lookup) {
      AsyncData(:final value) => describeTarget(context, value),
      _ => null,
    };
    final (String? title, String? parent, String? route) = (
      description?.title,
      description?.parent,
      description?.route,
    );
    // Gone from the content: the content reconciliation removes it.
    if (lookup case AsyncData(value: TargetMissing())) {
      return const SizedBox.shrink();
    }

    final d = p.updatedAt;
    final date = format.digits('${d.day}/${d.month}/${d.year}');
    final dim = TextStyle(color: colors.onSurfaceDim);

    return ListTile(
      leading: Icon(Icons.check_circle, color: colors.accent),
      title: Text(
        title ??
            (lookup is AsyncError
                ? l10n.savedItemLoadError
                : l10n.savedItemLoading),
      ),
      subtitle: Text(
        [?parent, l10n.historyFinishedOn(date)].join(' · '),
        style: dim,
      ),
      onTap: route == null ? null : () => context.push(route),
      trailing: IconButton(
        tooltip: l10n.historyReset,
        icon: const Icon(Icons.restart_alt),
        onPressed: () => resetProgress(context, ref, p, title ?? ''),
      ),
    );
  }
}
