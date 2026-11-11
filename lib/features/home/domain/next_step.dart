import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';

sealed class NextStep {
  const NextStep();
}

class JourneyNextStep extends NextStep {
  const JourneyNextStep(this.journey, this.step);
  final Journey journey;
  final JourneyStep step;
}

class ReviewNextStep extends NextStep {
  const ReviewNextStep(this.count);
  final int count;
}

class ReadingNextStep extends NextStep {
  const ReadingNextStep(this.progress);
  final ReadingProgress progress;
}

class StartJourneyNextStep extends NextStep {
  const StartJourneyNextStep();
}

/// A gentle daily suggestion, not a lock: a journey remains readable after
/// today's step. Paused journeys never outrank review or unfinished reading.
NextStep? chooseNextStep({
  required DateTime today,
  required List<Journey> journeys,
  required List<JourneyEnrollment> enrollments,
  required List<JourneyStepProgress> steps,
  required int dueCount,
  required List<ReadingProgress> reading,
  required bool hasHistory,
}) {
  DateTime activity(JourneyEnrollment e) => steps
      .where(
        (s) =>
            s.journeyId == e.journeyId &&
            s.startedAt == e.startedAt &&
            !s.skipped,
      )
      .fold<DateTime>(
        e.updatedAt,
        (last, s) => s.updatedAt.isAfter(last) ? s.updatedAt : last,
      );
  final active = enrollments.where((e) => !e.paused).toList()
    ..sort((a, b) {
      final recent = activity(b).compareTo(activity(a));
      return recent != 0 ? recent : a.journeyId.compareTo(b.journeyId);
    });
  for (final e in active) {
    final j = journeys.where((j) => j.id == e.journeyId).firstOrNull;
    if (j == null) continue;
    final progress = steps
        .where((s) => s.journeyId == j.id && s.startedAt == e.startedAt)
        .toList();
    final doneToday = progress.any((s) {
      if (s.completedAt == null ||
          s.skipped ||
          !j.steps.any((step) => step.id == s.stepId)) {
        return false;
      }
      final local = s.completedAt!.toLocal();
      return local.year == today.year &&
          local.month == today.month &&
          local.day == today.day;
    });
    if (doneToday) continue;
    final next = j.steps
        .where((s) => !progress.any((p) => p.stepId == s.id && p.finished))
        .firstOrNull;
    if (next != null) return JourneyNextStep(j, next);
  }
  if (dueCount > 0) return ReviewNextStep(dueCount);
  final unfinished = reading.where((p) => !p.completed).toList()
    ..sort((a, b) {
      final recent = b.updatedAt.compareTo(a.updatedAt);
      return recent != 0 ? recent : a.targetId.compareTo(b.targetId);
    });
  if (unfinished.isNotEmpty) return ReadingNextStep(unfinished.first);
  if (!hasHistory && journeys.isNotEmpty) return const StartJourneyNextStep();
  return null;
}
