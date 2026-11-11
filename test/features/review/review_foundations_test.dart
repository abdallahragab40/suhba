import 'dart:math';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/review/data/drift_review_repository.dart';
import 'package:suhba/features/review/domain/learning_topics.dart';
import 'package:suhba/features/review/domain/review_item.dart';
import 'package:suhba/shared/content/providers.dart';

import '../../helpers/app_harness.dart';

void main() {
  ReviewItem item({int box = 1, int wrong = 1}) => ReviewItem(
    questionKey: 'kunya:ali',
    box: box,
    dueOn: DateTime.utc(2026, 11, 9),
    lastAnsweredAt: DateTime.utc(2026, 11, 8, 21),
    timesRight: box,
    timesWrong: wrong,
  );
  test('learning states reflect answers and do not penalize elapsed days', () {
    expect(learningState([item(wrong: 0)]), LearningState.learning);
    expect(learningState([item()]), LearningState.worthRevisiting);
    expect(learningState([item(box: 3)]), LearningState.learning);
    expect(learningState([item(box: 4), item(box: 5)]), LearningState.mastered);
    expect(
      learningState([item(box: 5), item()]),
      LearningState.worthRevisiting,
    );
    expect(learningState([item(box: 5), item(box: 2)]), LearningState.learning);
  });
  test(
    'concurrent due answers count once; stale and future snapshots never overwrite history',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final repo = DriftReviewRepository(
        db,
        clock: () => DateTime(2026, 11, 9, 21),
      );
      await repo.save(item());
      final expected = (await repo.all()).single;
      final results = await Future.wait([
        repo.answerDue(expected, correct: false),
        repo.answerDue(expected, correct: true),
      ]);
      expect(results.where((v) => v), hasLength(1));
      final current = (await repo.all()).single;
      expect(
        current.timesRight + current.timesWrong,
        expected.timesRight + expected.timesWrong + 1,
      );
      expect(await repo.answerDue(expected, correct: true), isFalse);
      expect(await repo.answerDue(current, correct: true), isFalse);
    },
  );
  testApp(
    'saved comparison keys reconstruct the same choices and answer for every round',
    (tester) async {
      final app = AppUnderTest();
      final content = await app.container.read(quizContentProvider.future);
      final resolver = QuizGenerator(content, random: Random(99));
      for (var seed = 0; seed < 10; seed++) {
        final generator = QuizGenerator(content, random: Random(seed));
        for (final kind in [QuizKind.earliestEvent, QuizKind.earliestChapter]) {
          for (final original in generator.questionsOf(kind)) {
            final restored = resolver.questionByKey(original.key)!;
            expect(restored.answer, original.answer);
            expect(restored.choices.toSet(), original.choices.toSet());
            expect(restored.provenance, original.provenance);
          }
        }
      }
      for (final key in [
        'first-event:a,b,c',
        'first-event:a,a,a,a',
        'first-event:d,c,b,a',
        'first-chapter:a,b,c,d',
        'removed:record',
      ]) {
        expect(resolver.questionByKey(key), isNull, reason: key);
      }
    },
  );

  testApp(
    'learning topics use the source event and Seerah period without inflating unrelated facts',
    (tester) async {
      final app = AppUnderTest();
      final content = await app.container.read(quizContentProvider.future);
      final index = await app.container.read(seerahIndexProvider.future);
      final generator = QuizGenerator(content, random: Random(3));
      final event = generator.questionBank()['event-year:badr']!;
      final chapter = generator.questionsOf(QuizKind.earliestChapter).first;
      ReviewItem history(String key) => ReviewItem(
        questionKey: key,
        box: 4,
        dueOn: DateTime.utc(2026, 11, 9),
        lastAnsweredAt: DateTime.utc(2026, 11, 8),
        timesRight: 4,
        timesWrong: 0,
      );
      final topics = learningTopics(
        history: [
          history(event.key),
          history(chapter.key),
          history('missing:record'),
        ],
        questions: {event.key: event, chapter.key: chapter},
        content: content,
        periods: index.collection.periods,
      );
      expect(topics.any((t) => t.key == 'event:badr'), isTrue);
      final period = index.collection.periods.firstWhere(
        (p) => p.chapterIds.contains(chapter.provenance!.recordId),
      );
      expect(topics.any((t) => t.key == 'period:${period.id}'), isTrue);
      expect(topics, hasLength(2));
      expect(topics.every((t) => t.state == LearningState.mastered), isTrue);
    },
  );
}
