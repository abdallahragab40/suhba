/// Bundled font families (see assets/fonts/LICENSES.md). Never fetched at
/// runtime.
abstract final class AppFonts {
  /// UI and reading text: headlines, titles, body, labels, biographies
  /// and stories. IBM Plex Sans Arabic, the interface face of Nusuk; it
  /// has true Arabic-Indic digits and ﷺ.
  static const plexArabic = 'IBMPlexSansArabic';

  /// The «صُحبة» wordmark and the icon's lettering only (since
  /// 2026-11-21); also the fallback for any rare glyph Plex lacks.
  static const amiri = 'Amiri';

  /// Qur'anic verses only.
  static const amiriQuran = 'AmiriQuran';
}
