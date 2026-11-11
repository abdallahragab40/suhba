import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/features/biography/presentation/section_reader_page.dart';
import 'package:suhba/features/home/presentation/home_page.dart';
import 'package:suhba/features/journeys/presentation/journey_page.dart';

import '../helpers/app_harness.dart';

void main() {
  testApp('journey reading returns through the journey to the original Home', (
    tester,
  ) async {
    final app = AppUnderTest();
    await app.pump(tester);
    for (final route in [
      AppRoutes.journeys,
      AppRoutes.journey('meet-the-companions'),
      AppRoutes.section('abu-bakr', 'abu-bakr.early-life'),
    ]) {
      unawaited(app.router.push<void>(route));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
    expect(find.byType(SectionReaderPage), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(JourneyPage), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(app.router.canPop(), isFalse);
  });

  for (final overlay in [
    AppRoutes.review,
    AppRoutes.learned,
    AppRoutes.relations(),
  ]) {
    testApp(
      '$overlay can repeatedly open content and return to its own stack',
      (tester) async {
        final app = AppUnderTest();
        await app.pump(tester);
        unawaited(app.router.push<void>(overlay));
        await tester.pumpAndSettle();
        for (final route in [
          AppRoutes.companion('abu-bakr'),
          AppRoutes.section('abu-bakr', 'abu-bakr.early-life'),
          AppRoutes.story('unknown-story'),
          AppRoutes.chapter('unknown-story', 'unknown-chapter'),
          AppRoutes.seerahChapter('hijrah-to-madinah'),
          AppRoutes.seerahTopic('unknown-topic'),
          AppRoutes.seerahTimeline,
        ]) {
          unawaited(app.router.push<void>(route));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(app.location, '/content$route');
          await tester.binding.handlePopRoute();
          await tester.pumpAndSettle();
          expect(app.location, overlay);
          expect(tester.takeException(), isNull);
        }
      },
    );
  }
}
