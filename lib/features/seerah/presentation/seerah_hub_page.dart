import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/app_shell.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/design_system/widgets/scene_backdrop.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/passage_contents.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/settings/presentation/reading_settings.dart';
import 'package:suhba/features/sources/presentation/citation_sheet.dart';
import 'package:suhba/features/sources/presentation/passage_share.dart';
import 'package:suhba/shared/content/domain/content_block.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/domain/review.dart';
import 'package:suhba/shared/content/domain/seerah.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/presentation/reading_body.dart';
import 'package:suhba/shared/content/presentation/record_links.dart';
import 'package:suhba/shared/content/providers.dart';
import 'package:suhba/shared/visuals/presentation/infographic_view.dart';

/// The Seerah hub (S15): محمد رسول الله ﷺ. An opening scene with a way to
/// start or continue; the chapter journey grouped by period; an ink band
/// on the Hijrah; thematic essays; selected events and places; related
/// companions; and how the section is sourced.
class SeerahHubPage extends ConsumerWidget {
  const SeerahHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final index = ref.watch(seerahIndexProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.seerahSectionName),
        actions: shellActions(context),
      ),
      body: switch (index) {
        AsyncData(:final value) => _Hub(index: value),
        AsyncError(error: NotFoundFailure()) => EmptyState(
          icon: Icons.auto_stories_outlined,
          title: l10n.seerahUnavailable,
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(seerahIndexProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 10),
        ),
      },
    );
  }
}

/// Where to continue the Seerah: the most recent unfinished chapter, else
/// the first chapter not yet finished, else null (finished, or no
/// progress yet and so start at chapter one).
SeerahChapterSummary? seerahResumeChapter(
  List<SeerahChapterSummary> chapters,
  Map<String, ReadingProgress> progress,
) {
  final unfinished = [
    for (final c in chapters)
      if (progress[c.id] case final p? when !p.completed) (c, p),
  ]..sort((a, b) => b.$2.updatedAt.compareTo(a.$2.updatedAt));
  if (unfinished.isNotEmpty) return unfinished.first.$1;
  if (progress.isEmpty) return null;
  return chapters.where((c) => progress[c.id]?.completed != true).firstOrNull;
}

class _Hub extends ConsumerWidget {
  const _Hub({required this.index});

