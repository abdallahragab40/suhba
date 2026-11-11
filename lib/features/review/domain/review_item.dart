import 'package:flutter/foundation.dart';

/// The reader's answer history for one stable generated-question key.
@immutable
class ReviewItem {
  const ReviewItem({
    required this.questionKey,
    required this.box,
    required this.dueOn,
    required this.lastAnsweredAt,
    required this.timesRight,
    required this.timesWrong,
  }) : assert(box >= 1 && box <= 5),
       assert(timesRight >= 0),
       assert(timesWrong >= 0);

  final String questionKey;
  final int box;

  /// A calendar date, encoded as UTC midnight to avoid DST arithmetic.
  /// Its year/month/day describe the reader's local due date, not an instant.
  final DateTime dueOn;
  final DateTime lastAnsweredAt;
  final int timesRight;
  final int timesWrong;

  bool isDueOn(DateTime localDate) => !dueOn.isAfter(
    DateTime.utc(localDate.year, localDate.month, localDate.day),
  );
}
