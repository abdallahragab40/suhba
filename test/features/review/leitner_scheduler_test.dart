import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/review/domain/leitner_scheduler.dart';
import 'package:suhba/features/review/domain/review_item.dart';

void main() {
  test('an injected UTC instant uses the device calendar day', () {
    final local = DateTime(2026, 11, 10, 0, 30);
    final item = LeitnerScheduler(
      clock: local.toUtc,
    ).answer(questionKey: 'kunya:ali', correct: false);
    expect(item.dueOn, DateTime.utc(2026, 11, 11));
    expect(item.lastAnsweredAt, local.toUtc());
  });

  test('correct reviews follow 1/3/7/16/35 days and stay in box 5', () {
    var now = DateTime(2026, 11, 9, 21);
    final scheduler = LeitnerScheduler(clock: () => now);
    ReviewItem? item;
    for (final (index, interval) in [1, 3, 7, 16, 35, 35].indexed) {
      item = scheduler.answer(
        questionKey: 'kunya:ali',
        correct: true,
        previous: item,
      );
      expect(item.box, (index + 1).clamp(1, 5));
      expect(item.timesRight, index + 1);
      expect(item.timesWrong, 0);
      expect(item.lastAnsweredAt, now.toUtc());
      expect(item.dueOn, DateTime.utc(now.year, now.month, now.day + interval));
      expect(item.isDueOn(now), isFalse);
      now = DateTime(item.dueOn.year, item.dueOn.month, item.dueOn.day, 21);
      expect(item.isDueOn(now), isTrue);
    }
  });

  test('a mistake in every box resets to tomorrow and preserves counts', () {
    final now = DateTime(2026, 12, 31, 23, 59);
    final scheduler = LeitnerScheduler(clock: () => now);
    for (var box = 1; box <= 5; box++) {
      final result = scheduler.answer(
        questionKey: 'event-year:badr',
        correct: false,
        previous: ReviewItem(
          questionKey: 'event-year:badr',
          box: box,
          dueOn: DateTime.utc(2026, 12, 31),
          lastAnsweredAt: DateTime.utc(2026, 12),
          timesRight: 6,
          timesWrong: 2,
        ),
      );
      expect(result.box, 1);
      expect(result.dueOn, DateTime.utc(2027));
      expect(result.timesRight, 6);
      expect(result.timesWrong, 3);
      expect(result.isDueOn(DateTime(2027, 1, 2)), isTrue);
    }
  });

  test('first wrong answer is due tomorrow across a leap-day boundary', () {
    final result = LeitnerScheduler(
      clock: () => DateTime(2028, 2, 28, 23),
    ).answer(questionKey: 'kunya:ali', correct: false);
    expect(result.dueOn, DateTime.utc(2028, 2, 29));
    expect(result.timesRight, 0);
    expect(result.timesWrong, 1);
  });

  test('rejects empty keys and history for a different question', () {
    final scheduler = LeitnerScheduler(clock: () => DateTime(2026, 11, 9));
    final previous = scheduler.answer(questionKey: 'one', correct: true);
    expect(
      () => scheduler.answer(questionKey: '', correct: true),
      throwsArgumentError,
    );
    expect(
      () => scheduler.answer(
        questionKey: 'two',
        correct: true,
        previous: previous,
      ),
      throwsArgumentError,
    );
  });
}
