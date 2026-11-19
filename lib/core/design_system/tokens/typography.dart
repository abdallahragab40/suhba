import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';

// Every style sets letterSpacing to 0: Material's defaults add tracking,
// which pulls connected Arabic letters apart. Even leading keeps Arabic
// glyphs, with their tall marks, vertically centred in the line box.
// Zain lacks some Arabic ligatures (notably ﷺ, U+FDFA), so Zain styles
// fall back to Amiri for any glyph Zain does not have.
TextStyle _style(String family, double size, double height, FontWeight weight) {
  return TextStyle(
    fontFamily: family,
    fontFamilyFallback: family == AppFonts.zain ? const [AppFonts.amiri] : null,
    fontSize: size,
    height: height,
    fontWeight: weight,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );
}

/// The Material type scale (review §2.7, decision 8). Display roles use
/// Amiri (calligraphic names); everything else uses Zain, in its three
/// bundled weights: 400, 700 and 800. Nothing is set below 13.
abstract final class AppTypography {
  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: _style(AppFonts.amiri, 56, 1.35, FontWeight.w700),
      displayMedium: _style(AppFonts.amiri, 48, 1.35, FontWeight.w700),
      // Tall marks and descenders need the 1.5 line (review F08).
      displaySmall: _style(AppFonts.amiri, 40, 1.5, FontWeight.w700),
      headlineLarge: _style(AppFonts.zain, 30, 1.3, FontWeight.w800),
      headlineMedium: _style(AppFonts.zain, 26, 1.3, FontWeight.w700),
      // Page section titles: lighter and smaller than before (F13).
      headlineSmall: _style(AppFonts.zain, 24, 1.35, FontWeight.w700),
      titleLarge: _style(AppFonts.zain, 20, 1.4, FontWeight.w700),
      titleMedium: _style(AppFonts.zain, 17, 1.45, FontWeight.w700),
      titleSmall: _style(AppFonts.zain, 15, 1.45, FontWeight.w700),
      bodyLarge: _style(AppFonts.zain, 16, 1.6, FontWeight.w400),
      bodyMedium: _style(AppFonts.zain, 15, 1.6, FontWeight.w400),
      bodySmall: _style(AppFonts.zain, 13, 1.55, FontWeight.w400),
      // Zain sets smaller than Cairo did at the same size, so labels and
      // badges are a step up (review §2.7): 15 / 14 / 14.
      labelLarge: _style(AppFonts.zain, 15, 1.4, FontWeight.w700),
      labelMedium: _style(AppFonts.zain, 14, 1.4, FontWeight.w700),
      labelSmall: _style(AppFonts.zain, 14, 1.4, FontWeight.w700),
    ).apply(bodyColor: color, displayColor: color);
  }
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
      reading: _style(
        AppFonts.amiri,
        readingSize,
        1.8,
        FontWeight.w400,
      ).copyWith(color: text),
      // Quoted wording is set apart by size, not by bold: fully vocalised
      // text in bold closes up its marks (review §2.3).
      readingStrong: _style(
        AppFonts.amiri,
        21,
        1.9,
        FontWeight.w400,
      ).copyWith(color: text),
      readingHeading: _style(
        AppFonts.amiri,
        24,
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
        AppFonts.zain,
        14,
        1.4,
        FontWeight.w700,
      ).copyWith(color: dimText),
      numeral: _style(AppFonts.zain, 72, 1, FontWeight.w800).copyWith(
        color: text,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }

  /// Default reading size, before the reader's own setting.
  static const readingSize = 20.0;

  /// Biography and story body text (Amiri).
  final TextStyle reading;

  /// Quoted wording inside reading text: a step larger, not bolder.
  final TextStyle readingStrong;

  /// Headings inside a passage: Amiri, so the reading column keeps one
  /// voice (review F13).
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
