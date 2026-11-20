import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/welcome/presentation/welcome_page.dart';

import '../../helpers/app_harness.dart';

/// E4 (review A1): «ابدأ من هنا», the first journey by order, is reachable
/// from the welcome screens and, for a new reader, from Home.
void main() {
  void tall(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
  }

  testApp('the first journey is «ابدأ من هنا», five short steps', (
    tester,
  ) async {
    final journeys = await AppUnderTest().container.read(
      journeysProvider.future,
    );
    expect(journeys.first.id, 'start-here');
    expect(journeys.first.steps, hasLength(5));
  });

  testApp('a new reader finds it on Home; it goes once reading starts', (
    tester,
  ) async {
    tall(tester);
    final app = AppUnderTest();
    await app.pump(tester);
    await tester.tap(find.text('جديد هنا؟ ابدأ من هنا'));
    await tester.pumpAndSettle();
    expect(app.location, '/journeys/start-here');

    await app.container.read(journeyActionsProvider).start('start-here');
    app.router.go('/home');
    await tester.pumpAndSettle();
    expect(find.text('جديد هنا؟ ابدأ من هنا'), findsNothing);
  });

  testApp('the last welcome screen offers it', (tester) async {
    tall(tester);
    final app = AppUnderTest(welcome: true, settings: MemorySettingsStore());
    await app.pump(tester);
    while (find.text('ابدأ من هنا').evaluate().isEmpty) {
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('ابدأ من هنا'));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomePage), findsNothing);
    expect(app.location, '/journeys/start-here');
    // Home lies beneath: Back returns to it rather than leaving the app.
    expect(app.router.canPop(), isTrue);
    app.router.pop();
    await tester.pumpAndSettle();
    expect(app.location, '/home');
  });
}
