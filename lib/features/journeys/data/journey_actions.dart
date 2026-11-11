import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/journeys/data/drift_journey_repository.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/domain/journey_runtime.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/review/data/drift_review_repository.dart';

/// Checks completion in the same transaction that persists it. Opening a page
/// or choosing a correct answer alone can never finish a step.
class JourneyActions {
  JourneyActions({
    required this.db,
    required this.journeys,
    required this.reading,
    required this.reviews,
    required this.clock,
  });
  final AppDatabase db;
  final DriftJourneyRepository journeys;
  final ReadingProgressRepository reading;
  final DriftReviewRepository reviews;
  final DateTime Function() clock;

  Future<void> start(String id) => db.transaction(() async {
    if ((await journeys.enrollments()).any((e) => e.journeyId == id)) return;
    final now = clock().toUtc();
    await journeys.saveEnrollment(
      JourneyEnrollment(
        journeyId: id,
        startedAt: now,
        updatedAt: now,
        paused: false,
      ),
    );
  });

  Future<void> pause(String id, bool paused) => db.transaction(() async {
    final e = (await journeys.enrollments()).firstWhere(
      (e) => e.journeyId == id,
    );
    await journeys.saveEnrollment(
      JourneyEnrollment(
        journeyId: id,
        startedAt: e.startedAt,
        updatedAt: clock().toUtc(),
        paused: paused,
      ),
    );
  });

  /// Global reading/review history is retained. Only this journey's attempt
  /// restarts, so following two journeys never resets the other one.
  Future<void> restart(String id) => db.transaction(() async {
    final old = (await journeys.enrollments()).firstWhere(
      (e) => e.journeyId == id,
    );
    var now = clock().toUtc();
    // Drift stores seconds: keep attempt IDs distinct even on rapid restarts.
    if (now.difference(old.startedAt).inSeconds < 1) {
      now = old.startedAt.add(const Duration(seconds: 1));
    }
    await journeys.clearSteps(id);
    await journeys.saveEnrollment(
      JourneyEnrollment(
        journeyId: id,
        startedAt: now,
        updatedAt: now,
        paused: false,
      ),
    );
  });

  Future<JourneyEnrollment> _active(
    JourneyRuntime runtime,
    String stepId,
  ) async {
    final e = (await journeys.enrollments())
        .where((e) => e.journeyId == runtime.journey.id)
        .firstOrNull;
    if (e == null ||
        e.paused ||
        !runtime.unlocked(
          stepId,
          (await journeys.steps())
              .where((p) => p.startedAt == e.startedAt)
              .toList(),
        )) {
      throw StateError('Journey step is not active');
    }
    if (runtime.missing(stepId)) throw StateError('Journey passage is missing');
    final positions = await reading.all();
    final step = runtime.journey.steps.firstWhere((s) => s.id == stepId);
    for (final ref in step.readings) {
      if (!positions.any(
        (p) =>
            p.target == ref.progressTarget &&
            p.targetId == ref.targetId &&
            p.completed,
      )) {
        throw StateError('Finish every passage before answering or completing');
      }
    }
    return e;
  }

  Future<void> answer(
    JourneyRuntime runtime,
    String stepId,
    String questionKey,
    int choice,
  ) => db.transaction(() async {
    final e = await _active(runtime, stepId);
    final q = runtime.questions[stepId]!.firstWhere(
      (q) => q.key == questionKey,
    );
    if (choice < 0 || choice >= q.choices.length) {
      throw ArgumentError.value(choice);
    }
    final prior = (await journeys.steps())
        .where((p) => p.journeyId == e.journeyId && p.stepId == stepId)
        .firstOrNull;
    if (prior?.answeredKeys.contains(questionKey) ?? false) return;
    await reviews.recordAnswer(questionKey, correct: choice == q.correct);
    await journeys.saveStep(
      JourneyStepProgress(
        journeyId: e.journeyId,
        stepId: stepId,
        startedAt: e.startedAt,
        updatedAt: clock().toUtc(),
        completedAt: prior?.completedAt,
        answeredKeys: {...?prior?.answeredKeys, questionKey},
      ),
    );
  });

  Future<void> complete(JourneyRuntime runtime, String stepId) =>
      db.transaction(() async {
        final e = await _active(runtime, stepId);
        final prior = (await journeys.steps())
            .where((p) => p.journeyId == e.journeyId && p.stepId == stepId)
            .firstOrNull;
        if (prior?.finished ?? false) return;
        final answered = prior?.answeredKeys ?? const <String>{};
        if (!runtime.questions[stepId]!.every(
          (q) => answered.contains(q.key),
        )) {
          throw StateError('Answer every question before completing');
        }
        final now = clock().toUtc();
        await journeys.saveStep(
          JourneyStepProgress(
            journeyId: e.journeyId,
            stepId: stepId,
            startedAt: e.startedAt,
            updatedAt: now,
            completedAt: now,
            answeredKeys: answered,
          ),
        );
      });
}
