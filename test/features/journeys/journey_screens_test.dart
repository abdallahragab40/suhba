@Tags(['golden'])
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';
import '../../helpers/journey_bundle.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);
  for (final brightness in Brightness.values) {
    for (final screen in ['catalog', 'journey', 'step']) {
      testApp('$screen ${brightness.name}', (tester) async {
        tester.view
          ..devicePixelRatio = 1
          ..physicalSize = const Size(400, 900);
        tester.platformDispatcher.platformBrightnessTestValue = brightness;
        addTearDown(() {
          tester.view.reset();
          tester.platformDispatcher.clearPlatformBrightnessTestValue();
        });
        const id = 'meet-the-companions';
        final location = switch (screen) {
          'catalog' => AppRoutes.journeys,
          'journey' => AppRoutes.journey(id),
          _ => AppRoutes.journeyStep(id, '$id.first'),
        };
        final app = AppUnderTest(
          location: location,
          bundle: screen == 'catalog'
              ? MemoryAssetBundle.builtContent()
              : journeyBundle(),
          // The choices are shown in a random order; fix it for the goldens.
          overrides: [quizRandomProvider.overrideWithValue(Random(3))],
        );
        if (screen != 'catalog') {
          await app.container.read(journeyActionsProvider).start(id);
        }
        await app.pump(tester);
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/${screen}_${brightness.name}.png'),
        );
        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
    }
  }

  testApp('TalkBack identifies the step number and completed status', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    const id = 'meet-the-companions';
    final app = AppUnderTest(
      location: AppRoutes.journey(id),
      bundle: journeyBundle(),
    );
    await app.container.read(journeyActionsProvider).start(id);
    final repository = app.container.read(journeyRepositoryProvider);
    final enrollment = (await repository.enrollments()).single;
    await repository.saveStep(
      JourneyStepProgress(
        journeyId: id,
        stepId: '$id.first',
        startedAt: enrollment.startedAt,
        updatedAt: enrollment.updatedAt,
        completedAt: enrollment.updatedAt,
      ),
    );
    await app.pump(tester);
    final step = find.bySemanticsLabel(RegExp('الخطوة ١ من ٢'));
    await tester.ensureVisible(step);
    expect(tester.getSemantics(step).getSemanticsData().value, 'أكملت الخطوة');
    handle.dispose();
  });

  testApp('journey screens fit large text and a tablet', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(400, 900);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(() {
      tester.view.reset();
      tester.platformDispatcher.clearTextScaleFactorTestValue();
    });
    const id = 'meet-the-companions';
    final app = AppUnderTest(
      location: AppRoutes.journey(id),
      bundle: journeyBundle(),
    );
    await app.container.read(journeyActionsProvider).start(id);
    await app.pump(tester);
    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(ListView), const Offset(0, -1200));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    app.router.go(AppRoutes.journeyStep(id, '$id.first'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    tester.view.physicalSize = const Size(1024, 1366);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
