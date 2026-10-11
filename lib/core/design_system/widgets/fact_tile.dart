import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';

/// One "at a glance" fact: a label, its value, and how it is established
/// (a reliability badge and a citation marker).
class FactTile extends StatelessWidget {
  const FactTile({
    required this.label,
    required this.value,
    this.badge,
    this.marker,
    super.key,
  });

  final String label;
  final String value;
  final Widget? badge;
  final Widget? marker;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final badge = this.badge;
    final marker = this.marker;
    return Container(
      padding: const EdgeInsetsDirectional.only(
        top: AppSpacing.sm,
        bottom: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: colors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: SuhbaTextStyles.of(context).kicker),
          const SizedBox(height: AppSpacing.xxs),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
          if (badge != null || marker != null)
            Row(
              children: [
                if (badge != null) Flexible(child: badge),
                ?marker,
              ],
            ),
        ],
      ),
    );
  }
}
