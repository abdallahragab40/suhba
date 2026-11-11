import 'package:suhba/features/journeys/domain/journey_progress.dart';

class JourneyImport {
  const JourneyImport(this.enrollments, this.steps);
  final List<JourneyEnrollment> enrollments;
  final List<JourneyStepProgress> steps;
}

/// A restart creates a newer attempt. Old attempts can never resurrect reset
/// steps. Within an attempt keep finished steps, then the later snapshot;
/// local snapshots win ties, and the answers recorded on either side are
/// combined. Unknown journey and step IDs are kept.
JourneyImport mergeJourneys({
  required List<JourneyEnrollment> local,
  required List<JourneyStepProgress> localSteps,
  required List<JourneyEnrollment> incoming,
  required List<JourneyStepProgress> incomingSteps,
}) {
  final selected = {for (final e in local) e.journeyId: e};
  final changed = <String, JourneyEnrollment>{};
  for (final e in incoming) {
    final old = selected[e.journeyId];
    if (old == null ||
        e.startedAt.isAfter(old.startedAt) ||
        (e.startedAt == old.startedAt && e.updatedAt.isAfter(old.updatedAt))) {
      selected[e.journeyId] = changed[e.journeyId] = e;
    }
  }
  String key(JourneyStepProgress s) => '${s.journeyId}/${s.stepId}';
  bool current(JourneyStepProgress s) =>
      selected[s.journeyId]?.startedAt == s.startedAt;
  final steps = {
    for (final s in localSteps)
      if (current(s)) key(s): s,
  };
  final changedSteps = <String, JourneyStepProgress>{};
  for (final s in incomingSteps.where(current)) {
    final old = steps[key(s)];
    if (old == null) {
      steps[key(s)] = changedSteps[key(s)] = s;
      continue;
    }
    final newer =
        (!old.finished && s.finished) ||
        (old.finished == s.finished && s.updatedAt.isAfter(old.updatedAt));
    final base = newer ? s : old;
    // Answers given on either device count: an answer is never asked twice.
    final answered = {...old.answeredKeys, ...s.answeredKeys};
    if (!newer && answered.length == old.answeredKeys.length) continue;
    steps[key(s)] = changedSteps[key(s)] = JourneyStepProgress(
      journeyId: base.journeyId,
      stepId: base.stepId,
      startedAt: base.startedAt,
      updatedAt: base.updatedAt,
      completedAt: base.completedAt,
      skipped: base.skipped,
      answeredKeys: answered,
    );
  }
  return JourneyImport(
    changed.values.toList()..sort((a, b) => a.journeyId.compareTo(b.journeyId)),
    changedSteps.values.toList()..sort((a, b) => key(a).compareTo(key(b))),
  );
}
