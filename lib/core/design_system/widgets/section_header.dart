import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/format/display_formatter.dart';

/// A hairline, then a gold index (٠١) and kicker, then the section title.
///
/// The reference site's section head, set for mobile.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.index,
    this.kicker,
    this.note,
    super.key,
  });

  final String title;

  /// Shown zero-padded in the current digit style. Decorative: the title
  /// carries the meaning, so the index is hidden from screen readers.
  final int? index;

  final String? kicker;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final styles = SuhbaTextStyles.of(context);
    final colors = SuhbaColors.of(context);
    final index = this.index;
    final kicker = this.kicker;
    final note = this.note;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        const SizedBox(height: AppSpacing.sm),
        if (index != null || kicker != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (index != null)
                ExcludeSemantics(
                  child: Text(
                    DisplayFormatter.of(context).padded(index),
                    style: styles.kicker.copyWith(color: colors.accentText),
                  ),
                ),
              if (index != null && kicker != null)
                const SizedBox(width: AppSpacing.xs),
              if (kicker != null)
                Flexible(child: Text(kicker, style: styles.kicker)),
            ],
          ),
        const SizedBox(height: AppSpacing.xxs),
        Semantics(
          header: true,
          child: Text(title, style: textTheme.headlineMedium),
        ),
        if (note != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            note,
            style: textTheme.bodyLarge?.copyWith(color: colors.onSurfaceDim),
          ),
        ],
      ],
    );
  }
}
