import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';
import 'package:siyar_sahaba/features/home/presentation/home_page.dart';
import 'package:siyar_sahaba/features/welcome/presentation/welcome_page.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart';

/// The welcome screens: on the first launch only, until finished or
/// skipped.
void main() {
  setUpAll(loadAppFonts);

  Future<AppUnderTest> open(
    WidgetTester tester, {
    MemorySettingsStore? store,
  }) async {
    final app = AppUnderTest(welcome: true, settings: store);
    await app.pump(tester);
    return app;
  }

  testApp('the first launch opens on the welcome screens', (tester) async {
    await open(tester);
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
    expect(find.text('مرحبًا بك'), findsOneWidget);
  });

  testApp('next pages through to start, which opens the app', (tester) async {
    final store = MemorySettingsStore();
    await open(tester, store: store);
    for (final kicker in ['السيرة النبوية', 'الصحابة', 'المنهج']) {
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
      expect(find.text(kicker), findsWidgets, reason: kicker);
    }
    expect(find.text('التالي'), findsNothing);
    await tester.tap(find.text('ابدأ'));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomePage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
    expect(store.getString(SettingsKeys.welcomeSeen), isNotNull);
  });

  testApp('skip opens the app straight away', (tester) async {
    await open(tester);
    await tester.tap(find.text('تخطَّ'));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomePage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testApp('once seen, never again', (tester) async {
    final store = MemorySettingsStore();
    await open(tester, store: store);
    await tester.tap(find.text('تخطَّ'));
    await tester.pumpAndSettle();

    final second = AppUnderTest(welcome: true, settings: store);
    await second.pump(tester);
    expect(find.byType(WelcomePage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testApp('every page fits at text scale 2.0', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await open(tester);
    for (var i = 0; i < 3; i++) {
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull);
  });

  testApp('the first page', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);
    await open(tester);
    await expectLater(
      find.byType(WelcomePage),
      matchesGoldenFile('goldens/welcome_first.png'),
    );
  });
}
