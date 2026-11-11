import 'dart:math';

import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/domain/journey_questions.dart';
import 'package:suhba/features/journeys/domain/journey_reading.dart';
import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/shared/content/domain/content_repository.dart';

class JourneyRuntime {
  const JourneyRuntime({
    required this.journey,
    required this.readings,
    required this.questions,
  });
  final Journey journey;
  final Map<String, List<JourneyReading?>> readings;
  final Map<String, List<QuizQuestion>> questions;

  bool missing(String stepId) => readings[stepId]!.any((r) => r == null);
  int minutes(String stepId) => readingMinutes(
    readings[stepId]!.nonNulls.fold<int>(0, (n, r) => n + r.wordCount),
  );

  bool unlocked(String stepId, List<JourneyStepProgress> progress) {
    final index = journey.steps.indexWhere((s) => s.id == stepId);
    if (index < 0) return false;
    final done = {
      for (final p in progress)
        if (p.journeyId == journey.id && p.finished) p.stepId,
    };
    return journey.steps.take(index).every((s) => done.contains(s.id));
  }
}

Future<JourneyRuntime> resolveJourney(
  ContentRepository content,
  Journey journey,
  QuizContent quiz,
) async {
  final readings = <String, List<JourneyReading?>>{};
  for (final step in journey.steps) {
    readings[step.id] = await Future.wait(
      step.readings.map((r) => resolveJourneyReading(content, r)),
    );
  }
  // One deterministic pool per journey, rather than rescanning every story
  // and candidate name for every step. Step filtering preserves provenance.
  final bank =
      journey.steps.any(
        (step) => step.readings.any(
          (reading) => reading.type == StepRefType.storyChapter,
        ),
      )
      ? QuizGenerator(
          quiz,
          random: Random(0),
        ).questionsOf(QuizKind.companionInStory)
      : const <QuizQuestion>[];
  return JourneyRuntime(
    journey: journey,
    readings: readings,
    questions: {
      for (final step in journey.steps)
        step.id: journeyQuestions(quiz, step, bank: bank),
    },
  );
}
