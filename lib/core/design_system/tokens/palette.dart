import 'dart:ui';

/// Raw color values. Widgets never use these directly: they read the
/// semantic roles from `Theme.of(context).colorScheme` or [SuhbaColors].
///
/// Warm ivory paper, a green-black ink, Madinah green and a soft sand gold
/// (the 2026-11 redesign). Every text/background pair meets WCAG AA (see
/// contrast_test.dart).
abstract final class Palette {
  // Paper (light surfaces), lightest to darkest. [paper] is the page, a
  // warm ivory; cards are [paperLowest], lighter than the page and edged
  // with a hairline, so a page reads as paper with sheets laid on it.
  static const paperLowest = Color(0xFFFFFDF8);
  static const paper = Color(0xFFF8F4EB);
  static const paperLow = Color(0xFFF3EEE2);
  static const paperAlt = Color(0xFFEEE8DA);
  static const paperHigh = Color(0xFFE8E1D1);
  static const paperHighest = Color(0xFFE1D9C7);

  // Ink (dark surfaces), darkest to lightest: a green-black, so dark mode
  // belongs to the same family as the Madinah green.
  static const inkLowest = Color(0xFF050C09);
  static const ink = Color(0xFF09120E);
  static const inkLow = Color(0xFF0D1712);
  static const inkAlt = Color(0xFF111D17);
  static const inkHigh = Color(0xFF16241D);
  static const inkHighest = Color(0xFF1C2C24);

  // Night: the dark theme's surfaces. A soft charcoal with a breath of
  // green, lighter and less saturated than [ink], with clear steps, so
  // cards stand off the page and long reading does not tire the eye; text
  // is a warm off-white rather than [paper], which glares on a dark page.
  static const nightLowest = Color(0xFF0B110F);
  static const night = Color(0xFF101816);
  static const nightLow = Color(0xFF141D1A);
  static const nightAlt = Color(0xFF19231F);
  static const nightHigh = Color(0xFF1F2B26);
  static const nightHighest = Color(0xFF26342E);
  static const lineOnNight = Color(0xFF2E3D37);
  static const textOnNight = Color(0xFFE7E3D9);
  static const dimOnNight = Color(0xFFA8A69E);

  // Warm night: the reader's warm tone in the dark theme (K5 at night).
  static const warmNight = Color(0xFF1A1612);
  static const warmNightAlt = Color(0xFF241E18);
  static const lineOnWarmNight = Color(0xFF3A3026);
  static const textOnWarmNight = Color(0xFFEADFCB);
  static const dimOnWarmNight = Color(0xFFB3A792);

  // Reading and interface text on paper: softer than [ink], which is kept
  // for shadows and the night share card.
  static const inkText = Color(0xFF16211B);
  static const inkTextOnWarmPaper = Color(0xFF241D14);

  // Secondary text, hairlines and outlines.
  static const inkDim = Color(0xFF5C5850);
  static const paperDim = Color(0xFF989694);
  static const lineOnPaper = Color(0xFFE3DCCB);
  static const lineOnInk = Color(0xFF26352D);
  static const outlineOnPaper = Color(0xFF857F72);
  static const outlineOnInk = Color(0xFF748279);

  // Sand gold. [gold] is decorative on paper (about 2.2:1); use [goldText]
  // there. [verseWash] grounds a Qur'anic verse: the page's illumination.
  static const verseWash = Color(0xFFF7F0DC);
  static const verseWashOnNight = Color(0xFF1F2218);
  static const verseWashOnWarmPaper = Color(0xFFF8EDD0);
  static const verseWashOnWarmNight = Color(0xFF29221A);
  // Source marks in running text: present, never louder than the words.
  static const markOnPaper = Color(0xFF2E6A56);
  static const markOnNight = Color(0xFFA8925C);
  static const gold = Color(0xFFC9A24D);
  static const goldText = Color(0xFF7A5A12);
  static const goldOnInk = Color(0xFFDDB765);
  static const goldWash = Color(0xFFF5ECD6);
  static const goldWashOnInk = Color(0xFF332A14);
  static const goldDeep = Color(0xFF4A3608);

  // Madinah green: the brand colour. [green] is the ground of the icon and
  // of the app's feature sections (the Seerah hero, the night scenes);
  // the light theme's primary actions use it on paper. Its steps mirror
  // the ink surfaces, lightest last.
  static const greenLowest = Color(0xFF0A2E24);
  static const green = Color(0xFF124A39);
  static const greenLow = Color(0xFF154E3C);
  static const greenAlt = Color(0xFF175240);
  static const greenHigh = Color(0xFF1B5946);
  static const greenHighest = Color(0xFF20604C);
  static const greenWash = Color(0xFFE1EBDF);
  static const greenWashOnInk = Color(0xFF1E4537);
  static const lineOnGreen = Color(0xFF2F6A57);
  static const paperDimOnGreen = Color(0xFFBECCC4);
  static const outlineOnGreen = Color(0xFF86A094);

  // Reliability and review states.
  static const establishedOnPaper = Color(0xFF265C44);
  static const establishedOnInk = Color(0xFF7BC4A0);
  static const establishedOnGreen = Color(0xFF8ED2B0);
  static const disputedOnPaper = Color(0xFF784700);
  static const disputedOnInk = Color(0xFFF0B45A);
  // Review status is neutral: the icon and the words carry the meaning, and
  // gold is kept for illumination (review §2.7, F12).
  static const draftOnPaper = inkDim;
  static const draftWash = paperAlt;
  static const draftOnInk = paperDim;
  static const draftWashOnInk = inkAlt;
  static const draftOnGreen = paperDimOnGreen;
  static const draftWashOnGreen = greenAlt;

  // Clay: errors and destructive actions only (review §2.7).
  static const clay = Color(0xFF8A3B2E);
  static const clayWash = Color(0xFFF3E3DD);
  static const clayOnInk = Color(0xFFF2B8A8);
  static const clayWashOnInk = Color(0xFF2A1714);

  // Warm paper: the reader's optional page tone (review K5), a sepia a
  // clear step warmer than [paper]; cards and lines follow it.
  static const warmPaper = Color(0xFFF4EAD5);
  static const warmPaperAlt = Color(0xFFFAF2E2);
  static const lineOnWarmPaper = Color(0xFFE2D5B9);

  /// The selected destination's pill on paper: a step stronger than
  /// [greenWash], so the current tab reads at a glance.
  static const greenWashStrong = Color(0xFFC5D9C8);
}
