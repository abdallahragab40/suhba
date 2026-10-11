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

  // Ink (dark surfaces), darkest to lightest: a green-black, so dark mode
  // belongs to the same family as the Madinah green.
  static const inkLowest = Color(0xFF050C09);
  static const ink = Color(0xFF09120E);
  static const inkLow = Color(0xFF0D1712);
  static const inkAlt = Color(0xFF111D17);
  static const inkHigh = Color(0xFF16241D);
  static const inkHighest = Color(0xFF1C2C24);

  // Secondary text, hairlines and outlines.
  static const inkDim = Color(0xFF565553);
  static const paperDim = Color(0xFF989694);
  static const lineOnPaper = Color(0xFFC9C7C3);
  static const lineOnInk = Color(0xFF26352D);
  static const outlineOnPaper = Color(0xFF888784);
  static const outlineOnInk = Color(0xFF6E7D75);

  // Gold. [gold] is decorative on paper (about 2.2:1); use [goldText] there.
  static const gold = Color(0xFFC99A2E);
  static const goldText = Color(0xFF6E500F);
  static const goldOnInk = Color(0xFFD9AE4A);
  static const goldWash = Color(0xFFF1E6CC);
  static const goldWashOnInk = Color(0xFF3A2E12);
  static const goldDeep = Color(0xFF4A3608);

  // Madinah green: the brand colour. [green] is the ground of the icon and
  // of the app's feature sections (the Seerah hero, the night scenes);
  // the light theme's primary actions use it on paper. Its steps mirror
  // the ink surfaces, lightest last.
  static const greenLowest = Color(0xFF07211A);
  static const green = Color(0xFF0E3A2C);
  static const greenLow = Color(0xFF113F31);
  static const greenAlt = Color(0xFF154736);
  static const greenHigh = Color(0xFF1A513F);
  static const greenHighest = Color(0xFF205B48);
  static const greenWash = Color(0xFFDDE8E1);
  static const greenWashOnInk = Color(0xFF1D4234);
  static const lineOnGreen = Color(0xFF2D5E4D);
  static const paperDimOnGreen = Color(0xFFB4C3BB);
  static const outlineOnGreen = Color(0xFF7F988D);

  // Reliability and review states.
  static const establishedOnPaper = Color(0xFF265C44);
  static const establishedOnInk = Color(0xFF7BC4A0);
  static const disputedOnPaper = Color(0xFF784700);
  static const disputedOnInk = Color(0xFFF0B45A);
  static const draftOnPaper = Color(0xFF8A3B2E);
  static const draftWash = Color(0xFFF4E6DB);
  static const draftOnInk = Color(0xFFF1D3A6);
  static const draftWashOnInk = Color(0xFF2A2312);
  // Draft on the green feature sections: warm sand on a deep amber wash,
  // which sits with the gold rather than against the green.
  static const draftOnGreen = Color(0xFFF1D3A6);
  static const draftWashOnGreen = Color(0xFF3B2E14);
}
