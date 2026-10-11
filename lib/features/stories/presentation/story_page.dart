import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/companion_card.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/landscape_hero.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:suhba/shared/content/domain/story.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// A story's overview (S07): title and synopsis, its chapters, and the
/// companions it is about.
class StoryPage extends ConsumerWidget {
  const StoryPage({required this.storyId, super.key});

  final String storyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final story = ref.watch(storyProvider(storyId));
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (story.hasValue)
            BookmarkButton(target: BookmarkTarget.story, targetId: storyId),
        ],
      ),
      body: switch (story) {
        AsyncData(:final value) => _StoryOverview(story: value),
        AsyncError(error: NotFoundFailure()) => EmptyState(
          icon: Icons.auto_stories_outlined,
          title: l10n.storyNotFound,
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(storyProvider(storyId)),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 6),
        ),
      },
    );
  }
}

class _StoryOverview extends StatelessWidget {
  const _StoryOverview({required this.story});

  final Story story;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final s = story;

    void openChapter(StoryChapter chapter) =>
        context.push(AppRoutes.chapter(s.id, chapter.id));

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.readingMaxWidth),
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.gutter,
            0,
            AppSpacing.gutter,
            AppSpacing.xxl,
          ),
          children: [
            LandscapeHero(
              child: Builder(
                builder: (context) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!s.review.isApproved) ...[
                      DraftBadge(preliminary: s.review.isPreliminary),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                    Semantics(
                      header: true,
                      child: Text(
                        s.title.of(context),
                        style: CompanionCard.nameStyle(context),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      s.synopsis.of(context),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.storyReadingMinutes(
                        s.readingMinutes,
                        format.integer(s.readingMinutes),
                      ),
                      style: SuhbaTextStyles.of(context).kicker,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: () => openChapter(s.chapters.first),
              icon: const Icon(Icons.auto_stories_outlined),
              label: Text(l10n.storyStart),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(
              index: 1,
              kicker: l10n.storyChaptersKicker,
              title: l10n.storyChaptersTitle,
            ),
            for (var i = 0; i < s.chapters.length; i++)
              InkWell(
                onTap: () => openChapter(s.chapters[i]),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 48),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(color: colors.line),
                    ),
                  ),
                  child: Row(
                    children: [
                      ExcludeSemantics(
                        child: Text(
                          format.padded(i + 1),
                          style: textTheme.titleMedium?.copyWith(
                            color: colors.accentText,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          s.chapters[i].title.of(context),
                          style: textTheme.titleMedium,
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
            StoryCompanions(companionIds: s.companionIds),
          ],
        ),
      ),
    );
  }
}

/// Links to the companions a story is about.
class StoryCompanions extends ConsumerWidget {
  const StoryCompanions({required this.companionIds, super.key});

  final List<String> companionIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final index = ref.watch(companionIndexProvider).value ?? const [];
    final companions = [
      for (final id in companionIds) ...index.where((c) => c.id == id),
    ];
    if (companions.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(kicker: l10n.tabCompanions, title: l10n.storyCompanions),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final c in companions)
              ActionChip(
                label: Text(
                  '${c.name.of(context)} ${companionHonorific(c.gender)}',
                ),
                onPressed: () => context.push(AppRoutes.companion(c.id)),
              ),
          ],
        ),
      ],
    );
  }
}
