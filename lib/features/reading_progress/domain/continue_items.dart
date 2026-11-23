import 'package:suhba/features/reading_progress/domain/reading_entry.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/shared/content/domain/content_target.dart';

/// A place to pick reading up: a passage left unfinished, or the next
/// passage of a work read in part whose passages read so far are all
/// finished (a biography with one section read, the Seerah with a chapter
/// read through a journey).
final class ContinueItem {
  /// An unfinished passage, at its saved position.
  ContinueItem.resume(ReadingProgress this.progress)
    : target = progress.target,
      parentId = progress.parentId,
      passageId = progress.targetId,
      updatedAt = progress.updatedAt;

  /// The next passage of a work, not yet opened.
  const ContinueItem.next({
    required this.target,
    required this.parentId,
    required this.passageId,
    required this.updatedAt,
  }) : progress = null;

  final ProgressTarget target;
  final String parentId;
  final String passageId;

  /// When the work was last read.
  final DateTime updatedAt;

  /// The saved position; null for the next passage of a work.
  final ReadingProgress? progress;

  bool get isNext => progress == null;

  ContentTarget get contentTarget =>
      progressContentTarget(target, parentId: parentId, targetId: passageId);
}

/// Works whose next passage [continueItems] needs to know: those read in
/// part with nothing left unfinished. Essays (Seerah topics) stand alone
/// and have no next one.
Set<(ProgressTarget, String)> worksNeedingOrder(List<ReadingProgress> all) => {
  for (final MapEntry(:key, :value) in _byWork(all).entries)
    if (key.$1 != ProgressTarget.seerahTopic && value.every((p) => p.completed))
      key,
};

/// Every place to pick reading up, most recent first: each unfinished
/// passage, and for a work read in part with nothing unfinished its next
/// passage ([nextUnreadPassage]). [orderOf] gives a work's passages in
/// reading order, or null when they are not known (the work failed to
/// load); such a work offers no next passage.
List<ContinueItem> continueItems(
  List<ReadingProgress> all,
  List<String>? Function(ProgressTarget target, String parentId) orderOf,
) {
  final items = <ContinueItem>[];
  for (final MapEntry(key: (target, parentId), value: positions) in _byWork(
    all,
  ).entries) {
    final unfinished = positions.where((p) => !p.completed);
    if (unfinished.isNotEmpty) {
      items.addAll(unfinished.map(ContinueItem.resume));
      continue;
    }
    if (target == ProgressTarget.seerahTopic) continue;
    final order = orderOf(target, parentId);
    if (order == null) continue;
    final byId = {for (final p in positions) p.targetId: p};
    if (!order.any(byId.containsKey)) continue;
    final next = nextUnreadPassage(order, byId);
    if (next == null) continue;
    items.add(
      ContinueItem.next(
        target: target,
        parentId: parentId,
        passageId: next,
        updatedAt: positions
            .map((p) => p.updatedAt)
            .reduce((a, b) => a.isAfter(b) ? a : b),
      ),
    );
  }
  return items..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
}

Map<(ProgressTarget, String), List<ReadingProgress>> _byWork(
  List<ReadingProgress> all,
) {
  final works = <(ProgressTarget, String), List<ReadingProgress>>{};
  for (final p in all) {
    (works[(p.target, p.parentId)] ??= []).add(p);
  }
  return works;
}
