import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/widgets/scene_backdrop.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/home/presentation/home_page.dart';
import 'package:suhba/features/welcome/presentation/welcome_controller.dart';
import 'package:suhba/features/welcome/presentation/welcome_page.dart';
import 'package:suhba/shared/content/domain/content_manifest.dart';
import 'package:suhba/shared/content/domain/review.dart';
import 'package:suhba/shared/content/providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';
import '../../helpers/pump_app.dart';

/// The welcome screens: on the first launch only, until finished or
/// skipped.
void main() {
  setUpAll(loadAppFonts);

  Future<AppUnderTest> open(
    WidgetTester tester, {
    MemorySettingsStore? store,
    ContentManifest? manifest,
  }) async {
    final app = AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      welcome: true,
      settings: store,
      overrides: [
        if (manifest != null)
          contentManifestProvider.overrideWith((ref) async => manifest),
      ],
    );
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
    for (final kicker in ['السيرة النبوية', 'الصحابة', 'رحلتك', 'المنهج']) {
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
      expect(find.text(kicker), findsWidgets, reason: kicker);
    }
    expect(find.text('التالي'), findsNothing);
    await tester.tap(find.text('ابدأ'));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomePage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
    expect(store.getString(SettingsKeys.welcomeSeen), WelcomeController.seen);
  });

  testApp('the method page says the content is still under review', (
    tester,
  ) async {
    await open(tester);
    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
    }
    expect(find.textContaining('في مراجعة أولية'), findsOneWidget);
    expect(find.textContaining('روجع المحتوى تحريريًا'), findsNothing);
  });

  testApp('a published build says the content was reviewed', (tester) async {
    await open(
      tester,
      manifest: const ContentManifest(
        contentVersion: '1',
        schemaVersion: 1,
        channel: ContentChannel.published,
        companionCount: 0,
        storyCount: 0,
        approvedCount: 0,
        unapprovedCount: 0,
      ),
    );
    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
    }
    expect(find.textContaining('روجع المحتوى تحريريًا'), findsOneWidget);
    expect(find.textContaining('في مراجعة أولية'), findsNothing);
  });

  testApp('after the upgrade from 1.0, only what is new, once', (tester) async {
    final store = MemorySettingsStore();
    await store.setString(
      SettingsKeys.welcomeSeen,
      WelcomeController.seenBeforeJourneys,
    );
    await open(tester, store: store);
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.text('جديد في صُحبة'), findsOneWidget);
    expect(find.text('خطوة كل يوم'), findsOneWidget);
    expect(find.text('التالي'), findsNothing);
    expect(find.text('مرحبًا بك'), findsNothing);
    await tester.tap(find.text('ابدأ'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(store.getString(SettingsKeys.welcomeSeen), WelcomeController.seen);

    final second = AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      welcome: true,
      settings: store,
    );
    await second.pump(tester);
    expect(find.byType(WelcomePage), findsNothing);
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

    final second = AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      welcome: true,
      settings: store,
    );
    await second.pump(tester);
    expect(find.byType(WelcomePage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testApp('every page fits at text scale 2.0', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await open(tester);
    for (var i = 0; i < 4; i++) {
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull);
  });

  group('on a small phone (320 × 569)', () {
    Future<void> small(WidgetTester tester, double scale) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(320, 569)
        ..padding = const FakeViewPadding(top: 24);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await open(tester);
    }

    String body(WidgetTester tester, int page) {
      final l10n = AppLocalizations.of(tester.element(find.byType(PageView)));
      return [
        l10n.welcome1Body,
        l10n.welcome2Body,
        l10n.welcome3Body,
        l10n.welcomeJourneysBody,
        l10n.welcome4Body,
      ][page];
    }

    testApp('every page shows all its words without scrolling', (tester) async {
      await small(tester, 1);
      final view = tester.getRect(find.byType(PageView));
      for (var i = 0; i < 5; i++) {
        final text = tester.getRect(find.text(body(tester, i)));
        expect(text.top, greaterThanOrEqualTo(view.top), reason: 'page $i');
        expect(text.bottom, lessThanOrEqualTo(view.bottom), reason: 'page $i');
        expect(tester.takeException(), isNull);
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
      }
    });

    testApp('the first page keeps its scene when there is room', (
      tester,
    ) async {
      await small(tester, 1);
      final scene = find.byType(SceneBackdrop).first;
      expect(tester.getSize(scene).height, greaterThanOrEqualTo(120));
    });

    testApp('at 2× the words start on screen and the scene gives way', (
      tester,
    ) async {
      await small(tester, 2);
      final view = tester.getRect(find.byType(PageView));
      for (var i = 0; i < 5; i++) {
        expect(find.byType(SceneBackdrop), findsNothing, reason: 'page $i');
        final text = tester.getRect(find.text(body(tester, i)));
        expect(text.top, greaterThanOrEqualTo(view.top), reason: 'page $i');
        expect(text.top, lessThan(view.bottom - 60), reason: 'page $i');
        expect(tester.takeException(), isNull);
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
      }
    });

    testApp('at 2× the button grows to hold its label', (tester) async {
      await small(tester, 2);
      // The pill itself, inside the button's 48 dp tap target.
      final button = tester.getRect(
        find.descendant(
          of: find.byType(FilledButton),
          matching: find.byType(Material),
        ),
      );
      final label = tester.getRect(
        find.descendant(
          of: find.byType(FilledButton),
          matching: find.text('التالي'),
        ),
      );
      // The label's line (twice its 28 dp size) sits inside the pill.
      expect(label.height, greaterThanOrEqualTo(2 * 28 - 0.5));
      expect(button.top, lessThanOrEqualTo(label.top));
      expect(button.bottom, greaterThanOrEqualTo(label.bottom));
      expect(tester.takeException(), isNull);
    });
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

  testApp('what is new after the upgrade', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);
    final store = MemorySettingsStore();
    await store.setString(
      SettingsKeys.welcomeSeen,
      WelcomeController.seenBeforeJourneys,
    );
    await open(tester, store: store);
    await expectLater(
      find.byType(WelcomePage),
      matchesGoldenFile('goldens/welcome_whats_new.png'),
    );
  });
}
