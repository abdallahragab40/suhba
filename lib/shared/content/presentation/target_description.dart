import 'package:flutter/widgets.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

/// How a found saved item or reading position is shown: its title, what
/// it belongs to, and where it opens.
typedef TargetDescription = ({String title, String? parent, String route});

/// Describes [found], or null when it is [TargetMissing]. Used by Saved,
/// Continue reading and the reading history, so every kind of target is
/// shown the same way everywhere.
TargetDescription? describeTarget(BuildContext context, TargetLookup found) {
  final l10n = AppLocalizations.of(context);
  return switch (found) {
    FoundCompanion(:final companion) => (
      title:
          '${companion.name.of(context)} '
          '${companionHonorific(companion.gender)}',
      parent: companion.kunya?.of(context),
      route: AppRoutes.companion(companion.id),
    ),
    FoundSection(:final companion, :final section) => (
      title: section.title.of(context),
      parent: companion.name.of(context),
      route: AppRoutes.section(companion.id, section.id),
    ),
    FoundStory(:final story) => (
      title: story.title.of(context),
      parent: story.synopsis.of(context),
      route: AppRoutes.story(story.id),
    ),
    FoundChapter(:final story, :final chapter) => (
      title: chapter.title.of(context),
      parent: story.title.of(context),
      route: AppRoutes.chapter(story.id, chapter.id),
    ),
    FoundSeerahChapter(:final chapter) => (
      title: chapter.title.of(context),
      parent: l10n.seerahSectionName,
      route: AppRoutes.seerahChapter(chapter.id),
    ),
    FoundSeerahTopic(:final topic) => (
      title: topic.title.of(context),
      parent: l10n.seerahSectionName,
      route: AppRoutes.seerahTopic(topic.id),
    ),
    TargetMissing() => null,
  };
}
