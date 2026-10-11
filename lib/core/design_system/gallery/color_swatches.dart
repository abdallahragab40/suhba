import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';

/// The semantic colors of the current theme, each with a text sample.
class ColorSwatches extends StatelessWidget {
  const ColorSwatches({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    final swatches = <(String, Color, Color)>[
      ('surface / onSurface', scheme.surface, scheme.onSurface),
      ('surfaceAlt / onSurfaceDim', colors.surfaceAlt, colors.onSurfaceDim),
      ('primary / onPrimary', scheme.primary, scheme.onPrimary),
      ('surface / accentText', scheme.surface, colors.accentText),
      ('surface / established', scheme.surface, colors.established),
      ('surface / disputed', scheme.surface, colors.disputed),
      ('draftSurface / draft', colors.draftSurface, colors.draft),
      ('accent (decorative)', colors.accent, scheme.surface),
    ];

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final (name, background, foreground) in swatches)
          Container(
            width: 160,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: background,
              borderRadius: const BorderRadius.all(AppRadii.sm),
              border: Border.all(color: colors.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أبجد ١٢٣',
                  style: textTheme.titleMedium?.copyWith(color: foreground),
                ),
                Text(
                  name,
                  style: textTheme.labelSmall?.copyWith(color: foreground),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
