import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/database/database_provider.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/companion_card.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_banner.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/landscape_hero.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/design_system/widgets/section_header.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/companions/presentation/directory/directory_page.dart';
import 'package:siyar_sahaba/features/home/domain/daily_featured.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/continue_reading.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_manifest.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// Home (S02): the companion of the day, unfinished reading, categories in
/// a dark band, and selected stories.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final manifest = ref.watch(contentManifestProvider);
    final index = ref.watch(companionIndexProvider);
    final categories = ref.watch(categoriesProvider);
    final stories = ref.watch(storyIndexProvider);

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
        actions: [
          IconButton(
            tooltip: l10n.searchTooltip,
            icon: const Icon(Icons.search),
            onPressed: () => context.push(AppRoutes.search),
          ),
        ],
      ),
      body: body,
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({
    required this.manifest,
    required this.companions,
    required this.categories,
    required this.stories,
    required this.today,
  });

  final ContentManifest manifest;
  final List<CompanionSummary> companions;
  final List<CompanionCategory> categories;
  final List<StorySummary> stories;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final featured = featuredFor(today, companions, channel: manifest.channel);
    var index = 0;
    Widget header(String kicker, String title) => Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSpacing.xl,
        bottom: AppSpacing.sm,
      ),
      child: SectionHeader(index: ++index, kicker: kicker, title: title),
    );

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (manifest.isDraft) ...[
                const DraftBanner(),
                const SizedBox(height: AppSpacing.md),
              ],
              if (featured != null) _FeaturedHero(companion: featured),
              ContinueReadingList(
                header: header(l10n.continueKicker, l10n.continueTitle),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _CategoryBand(categories: categories, companions: companions),
        if (stories.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header(l10n.homeStoriesKicker, l10n.homeStoriesTitle),
                for (final s in stories) _StoryCard(story: s),
              ],
            ),
          ),
      ],
    );
  }
}

class _FeaturedHero extends StatelessWidget {
  const _FeaturedHero({required this.companion});

  final CompanionSummary companion;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = companion;
    return LandscapeHero(
      child: Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.homeFeaturedKicker,
                    style: SahabaTextStyles.of(context).kicker.copyWith(
                      color: SahabaColors.of(context).accentText,
                    ),
                  ),
                ),
                if (!c.review.isApproved) const DraftBadge(),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
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
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: () => context.push(AppRoutes.companion(c.id)),
              child: Text(l10n.homeReadBiography),
            ),
          ],
        ),
      ),
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
      data: AppTheme.dark,
      child: Builder(
        builder: (context) {
          final format = DisplayFormatter.of(context);
          final colors = SahabaColors.of(context);
          final textTheme = Theme.of(context).textTheme;
          return ColoredBox(
            color: Palette.ink,
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

class _StoryCard extends StatelessWidget {
  const _StoryCard({required this.story});

  final StorySummary story;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final s = story;
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(AppRadii.md),
      ),
      child: InkWell(
        onTap: () => context.push(AppRoutes.story(s.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!s.review.isApproved) ...[
                const DraftBadge(),
                const SizedBox(height: AppSpacing.xs),
              ],
              Text(
                s.title.of(context),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                s.synopsis.of(context),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceDim),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.storyReadingMinutes(
                  s.readingMinutes,
                  format.integer(s.readingMinutes),
                ),
                style: SahabaTextStyles.of(context).kicker,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
