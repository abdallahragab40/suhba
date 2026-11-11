import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/review/domain/review_item.dart';

class DueReview {
  const DueReview(this.history, this.question);
  final ReviewItem history;
  final QuizQuestion question;
}

/// Unknown keys remain stored, but are never offered as broken questions.
List<DueReview> dueReviews(
  List<ReviewItem> history,
  Map<String, QuizQuestion> questions,
  DateTime today,
) =>
    [
      for (final item in history)
        if (item.isDueOn(today) && questions[item.questionKey] != null)
          DueReview(item, questions[item.questionKey]!),
    ]..sort((a, b) {
      final due = a.history.dueOn.compareTo(b.history.dueOn);
      return due != 0
          ? due
          : a.history.questionKey.compareTo(b.history.questionKey);
    });
