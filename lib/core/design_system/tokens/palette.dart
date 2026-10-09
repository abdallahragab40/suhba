import 'dart:ui';

/// Raw color values. Widgets never use these directly: they read the
/// semantic roles from `Theme.of(context).colorScheme` or [SahabaColors].
///
/// Paper, ink and gold come from the reference site. The text variants were
/// tuned so every text/background pair meets WCAG AA (see contrast_test.dart).
abstract final class Palette {
  // Paper (light surfaces), lightest to darkest.
  static const paperLowest = Color(0xFFF6F4F0);
  static const paper = Color(0xFFEDEBE6);
  static const paperLow = Color(0xFFE9E6E0);
  static const paperAlt = Color(0xFFE3E0D9);
  static const paperHigh = Color(0xFFDCD8D0);
  static const paperHighest = Color(0xFFD5D1C8);

  // Ink (dark surfaces), darkest to lightest.
  static const inkLowest = Color(0xFF070708);
  static const ink = Color(0xFF0C0C0D);
  static const inkLow = Color(0xFF121214);
  static const inkAlt = Color(0xFF17171A);
  static const inkHigh = Color(0xFF1E1E22);
  static const inkHighest = Color(0xFF26262B);

  // Secondary text, hairlines and outlines.
  static const inkDim = Color(0xFF565553);
  static const paperDim = Color(0xFF989694);
  static const lineOnPaper = Color(0xFFC9C7C3);
  static const lineOnInk = Color(0xFF2C2B2B);
  static const outlineOnPaper = Color(0xFF888784);
  static const outlineOnInk = Color(0xFF71706F);

  // Gold. [gold] is decorative on paper (about 2.2:1); use [goldText] there.
  static const gold = Color(0xFFC99A2E);
  static const goldText = Color(0xFF6E500F);
  static const goldOnInk = Color(0xFFD9AE4A);
  static const goldWash = Color(0xFFF1E6CC);
  static const goldWashOnInk = Color(0xFF3A2E12);
  static const goldDeep = Color(0xFF4A3608);

  // Reliability and review states.
  static const establishedOnPaper = Color(0xFF265C44);
  static const establishedOnInk = Color(0xFF7BC4A0);
  static const disputedOnPaper = Color(0xFF784700);
  static const disputedOnInk = Color(0xFFF0B45A);
  static const draftOnPaper = Color(0xFF8A3B2E);
  static const draftWash = Color(0xFFF3E3DD);
  static const draftOnInk = Color(0xFFF2B8A8);
  static const draftWashOnInk = Color(0xFF2A1714);
}
