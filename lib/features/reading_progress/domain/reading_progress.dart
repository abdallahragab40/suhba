import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/domain/passage_position.dart';

part 'reading_progress.freezed.dart';

/// What has a reading position.
///
/// Stored by name: add values, never rename them.
enum ProgressTarget { section, chapter, seerahChapter, seerahTopic }

@freezed
abstract class ReadingProgress with _$ReadingProgress {
  const factory ReadingProgress({
    required ProgressTarget target,
    required String targetId,

    /// The companion of a section, the story of a chapter, or
    /// [seerahParentId] for the Seerah.
    required String parentId,

    /// 0–1, the share of the text scrolled through.
    required double fraction,
    required bool completed,
    required String contentVersion,
    required DateTime updatedAt,

    /// The passage's content revision when the position was recorded
    /// (`BiographySection.revision`, `StoryChapter.revision`). Null for
    /// positions saved before revisions existed.
    String? targetRevision,

    /// The block at the top of the screen and how far into it (0–1); see
    /// [PassagePosition]. Null for positions saved before anchors existed.
    int? blockIndex,
    double? blockOffset,
  }) = _ReadingProgress;

  const ReadingProgress._();

  PassagePosition get position => PassagePosition(
    fraction: fraction,
    blockIndex: blockIndex,
    blockOffset: blockOffset,
  );

  ContentTarget get contentTarget => switch (target) {
    ProgressTarget.section => ContentTarget.section(parentId, targetId),
    ProgressTarget.chapter => ContentTarget.chapter(parentId, targetId),
    ProgressTarget.seerahChapter => ContentTarget.seerahChapter(targetId),
    ProgressTarget.seerahTopic => ContentTarget.seerahTopic(targetId),
  };
}

/// Whether a saved position still fits the passage as it is now.
enum PositionFit {
  /// Recorded against this exact text: restore it.
  current,

  /// The text changed since (or it cannot be told): do not jump there
  /// silently.
  outdated,
}

extension ReadingProgressFit on ReadingProgress {
  /// Compares this position with the passage's current [revision] and the
  /// running [contentVersion]. Positions from before revisions existed
  /// count as current only if they were saved against the same build.
  PositionFit fitFor({
    required String revision,
    required String? contentVersion,
  }) {
    final saved = targetRevision;
    if (saved != null) {
      return saved == revision ? PositionFit.current : PositionFit.outdated;
    }
    return contentVersion != null && this.contentVersion == contentVersion
        ? PositionFit.current
        : PositionFit.outdated;
  }
}

/// Reading positions. Lives on the device only.
abstract interface class ReadingProgressRepository {
  Stream<ReadingProgress?> watch(ProgressTarget target, String targetId);

  /// Unfinished positions, most recent first.
  Stream<List<ReadingProgress>> watchInProgress({int limit = 10});

  /// Every position in the passages of [parentId] (a companion's sections or
  /// a story's chapters), finished or not.
  Stream<List<ReadingProgress>> watchForParent(
    ProgressTarget target,
    String parentId,
  );

  /// Finished passages, most recently finished first.
  Stream<List<ReadingProgress>> watchCompleted();

  /// Every saved position, finished or not.
  Stream<List<ReadingProgress>> watchAll();

  /// Every saved position, finished or not (one-shot).
  Future<List<ReadingProgress>> all();

  /// Records a position. Once completed, an item stays completed.
  Future<void> save(ReadingProgress progress);

  Future<void> remove(ProgressTarget target, String targetId);

  /// Puts back [progress] exactly as it was, e.g. to undo a reset. Does
  /// nothing if the passage has been read again meanwhile.
  Future<void> restore(ReadingProgress progress);

  /// Removes every position, finished or not; returns how many there were.
  Future<int> clearAll();

  /// Marks a position as recorded against [revision] of [contentVersion],
  /// without touching where the reader got to.
  Future<void> confirmRevision(
    ProgressTarget target,
    String targetId, {
    required String revision,
    required String contentVersion,
  });
}
