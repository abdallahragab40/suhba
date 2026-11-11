import 'dart:math';

import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/review/domain/review_item.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';

import 'app_harness.dart';

Future<QuizQuestion> seedReview(
  AppUnderTest app, {
  String? key,
  int box = 1,
  DateTime? dueOn,
  int right = 0,
  int wrong = 1,
}) async {
  final content = await app.container.read(quizContentProvider.future);
  final bank = QuizGenerator(content, random: Random(0)).questionBank();
  final q = key == null
      ? bank.values.firstWhere(
          (q) =>
              q.kind == QuizKind.companionInStory &&
              q.provenance!.recordId == 'the-cave',
        )
      : bank[key]!;
  await app.container
      .read(reviewRepositoryProvider)
      .save(
        ReviewItem(
          questionKey: q.key,
          box: box,
          dueOn: dueOn ?? DateTime.utc(2026, 10, 9),
          lastAnsweredAt: DateTime.utc(2026, 10, 8, 21),
          timesRight: right,
          timesWrong: wrong,
        ),
      );
  return q;
}
