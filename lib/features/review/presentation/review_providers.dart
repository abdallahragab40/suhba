import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/time/local_day_provider.dart';
import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/review/data/drift_review_repository.dart';
import 'package:suhba/features/review/domain/learning_topics.dart';
import 'package:suhba/features/review/domain/review_item.dart';
import 'package:suhba/features/review/domain/review_session.dart';
import 'package:suhba/shared/content/providers.dart';

final reviewRepositoryProvider = Provider<DriftReviewRepository>(
  (ref) => DriftReviewRepository(
    ref.watch(appDatabaseProvider),
    clock: ref.watch(clockProvider),
  ),
);

final reviewItemsProvider = StreamProvider<List<ReviewItem>>(
  (ref) => ref.watch(reviewRepositoryProvider).watchAll(),
);

/// Every generated question by key. It depends on the content only, so it
/// is built once rather than again after each recorded answer.
final reviewQuestionBankProvider =
    FutureProvider<({QuizGenerator generator, Map<String, QuizQuestion> bank})>(
      (ref) async {
        final content = await ref.watch(quizContentProvider.future);
        final generator = QuizGenerator(content, random: Random(0));
        return (generator: generator, bank: generator.questionBank());
      },
    );

final reviewQuestionsProvider = FutureProvider<Map<String, QuizQuestion>>((
  ref,
) async {
  final observed = ref.watch(reviewItemsProvider);
  final history = observed.hasValue
      ? observed.requireValue
      : await ref.watch(reviewItemsProvider.future);
  if (history.isEmpty) return const {};
  final (:generator, :bank) = await ref.watch(
    reviewQuestionBankProvider.future,
  );
  final resolved = <String, QuizQuestion>{};
  for (final item in history) {
    final isComparison =
        item.questionKey.startsWith('first-event:') ||
        item.questionKey.startsWith('first-chapter:');
    final q =
        bank[item.questionKey] ??
        (isComparison ? generator.questionByKey(item.questionKey) : null);
    if (q != null) resolved[q.key] = q;
  }
  return resolved;
});

final dueReviewsProvider = FutureProvider<List<DueReview>>((ref) async {
  final today = ref.watch(localDayProvider);
  final observed = ref.watch(reviewItemsProvider);
  final questions = await ref.watch(reviewQuestionsProvider.future);
  final history = observed.hasValue
      ? observed.requireValue
      : await ref.watch(reviewItemsProvider.future);
  return dueReviews(history, questions, today);
});

final learningTopicsProvider = FutureProvider<List<LearningTopic>>((ref) async {
  final observed = ref.watch(reviewItemsProvider);
  final history = observed.hasValue
      ? observed.requireValue
      : await ref.watch(reviewItemsProvider.future);
  if (history.isEmpty) return const [];
  final questions = await ref.watch(reviewQuestionsProvider.future);
  final content = await ref.watch(quizContentProvider.future);
  final seerah = await ref.watch(seerahIndexProvider.future);
  return learningTopics(
    history: history,
    questions: questions,
    content: content,
    periods: seerah.collection.periods,
  );
});
