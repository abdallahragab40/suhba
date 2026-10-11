import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/app_shell.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/database/database_provider.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/companion_card.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_banner.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/design_system/widgets/section_header.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/companions/presentation/directory/directory_page.dart';
import 'package:siyar_sahaba/features/home/domain/daily_featured.dart';
import 'package:siyar_sahaba/features/quiz/presentation/quiz_banner.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/continue_reading.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/features/seerah/presentation/seerah_hub_page.dart';
import 'package:siyar_sahaba/features/stories/presentation/story_card.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/content_manifest.dart';
import 'package:siyar_sahaba/shared/content/domain/content_target.dart';
import 'package:siyar_sahaba/shared/content/domain/seerah.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/presentation/record_links.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/infographic_view.dart';

/// Home (S02), an editorial front page. In order: the Seerah's opening
/// scene with begin/continue; the reader's unfinished reading; the next
/// Seerah chapters on paper; one decisive episode on ink with its visual;
/// the companion of the day with a passage from their biography; the
/// atlas; selected events from the archive; then the collections.
///
/// Sections alternate between paper and ink, and each has its own
/// composition, rather than one repeated card.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final manifest = ref.watch(contentManifestProvider);
    final index = ref.watch(companionIndexProvider);
    final categories = ref.watch(categoriesProvider);
    final stories = ref.watch(storyIndexProvider);
    // The Seerah is optional: a build without it still has a Home.
    final seerah = ref.watch(seerahIndexProvider);

    final Widget body;
    if (manifest.hasError || index.hasError || categories.hasError) {
      body = ErrorView(
        error: manifest.error ?? index.error ?? categories.error,
        onRetry: () => ref
          ..invalidate(contentManifestProvider)
          ..invalidate(companionIndexProvider)
          ..invalidate(categoriesProvider),
      );
    } else if ((manifest.value, index.value, categories.value) case (
      final m?,
      final i?,
      final c?,
    )) {
      body = _Home(
        manifest: m,
        companions: i,
        categories: c,
        stories: stories.value ?? const [],
        seerah: seerah.value,
        today: ref.watch(clockProvider)(),
      );
    } else {
      body = const Padding(
        padding: EdgeInsets.all(AppSpacing.gutter),
        child: LoadingSkeleton(lines: 8),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: shellActions(context),
      ),
      body: body,
    );
  }
}

class _Home extends ConsumerWidget {
  const _Home({
    required this.manifest,
    required this.companions,
    required this.categories,
    required this.stories,
    required this.seerah,
    required this.today,
  });

