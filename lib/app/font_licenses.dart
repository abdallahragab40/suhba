import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The bundled fonts and the licence each ships with (SIL OFL 1.1), for
/// the licences page (About). Amiri Quran comes from the Amiri project
/// under the same licence text, so one file serves both.
const fontLicenseFiles = <(List<String>, String)>[
  (['IBM Plex Sans Arabic'], 'assets/fonts/ibm_plex_sans_arabic/OFL.txt'),
  (['Amiri', 'Amiri Quran'], 'assets/fonts/amiri/OFL.txt'),
];

/// The fonts' licences, read from the app's assets.
Stream<LicenseEntry> fontLicenses(AssetBundle bundle) async* {
  for (final (packages, path) in fontLicenseFiles) {
    yield LicenseEntryWithLineBreaks(packages, await bundle.loadString(path));
  }
}

/// Adds the fonts' licences to those Flutter lists on its licences page,
/// beside the packages' own. Read only when that page opens.
void registerFontLicenses({AssetBundle? bundle}) {
  LicenseRegistry.addLicense(() => fontLicenses(bundle ?? rootBundle));
}
