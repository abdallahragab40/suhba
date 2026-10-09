import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A lattice of eight-pointed stars (khatam) joined by straight lines, drawn
/// as fine strokes. Used behind heroes and empty states.
///
/// Decorative only; it has no semantics. Size it with its parent, e.g.
/// `Positioned.fill(child: GeometricPattern())`.
class GeometricPattern extends StatelessWidget {
  const GeometricPattern({
    this.color,
    this.tileSize = 56,
    this.strokeWidth = 1,
    super.key,
  });

  /// Defaults to the text color at 7% opacity.
  final Color? color;
  final double tileSize;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final color =
        this.color ??
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.07);
    return RepaintBoundary(
      child: CustomPaint(
        isComplex: true,
        painter: _KhatamLatticePainter(
          color: color,
          tileSize: tileSize,
          strokeWidth: strokeWidth,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _KhatamLatticePainter extends CustomPainter {
  _KhatamLatticePainter({
    required this.color,
    required this.tileSize,
    required this.strokeWidth,
  });

  final Color color;
  final double tileSize;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    final tile = _tilePath(tileSize);
    // Centre the lattice so it is symmetric whatever the size.
    final columns = (size.width / tileSize).ceil() + 1;
    final rows = (size.height / tileSize).ceil() + 1;
    final dx = (size.width - columns * tileSize) / 2;
    final dy = (size.height - rows * tileSize) / 2;

    canvas.save();
    canvas.clipRect(Offset.zero & size);
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        canvas.drawPath(
          tile.shift(Offset(dx + column * tileSize, dy + row * tileSize)),
          paint,
        );
      }
    }
    canvas.restore();
  }

  /// One tile: an eight-pointed star in the centre, with its axis points
  /// joined to the edge midpoints and its diagonal points to the corners.
  static Path _tilePath(double s) {
    final c = Offset(s / 2, s / 2);
    final outer = s * 0.3;
    // Inner radius of the {8/2} star (two overlapping squares).
    final inner = outer * math.cos(math.pi / 4) / math.cos(math.pi / 8);

    Offset at(double radius, double angle) =>
        c + Offset(math.cos(angle) * radius, math.sin(angle) * radius);

    final path = Path();
    for (var i = 0; i < 16; i++) {
      final angle = -math.pi / 2 + i * math.pi / 8;
      final point = at(i.isEven ? outer : inner, angle);
      i == 0
          ? path.moveTo(point.dx, point.dy)
          : path.lineTo(point.dx, point.dy);
    }
    path.close();

    for (var k = 0; k < 8; k++) {
      final angle = -math.pi / 2 + k * math.pi / 4;
      final from = at(outer, angle);
      // Axis directions reach the edge midpoint; diagonals reach the corner.
      final reach = k.isEven ? s / 2 : s / 2 * math.sqrt2;
      final to = at(reach, angle);
      path
        ..moveTo(from.dx, from.dy)
        ..lineTo(to.dx, to.dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(_KhatamLatticePainter old) =>
      old.color != color ||
      old.tileSize != tileSize ||
      old.strokeWidth != strokeWidth;
}
