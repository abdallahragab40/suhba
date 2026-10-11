import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/visuals/presentation/timeline_chart.dart';

/// Periods as bands along one time axis, each as long as it lasted, in
/// reading order (earliest at the start, the right in Arabic). Lengths
/// follow the recorded dates; a band never shrinks to nothing, and
/// differently shaded bands are also labelled, so colour carries no
/// meaning on its own.
class PeriodBands extends StatelessWidget {
  const PeriodBands({required this.bands, this.onSelected, super.key});

  final List<PeriodBand> bands;
  final ValueChanged<PeriodBand>? onSelected;

  @override
  Widget build(BuildContext context) {
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final kicker = SuhbaTextStyles.of(context).kicker;
    final measured = [
      for (final b in bands)
        if (b.date.sortKey case final start?)
          (b, start, math.max(endKey(b.date) ?? start, start)),
    ];
    if (measured.isEmpty) return const SizedBox.shrink();
    final total = measured.fold<double>(
      0,
      (sum, m) => sum + math.max(m.$3 - m.$2, 0.0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ExcludeSemantics(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(AppRadii.sm),
            child: SizedBox(
              height: 28,
              child: Row(
                children: [
                  for (final (i, (_, start, end)) in measured.indexed)
                    Builder(
                      builder: (context) {
                        final fill = Color.lerp(
                          colors.accent,
                          colors.surfaceAlt,
                          i / math.max(measured.length, 2) * 0.8,
                        )!;
                        final dark =
                            ThemeData.estimateBrightnessForColor(fill) ==
                            Brightness.dark;
                        return Expanded(
                          // At least a sliver, so short periods stay visible.
                          flex: math.max(
                            1,
                            ((end - start) / math.max(total, 1) * 1000).round(),
                          ),
                          child: Container(
                            color: fill,
                            alignment: Alignment.center,
                            child: Text(
                              format.integer(i + 1),
                              style: kicker.copyWith(
                                color: dark ? Palette.paper : Palette.ink,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final (i, (band, _, _)) in measured.indexed)
          InkWell(
            onTap: onSelected == null ? null : () => onSelected!(band),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      format.integer(i + 1),
                      style: kicker.copyWith(color: colors.accentText),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          band.label.of(context),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(format.historicalDate(band.date), style: kicker),
                        if (band.note case final note?)
                          Text(
                            note.of(context),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