  final ContentManifest manifest;
  final List<CompanionSummary> companions;
  final List<CompanionCategory> categories;
  final List<StorySummary> stories;
  final SeerahIndex? seerah;
  final DateTime today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final featured = featuredFor(today, companions, channel: manifest.channel);
    final progress =
        ref
            .watch(
              workProgressProvider((
                ProgressTarget.seerahChapter,
                seerahParentId,
              )),
            )
            .value ??
        const <String, ReadingProgress>{};
    final seerah = this.seerah;
    var index = 0;
    Widget header(String kicker, String title, {String? note}) => Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSpacing.xl,
        bottom: AppSpacing.sm,
      ),
      child: SectionHeader(
        index: ++index,
        kicker: kicker,
        title: title,
        note: note,
      ),
    );
    Widget paper(List<Widget> children) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );

    // The next chapters to read: from where the reader is, else the start.
    final resume = seerah == null
        ? null
        : seerahResumeChapter(seerah.chapters, progress);
    final from = seerah == null || resume == null
        ? 0
        : seerah.chapters.indexOf(resume);
    final nextChapters = seerah == null
        ? const <SeerahChapterSummary>[]
        : seerah.chapters.skip(from).take(3).toList();

    // Laid out in full rather than lazily: the page is finite, and its
    // sections (visuals, excerpts) must not reload and shift as they
    // scroll back into view.
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (seerah != null)
            SeerahOpening(index: seerah, progress: progress, compact: true),
          paper([
            if (manifest.isDraft) ...[
              const SizedBox(height: AppSpacing.md),
              const DraftBanner(),
            ],
            // Not numbered: it only appears when there is unfinished reading.
            ContinueReadingList(
              header: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: AppSpacing.xl,
                  bottom: AppSpacing.sm,
                ),
                child: SectionHeader(
                  kicker: l10n.continueKicker,
                  title: l10n.continueTitle,
                ),
              ),
            ),
            if (nextChapters.isNotEmpty) ...[
              header(l10n.homeSeerahKicker, l10n.homeSeerahTitle),
              for (final c in nextChapters)
                ChapterJourneyTile(
                  chapter: c,
                  progress: progress[c.id],
                  last: c == nextChapters.last,
                ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: () => context.go(AppRoutes.seerah),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(l10n.homeAllChapters),
                ),
              ),
            ],
          ]),
          if (seerah?.collection.visualIds.contains('hijrah-route') ??
              false) ...[
            const SizedBox(height: AppSpacing.xl),
            const _InkEpisode(),
          ],
          paper([
            if (featured != null) ...[
              header(l10n.homeFeaturedKicker, l10n.homeDiscoverTitle),
              _FeaturedCompanion(companion: featured),
            ],
            const SizedBox(height: AppSpacing.xl),
            const QuizBanner(),
            if (seerah?.collection.visualIds.contains('seerah-atlas') ??
                false) ...[
              header(l10n.homeAtlasKicker, l10n.homeAtlasTitle),
              const InfographicView(visualId: 'seerah-atlas', inline: true),
            ],
            if (seerah?.collection.featuredEventIds case final ids?
                when ids.isNotEmpty) ...[
              header(l10n.homeArchiveKicker, l10n.homeArchiveTitle),
              EventRows(ids: ids),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: () =>
                      context.go('${AppRoutes.explore}?show=events'),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(l10n.homeAllEvents),
                ),
              ),
            ],
          ]),
          const SizedBox(height: AppSpacing.xl),
          _CategoryBand(categories: categories, companions: companions),
          paper([
            if (stories.isNotEmpty) ...[
              header(l10n.homeStoriesKicker, l10n.homeStoriesTitle),
              for (final s in stories) StoryCard(story: s),
            ],
            const SizedBox(height: AppSpacing.md),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                onPressed: () => context.push(AppRoutes.sourcesDirectory),
                icon: const Icon(Icons.menu_book_outlined),
                label: Text(l10n.seerahAllSources),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

/// The ink band: one decisive episode told as a sequence.
class _InkEpisode extends StatelessWidget {
  const _InkEpisode();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Theme(
      data: AppTheme.feature,
      child: Builder(
        builder: (context) => Material(
          color: Palette.green,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.gutter),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionHeader(
                      kicker: l10n.seerahFeatureKicker,
                      title: l10n.seerahFeatureTitle,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const InfographicView(
                      visualId: 'hijrah-sequence',
                      inline: true,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FilledButton.tonalIcon(
                        onPressed: () => context.push(
                          AppRoutes.seerahChapter('hijrah-to-madinah'),
                        ),
                        icon: const Icon(Icons.auto_stories),
                        label: Text(l10n.seerahFeatureRead),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The companion of the day, with the opening of their written biography
/// when there is one, so Home shows real narrative rather than a label.
class _FeaturedCompanion extends ConsumerWidget {
  const _FeaturedCompanion({required this.companion});

  final CompanionSummary companion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final c = companion;
    final full = ref.watch(companionProvider(c.id)).value;
    final excerpt = full == null
        ? null
        : [
            for (final s in full.sections)
              for (final b in s.blocks)
                if (b case ParagraphBlock(:final text)) text.of(context),
          ].take(2).join(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The review badge on its own line, as on the other cards: beside
        // the name it does not fit at large text sizes.
        if (!c.review.isApproved) ...[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: DraftBadge(preliminary: c.review.isPreliminary),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        Hero(
          tag: DirectoryPage.heroTag(c.id),
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              c.name.of(context),
              style: CompanionCard.nameStyle(context),
            ),
          ),
        ),
        Text(
          companionHonorific(c.gender),
          style: SahabaTextStyles.of(context).kicker,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          c.summary.of(context),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (excerpt != null && excerpt.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          DecoratedBox(
            decoration: BoxDecoration(
              border: BorderDirectional(
                start: BorderSide(color: colors.accent, width: 3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: AppSpacing.sm),
              child: Text(
                excerpt,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: SahabaTextStyles.of(context).reading,
              ),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: FilledButton(
            onPressed: () => context.push(AppRoutes.companion(c.id)),
            child: Text(l10n.homeReadBiography),
          ),
        ),
      ],
    );
  }
}

/// The reference site's alternating dark section: categories on ink.
class _CategoryBand extends StatelessWidget {
  const _CategoryBand({required this.categories, required this.companions});

  final List<CompanionCategory> categories;
  final List<CompanionSummary> companions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Theme(
      data: AppTheme.feature,
      child: Builder(
        builder: (context) {
          final format = DisplayFormatter.of(context);
          final colors = SahabaColors.of(context);
          final textTheme = Theme.of(context).textTheme;
          return Material(
            color: Palette.green,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.gutter),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionHeader(
                    kicker: l10n.homeCategoriesKicker,
                    title: l10n.homeCategoriesTitle,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final cat in categories)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: AppSpacing.sm,
                      ),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => context.go(
                            AppRoutes.companionsInCategory(cat.id),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cat.name.of(context),
                                        style: textTheme.titleLarge,
                                      ),
                                      if (cat.description case final d?)
                                        Text(
                                          d.of(context),
                                          style: textTheme.bodySmall?.copyWith(
                                            color: colors.onSurfaceDim,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Builder(
                                  builder: (context) {
                                    final n = companions
                                        .where(
                                          (c) => c.categoryIds.contains(cat.id),
                                        )
                                        .length;
                                    return Text(
                                      l10n.homeCategoryCount(
                                        n,
                                        format.integer(n),
                                      ),
                                      style: SahabaTextStyles.of(context).kicker
                                          .copyWith(color: colors.accentText),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
