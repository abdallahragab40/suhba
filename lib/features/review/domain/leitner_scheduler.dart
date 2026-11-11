import 'package:suhba/features/review/domain/review_item.dart';

/// Calendar-day scheduling: first answer enters box 1; subsequent correct
/// answers advance one box, while any wrong answer returns to box 1.
class LeitnerScheduler {
  LeitnerScheduler({DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final DateTime Function() _clock;
  static const intervals = [1, 3, 7, 16, 35];

  ReviewItem answer({
    required String questionKey,
    required bool correct,
    ReviewItem? previous,
  }) {
    if (questionKey.isEmpty) {
      throw ArgumentError.value(
        questionKey,
        'questionKey',
        'Must not be empty',
      );
    }
    if (previous != null && previous.questionKey != questionKey) {
      throw ArgumentError('Previous history belongs to another question');
    }
    final now = _clock().toLocal();
    final box = !correct || previous == null
        ? 1
        : (previous.box + 1).clamp(1, intervals.length);
    final today = DateTime.utc(now.year, now.month, now.day);
    return ReviewItem(
      questionKey: questionKey,
      box: box,
      dueOn: today.add(Duration(days: intervals[box - 1])),
      lastAnsweredAt: now.toUtc(),
      timesRight: (previous?.timesRight ?? 0) + (correct ? 1 : 0),
      timesWrong: (previous?.timesWrong ?? 0) + (correct ? 0 : 1),
    );
  }
}
