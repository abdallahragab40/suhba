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

/// The app's mark: the name "صحبة" (companionship, the bond that makes a
/// Companion) as a calligraphic word mark in Amiri, gold on ink, with a
/// small eight-pointed star (khatam, as in the app's lattice) above it.
/// The vowel marks are left off so the word reads cleanly at icon sizes.
/// Lettering and geometry only, with no figures (decision D5).
void paintBrandMark(
  Canvas canvas,
  Size size,
  BrandMarkLayout layout, {
  String fontFamily = AppFonts.amiri,
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
  // layers are 108 dp with a 66 dp safe circle, so the word stays inside.
  final box =
      s *
      switch (layout) {
        BrandMarkLayout.square => 0.74,
        BrandMarkLayout.roundedSquare => 0.66,
        BrandMarkLayout.disc => 0.62,
        BrandMarkLayout.adaptiveForeground ||
        BrandMarkLayout.monochrome => 0.54,
      };

  // The word, sized so its width fills the box.
  TextPainter word(double fontSize) => TextPainter(
    text: TextSpan(
      text: 'صحبة',
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        height: 1,
        color: gold,
      ),
    ),
    textDirection: TextDirection.rtl,
  )..layout();
  final probe = word(100);
  final name = word(100 * box / probe.width);
  final top = centre.dy - name.height / 2 + box * 0.08;
  name.paint(canvas, Offset(centre.dx - name.width / 2, top));

  // The star above the word.
  canvas.drawPath(
    _star(Offset(centre.dx, centre.dy - box * 0.36), box * 0.07),
    Paint()
      ..color = gold
      ..isAntiAlias = true,
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
