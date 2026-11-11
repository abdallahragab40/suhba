import 'package:suhba/core/result/failure.dart';
import 'package:suhba/features/journeys/data/drift_journey_repository.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/domain/journey_reading.dart';
import 'package:suhba/shared/content/domain/content_repository.dart';

/// Missing passages skip their step, retaining its answers and completion date.
/// Unknown journeys/step IDs are retained for later content editions and exports.
/// A load failure never counts as a removal. Returns the number of failed lookups.
Future<int> reconcileJourneys({
  required ContentRepository content,
  required DriftJourneyRepository journeys,
  required DateTime Function() clock,
}) async {
  var failures = 0;
  for (final enrollment in await journeys.enrollments()) {
    try {
      final result = await content.journey(enrollment.journeyId);
      if (result.failureOrNull is NotFoundFailure) continue;
      final journey = result.getOrThrow();
      for (final step in journey.steps) {
        final loaded = await Future.wait(
          step.readings.map((r) => resolveJourneyReading(content, r)),
        );
        if (loaded.every((r) => r != null)) continue;
        await journeys.db.transaction(() async {
          final current = (await journeys.enrollments())
              .where((e) => e.journeyId == enrollment.journeyId)
              .firstOrNull;
          if (current?.startedAt != enrollment.startedAt) return;
          final prior = (await journeys.steps())
              .where((p) => p.journeyId == journey.id && p.stepId == step.id)
              .firstOrNull;
          if (prior?.skipped ?? false) return;
          await journeys.saveStep(
            JourneyStepProgress(
              journeyId: journey.id,
              stepId: step.id,
              startedAt: enrollment.startedAt,
              updatedAt: clock().toUtc(),
              skipped: true,
              completedAt: prior?.completedAt,
              answeredKeys: prior?.answeredKeys ?? const {},
            ),
          );
        });
      }
    } on Failure {
      failures++;
    } on Exception {
      // A malformed journey record or stored row must not stop the checks of
      // other journeys, saved items and reading positions.
      failures++;
    } on StateError {
      failures++;
    }
  }
  return failures;
}
