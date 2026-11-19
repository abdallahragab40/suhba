/// The reader's daily reading plan (review K3): how many Seerah chapters a
/// day, counted from the day it (re)started. There is no streak and no
/// score; a missed day only changes what today offers.
class ReadingPlan {
  const ReadingPlan({
    required this.pace,
    required this.startedOn,
    required this.baseline,
    this.catchUp = false,
  });

  /// The pace choices: one, two or three chapters a day.
  static const paces = [1, 2, 3];

  /// Chapters a day, 1–3.
  final int pace;

  /// The local calendar date the plan started or was last re-based.
  final DateTime startedOn;

  /// Chapters already finished on [startedOn].
  final int baseline;

  /// After a missed day: one extra chapter a day until caught up.
  final bool catchUp;

  ReadingPlan copyWith({
    int? pace,
    DateTime? startedOn,
    int? baseline,
    bool? catchUp,
  }) => ReadingPlan(
    pace: pace ?? this.pace,
    startedOn: startedOn ?? this.startedOn,
    baseline: baseline ?? this.baseline,
    catchUp: catchUp ?? this.catchUp,
  );
}

/// What today asks for under a plan.
class DailyTarget {
  const DailyTarget({
    required this.chapters,
    required this.doneToday,
    required this.behind,
    required this.askHowToContinue,
  });

  /// Chapters to read today (the pace, plus one while catching up),
  /// never more than remain.
  final int chapters;

  /// Chapters finished today.
  final int doneToday;

  /// Chapters the plan expected before today that are still unread.
  final int behind;

  /// Whether to offer "continue where I stopped" or "catch up gradually":
  /// days were missed and the reader has not chosen yet.
  final bool askHowToContinue;

  bool get done => doneToday >= chapters;
}

/// Today's target under [plan]. [finished] counts every finished Seerah
/// chapter, [finishedToday] those finished today, and [total] all of them.
DailyTarget dailyTarget({
  required ReadingPlan plan,
  required DateTime today,
  required int finished,
  required int finishedToday,
  required int total,
}) {
  DateTime day(DateTime d) => DateTime.utc(d.year, d.month, d.day);
  final days = day(today).difference(day(plan.startedOn)).inDays;
  final remainingBeforeToday = total - (finished - finishedToday);
  final expected = plan.baseline + plan.pace * (days < 0 ? 0 : days);
  final behind = (expected - (finished - finishedToday)).clamp(
    0,
    remainingBeforeToday < 0 ? 0 : remainingBeforeToday,
  );
  final wanted = plan.pace + (plan.catchUp && behind > 0 ? 1 : 0);
  return DailyTarget(
    chapters: wanted.clamp(
      0,
      remainingBeforeToday < 0 ? 0 : remainingBeforeToday,
    ),
    doneToday: finishedToday,
    behind: behind,
    askHowToContinue: behind > 0 && !plan.catchUp,
  );
}
