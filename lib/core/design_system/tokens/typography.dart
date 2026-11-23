import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';

// Every style sets letterSpacing to 0: Material's defaults add tracking,
// which pulls connected Arabic letters apart. Even leading keeps Arabic
// glyphs, with their tall marks, vertically centred in the line box.
// IBM Plex Sans Arabic covers Arabic, Arabic-Indic digits and ﷺ; its
// styles still fall back to Amiri for any rarer glyph it lacks.
TextStyle _style(String family, double size, double height, FontWeight weight) {
  return TextStyle(
    fontFamily: family,
    fontFamilyFallback: family == AppFonts.plexArabic
        ? const [AppFonts.amiri]
        : null,
    fontSize: size,
    height: height,
    fontWeight: weight,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );
}

/// The Material type scale (review §2.7, decision 8). Since 2026-11-21
/// every role, display names and titles and the reading text included,
/// uses IBM Plex Sans Arabic
/// (2026-11-20, after Nusuk), in its four bundled weights: 400 for text,
/// 500 for small labels, 600 for titles and buttons, 700 for headlines.
/// Plex sets larger than Zain did at the same size, so the labels are
/// back to 14 / 13 / 13. Nothing is set below 13.
abstract final class AppTypography {
  static TextTheme textTheme(Color color) {
    return TextTheme(
      // Display: names and titles, in the interface face. Plex sets
      // large, so the sizes are a step below the old Amiri ones.
      displayLarge: _style(AppFonts.plexArabic, 40, 1.35, FontWeight.w700),
      displayMedium: _style(AppFonts.plexArabic, 34, 1.4, FontWeight.w700),
      displaySmall: _style(AppFonts.plexArabic, 28, 1.4, FontWeight.w700),
      headlineLarge: _style(AppFonts.plexArabic, 28, 1.35, FontWeight.w700),
      headlineMedium: _style(AppFonts.plexArabic, 24, 1.4, FontWeight.w700),
      // Page section titles: lighter and smaller than before (F13).
      headlineSmall: _style(AppFonts.plexArabic, 22, 1.4, FontWeight.w600),
      titleLarge: _style(AppFonts.plexArabic, 19, 1.45, FontWeight.w600),
      titleMedium: _style(AppFonts.plexArabic, 16, 1.5, FontWeight.w600),
      titleSmall: _style(AppFonts.plexArabic, 14, 1.5, FontWeight.w600),
      bodyLarge: _style(AppFonts.plexArabic, 16, 1.65, FontWeight.w400),
      bodyMedium: _style(AppFonts.plexArabic, 14, 1.65, FontWeight.w400),
      bodySmall: _style(AppFonts.plexArabic, 13, 1.6, FontWeight.w400),
      labelLarge: _style(AppFonts.plexArabic, 14, 1.45, FontWeight.w600),
      labelMedium: _style(AppFonts.plexArabic, 13, 1.45, FontWeight.w500),
      labelSmall: _style(AppFonts.plexArabic, 13, 1.45, FontWeight.w500),
    ).apply(bodyColor: color, displayColor: color);
  }

  /// The most the display and headline roles grow with the system text
  /// size. They start large: at the largest accessibility sizes (2× and
  /// more) a heading such as «تعرّف على صحابي» would break a word to a
  /// line on a phone. Reading text is never capped.
  static const displayMaxScale = 1.5;

  /// The text scaler for a display or headline role: the system's, capped
  /// at [displayMaxScale]. Pass it as `Text.textScaler`.
  static TextScaler displayScaler(BuildContext context) =>
      MediaQuery.textScalerOf(context).clamp(maxScaleFactor: displayMaxScale);
}

/// Text styles outside the Material type scale: long-form reading, Qur'anic
/// verses, section kickers and large numerals.
///
/// Read with `SuhbaTextStyles.of(context)`.
@immutable
class SuhbaTextStyles extends ThemeExtension<SuhbaTextStyles> {
  const SuhbaTextStyles({
    required this.reading,
    required this.readingStrong,
    required this.readingHeading,
    required this.quran,
    required this.kicker,
    required this.numeral,
  });

  factory SuhbaTextStyles.forColors({
    required Color text,
    required Color dimText,
  }) {
    return SuhbaTextStyles(
      // Long-form text is set in the interface's own face: a clean
      // sans reads easily on a phone, and the page keeps one voice. The
      // open line (1.8) gives vocalised words room for their marks.
      reading: _style(
        AppFonts.plexArabic,
        readingSize,
        1.8,
        FontWeight.w400,
      ).copyWith(color: text),
      // Quoted wording is set apart by a step in size and the medium
      // weight, never bold: fully vocalised text in bold closes up its
      // marks (review §2.3).
      readingStrong: _style(
        AppFonts.plexArabic,
        21,
        2,
        FontWeight.w500,
      ).copyWith(color: text),
      readingHeading: _style(
        AppFonts.plexArabic,
        22,
        1.5,
        FontWeight.w700,
      ).copyWith(color: text),
      quran: _style(
        AppFonts.amiriQuran,
        22,
        2.1,
        FontWeight.w400,
      ).copyWith(color: text),
      kicker: _style(
        AppFonts.plexArabic,
        13,
        1.45,
        FontWeight.w500,
      ).copyWith(color: dimText),
      numeral: _style(
        AppFonts.plexArabic,
        64,
        1.1,
        FontWeight.w700,
      ).copyWith(color: text),
    );
  }

  /// Default reading size, before the reader's own setting.
  static const readingSize = 20.0;

  /// Biography and story body text.
  final TextStyle reading;

  /// Quoted wording inside reading text: a step larger, not bolder.
  final TextStyle readingStrong;

  /// Headings inside a passage: the reading face, so the column keeps
  /// one voice (review F13).
  final TextStyle readingHeading;

  /// Qur'anic verses (Amiri Quran). Use for verse text only.
  final TextStyle quran;

  /// Small label above a section title.
  final TextStyle kicker;

  /// Large decorative numerals (years, chapter ordinals).
  final TextStyle numeral;

  static SuhbaTextStyles of(BuildContext context) =>
      Theme.of(context).extension<SuhbaTextStyles>()!;

  @override
  SuhbaTextStyles copyWith({
    TextStyle? reading,
    TextStyle? readingStrong,
    TextStyle? readingHeading,
    TextStyle? quran,
    TextStyle? kicker,
    TextStyle? numeral,
  }) {
    return SuhbaTextStyles(
      reading: reading ?? this.reading,
      readingStrong: readingStrong ?? this.readingStrong,
      readingHeading: readingHeading ?? this.readingHeading,
      quran: quran ?? this.quran,
      kicker: kicker ?? this.kicker,
      numeral: numeral ?? this.numeral,
    );
  }

  @override
  SuhbaTextStyles lerp(SuhbaTextStyles? other, double t) {
    if (other == null) return this;
    return SuhbaTextStyles(
      reading: TextStyle.lerp(reading, other.reading, t)!,
      readingStrong: TextStyle.lerp(readingStrong, other.readingStrong, t)!,
      readingHeading: TextStyle.lerp(readingHeading, other.readingHeading, t)!,
      quran: TextStyle.lerp(quran, other.quran, t)!,
      kicker: TextStyle.lerp(kicker, other.kicker, t)!,
      numeral: TextStyle.lerp(numeral, other.numeral, t)!,
    );
  }
}
