class JourneyEnrollment {
  const JourneyEnrollment({
    required this.journeyId,
    required this.startedAt,
    required this.updatedAt,
    required this.paused,
  });
  final String journeyId;

  /// Also the attempt identity: restart begins a new attempt.
  final DateTime startedAt;
  final DateTime updatedAt;
  final bool paused;
}

class JourneyStepProgress {
  const JourneyStepProgress({
    required this.journeyId,
    required this.stepId,
    required this.startedAt,
    required this.updatedAt,
    this.completedAt,
    this.skipped = false,
    this.answeredKeys = const {},
  });
  final String journeyId;
  final String stepId;
  final DateTime startedAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final bool skipped;
  final Set<String> answeredKeys;

  bool get finished => completedAt != null || skipped;
}
