import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/personal_data/domain/reading_data_archive.dart';
import 'package:suhba/features/review/domain/leitner_scheduler.dart';
import 'package:suhba/features/review/domain/review_item.dart';

void main() {
  final now = DateTime(2026, 11, 9, 21);
  final review = LeitnerScheduler(
    clock: () => now,
  ).answer(questionKey: 'title:umar:الفاروق', correct: false);
  ReadingDataArchive archive(List<ReviewItem> items) => ReadingDataArchive(
    bookmarks: const [],
    progress: const [],
    reviews: items,
    exportedAt: now,
  );

  test('review keys, calendar dates and counters round-trip exactly', () {
    final restored =
        (decodeArchive(encodeArchive(archive([review]))) as ArchiveDecoded)
            .archive
            .reviews
            .single;
    expect(restored.questionKey, review.questionKey);
    expect(restored.dueOn, review.dueOn);
    expect(restored.box, review.box);
    expect(restored.lastAnsweredAt, review.lastAnsweredAt);
    expect(restored.timesRight, review.timesRight);
    expect(restored.timesWrong, review.timesWrong);
  });

  test('legacy v1 exports without reviews are still accepted', () {
    final json = jsonDecode(encodeArchive(archive([]))) as Map<String, dynamic>;
    json['version'] = 1;
    json.remove('reviews');
    expect(
      (decodeArchive(jsonEncode(json)) as ArchiveDecoded).archive.reviews,
      isEmpty,
    );
  });

  test('invalid review records refuse the whole archive', () {
    for (final (field, value) in <(String, Object)>[
      ('box', 0),
      ('box', 6),
      ('timesRight', -1),
      ('timesWrong', 1.5),
      ('questionKey', ''),
      ('dueOn', '2026-11-10T12:00:00Z'),
      ('lastAnsweredAt', 'yesterday'),
    ]) {
      final json =
          jsonDecode(encodeArchive(archive([review]))) as Map<String, dynamic>;
      ((json['reviews'] as List<Object?>).single
              as Map<String, Object?>)[field] =
          value;
      final rejected = decodeArchive(jsonEncode(json)) as ArchiveRejected;
      expect(rejected.problem, ArchiveProblem.invalidRecord);
      expect(rejected.where, 'reviews[0].$field');
    }
  });

  test('merge keeps the latest snapshot, local ties, and unknown keys', () {
    final newer = LeitnerScheduler(
      clock: () => DateTime(2026, 11, 10),
    ).answer(questionKey: review.questionKey, correct: true, previous: review);
    final unknown = LeitnerScheduler(
      clock: () => now,
    ).answer(questionKey: 'removed:record', correct: true);
    ImportPlan plan(List<ReviewItem> local, List<ReviewItem> incoming) =>
        planImport(
          localBookmarks: const [],
          localProgress: const [],
          localReviews: local,
          archive: archive(incoming),
        );
    expect(plan([review], [review]).isEmpty, isTrue);
    expect(plan([newer], [review]).keptReviews, 1);
    final merged = plan([review], [review, newer, unknown]);
    expect(merged.reviewsToSave, [unknown, newer]);
    expect(merged.isEmpty, isFalse);
    expect(newer.timesWrong, 1);
    expect(newer.timesRight, 1);
  });
}
