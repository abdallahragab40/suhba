import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A ring that fills clockwise from the top as [value] goes from 0 to 1
/// (review K2). It carries no meaning on its own: give it a [label] that
/// says the same in words, which is what screen readers announce.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    required this.value,
    required this.label,
    required this.color,
    required this.trackColor,
    this.size = 48,
    this.strokeWidth = 5,
    this.child,
    super.key,
  });

  /// Between 0 and 1.
  final double value;
  final String label;
  final Color color;
  final Color trackColor;
  final double size;
  final double strokeWidth;

  /// Shown in the middle of the ring, such as a count or a check mark.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _RingPainter(
            value: value.clamp(0, 1),
            color: color,
            trackColor: trackColor,
            strokeWidth: strokeWidth,
          ),
          child: child == null ? null : Center(child: child),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.value,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double value;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, 2 * math.pi, false, paint..color = trackColor);
    if (value > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * value,
        false,
        paint..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value ||
      old.color != color ||
      old.trackColor != trackColor ||
      old.strokeWidth != strokeWidth;
}
