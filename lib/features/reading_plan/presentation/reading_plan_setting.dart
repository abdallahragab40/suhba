import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/feedback/haptics.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/reading_plan/domain/reading_plan.dart';
import 'package:suhba/features/reading_plan/presentation/reading_plan_providers.dart';

/// Settings: the daily Seerah pace (review K3). No plan, or one, two or
/// three chapters a day.
class ReadingPlanSetting extends ConsumerWidget {
  const ReadingPlanSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final plan = ref.watch(readingPlanProvider);
    final selected = plan.value?.pace ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.planTitle),
        Text(
          l10n.planNote,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
        ),
        const SizedBox(height: AppSpacing.xs),
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(value: 0, label: Text(l10n.planNone)),
            for (final pace in ReadingPlan.paces)
              ButtonSegment(
                value: pace,
                label: Text(l10n.planPace(pace, format.integer(pace))),
              ),
          ],
          selected: {selected},
          onSelectionChanged: plan.hasValue
              ? (s) {
                  Haptics.selection(context);
                  final pace = s.single;
                  ref
                      .read(readingPlanActionsProvider)
                      .setPace(pace == 0 ? null : pace);
                }
              : null,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
