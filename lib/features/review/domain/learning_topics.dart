import 'package:suhba/app/router/routes.dart';
import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/review/domain/review_item.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/seerah.dart';

enum LearningState { worthRevisiting, learning, mastered }

class LearningTopic {
  const LearningTopic({
    required this.key,
    required this.title,
    required this.route,
    required this.state,
  });
  final String key;
  final LocalizedText title;
  final String route;
  final LearningState state;
}

LearningState learningState(Iterable<ReviewItem> items) {
  final list = items.toList();
  if (list.any((i) => i.box == 1 && i.timesWrong > 0)) {
    return LearningState.worthRevisiting;
  }
  if (list.isNotEmpty && list.every((i) => i.box >= 4)) {
    return LearningState.mastered;
  }
  return LearningState.learning;
}

/// States describe the facts actually answered, never a percentage of a topic
/// or a score for a person. A missed day does not lower a topic's state.
List<LearningTopic> learningTopics({
  required List<ReviewItem> history,
  required Map<String, QuizQuestion> questions,
  required QuizContent content,
  required List<SeerahPeriod> periods,
}) {
  final topics =
      <
        String,
        ({LocalizedText title, String route, Map<String, ReviewItem> items})
      >{};
  void add(String key, LocalizedText title, String route, ReviewItem item) {
    final topic = topics.putIfAbsent(
      key,
      () => (title: title, route: route, items: {}),
    );
    topic.items[item.questionKey] = item;
  }

  for (final item in history) {
    if (item.timesRight + item.timesWrong == 0) continue;
    final q = questions[item.questionKey];
    final source = q?.provenance;
    if (q == null || source == null) continue;
    switch (source.type) {
      case QuizSourceType.companion:
        final c = content.companions
            .where((c) => c.id == source.recordId)
            .firstOrNull;
        if (c != null) {
          add('companion:${c.id}', c.name, AppRoutes.companion(c.id), item);
        }
      case QuizSourceType.event:
        final e = content.events
            .where((e) => e.id == source.recordId)
            .firstOrNull;
        if (e != null) {
          add('event:${e.id}', e.name, AppRoutes.event(e.id), item);
        }
      case QuizSourceType.seerahChapter:
        final chapter = content.chapters
            .where((c) => c.id == source.recordId)
            .firstOrNull;
        final period = periods
            .where((p) => p.chapterIds.contains(source.recordId))
            .firstOrNull;
        if (period != null) {
          add('period:${period.id}', period.name, AppRoutes.seerah, item);
        } else if (chapter != null) {
          add(
            'chapter:${chapter.id}',
            chapter.title,
            AppRoutes.seerahChapter(chapter.id),
            item,
          );
        }
      case QuizSourceType.story:
        final story = content.stories
            .where((s) => s.id == source.recordId)
            .firstOrNull;
        if (story != null) {
          add(
            'story:${story.id}',
            story.title,
            AppRoutes.story(story.id),
            item,
          );
        }
        // This question identifies one companion in that story. It does not
        // establish knowledge of every participant or event in its metadata.
        if (q.kind == QuizKind.companionInStory) {
          final id = q.key.split(':').last;
          final c = content.companions.where((c) => c.id == id).firstOrNull;
          if (c != null) {
            add('companion:${c.id}', c.name, AppRoutes.companion(c.id), item);
          }
        }
    }
  }
  return [
    for (final MapEntry(:key, :value) in topics.entries)
      LearningTopic(
        key: key,
        title: value.title,
        route: value.route,
        state: learningState(value.items.values),
      ),
  ]..sort((a, b) => a.key.compareTo(b.key));
}
