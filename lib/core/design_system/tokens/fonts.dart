/// Bundled font families (see assets/fonts/LICENSES.md). Never fetched at
/// runtime.
abstract final class AppFonts {
  /// UI: headlines, titles, body, labels. Draws Arabic-Indic digits with
  /// Western shapes and has no ﷺ; its styles fall back to Amiri.
  static const zain = 'Zain';

  /// Biographies and stories, and calligraphic display names.
  static const amiri = 'Amiri';

  /// Qur'anic verses only.
  static const amiriQuran = 'AmiriQuran';
}
