import 'dart:math' as math;

import 'package:flutter/painting.dart';
import 'package:siyar_sahaba/core/design_system/tokens/fonts.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';

/// How the mark is laid out on its canvas.
enum BrandMarkLayout {
  /// Opaque ink square, full bleed: iOS icons (the OS rounds the corners).
  square,

  /// Ink rounded square on transparent: legacy Android launcher icons.
  roundedSquare,

  /// Gold mark on transparent, inside the adaptive-icon safe zone.
  adaptiveForeground,

  /// White mark on transparent, inside the safe zone: Android 13 themed icons.
  monochrome,

  /// Ink disc with the mark, on transparent: launch screens.
  disc,
}

/// The app's mark: a pointed arch (as of a mihrab or a gate), with an
/// eight-pointed star (khatam, as in the app's lattice) in its crown and
/// the name "سِيَر" in Cairo on its threshold (its vowel marks sit close
/// to the letters at icon sizes). Geometry and lettering only,
/// with no figures (decision D5).
void paintBrandMark(
  Canvas canvas,
  Size size,
  BrandMarkLayout layout, {
  String fontFamily = AppFonts.cairo,
}) {
  final s = size.shortestSide;
  final centre = size.center(Offset.zero);
  final gold = layout == BrandMarkLayout.monochrome
      ? const Color(0xFFFFFFFF)
      : Palette.goldOnInk;

  switch (layout) {
    case BrandMarkLayout.square:
      canvas.drawRect(Offset.zero & size, Paint()..color = Palette.ink);
    case BrandMarkLayout.roundedSquare:
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: centre, width: s * 0.92, height: s * 0.92),
          Radius.circular(s * 0.2),
        ),
        Paint()..color = Palette.ink,
      );
    case BrandMarkLayout.disc:
      canvas.drawCircle(centre, s / 2, Paint()..color = Palette.ink);
    case BrandMarkLayout.adaptiveForeground || BrandMarkLayout.monochrome:
      break;
  }

  // The box the mark is drawn in, as a share of the canvas. The adaptive
  // layers are 108 dp with a 66 dp safe circle, so the arch stays inside.
  final box =
      s *
      switch (layout) {
        BrandMarkLayout.square => 0.80,
        BrandMarkLayout.roundedSquare => 0.70,
        BrandMarkLayout.disc => 0.66,
        BrandMarkLayout.adaptiveForeground ||
        BrandMarkLayout.monochrome => 0.48,
      };

  // The arch: straight jambs, then two arcs meeting at a point.
  final width = box * 0.66;
  final bottom = centre.dy + box * 0.46;
  final spring = centre.dy - box * 0.02;
  final left = centre.dx - width / 2;
  final right = centre.dx + width / 2;
  final radius = width * 0.74;
  Path arch(double inset) {
    final l = left + inset;
    final r = right - inset;
    final rad = Radius.circular(radius - inset);
    final apexY =
        spring -
        math.sqrt(
          math.pow(radius - inset, 2) -
              math.pow(radius - inset - (r - l) / 2, 2),
        );
    return Path()
      ..moveTo(l, bottom - inset * 0.4)
      ..lineTo(l, spring)
      ..arcToPoint(Offset(centre.dx, apexY), radius: rad)
      ..arcToPoint(Offset(r, spring), radius: rad)
      ..lineTo(r, bottom - inset * 0.4);
  }

  final stroke = Paint()
    ..color = gold
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round
    ..strokeWidth = box * 0.045
    ..isAntiAlias = true;
  canvas
    ..drawPath(arch(0), stroke)
    ..drawPath(arch(box * 0.075), stroke..strokeWidth = box * 0.018)
    // The threshold.
    ..drawLine(
      Offset(left - box * 0.08, bottom),
      Offset(right + box * 0.08, bottom),
      stroke..strokeWidth = box * 0.045,
    );

  // The star in the crown.
  canvas.drawPath(
    _star(Offset(centre.dx, spring - box * 0.14), box * 0.085),
    Paint()
      ..color = gold
      ..isAntiAlias = true,
  );

  final name = TextPainter(
    text: TextSpan(
      text: 'سِيَر',
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: box * 0.25,
        height: 1.2,
        color: gold,
      ),
    ),
    textDirection: TextDirection.rtl,
  )..layout();
  name.paint(
    canvas,
    Offset(
      centre.dx - name.width / 2,
      (spring + bottom) / 2 - name.height / 2 + box * 0.02,
    ),
  );
}

/// A {8/2} star: two squares, one turned 45°, traced as one outline.
Path _star(Offset c, double outer) {
  final inner = outer * math.cos(math.pi / 4) / math.cos(math.pi / 8);
  final path = Path();
  for (var i = 0; i < 16; i++) {
    final angle = -math.pi / 2 + i * math.pi / 8;
    final r = i.isEven ? outer : inner;
    final p = c + Offset(math.cos(angle) * r, math.sin(angle) * r);
    i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
  }
  return path..close();
}
