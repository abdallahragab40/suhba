import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Bundled font families (see assets/fonts/LICENSES.md). Never fetched at
/// runtime.
abstract final class AppFonts {
  /// UI: headlines, titles, body, labels.
  static const cairo = 'Cairo';

  /// Biographies and stories, and calligraphic display names.
  static const amiri = 'Amiri';

  /// Qur'anic verses only.
  static const amiriQuran = 'AmiriQuran';
}

/// Adds the bundled fonts' OFL licences to the app's licence page.
void registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final (packages, asset) in const [
      (['Cairo'], 'assets/fonts/cairo/OFL.txt'),
      (['Amiri', 'Amiri Quran'], 'assets/fonts/amiri/OFL.txt'),
    ]) {
      yield LicenseEntryWithLineBreaks(
        packages,
        await rootBundle.loadString(asset),
      );
    }
  });
}
