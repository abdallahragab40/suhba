import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/format/digits.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/features/home/presentation/home_page.dart';

import '../helpers/app_harness.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) => AppUnderTest().pump(tester);

  testApp('starts on Home, in Arabic, right-to-left, with the app name', (
    tester,
  ) async {
    await pumpApp(tester);

    final context = tester.element(find.byType(HomePage));
    expect(Localizations.localeOf(context), const Locale('ar'));
    expect(Directionality.of(context), TextDirection.rtl);
    expect(find.text('صُحبة'), findsWidgets);
  });

  testApp('stays Arabic even when the device language is English', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = const [Locale('en', 'US')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    await pumpApp(tester);

    final context = tester.element(find.byType(HomePage));
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testApp('provides an Arabic-Indic display formatter by default', (
    tester,
  ) async {
    await pumpApp(tester);

    final formatter = DisplayFormatter.of(
      tester.element(find.byType(HomePage)),
    );
    expect(formatter.digitStyle, DigitStyle.arabicIndic);
    expect(formatter.integer(13), '١٣');
  });
}
