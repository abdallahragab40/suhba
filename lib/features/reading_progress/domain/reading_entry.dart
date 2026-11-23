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

/// Every passage read so far is finished: go on to the next one not yet
/// read (see [nextUnreadPassage]).
final class NextReading extends ReadingEntry {
  const NextReading(this.passageId);
  final String passageId;
}

/// Every passage is finished.
final class FinishedReading extends ReadingEntry {
  const FinishedReading(this.firstPassageId);
  final String firstPassageId;
}

/// Chooses the entry for [passageIds] (in reading order, not empty) from
/// the saved [progress] (by passage id; ids not in [passageIds] are
/// ignored). The most recently read unfinished passage wins; if none is
/// unfinished, the next passage not yet finished is next (see
/// [nextUnreadPassage]); if all are finished, the work is finished.
ReadingEntry readingEntryFor(
  List<String> passageIds,
  Map<String, ReadingProgress> progress,
) {
  assert(passageIds.isNotEmpty, 'a work has at least one passage');
  if (latestUnfinished(passageIds, progress) case final p?) {
    return ResumeReading(p.targetId, p.fraction);
  }
  if (!passageIds.any(progress.containsKey)) {
    return StartReading(passageIds.first);
  }
  return switch (nextUnreadPassage(passageIds, progress)) {
    final next? => NextReading(next),
    null => FinishedReading(passageIds.first),
  };
}

/// The unfinished passage of [passageIds] read most recently, if any.
ReadingProgress? latestUnfinished(
  List<String> passageIds,
  Map<String, ReadingProgress> progress,
) {
  final unfinished = [
    for (final id in passageIds)
      if (progress[id] case final p? when !p.completed) p,
  ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return unfinished.firstOrNull;
}

/// The passage to read after those already read: the first one not
/// finished after the furthest passage read, so a chapter read out of
/// order (through a journey, say) moves the reader on from there rather
/// than back to the start; when nothing is left after it, the first one
/// not finished. Null when every passage is finished.
String? nextUnreadPassage(
  List<String> passageIds,
  Map<String, ReadingProgress> progress,
) {
  final furthest = passageIds.lastIndexWhere(progress.containsKey);
  for (var i = furthest + 1; i < passageIds.length; i++) {
    if (progress[passageIds[i]]?.completed != true) return passageIds[i];
  }
  return passageIds.where((id) => progress[id]?.completed != true).firstOrNull;
}

/// Where to pick a work up: the unfinished passage read most recently,
/// else the next passage not yet read ([nextUnreadPassage]). Null when
/// nothing of the work was read, or all of it was finished.
String? resumePassage(
  List<String> passageIds,
  Map<String, ReadingProgress> progress,
) => passageIds.isEmpty
    ? null
    : switch (readingEntryFor(passageIds, progress)) {
        ResumeReading(:final passageId) ||
        NextReading(:final passageId) => passageId,
        StartReading() || FinishedReading() => null,
      };
