import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';

/// The kinds of landscape the app draws. All are original vector
/// compositions: land, sky and plants only, never people or buildings
/// presented as historical scenes.
enum SceneKind {
  /// Dunes under a crescent and stars: the night of the Hijrah, the desert.
  nightDesert,

  /// Layered mountain ridges: Makkah's valley, Hira and Thawr.
  mountains,

  /// Palms on a plain: the oasis of Madinah.
  oasis,

  /// A horizon over water: the crossing to Abyssinia.
  sea,
}

/// An illustrative landscape on ink, drawn in gold and ink tones.
///
/// Decorative only (no semantics); its meaning is always carried by the
/// text laid over or beside it. It scales to any size and is drawn at most
/// once per size change.
class SceneBackdrop extends StatelessWidget {
  const SceneBackdrop({required this.kind, this.glow = true, super.key});

  final SceneKind kind;

  /// A soft gold light low on the horizon.
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: CustomPaint(
          isComplex: true,
          painter: _ScenePainter(kind, glow: glow),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _ScenePainter extends CustomPainter {
  _ScenePainter(this.kind, {required this.glow});

  final SceneKind kind;
  final bool glow;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Palette.inkLowest, Palette.inkHigh],
        ).createShader(rect),
    );
    if (glow) {
      canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.78),
        size.width * 0.7,
        Paint()
          ..shader =
              RadialGradient(
                colors: [
                  Palette.gold.withValues(alpha: 0.18),
                  Palette.gold.withValues(alpha: 0),
                ],
              ).createShader(
                Rect.fromCircle(
                  center: Offset(size.width * 0.5, size.height * 0.78),
                  radius: size.width * 0.7,
                ),
              ),
      );
    }
    _stars(canvas, size, count: kind == SceneKind.nightDesert ? 46 : 22);
    switch (kind) {
      case SceneKind.nightDesert:
        _crescent(
          canvas,
          Offset(size.width * 0.5, size.height * 0.07),
          size,
          scale: 0.6,
        );
        _ridges(
          canvas,
          size,
          layers: 3,
          base: 0.66,
          amplitude: 0.05,
          smooth: true,
        );
      case SceneKind.mountains:
        _crescent(canvas, Offset(size.width * 0.2, size.height * 0.18), size);
        _ridges(
          canvas,
          size,
          layers: 4,
          base: 0.5,
          amplitude: 0.16,
          smooth: false,
        );
      case SceneKind.oasis:
        _ridges(
          canvas,
          size,
          layers: 2,
          base: 0.72,
          amplitude: 0.04,
          smooth: true,
        );
        for (final (x, h) in [
          (0.16, 0.34),
          (0.27, 0.26),
          (0.7, 0.3),
          (0.83, 0.38),
        ]) {
          _palm(
            canvas,
            Offset(size.width * x, size.height * 0.84),
            size.height * h,
          );
        }
      case SceneKind.sea:
        _crescent(canvas, Offset(size.width * 0.5, size.height * 0.22), size);
        _waves(canvas, size);
    }
  }

  /// Stars at fixed pseudo-random places, so every paint is identical.
  void _stars(Canvas canvas, Size size, {required int count}) {
    final random = math.Random(kind.index * 31 + 7);
    final paint = Paint()..color = Palette.goldOnInk.withValues(alpha: 0.55);
    for (var i = 0; i < count; i++) {
      final p = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height * 0.5,
      );
      canvas.drawCircle(p, 0.6 + random.nextDouble() * 1.1, paint);
    }
  }

  void _crescent(Canvas canvas, Offset centre, Size size, {double scale = 1}) {
    final r = math.min(size.width, size.height) * 0.07 * scale;
    final moon = Path()..addOval(Rect.fromCircle(center: centre, radius: r));
    final bite = Path()
      ..addOval(
        Rect.fromCircle(center: centre + Offset(r * 0.45, -r * 0.2), radius: r),
      );
    canvas.drawPath(
      Path.combine(PathOperation.difference, moon, bite),
      Paint()..color = Palette.goldOnInk.withValues(alpha: 0.9),
    );
  }

  /// Ridges from the back (lighter) to the front (darker).
  void _ridges(
    Canvas canvas,
    Size size, {
    required int layers,
    required double base,
    required double amplitude,
    required bool smooth,
  }) {
    final random = math.Random(kind.index * 101 + 3);
    for (var layer = 0; layer < layers; layer++) {
      final depth = layer / math.max(1, layers - 1);
      final y0 = size.height * (base + depth * (0.92 - base));
      final amp = size.height * amplitude * (1 - depth * 0.35);
      final path = Path()..moveTo(0, size.height);
      const steps = 9;
      final points = [
        for (var i = 0; i <= steps; i++)
          Offset(
            size.width * i / steps,
            y0 - amp * (0.4 + random.nextDouble() * 0.6),
          ),
      ];
      path.lineTo(points.first.dx, points.first.dy);
      for (var i = 1; i < points.length; i++) {
        if (smooth) {
          final mid = Offset.lerp(points[i - 1], points[i], 0.5)!;
          path.quadraticBezierTo(
            points[i - 1].dx,
            points[i - 1].dy,
            mid.dx,
            mid.dy,
          );
        } else {
          path.lineTo(points[i].dx, points[i].dy);
        }
      }
      path
        ..lineTo(size.width, points.last.dy)
        ..lineTo(size.width, size.height)
        ..close();
      final colour = Color.lerp(Palette.inkHighest, Palette.inkLowest, depth)!;
      canvas.drawPath(path, Paint()..color = colour);
      // A thin gold rim light on each crest.
      canvas.drawPath(
        Path()..addPolygon(points, false),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Palette.gold.withValues(alpha: 0.25 * (1 - depth) + 0.05),
      );
    }
  }

  void _palm(Canvas canvas, Offset foot, double height) {
    final trunk = Paint()
      ..color = Palette.inkLowest
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = math.max(2, height * 0.05);
    final top = foot + Offset(height * 0.12, -height);
    canvas.drawPath(
      Path()
        ..moveTo(foot.dx, foot.dy)
        ..quadraticBezierTo(
          foot.dx + height * 0.02,
          foot.dy - height * 0.6,
          top.dx,
          top.dy,
        ),
      trunk,
    );
    final frond = Paint()..color = Palette.inkLowest;
    for (var i = 0; i < 7; i++) {
      final angle = -math.pi / 2 + (i - 3) * 0.48;
      final tip =
          top + Offset(math.cos(angle), math.sin(angle) + 0.55) * height * 0.42;
      final bend =
          top + Offset(math.cos(angle), math.sin(angle)) * height * 0.28;
      canvas.drawPath(
        Path()
          ..moveTo(top.dx, top.dy)
          ..quadraticBezierTo(bend.dx, bend.dy - height * 0.06, tip.dx, tip.dy)
          ..quadraticBezierTo(bend.dx, bend.dy + height * 0.02, top.dx, top.dy),
        frond,
      );
    }
  }

  void _waves(Canvas canvas, Size size) {
    final horizon = size.height * 0.62;
    canvas.drawRect(
      Rect.fromLTWH(0, horizon, size.width, size.height - horizon),
      Paint()..color = Palette.inkAlt,
    );
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Palette.gold.withValues(alpha: 0.3);
    for (var row = 0; row < 6; row++) {
      final y = horizon + (size.height - horizon) * (row + 0.5) / 6;
      final path = Path()..moveTo(0, y);
      const waves = 8;
      for (var i = 0; i < waves; i++) {
        final x0 = size.width * i / waves;
        final x1 = size.width * (i + 1) / waves;
        path.quadraticBezierTo((x0 + x1) / 2, y - 4 - row, x1, y);
      }
      canvas.drawPath(path, line);
    }
  }

  @override
  bool shouldRepaint(_ScenePainter old) => old.kind != kind || old.glow != glow;
}
