import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/app.dart';
import 'package:suhba/core/format/digits.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Loads every font declared in pubspec.yaml so text renders with the real
/// Cairo and Amiri glyphs instead of the test font. Needed for goldens.
Future<void> loadAppFonts() async {
  final manifest =
      jsonDecode(await rootBundle.loadString('FontManifest.json'))
          as List<Object?>;
  for (final family in manifest.cast<Map<String, Object?>>()) {
    final loader = FontLoader(family['family']! as String);
    for (final font
        in (family['fonts']! as List<Object?>).cast<Map<String, Object?>>()) {
      loader.addFont(rootBundle.load(font['asset']! as String));
    }
    await loader.load();
  }
}

/// Wraps [child] like the real app does: Arabic locale (RTL), [theme], a
/// [DisplayFormatterScope], plus test knobs for text scale and motion.
Widget testHarness({
  required Widget child,
  required ThemeData theme,
  double textScale = 1,
  bool disableAnimations = false,
  DigitStyle digitStyle = DigitStyle.arabicIndic,
}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: appLocale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: theme,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(textScale),
        disableAnimations: disableAnimations,
      ),
      child: DisplayFormatterScope(
        formatter: DisplayFormatter(AppLocalizations.of(context), digitStyle),
        child: child!,
      ),
    ),
    home: child,
  );
}
