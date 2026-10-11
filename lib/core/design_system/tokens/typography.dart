import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';

// Every style sets letterSpacing to 0: Material's defaults add tracking,
// which pulls connected Arabic letters apart. Even leading keeps Arabic
// glyphs, with their tall marks, vertically centred in the line box.
// Cairo lacks some Arabic ligatures (notably ﷺ, U+FDFA), so Cairo styles
// fall back to Amiri for any glyph Cairo does not have.
TextStyle _style(String family, double size, double height, FontWeight weight) {
  return TextStyle(
    fontFamily: family,
    fontFamilyFallback: family == AppFonts.cairo
        ? const [AppFonts.amiri]
        : null,
    fontSize: size,
    height: height,
    fontWeight: weight,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );
}

/// The Material type scale. Display roles use Amiri (calligraphic names);
/// everything else uses Cairo.
abstract final class AppTypography {
  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: _style(AppFonts.amiri, 56, 1.35, FontWeight.w700),
      displayMedium: _style(AppFonts.amiri, 48, 1.35, FontWeight.w700),
      displaySmall: _style(AppFonts.amiri, 40, 1.4, FontWeight.w700),
      headlineLarge: _style(AppFonts.cairo, 32, 1.3, FontWeight.w900),
      headlineMedium: _style(AppFonts.cairo, 28, 1.3, FontWeight.w800),
      headlineSmall: _style(AppFonts.cairo, 24, 1.35, FontWeight.w800),
      titleLarge: _style(AppFonts.cairo, 20, 1.4, FontWeight.w700),
      titleMedium: _style(AppFonts.cairo, 17, 1.45, FontWeight.w700),
      titleSmall: _style(AppFonts.cairo, 15, 1.45, FontWeight.w600),
      bodyLarge: _style(AppFonts.cairo, 16, 1.6, FontWeight.w400),
      bodyMedium: _style(AppFonts.cairo, 15, 1.6, FontWeight.w400),
      bodySmall: _style(AppFonts.cairo, 13, 1.55, FontWeight.w400),
      labelLarge: _style(AppFonts.cairo, 14, 1.4, FontWeight.w600),
      labelMedium: _style(AppFonts.cairo, 13, 1.4, FontWeight.w600),
      labelSmall: _style(AppFonts.cairo, 12, 1.4, FontWeight.w500),
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
        19,
        1.95,
        FontWeight.w400,
      ).copyWith(color: text),
      readingStrong: _style(
        AppFonts.amiri,
        19,
        1.95,
        FontWeight.w700,
      ).copyWith(color: text),
      quran: _style(
        AppFonts.amiriQuran,
        21,
        2.2,
        FontWeight.w400,
      ).copyWith(color: text),
      kicker: _style(
        AppFonts.cairo,
        13,
        1.4,
        FontWeight.w600,
      ).copyWith(color: dimText),
      numeral: _style(AppFonts.cairo, 72, 1, FontWeight.w900).copyWith(
        color: text,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }

  /// Biography and story body text (Amiri).
  final TextStyle reading;

  /// Emphasis inside reading text.
  final TextStyle readingStrong;

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
    TextStyle? quran,
    TextStyle? kicker,
    TextStyle? numeral,
  }) {
    return SuhbaTextStyles(
      reading: reading ?? this.reading,
      readingStrong: readingStrong ?? this.readingStrong,
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
      quran: TextStyle.lerp(quran, other.quran, t)!,
      kicker: TextStyle.lerp(kicker, other.kicker, t)!,
      numeral: TextStyle.lerp(numeral, other.numeral, t)!,
    );
  }
}
