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

/// The app's mark: an eight-pointed star (khatam, as in the app's lattice)
/// framing the name "سِيَر" in Amiri. Geometry and lettering only, with no
/// figures (decision D5).
void paintBrandMark(Canvas canvas, Size size, BrandMarkLayout layout) {
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

  // Outer radius of the star as a share of the canvas. The adaptive layers
  // are 108 dp with a 66 dp safe circle, so the star must stay within it.
  final outer =
      s *
      switch (layout) {
        BrandMarkLayout.square => 0.40,
        BrandMarkLayout.roundedSquare => 0.36,
        BrandMarkLayout.disc => 0.40,
        BrandMarkLayout.adaptiveForeground ||
        BrandMarkLayout.monochrome => 0.29,
      };

  final stroke = Paint()
    ..color = gold
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.miter
    ..strokeWidth = outer * 0.06
    ..isAntiAlias = true;
  canvas.drawPath(_star(centre, outer), stroke);
  canvas.drawPath(
    _star(centre, outer * 0.84),
    stroke..strokeWidth = outer * 0.025,
  );

  final name = TextPainter(
    text: TextSpan(
      text: 'سِيَر',
      style: TextStyle(
        fontFamily: AppFonts.amiri,
        fontWeight: FontWeight.w700,
        fontSize: outer * 0.8,
        height: 1,
        color: gold,
      ),
    ),
    textDirection: TextDirection.rtl,
  )..layout();
  // Amiri's ascent is tall; nudge the word down to sit optically centred.
  name.paint(
    canvas,
    centre - Offset(name.width / 2, name.height / 2 - outer * 0.06),
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
