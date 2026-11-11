import 'dart:math';

import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';

/// Only a complete story supports its record-level participation questions.
/// Companion metadata and chapter-order comparisons cannot honestly be
/// attributed to an arbitrary subsection. Those readings use reflection until
/// passage-specific builders are available. Never fill a step with unrelated facts.
List<QuizQuestion> journeyQuestions(
  QuizContent content,
  JourneyStep step, {
  List<QuizQuestion>? bank,
}) {
  final wholeStories = {
    for (final story in content.stories)
      if (story.chapters.isNotEmpty &&
          story.chapters.every(
            (chapter) => step.readings.any(
              (r) =>
                  r.type == StepRefType.storyChapter &&
                  r.parentId == story.id &&
                  r.targetId == chapter.id,
            ),
          ))
        story.id,
  };
  if (wholeStories.isEmpty) return const [];
  final questions =
      (bank ??
              QuizGenerator(
                content,
                random: Random(0),
              ).questionsOf(QuizKind.companionInStory))
          .where((q) => wholeStories.contains(q.provenance?.recordId))
          .toList()
        ..sort((a, b) => a.key.compareTo(b.key));
  return questions.take(3).toList();
}
