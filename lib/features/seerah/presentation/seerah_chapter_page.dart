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

/// One chapter of the Seerah (S16), in reading order, with its events,
/// places and companions, and the previous and next chapters.
class SeerahChapterPage extends ConsumerWidget {
  const SeerahChapterPage({required this.chapterId, super.key});

  final String chapterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final chapter = ref.watch(seerahChapterProvider(chapterId));
    final index = ref.watch(seerahIndexProvider);

    Widget message(Widget body) => Scaffold(appBar: AppBar(), body: body);

    return switch ((chapter, index)) {
      (AsyncData(value: final c), AsyncData(value: final i)) => _Chapter(
        chapter: c,
        index: i,
      ),
      (AsyncError(error: NotFoundFailure()), _) => message(
        EmptyState(
          icon: Icons.auto_stories_outlined,
          title: l10n.seerahChapterNotFound,
        ),
      ),
      (AsyncError(:final error), _) || (_, AsyncError(:final error)) => message(
        ErrorView(
          error: error,
          onRetry: () => ref
            ..invalidate(seerahChapterProvider(chapterId))
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

class _Chapter extends StatelessWidget {
  const _Chapter({required this.chapter, required this.index});

  final SeerahChapter chapter;
  final SeerahIndex index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final c = chapter;
    final chapters = index.chapters;
    final at = chapters.indexWhere((s) => s.id == c.id);
    final previous = at > 0 ? chapters[at - 1] : null;
    final next = at >= 0 && at < chapters.length - 1 ? chapters[at + 1] : null;
    void open(SeerahChapterSummary s) =>
        context.replace(AppRoutes.seerahChapter(s.id));

    return SeerahPassageReader(
      target: ProgressTarget.seerahChapter,
      bookmarkTarget: BookmarkTarget.seerahChapter,
      id: c.id,
      revision: c.revision,
      appBarTitle: index.collection.subtitle.of(context),
      kicker: l10n.seerahChapterOf(
        format.integer(c.number),
        format.integer(chapters.length),
        format.historicalDate(c.date),
      ),
      title: c.title.of(context),
      abstract: c.abstract.of(context),
      blocks: c.blocks,
      review: c.review,
      contentsLabel: l10n.seerahContents,
      contents: [
        for (final s in chapters)
          (
            id: s.id,
            title: '${format.integer(s.number)}. ${s.title.of(context)}',
            route: AppRoutes.seerahChapter(s.id),
          ),
      ],
      related: [
        if (c.eventIds.isNotEmpty) ...[
          LinkGroupTitle(l10n.relatedEvents),
          EventRows(ids: c.eventIds),
        ],
        if (c.placeIds.isNotEmpty) ...[
          LinkGroupTitle(l10n.relatedPlaces),
          PlaceChips(ids: c.placeIds),
        ],
        if (c.companionIds.isNotEmpty) ...[
          LinkGroupTitle(l10n.relatedCompanions),
          CompanionChips(ids: c.companionIds),
        ],
      ],
      previous: previous == null
          ? null
          : (
              label: l10n.seerahPreviousChapter,
              title: previous.title.of(context),
              open: () => open(previous),
            ),
      next: next == null
          ? null
          : (
              label: l10n.seerahNextChapter,
              title: next.title.of(context),
              open: () => open(next),
            ),
    );
  }
}
