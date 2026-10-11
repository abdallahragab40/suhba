import 'package:suhba/features/reading_progress/domain/reading_progress.dart';

/// Where a reader should go into a work (a biography's sections, a story's
/// chapters), given their progress in it.
sealed class ReadingEntry {
  const ReadingEntry();
}

/// Nothing read yet: start with the first passage.
final class StartReading extends ReadingEntry {
  const StartReading(this.passageId);
  final String passageId;
}

/// Pick up the unfinished passage read most recently.
final class ResumeReading extends ReadingEntry {
  const ResumeReading(this.passageId, this.fraction);
  final String passageId;
  final double fraction;
}

/// Every passage is finished.
final class FinishedReading extends ReadingEntry {
  const FinishedReading(this.firstPassageId);
  final String firstPassageId;
}

/// Chooses the entry for [passageIds] (in reading order, not empty) from
/// the saved [progress] (by passage id; ids not in [passageIds] are
/// ignored). The most recently read unfinished passage wins; if none is
/// unfinished, the first passage not yet finished is next; if all are
/// finished, the work is finished.
ReadingEntry readingEntryFor(
  List<String> passageIds,
  Map<String, ReadingProgress> progress,
) {
  assert(passageIds.isNotEmpty, 'a work has at least one passage');
  final relevant = [for (final id in passageIds) ?progress[id]];
  final unfinished = relevant.where((p) => !p.completed).toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  if (unfinished.isNotEmpty) {
    final latest = unfinished.first;
    return ResumeReading(latest.targetId, latest.fraction);
  }
  if (relevant.isEmpty) return StartReading(passageIds.first);
  final next = passageIds.where((id) => progress[id]?.completed != true);
  return next.isEmpty
      ? FinishedReading(passageIds.first)
      : ResumeReading(next.first, 0);
}
