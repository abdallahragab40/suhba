import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/geometric_pattern.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/design_system/widgets/outlined_numeral.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/section_header.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';

/// The core design-system widgets with sample data, for the gallery and
/// the golden tests. Sample text is neutral placeholder text.
class CoreWidgetsSpecimen extends StatelessWidget {
  const CoreWidgetsSpecimen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SahabaColors.of(context);
    // Empty and error states fill their parent; give them room that grows
    // with the text scale.
    final stateHeight = MediaQuery.textScalerOf(context).scale(300);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader(
          index: 1,
          kicker: 'السيرة',
          title: 'النشأة والإسلام',
          note: 'ملاحظة تجريبية تحت عنوان القسم.',
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final r in Reliability.values) ReliabilityBadge(r),
            for (final r in Reliability.values)
              ReliabilityBadge(r, provisional: true),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          height: 160,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colors.surfaceAlt,
            borderRadius: const BorderRadius.all(AppRadii.lg),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: GeometricPattern(
                  color: colors.accent.withValues(alpha: 0.3),
                ),
              ),
              const PositionedDirectional(
                end: AppSpacing.md,
                bottom: AppSpacing.xs,
                child: OutlinedNumeral(13),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const LoadingSkeleton(),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          height: stateHeight,
          child: const EmptyState(
            icon: Icons.bookmark_border,
            title: 'لا توجد محفوظات بعد',
            message: 'رسالة تجريبية لحالة القائمة الفارغة.',
          ),
        ),
        SizedBox(
          height: stateHeight,
          child: ErrorView(onRetry: () {}),
        ),
      ],
    );
  }
}
