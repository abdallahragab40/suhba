import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/home/domain/next_step.dart';
import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

void main() {
  final today = DateTime(2026, 11, 9);
  final started = today.subtract(const Duration(days: 2)).toUtc();
  final journey = Journey(
    id: 'one',
    title: const LocalizedText(ar: 'رحلة'),
    description: const LocalizedText(ar: 'قراءات'),
    review: const ReviewInfo(status: ReviewStatus.draft),
    steps: [
      for (final id in ['first', 'second'])
        JourneyStep(
          id: 'one.$id',
          title: LocalizedText(ar: id),
          readings: const [],
        ),
    ],
  );
  JourneyEnrollment enrollment({bool paused = false, DateTime? attempt}) =>
      JourneyEnrollment(
        journeyId: 'one',
        startedAt: attempt ?? started,
        updatedAt: started,
        paused: paused,
      );
  JourneyStepProgress step({
    DateTime? completed,
    DateTime? attempt,
    bool skipped = false,
    String id = 'one.first',
  }) => JourneyStepProgress(
    journeyId: 'one',
    stepId: id,
    startedAt: attempt ?? started,
    updatedAt: today.toUtc(),
    completedAt: completed,
    skipped: skipped,
  );
  final reading = ReadingProgress(
    target: ProgressTarget.chapter,
    targetId: 'the-cave.2',
    parentId: 'the-cave',
    fraction: .4,
    completed: false,
    contentVersion: '0.3.0',
    updatedAt: today,
  );
  NextStep? choose({
    List<JourneyEnrollment> e = const [],
    List<JourneyStepProgress> s = const [],
    int due = 0,
    bool history = true,
    List<ReadingProgress> r = const [],
  }) => chooseNextStep(
    today: today,
    journeys: [journey],
    enrollments: e,
    steps: s,
    dueCount: due,
    reading: r,
    hasHistory: history,
  );

  test(
    'priority is journey, due review, unfinished reading, then a first journey',
    () {
      expect(
        (choose(e: [enrollment()], due: 2, r: [reading]) as JourneyNextStep)
            .step
            .id,
        'one.first',
      );
      expect(choose(due: 2, r: [reading]), isA<ReviewNextStep>());
      expect(choose(r: [reading]), isA<ReadingNextStep>());
      expect(choose(history: false), isA<StartJourneyNextStep>());
      expect(choose(), isNull);
    },
  );
  test(
    'a step completed today or a paused journey lets due review take priority',
    () {
      expect(
        choose(
          e: [enrollment()],
          s: [step(completed: DateTime(2026, 11, 9, 8).toUtc())],
          due: 1,
        ),
        isA<ReviewNextStep>(),
      );
      expect(
        choose(e: [enrollment(paused: true)], due: 1),
        isA<ReviewNextStep>(),
      );
      expect(
        (choose(
                  e: [enrollment()],
                  s: [step(completed: DateTime(2026, 11, 8, 23).toUtc())],
                )
                as JourneyNextStep)
            .step
            .id,
        'one.second',
      );
    },
  );
  test('skips unlock the next step without counting as today’s reading', () {
    expect(
      (choose(e: [enrollment()], s: [step(skipped: true)], due: 1)
              as JourneyNextStep)
          .step
          .id,
      'one.second',
    );
    expect(
      choose(
        e: [enrollment()],
        s: [
          step(skipped: true),
          step(skipped: true, id: 'one.second'),
        ],
      ),
      isNull,
    );
  });
  test(
    'old attempts and removed step IDs never suppress a current suggestion',
    () {
      expect(
        (choose(
                  e: [enrollment(attempt: today.toUtc())],
                  s: [step(completed: today.toUtc())],
                )
                as JourneyNextStep)
            .step
            .id,
        'one.first',
      );
      expect(
        (choose(
                  e: [enrollment()],
                  s: [step(completed: today.toUtc(), id: 'one.removed')],
                )
                as JourneyNextStep)
            .step
            .id,
        'one.first',
      );
    },
  );
}
