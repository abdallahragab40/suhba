import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/core/result/failure.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/passage_contents.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/features/settings/presentation/reading_settings.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/features/sources/presentation/passage_share.dart';
import 'package:siyar_sahaba/features/stories/presentation/story_page.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/presentation/reader_navigation.dart';
import 'package:siyar_sahaba/shared/content/presentation/reading_body.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// One chapter of a story (S08). The last chapter ends with the companions
/// the story is about.
class ChapterPage extends ConsumerWidget {
  const ChapterPage({
    required this.storyId,
    required this.chapterId,
    super.key,
  });

  final String storyId;
  final String chapterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final story = ref.watch(storyProvider(storyId));

    Widget message(Widget body) => Scaffold(appBar: AppBar(), body: body);

    return switch (story) {
      AsyncData(:final value) => switch (value.chapters.indexWhere(
        (c) => c.id == chapterId,
      )) {
        -1 => message(
          EmptyState(
            icon: Icons.auto_stories_outlined,
            title: l10n.storyNotFound,
          ),
        ),
        final index => _Chapter(story: value, index: index),
      },
      AsyncError(error: NotFoundFailure()) => message(
        EmptyState(
          icon: Icons.auto_stories_outlined,
          title: l10n.storyNotFound,
        ),
      ),
      AsyncError(:final error) => message(
        ErrorView(
          error: error,
          onRetry: () => ref.invalidate(storyProvider(storyId)),
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

class _Chapter extends ConsumerWidget {
  const _Chapter({required this.story, required this.index});

  final Story story;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final s = story;
    final chapter = s.chapters[index];
    final provisional = !s.review.isApproved;
    final previous = index > 0 ? s.chapters[index - 1] : null;
    final next = index < s.chapters.length - 1 ? s.chapters[index + 1] : null;
    final citations = [for (final b in chapter.blocks) ...b.allCitations];

    void open(StoryChapter c) => context.replace(AppRoutes.chapter(s.id, c.id));

    return TrackedReaderScaffold(
      target: ProgressTarget.chapter,
      targetId: chapter.id,
      revision: chapter.revision,
      parentId: s.id,
      title: s.title.of(context),
      actions: [
        BookmarkButton(
          target: BookmarkTarget.chapter,
          targetId: chapter.id,
          parentId: s.id,
        ),
        PassageContentsButton(
          label: l10n.readerChapterContents,
          target: ProgressTarget.chapter,
          parentId: s.id,
          currentId: chapter.id,
          entries: [
            for (final ch in s.chapters)
              (
                id: ch.id,
                title: ch.title.of(context),
                route: AppRoutes.chapter(s.id, ch.id),
              ),
          ],
        ),
        const ReadingSettingsButton(),
      ],
      children: [
        if (provisional) ...[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: DraftBadge(preliminary: s.review.isPreliminary),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Text(
          l10n.storyChapterOf(
            format.integer(index + 1),
            format.integer(s.chapters.length),
          ),
          style: SahabaTextStyles.of(context).kicker,
        ),
        Semantics(
          header: true,
          child: Text(
            chapter.title.of(context),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ReadingBody(
          blocks: chapter.blocks,
          provisional: provisional,
          textSize: ref.watch(readingTextSizeProvider),
          onCitations: (cites, reliability, {passage}) => showCitationSheet(
            context,
            citations: cites,
            reliability: reliability,
            provisional: provisional,
            share: passage == null
                ? null
                : PassageShare(
                    text: passage,
                    origin:
                        '${s.title.of(context)} — ${chapter.title.of(context)}',
                  ),
          ),
        ),
        const PassageCompletion(),
        const SizedBox(height: AppSpacing.lg),
        PassageSources(
          citations: citations,
          onOpen: () => showCitationSheet(
            context,
            citations: citations,
            provisional: provisional,
          ),
        ),
        if (next == null) ...[
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.surfaceAlt,
              borderRadius: const BorderRadius.all(AppRadii.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.storyEnd,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                StoryCompanions(companionIds: s.companionIds),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        ReaderNavigation(
          previousLabel: l10n.storyPreviousChapter,
          previousTitle: previous?.title.of(context),
          onPrevious: previous == null ? null : () => open(previous),
          nextLabel: l10n.storyNextChapter,
          nextTitle: next?.title.of(context),
          onNext: next == null ? null : () => open(next),
        ),
      ],
    );
  }
}
