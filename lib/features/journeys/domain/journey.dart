import 'package:suhba/app/router/routes.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

enum StepRefType { companionSection, storyChapter, seerahChapter, seerahTopic }

/// References an existing passage; journey files never duplicate its prose.
class StepRef {
  const StepRef({required this.type, required this.targetId, this.parentId});

  final StepRefType type;
  final String targetId;
  final String? parentId;

  ProgressTarget get progressTarget => switch (type) {
    StepRefType.companionSection => ProgressTarget.section,
    StepRefType.storyChapter => ProgressTarget.chapter,
    StepRefType.seerahChapter => ProgressTarget.seerahChapter,
    StepRefType.seerahTopic => ProgressTarget.seerahTopic,
  };

  String get route => switch (type) {
    StepRefType.companionSection => AppRoutes.section(parentId!, targetId),
    StepRefType.storyChapter => AppRoutes.chapter(parentId!, targetId),
    StepRefType.seerahChapter => AppRoutes.seerahChapter(targetId),
    StepRefType.seerahTopic => AppRoutes.seerahTopic(targetId),
  };

  ContentTarget get target => switch (type) {
    StepRefType.companionSection => ContentTarget.section(parentId!, targetId),
    StepRefType.storyChapter => ContentTarget.chapter(parentId!, targetId),
    StepRefType.seerahChapter => ContentTarget.seerahChapter(targetId),
    StepRefType.seerahTopic => ContentTarget.seerahTopic(targetId),
  };
}

class JourneyStep {
  const JourneyStep({
    required this.id,
    required this.title,
    required this.readings,
    this.framing,
    this.reflection,
  });

  /// Stable across editorial reordering; progress must not use array indices.
  final String id;
  final LocalizedText title;
  final List<StepRef> readings;
  final LocalizedText? framing;
  final LocalizedText? reflection;
}

class Journey {
  const Journey({
    required this.id,
    required this.title,
    required this.description,
    required this.steps,
    required this.review,
  });

  final String id;
  final LocalizedText title;
  final LocalizedText description;
  final List<JourneyStep> steps;
  final ReviewInfo review;
}
