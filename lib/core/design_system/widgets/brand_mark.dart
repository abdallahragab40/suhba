import 'package:flutter/widgets.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';

/// How the mark is laid out on its canvas.
enum BrandMarkLayout {
  /// Opaque ink square, full bleed: iOS icons (the OS rounds the corners).
  square,

  /// Gold mark on transparent, sized as [square]: the iOS 18 dark icon,
  /// which the OS sets on its own dark ground.
  squareDark,

  /// White mark on black, sized as [square]: the iOS 18 tinted icon, whose
  /// luminance the OS tints.
  squareTinted,

  /// Ink rounded square on transparent: legacy Android launcher icons.
  roundedSquare,

  /// Gold mark on transparent, inside the adaptive-icon safe zone.
  adaptiveForeground,

  /// White mark on transparent, inside the safe zone: Android 13 themed icons.
  monochrome,

  /// Ink disc with the mark, on transparent: launch screens.
  disc,
}

/// The name صحبة in a doorway: two leaning strokes that meet at a
/// rhombic dot, the *nuqta* that Arabic letters are measured by. Two
/// halves that make one arch, a companionship, and a door into the Seerah
/// and the lives of the Companions. No figurative imagery (D5).
///
/// The arch and its dot are sand gold, the name ivory, on Madinah green;
/// there is nothing finer than the name itself, so the mark holds at
/// launcher sizes. The monochrome (themed) and tinted icons are flat, in
/// one colour, so the OS can tint them.
void paintBrandMark(
  Canvas canvas,
  Size size,
  BrandMarkLayout layout, {
  String fontFamily = AppFonts.amiri,
  Color groundColor = Palette.green,
  Color markColor = Palette.goldOnInk,
  Color nameColor = Palette.paper,
}) {
  final s = size.shortestSide;
  final centre = size.center(Offset.zero);
  final flat =
      layout == BrandMarkLayout.monochrome ||
      layout == BrandMarkLayout.squareTinted;
  const white = Color(0xFFFFFFFF);
  final gold = flat ? white : markColor;
  final ivory = flat ? white : nameColor;

  // The green ground, lit faintly from behind the name.
  Paint ground(Rect bounds) => Paint()
    ..shader = RadialGradient(
      center: const Alignment(0, -0.1),
      radius: 0.8,
      colors: [
        Color.lerp(groundColor, white, 0.07)!,
        groundColor,
        Color.lerp(groundColor, const Color(0xFF000000), 0.18)!,
      ],
      stops: const [0, 0.6, 1],
    ).createShader(bounds);

  switch (layout) {
    case BrandMarkLayout.square:
      final r = Offset.zero & size;
      canvas.drawRect(r, ground(r));
    case BrandMarkLayout.squareTinted:
      canvas.drawRect(
        Offset.zero & size,
        Paint()..color = const Color(0xFF000000),
      );
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
    case BrandMarkLayout.squareDark ||
        BrandMarkLayout.adaptiveForeground ||
        BrandMarkLayout.monochrome:
      break;
  }

  // The mark is drawn in a 100-unit box, scaled so its silhouette stays
  // within Android's 66 dp safe circle on the 108 dp adaptive layers.
  final extent =
      s *
      switch (layout) {
        BrandMarkLayout.square ||
        BrandMarkLayout.squareDark ||
        BrandMarkLayout.squareTinted => 0.72,
        BrandMarkLayout.roundedSquare => 0.66,
        BrandMarkLayout.disc => 0.6,
        // The feet's outer corners are 57 units from the centre: at 0.53
        // they stay inside the safe circle's 30.5% radius.
        BrandMarkLayout.adaptiveForeground ||
        BrandMarkLayout.monochrome => 0.53,
      };
  canvas
    ..save()
    ..translate(centre.dx - extent / 2, centre.dy - extent / 2)
    ..scale(extent / 100);

  // Gold, a touch lighter at the crown and deeper at the foot.
  final goldPaint = Paint()
    ..color = gold
    ..isAntiAlias = true;
  if (!flat) {
    goldPaint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.lerp(gold, white, 0.25)!,
        gold,
        Color.lerp(gold, Palette.goldDeep, 0.22)!,
      ],
      stops: const [0, 0.5, 1],
    ).createShader(const Rect.fromLTWH(0, 0, 100, 100));
  }

  // One half of the arch, a stroke like a reed pen's: broad at the foot,
  // a straight jamb, then a curve thinning to the crown. [side] is -1 for
  // the left half and 1 for the right.
  const foot = 92.0;
  const spring = 48.0;
  const crown = 14.0; // where the two strokes would meet
  const halfWidth = 39.0; // outer edge, from the centre line
  const broad = 6.4; // the stroke at the foot
  const gap = 2.6; // each stroke stops this far short of the centre line
  Path stroke(double side) {
    double x(double v) => 50 + side * v;
    const inner = halfWidth - broad;
    return Path()
      ..moveTo(x(halfWidth), foot)
      ..lineTo(x(halfWidth), spring)
      ..cubicTo(
        x(halfWidth),
        spring - 20,
        x(halfWidth * 0.36),
        crown + 9.5,
        x(gap),
        crown + 1.5,
      )
      ..lineTo(x(gap), crown + 5.2)
      ..cubicTo(
        x(inner * 0.36),
        crown + 13,
        x(inner),
        spring - 17,
        x(inner),
        spring,
      )
      ..lineTo(x(inner), foot)
      ..close();
  }

  // The nuqta at the crown: a reed pen's square dot, set on its corner.
  const dot = 5.6; // half its diagonal
  const dotY = crown - 0.6;
  final nuqta = Path()
    ..moveTo(50, dotY - dot)
    ..lineTo(50 + dot, dotY)
    ..lineTo(50, dotY + dot)
    ..lineTo(50 - dot, dotY)
    ..close();

  canvas
    ..drawPath(stroke(-1), goldPaint)
    ..drawPath(stroke(1), goldPaint)
    ..drawPath(nuqta, goldPaint);

  // The name, centred in the doorway.
  TextPainter word(double fontSize) => TextPainter(
    text: TextSpan(
      text: 'صحبة',
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        height: 1,
        color: ivory,
      ),
    ),
    textDirection: TextDirection.rtl,
  )..layout();
  final probe = word(100);
  final name = word(100 * 57 / probe.width);
  // Measured in Amiri Bold: the ink's centre is 0.85 units left of the line
  // box's, and its foot is at 0.87 of the box.
  const inkCentreShift = 0.85;
  const inkFoot = 0.87; // the ink's lowest point, as a share of the box
  const rest = 79.0; // where the ink's foot rests
  name.paint(
    canvas,
    Offset(50 - name.width / 2 + inkCentreShift, rest - name.height * inkFoot),
  );
  probe.dispose();
  name.dispose();
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
