import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/seerah/presentation/seerah_passage.dart';
import 'package:suhba/shared/content/domain/seerah.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/presentation/record_links.dart';
import 'package:suhba/shared/content/providers.dart';

/// A thematic essay of the Seerah (S17), with the chapters and companions
/// it draws on. Its lessons are editorial.
class SeerahTopicPage extends ConsumerWidget {
  const SeerahTopicPage({required this.topicId, super.key});

  final String topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topic = ref.watch(seerahTopicProvider(topicId));
    final index = ref.watch(seerahIndexProvider);

    Widget message(Widget body) => Scaffold(appBar: AppBar(), body: body);

    return switch ((topic, index)) {
      (AsyncData(value: final t), AsyncData(value: final i)) => _Topic(
        topic: t,
        index: i,
      ),
      (AsyncError(error: NotFoundFailure()), _) => message(
        EmptyState(
          icon: Icons.auto_stories_outlined,
          title: l10n.seerahTopicNotFound,
        ),
      ),
      (AsyncError(:final error), _) || (_, AsyncError(:final error)) => message(
        ErrorView(
          error: error,
          onRetry: () => ref
            ..invalidate(seerahTopicProvider(topicId))
            ..invalidate(seerahIndexProvider),
        ),
      ),
      _ => message(
        const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 10),
        ),
      ),
    };
  }
}

class _Topic extends StatelessWidget {
  const _Topic({required this.topic, required this.index});

  final SeerahTopic topic;
  final SeerahIndex index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final t = topic;
    final topics = index.topics;
    final at = topics.indexWhere((s) => s.id == t.id);
    final previous = at > 0 ? topics[at - 1] : null;
    final next = at >= 0 && at < topics.length - 1 ? topics[at + 1] : null;
    void open(SeerahTopicSummary s) =>
        context.replace(AppRoutes.seerahTopic(s.id));
    final chapters = {for (final c in index.chapters) c.id: c};

    return SeerahPassageReader(
      target: ProgressTarget.seerahTopic,
      bookmarkTarget: BookmarkTarget.seerahTopic,
      id: t.id,
      revision: t.revision,
      appBarTitle: index.collection.subtitle.of(context),
      kicker: l10n.seerahTopicOf(
        format.integer(t.number),
        format.integer(topics.length),
      ),
      title: t.title.of(context),
      abstract: t.abstract.of(context),
      blocks: t.blocks,
      review: t.review,
      contentsLabel: l10n.seerahTopicsTitle,
      contents: [
        for (final s in topics)
          (
            id: s.id,
            title: s.title.of(context),
            route: AppRoutes.seerahTopic(s.id),
          ),
      ],
      related: [
        if (t.chapterIds.isNotEmpty) ...[
          LinkGroupTitle(l10n.relatedChapters),
          for (final id in t.chapterIds)
            if (chapters[id] case final c?)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.auto_stories_outlined),
                title: Text(c.title.of(context)),
                subtitle: Text(
                  l10n.seerahChapterLabel(
                    format.integer(c.number),
                    format.historicalDate(c.date),
                  ),
                ),
                onTap: () => context.push(AppRoutes.seerahChapter(c.id)),
              ),
        ],
        if (t.companionIds.isNotEmpty) ...[
          LinkGroupTitle(l10n.relatedCompanions),
          CompanionChips(ids: t.companionIds),
        ],
      ],
      previous: previous == null
          ? null
          : (
              label: l10n.seerahPreviousTopic,
              title: previous.title.of(context),
              open: () => open(previous),
            ),
      next: next == null
          ? null
          : (
              label: l10n.seerahNextTopic,
              title: next.title.of(context),
              open: () => open(next),
            ),
    );
  }
}