  final SeerahIndex index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
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
    final s = index.collection;
    final byId = {for (final c in index.chapters) c.id: c};
    var section = 0;
    Widget header(String kicker, String title, {String? note}) => Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSpacing.xl,
        bottom: AppSpacing.sm,
      ),
      child: SectionHeader(
        index: ++section,
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

    // Laid out in full rather than lazily: the page is finite, and its
    // sections (visuals, excerpts) must not reload and shift as they
    // scroll back into view.
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SeerahOpening(index: index, progress: progress),
          paper([
            const SizedBox(height: AppSpacing.md),
            ReadingBody(
              blocks: s.introduction.skip(1).toList(),
              provisional: !s.review.isApproved,
              textSize: ref.watch(readingTextSizeProvider),
              onCitations: (c, r, {passage}) => showCitationSheet(
                context,
                citations: c,
                reliability: r,
                provisional: !s.review.isApproved,
                share: passage == null
                    ? null
                    : PassageShare(text: passage, origin: s.title.of(context)),
              ),
            ),
            header(
              l10n.seerahJourneyKicker,
              l10n.seerahJourneyTitle,
              note: l10n.seerahJourneyNote(
                DisplayFormatter.of(context).integer(index.chapters.length),
              ),
            ),
            for (final period in s.periods) ...[
              _PeriodHeading(period: period),
              for (final id in period.chapterIds)
                if (byId[id] case final c?)
                  ChapterJourneyTile(
                    chapter: c,
                    progress: progress[c.id],
                    last: id == period.chapterIds.last,
                  ),
            ],
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: () => context.push(AppRoutes.seerahTimeline),
              icon: const Icon(Icons.timeline),
              label: Text(l10n.seerahOpenTimeline),
            ),
          ]),
          const SizedBox(height: AppSpacing.xl),
          if (s.visualIds.contains('hijrah-route'))
            const _InkFeature(visualId: 'hijrah-route'),
          paper([
            if (index.topics.isNotEmpty) ...[
              header(l10n.seerahTopicsKicker, l10n.seerahTopicsTitle),
              _TopicGrid(topics: index.topics),
            ],
            if (s.featuredEventIds.isNotEmpty) ...[
              header(l10n.seerahEventsKicker, l10n.seerahEventsTitle),
              EventRows(ids: s.featuredEventIds),
            ],
            if (s.featuredPlaceIds.isNotEmpty) ...[
              header(l10n.seerahPlacesKicker, l10n.seerahPlacesTitle),
              PlaceChips(ids: s.featuredPlaceIds),
              const SizedBox(height: AppSpacing.md),
              if (s.visualIds.contains('seerah-atlas'))
                const InfographicView(visualId: 'seerah-atlas', inline: true),
            ],
            if (s.companionIds.isNotEmpty) ...[
              header(l10n.seerahCompanionsKicker, l10n.seerahCompanionsTitle),
              CompanionChips(ids: s.companionIds),
            ],
            header(l10n.seerahMethodKicker, l10n.seerahMethodTitle),
            Text(
              s.methodology.of(context),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
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

/// The edge-to-edge opening: a drawn night landscape, the section's name
/// in large type, the first lines of the introduction, and a way to start
/// or continue. Its height follows its content, so large text never
/// clips.
class SeerahOpening extends ConsumerWidget {
  const SeerahOpening({
    required this.index,
    required this.progress,
    this.compact = false,
    super.key,
  });

  final SeerahIndex index;
  final Map<String, ReadingProgress> progress;

  /// The shorter form used on Home.
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final s = index.collection;
    final resume = seerahResumeChapter(index.chapters, progress);
    final first = index.chapters.firstOrNull;
    final introText = switch (s.introduction.firstOrNull) {
      ParagraphBlock(:final text) => text.of(context),
      _ => null,
    };

    return Theme(
      data: AppTheme.feature,
      child: Builder(
        builder: (context) {
          final textTheme = Theme.of(context).textTheme;
          return Stack(
            children: [
              const Positioned.fill(
                child: SceneBackdrop(kind: SceneKind.nightDesert),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.gutter,
                  compact ? AppSpacing.xl : AppSpacing.xxl,
                  AppSpacing.gutter,
                  AppSpacing.xl,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          s.subtitle.of(context),
                          style: SuhbaTextStyles.of(
                            context,
                          ).kicker.copyWith(color: Palette.goldOnInk),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Semantics(
                          header: true,
                          child: Text(
                            s.title.of(context),
                            textAlign: TextAlign.center,
                            style:
                                (compact
                                        ? textTheme.displaySmall
                                        : textTheme.displayMedium)
                                    ?.copyWith(color: Palette.paper),
                          ),
                        ),
                        if (!s.review.isApproved) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: DraftBadge(
                              preliminary: s.review.isPreliminary,
                            ),
                          ),
                        ],
                        if (introText != null) ...[
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            introText,
                            maxLines: compact ? 4 : null,
                            overflow: compact ? TextOverflow.ellipsis : null,
                            style: SuhbaTextStyles.of(
                              context,
                            ).reading.copyWith(color: Palette.paper),
                          ),
                        ],
                        const SizedBox(height: AppSpacing.lg),
                        if (resume case final c?)
                          FilledButton.icon(
                            onPressed: () =>
                                context.push(AppRoutes.seerahChapter(c.id)),
                            icon: const Icon(Icons.play_arrow),
                            label: Text(
                              l10n.seerahContinue(c.title.of(context)),
                            ),
                          )
                        else if (first != null)
                          FilledButton.icon(
                            onPressed: () =>
                                context.push(AppRoutes.seerahChapter(first.id)),
                            icon: const Icon(Icons.auto_stories),
                            label: Text(l10n.seerahStart),
                          ),
                        if (compact) ...[
                          const SizedBox(height: AppSpacing.xs),
                          OutlinedButton(
                            onPressed: () => context.go(AppRoutes.seerah),
                            child: Text(l10n.seerahOpenSection),
                          ),
                        ] else ...[
                          const SizedBox(height: AppSpacing.lg),
                          ExcludeSemantics(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    l10n.seerahScrollHint,
                                    style: SuhbaTextStyles.of(context).kicker
                                        .copyWith(
                                          color: Palette.paperDimOnGreen,
                                        ),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Palette.goldOnInk,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PeriodHeading extends StatelessWidget {
  const _PeriodHeading({required this.period});

  final SeerahPeriod period;

  @override
  Widget build(BuildContext context) {
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSpacing.lg,
        bottom: AppSpacing.xs,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colors.surfaceAlt,
          borderRadius: const BorderRadius.all(AppRadii.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              format.historicalDate(period.date),
              style: SuhbaTextStyles.of(
                context,
              ).kicker.copyWith(color: colors.accentText),
            ),
            Semantics(
              header: true,
              child: Text(
                period.name.of(context),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              period.summary.of(context),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// One chapter in the journey: its number in large outline, its time
/// label, title and abstract, how far the reader got, and whether it is a
/// short sample. Joined to the next chapter by a vertical line.
class ChapterJourneyTile extends StatelessWidget {
  const ChapterJourneyTile({
    required this.chapter,
    required this.progress,
    this.last = false,
    super.key,
  });

  final SeerahChapterSummary chapter;
  final ReadingProgress? progress;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final c = chapter;
    return InkWell(
      onTap: () => context.push(AppRoutes.seerahChapter(c.id)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 64,
              child: Column(
                children: [
                  // The chapter's place in the sequence, as a solid number
                  // in a ring: an outlined "١" reads as an empty box.
                  ExcludeSemantics(
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.accent, width: 1.5),
                      ),
                      child: Text(
                        format.integer(c.number),
                        textScaler: TextScaler.noScaling,
                        style: textTheme.titleMedium?.copyWith(
                          color: colors.accentText,
                        ),
                      ),
                    ),
                  ),
                  if (!last)
                    Expanded(
                      child: Center(
                        child: Container(width: 1.5, color: colors.line),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.seerahChapterLabel(
                              format.integer(c.number),
                              format.historicalDate(c.date),
                            ),
                            style: SuhbaTextStyles.of(
                              context,
                            ).kicker.copyWith(color: colors.accentText),
                          ),
                        ),
                        PassageProgressMarker(progress: progress),
                      ],
                    ),
                    Text(c.title.of(context), style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      c.abstract.of(context),
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceDim,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Wrap(
                      spacing: AppSpacing.sm,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          l10n.storyReadingMinutes(
                            readingMinutes(c.wordCount),
                            format.integer(readingMinutes(c.wordCount)),
                          ),
                          style: SuhbaTextStyles.of(context).kicker,
                        ),
                        if (c.visualIds.isNotEmpty)
                          Text(
                            l10n.seerahVisualCount(
                              c.visualIds.length,
                              format.integer(c.visualIds.length),
                            ),
                            style: SuhbaTextStyles.of(context).kicker,
                          ),
                        if (c.review.coverage == Coverage.sample)
                          Text(
                            l10n.coverageSampleShort,
                            style: SuhbaTextStyles.of(
                              context,
                            ).kicker.copyWith(color: colors.draft),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// An estimate of reading time for [words] of Arabic prose: about 130
/// words a minute, at least one minute.
int readingMinutes(int words) => (words / 130).ceil().clamp(1, 999);

/// The contrasting ink band: one decisive episode with its visual.
class _InkFeature extends StatelessWidget {
  const _InkFeature({required this.visualId});

  final String visualId;

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
                    InfographicView(visualId: visualId, inline: true),
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

class _TopicGrid extends StatelessWidget {
  const _TopicGrid({required this.topics});

  final List<SeerahTopicSummary> topics;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 560 ? 2 : 1;
        final width =
            (constraints.maxWidth - AppSpacing.sm * (columns - 1)) / columns;
        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final t in topics)
              SizedBox(
                width: width,
                child: Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => context.push(AppRoutes.seerahTopic(t.id)),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.title.of(context),
                            style: textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            t.abstract.of(context),
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceDim,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
