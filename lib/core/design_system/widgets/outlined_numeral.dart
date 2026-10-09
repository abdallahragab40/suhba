import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';

/// A large stroked numeral (a Hijri year or an ordinal) used as ornament.
///
/// Purely decorative: hidden from screen readers and not affected by the
/// text scale, since its size is part of the layout.
class OutlinedNumeral extends StatelessWidget {
  const OutlinedNumeral(
    this.value, {
    this.size = 120,
    this.strokeWidth = 1.5,
    this.color,
    super.key,
  });

  final int value;
  final double size;
  final double strokeWidth;

  /// Defaults to the decorative gold accent.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final numeral = SahabaTextStyles.of(context).numeral;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.round
      ..color = color ?? SahabaColors.of(context).accent;

    return ExcludeSemantics(
      child: Text(
        DisplayFormatter.of(context).integer(value),
        textScaler: TextScaler.noScaling,
        style: TextStyle(
          fontFamily: numeral.fontFamily,
          fontWeight: numeral.fontWeight,
          fontFeatures: numeral.fontFeatures,
          height: 1,
          letterSpacing: 0,
          fontSize: size,
          foreground: paint,
        ),
      ),
    );
  }
}
