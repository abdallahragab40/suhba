import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/rating/domain/rating_milestones.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart';

ReadingProgress _read(
  String id, {
  ProgressTarget target = ProgressTarget.section,
  String parent = 'abu-bakr',
}) => ReadingProgress(
  target: target,
  targetId: id,
  parentId: parent,
  fraction: 1,
  completed: true,
  contentVersion: 'test',
  updatedAt: DateTime(2026, 10, 9),
);

final _now = DateTime(2026, 11, 22, 10);

void main() {
  setUpAll(loadAppFonts);

  group('reachedAchievements', () {
    Set<Achievement> reached({
      List<ReadingProgress> completed = const [],
      List<JourneyEnrollment> enrollments = const [],
      List<JourneyStepProgress> steps = const [],
    }) => reachedAchievements(
      completed: completed,
      seerah: null,
      journeys: [_journey],
      enrollments: enrollments,
      steps: steps,
    );

    test('five finished passages, of any kind', () {
      final four = [for (var i = 0; i < 4; i++) _read('s$i')];
      expect(reached(completed: four), isEmpty);
      expect(reached(completed: [...four, _read('c1')]), {
        (kind: RatingMilestone.fiveReadings, id: ''),
      });
    });

    test('a journey counts once every step of its attempt is done', () {
      final start = DateTime(2026, 11);
      final enrolled = JourneyEnrollment(
        journeyId: 'j',
        startedAt: start,
        updatedAt: start,
        paused: false,
      );
      JourneyStepProgress step(String id, {DateTime? attempt}) =>
          JourneyStepProgress(
            journeyId: 'j',
            stepId: id,
            startedAt: attempt ?? start,
            updatedAt: start,
            completedAt: start,
          );
      expect(reached(enrollments: [enrolled], steps: [step('a')]), isEmpty);
      expect(
        reached(
          enrollments: [enrolled],
          steps: [
            step('a'),
            step('b', attempt: DateTime(2026, 10)),
          ],
        ),
        isEmpty,
        reason: 'a step from an earlier attempt',
      );
      expect(reached(enrollments: [enrolled], steps: [step('a'), step('b')]), {
        (kind: RatingMilestone.journey, id: 'j'),
      });
    });
  });

  group('decideRatingPrompt', () {
    const five = (kind: RatingMilestone.fiveReadings, id: '');
    const period1 = (kind: RatingMilestone.seerahPeriod, id: 'makkah');
    const period2 = (kind: RatingMilestone.seerahPeriod, id: 'madinah');
    const seerah = (kind: RatingMilestone.wholeSeerah, id: '');

    test('what the reader had done before is taken as known', () {
      final d = decideRatingPrompt(
        state: const RatingState(known: null),
        reached: {five, period1},
        now: _now,
      );
      expect(d.ask, isFalse);
      expect(d.state.known, {'fiveReadings:', 'seerahPeriod:makkah'});
    });

    test('a new achievement asks, once per kind', () {
      var d = decideRatingPrompt(
        state: const RatingState(known: {}),
        reached: {period1},
        now: _now,
      );
      expect(d.ask, isTrue);
      expect(d.state.asked, {RatingMilestone.seerahPeriod});
      // Another period, days later: that kind has asked already.
      d = decideRatingPrompt(
        state: d.state,
        reached: {period1, period2},
        now: _now.add(const Duration(days: 9)),
      );
      expect(d.ask, isFalse);
      // The whole Seerah, later still: a new kind.
      d = decideRatingPrompt(
        state: d.state,
        reached: {period1, period2, seerah},
        now: _now.add(const Duration(days: 20)),
      );
      expect(d.ask, isTrue);
    });

    test('two achievements at once ask once, for both kinds', () {
      final d = decideRatingPrompt(
        state: const RatingState(known: {}),
        reached: {period1, seerah},
        now: _now,
      );
      expect(d.ask, isTrue);
      expect(d.state.asked, {
        RatingMilestone.seerahPeriod,
        RatingMilestone.wholeSeerah,
      });
    });

    test('never twice within the minimum gap', () {
      final first = decideRatingPrompt(
        state: const RatingState(known: {}),
        reached: {five},
        now: _now,
      );
      final soon = decideRatingPrompt(
        state: first.state,
        reached: {five, period1},
        now: _now.add(const Duration(hours: 3)),
      );
      expect(soon.ask, isFalse);
      // That period passed unasked; the kind is still open for the next.
      expect(soon.state.asked, {RatingMilestone.fiveReadings});
      final later = decideRatingPrompt(
        state: soon.state,
        reached: {five, period1, period2},
        now: _now.add(ratingMinimumGap),
      );
      expect(later.ask, isTrue);
    });
  });

  testApp('finishing a fifth passage asks the store for its rating card', (
    tester,
  ) async {
    final app = AppUnderTest();
    final repo = app.container.read(readingProgressRepositoryProvider);
    await app.pump(tester);
    for (var i = 0; i < 4; i++) {
      await repo.save(_read('s$i'));
    }
    await tester.pumpAndSettle();
    expect(app.rating.reviews, 0);

    await repo.save(_read('s4'));
    await tester.pumpAndSettle();
    expect(app.rating.reviews, 1);
    final store = app.container.read(settingsStoreProvider);
    expect(store.getString(SettingsKeys.ratingAsked), '["fiveReadings"]');

    await repo.save(_read('s5'));
    await tester.pumpAndSettle();
    expect(app.rating.reviews, 1, reason: 'that kind has asked');
  });

  testApp('a reader with history is not asked on opening the update', (
    tester,
  ) async {
    final app = AppUnderTest();
    final repo = app.container.read(readingProgressRepositoryProvider);
    for (var i = 0; i < 6; i++) {
      await repo.save(_read('s$i'));
    }
    await app.pump(tester);
    expect(app.rating.reviews, 0);
  });

  testApp('Settings opens the store page to rate the app', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3200);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: '/settings');
    await app.pump(tester);
    await tester.tap(find.text('قيّم التطبيق'));
    await tester.pump();
    expect(app.rating.listings, 1);
    expect(app.rating.reviews, 0);
  });
}

const _journey = Journey(
  id: 'j',
  title: LocalizedText(ar: 'رحلة'),
  description: LocalizedText(ar: 'وصف'),
  steps: [
    JourneyStep(
      id: 'a',
      title: LocalizedText(ar: 'أ'),
      readings: [],
    ),
    JourneyStep(
      id: 'b',
      title: LocalizedText(ar: 'ب'),
      readings: [],
    ),
  ],
  review: ReviewInfo(status: ReviewStatus.approved),
);
