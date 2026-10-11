import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/gallery/design_gallery_page.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/format/digits.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/features/home/presentation/home_page.dart';

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

  testApp('the gallery theme button cycles system → light → dark', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    // Tall enough for the gallery link at the end of Settings.
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(800, 2000);
    addTearDown(tester.view.reset);
    await pumpApp(tester);

    await tester.tap(find.byTooltip('الإعدادات'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('معرض نظام التصميم'));
    await tester.tap(find.text('معرض نظام التصميم'));
    // The gallery contains a pulsing skeleton, so pump past the page
    // transition rather than settling.
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    Color background() => Theme.of(
      tester.element(find.byType(DesignGalleryPage)),
    ).scaffoldBackgroundColor;
    Finder toggle(String modeLabel) =>
        find.byTooltip('تغيير المظهر: $modeLabel');

    expect(toggle('حسب النظام'), findsOneWidget);
    expect(background(), Palette.paper); // system on a light device

    await tester.tap(toggle('حسب النظام'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(toggle('المظهر الفاتح'), findsOneWidget);
    expect(background(), Palette.paper);

    await tester.tap(toggle('المظهر الفاتح'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(toggle('المظهر الداكن'), findsOneWidget);
    expect(background(), Palette.ink);
  });
}
