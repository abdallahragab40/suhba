import 'package:flutter/widgets.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';

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

/// The name صحبة within a pointed arch, above an open book: a doorway
/// into the Seerah and the lives of the Companions, read from its sources.
/// Gold on the app's Madinah green, with no figurative
/// imagery (D5); the gold deepens slightly towards the foot, and the green
/// glows faintly behind the name. The monochrome (themed) icon is flat, in one
/// colour, so Android can tint it.
void paintBrandMark(
  Canvas canvas,
  Size size,
  BrandMarkLayout layout, {
  String fontFamily = AppFonts.amiri,
  Color groundColor = Palette.green,
  Color markColor = Palette.goldOnInk,
}) {
  final s = size.shortestSide;
  final centre = size.center(Offset.zero);
  final flat = layout == BrandMarkLayout.monochrome;
  final gold = flat ? const Color(0xFFFFFFFF) : markColor;

  // The ink ground, lit faintly from behind the name.
  Paint ground(Rect bounds) => Paint()
    ..shader = RadialGradient(
      center: const Alignment(0, -0.15),
      radius: 0.75,
      colors: [Color.lerp(groundColor, markColor, 0.09)!, groundColor],
    ).createShader(bounds);

  switch (layout) {
    case BrandMarkLayout.square:
      final r = Offset.zero & size;
      canvas.drawRect(r, ground(r));
    case BrandMarkLayout.roundedSquare:
      final r = Rect.fromCenter(
        center: centre,
        width: s * 0.92,
        height: s * 0.92,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, Radius.circular(s * 0.2)),
        ground(r),
      );
    case BrandMarkLayout.disc:
      final r = Rect.fromCircle(center: centre, radius: s / 2);
      canvas.drawCircle(centre, s / 2, ground(r));
    case BrandMarkLayout.adaptiveForeground || BrandMarkLayout.monochrome:
      break;
  }

  // The mark is drawn in a 100-unit box, scaled so its silhouette stays
  // within Android's 66 dp safe circle on the 108 dp adaptive layers.
  final extent =
      s *
      switch (layout) {
        BrandMarkLayout.square => 0.74,
        BrandMarkLayout.roundedSquare => 0.68,
        BrandMarkLayout.disc => 0.64,
        BrandMarkLayout.adaptiveForeground ||
        BrandMarkLayout.monochrome => 0.54,
      };
  canvas
    ..save()
    ..translate(centre.dx - extent / 2, centre.dy - extent / 2)
    ..scale(extent / 100);

  // Gold, a touch lighter at the crown and deeper at the foot.
  final shader = flat
      ? null
      : LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(gold, const Color(0xFFFFFFFF), 0.22)!,
            gold,
            Color.lerp(gold, Palette.goldDeep, 0.25)!,
          ],
          stops: const [0, 0.55, 1],
        ).createShader(const Rect.fromLTWH(0, 0, 100, 100));
  Paint ink({double? stroke}) {
    final p = Paint()
      ..color = gold
      ..shader = shader
      ..isAntiAlias = true;
    if (stroke != null) {
      p
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
    }
    return p;
  }

  // The pointed arch: straight jambs, then two curves meeting at the apex.
  Path arch(double inset) {
    final l = 12 + inset;
    final r = 88 - inset;
    const spring = 40.0;
    const foot = 72.0;
    final apex = 6 + inset * 1.25;
    final half = (r - l) / 2;
    return Path()
      ..moveTo(l, foot)
      ..lineTo(l, spring)
      ..cubicTo(l, spring - 16, 50 - half * 0.32, apex + 9, 50, apex)
      ..cubicTo(50 + half * 0.32, apex + 9, r, spring - 16, r, spring)
      ..lineTo(r, foot);
  }

  canvas
    ..drawPath(arch(0), ink(stroke: 3.4))
    ..drawPath(arch(5), ink(stroke: 1.1));

  // The name, centred in the arch's opening.
  TextPainter word(double fontSize) => TextPainter(
    text: TextSpan(
      text: 'صحبة',
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        height: 1,
        foreground: ink(),
      ),
    ),
    textDirection: TextDirection.rtl,
  )..layout();
  final probe = word(100);
  final name = word(100 * 56 / probe.width);
  // Centred on the book: the letters' ink sits over the spine and rests
  // just above the pages. Measured in Amiri Bold: the ink's centre is 0.85
  // units left of the line box's, and its foot is at 0.87 of the box.
  const inkCentreShift = 0.85;
  const inkFoot = 0.87; // the ink's lowest point, as a share of the box
  const rest = 69.0; // where the ink's foot rests, above the pages
  name.paint(
    canvas,
    Offset(50 - name.width / 2 + inkCentreShift, rest - name.height * inkFoot),
  );
  probe.dispose();
  name.dispose();

  // The open book: two pages curving down to the spine, each with a page
  // edge beneath, broad enough to read at the smallest sizes.
  Path page(double side) {
    double x(double v) => 50 + side * v;
    return Path()
      ..moveTo(x(2), 83)
      ..cubicTo(x(10), 76.5, x(26), 72.5, x(40), 74.5)
      ..lineTo(x(40), 86.5)
      ..cubicTo(x(26), 84.5, x(10), 88.5, x(2), 95)
      ..close();
  }

  Path edge(double side) {
    double x(double v) => 50 + side * v;
    return Path()
      ..moveTo(x(2), 98.4)
      ..cubicTo(x(10), 92, x(26), 88, x(40.5), 90);
  }

  for (final side in const [-1.0, 1.0]) {
    canvas
      ..drawPath(page(side), ink())
      ..drawPath(edge(side), ink(stroke: 1.4));
  }
  canvas.restore();
}

/// The mark as a widget, e.g. on the welcome screen.
class BrandMark extends StatelessWidget {
  const BrandMark({
    this.size = 120,
    this.layout = BrandMarkLayout.adaptiveForeground,
    super.key,
  });

  final double size;
  final BrandMarkLayout layout;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: CustomPaint(painter: _BrandMarkPainter(layout)),
  );
}

class _BrandMarkPainter extends CustomPainter {
  _BrandMarkPainter(this.layout);

  final BrandMarkLayout layout;

  @override
  void paint(Canvas canvas, Size size) => paintBrandMark(canvas, size, layout);

  @override
  bool shouldRepaint(_BrandMarkPainter old) => old.layout != layout;
}
