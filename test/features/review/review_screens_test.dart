@Tags(['golden'])
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/review_fixture.dart';

void main() {
  setUpAll(loadAppFonts);
  for (final brightness in Brightness.values) {
    for (final screen in ['question', 'feedback', 'learned', 'empty']) {
      testApp('$screen ${brightness.name}', (tester) async {
        tester.view
          ..devicePixelRatio = 1
          ..physicalSize = const Size(400, 1000);
        tester.platformDispatcher.platformBrightnessTestValue = brightness;
        addTearDown(() {
          tester.view.reset();
          tester.platformDispatcher.clearPlatformBrightnessTestValue();
        });
        final app = AppUnderTest(
          location: screen == 'learned' ? AppRoutes.learned : AppRoutes.review,
          // The choices are shown in a random order; fix it for the goldens.
          overrides: [quizRandomProvider.overrideWithValue(Random(3))],
        );
        if (screen != 'empty') {
          await seedReview(app, box: screen == 'learned' ? 4 : 1);
        }
        if (screen == 'learned') {
          await seedReview(app, key: 'kunya:ali', box: 2, right: 2, wrong: 0);
          await seedReview(app, key: 'event-year:badr');
        }
        await app.pump(tester);
        if (screen == 'feedback') {
          final due = app.container
              .read(dueReviewsProvider)
              .requireValue
              .single;
          await tester.tap(
            find.byKey(
              ValueKey('review-choice:${(due.question.correct + 1) % 4}'),
            ),
          );
          await tester.pumpAndSettle();
        }
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/${screen}_${brightness.name}.png'),
        );
        final semantics = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        semantics.dispose();
      });
    }
  }
  testApp('review and learning pages fit large text and tablet widths', (
    tester,
  ) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(400, 1000);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(() {
      tester.view.reset();
      tester.platformDispatcher.clearTextScaleFactorTestValue();
    });
    final app = AppUnderTest(location: AppRoutes.review);
    await seedReview(app);
    await app.pump(tester);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byKey(const ValueKey('review-choice:0')));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    app.router.go(AppRoutes.learned);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    tester.view.physicalSize = const Size(1024, 1366);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
