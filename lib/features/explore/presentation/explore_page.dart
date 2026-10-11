import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/app_shell.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/design_system/widgets/section_header.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/atlas/presentation/place_page.dart';
import 'package:siyar_sahaba/features/stories/presentation/story_card.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/presentation/record_links.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/infographic_view.dart';

/// What Explore shows; its name is the `show` query parameter.
enum ExploreFilter { all, events, places, visuals, stories }

/// Explore (S19): the event archive, the places, the visuals and the
/// stories, filterable by kind. Every entry opens its own page; there are
/// no empty destinations (a kind with nothing in this build is not
/// offered).
class ExplorePage extends ConsumerWidget {
  const ExplorePage({this.filter, super.key});

  /// The initial filter's name, from the route; all when unknown.
  final String? filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final events = ref.watch(eventsProvider);
    final places = ref.watch(placesProvider);
    final visuals = ref.watch(visualsProvider);
    final stories = ref.watch(storyIndexProvider);

    final Widget body;
    if (events.hasError || places.hasError || visuals.hasError) {
      body = ErrorView(
        error: events.error ?? places.error ?? visuals.error,
        onRetry: () => ref
          ..invalidate(eventsProvider)
          ..invalidate(placesProvider)
          ..invalidate(visualsProvider),
      );
    } else if ((events.value, places.value, visuals.value) case (
      final e?,
      final p?,
      final v?,
    )) {
      body = _Explore(
        initial:
            ExploreFilter.values.where((f) => f.name == filter).firstOrNull ??
            ExploreFilter.all,
        events: e.values.toList()..sort((a, b) => a.date.compareTo(b.date)),
        places: p.values.toList()
          ..sort((a, b) => a.name.ar.compareTo(b.name.ar)),
        visuals: v.values.toList(),
        stories: stories.value ?? const [],
      );
    } else {
      body = const Padding(
        padding: EdgeInsets.all(AppSpacing.gutter),
        child: LoadingSkeleton(lines: 8),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabExplore),
        actions: shellActions(context),
      ),
      body: body,
    );
  }
}

class _Explore extends StatefulWidget {
  const _Explore({
    required this.initial,
    required this.events,
    required this.places,
    required this.visuals,
    required this.stories,
  });

  final ExploreFilter initial;
  final List<HistoricalEvent> events;
  final List<HistoricalPlace> places;
  final List<Infographic> visuals;
  final List<StorySummary> stories;

  @override
  State<_Explore> createState() => _ExploreState();
}

class _ExploreState extends State<_Explore> {
  late ExploreFilter _filter = widget.initial;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final available = {
      ExploreFilter.all: l10n.exploreAll,
      if (widget.events.isNotEmpty) ExploreFilter.events: l10n.exploreEvents,
      if (widget.places.isNotEmpty) ExploreFilter.places: l10n.explorePlaces,
      if (widget.visuals.isNotEmpty) ExploreFilter.visuals: l10n.exploreVisuals,
      if (widget.stories.isNotEmpty) ExploreFilter.stories: l10n.exploreStories,
    };
    bool show(ExploreFilter f) =>
        (_filter == ExploreFilter.all || _filter == f) &&
        available.containsKey(f);

    final beforeHijrah = [
      for (final e in widget.events)
        if ((e.date.sortKey ?? 0) < 0 && !e.date.isUnknown) e,
    ];
    final undated = [
      for (final e in widget.events)
        if (e.date.isUnknown) e,
    ];
    final afterHijrah = [
      for (final e in widget.events)
        if (!beforeHijrah.contains(e) && !undated.contains(e)) e,
    ];

    Widget header(String kicker, String title, {String? note}) => Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSpacing.lg,
        bottom: AppSpacing.sm,
      ),
      child: SectionHeader(kicker: kicker, title: title, note: note),
    );
    Widget group(String label) => Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.md),
      child: Text(label, style: SahabaTextStyles.of(context).kicker),
    );

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.gutter,
        AppSpacing.sm,
        AppSpacing.gutter,
        AppSpacing.xxl,
      ),
      children: [
        Text(l10n.exploreIntro, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final MapEntry(key: f, value: label) in available.entries)
              ChoiceChip(
                label: Text(label),
                selected: _filter == f,
                onSelected: (_) => setState(() => _filter = f),
              ),
          ],
        ),
        if (show(ExploreFilter.events)) ...[
          header(
            l10n.exploreEventsKicker,
            l10n.exploreEventsTitle,
            note: l10n.exploreEventsNote,
          ),
          if (beforeHijrah.isNotEmpty) group(l10n.exploreBeforeHijrah),
          for (final e in beforeHijrah) EventRow(event: e),
          if (afterHijrah.isNotEmpty) group(l10n.exploreAfterHijrah),
          for (final e in afterHijrah) EventRow(event: e),
          if (undated.isNotEmpty) group(l10n.timelineUndated),
          for (final e in undated) EventRow(event: e),
        ],
        if (_filter == ExploreFilter.all) ...[
          header(l10n.exploreRelationsKicker, l10n.exploreRelationsTitle),
          const _RelationsTile(),
        ],
        if (show(ExploreFilter.visuals)) ...[
          header(l10n.exploreVisualsKicker, l10n.exploreVisualsTitle),
          for (final v in widget.visuals) _VisualTile(visual: v),
        ],
        if (show(ExploreFilter.places)) ...[
          header(l10n.explorePlacesKicker, l10n.explorePlacesTitle),
          for (final p in widget.places) _PlaceTile(place: p),
        ],
        if (show(ExploreFilter.stories)) ...[
          header(l10n.exploreStoriesKicker, l10n.exploreStoriesTitle),
          for (final s in widget.stories) StoryCard(story: s),
        ],
      ],
    );
  }
}

class _VisualTile extends StatelessWidget {
  const _VisualTile({required this.visual});

  final Infographic visual;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final v = visual;
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.visual(v.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(infographicTypeIcon(v.type), color: colors.accentText),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      infographicTypeLabel(l10n, v.type),
                      style: SahabaTextStyles.of(context).kicker,
                    ),
                    Text(
                      v.title.of(context),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      v.takeaway.of(context),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceDim,
                      ),
                    ),
                  ],
                ),
              ),
              if (!v.review.isApproved)
                Flexible(
                  child: DraftBadge(preliminary: v.review.isPreliminary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceTile extends StatelessWidget {
  const _PlaceTile({required this.place});

  final HistoricalPlace place;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = place;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.place_outlined),
      title: Text(p.name.of(context)),
      subtitle: Text(
        '${geoPrecisionLabel(l10n, p.location.precision)} · '
        '${p.summary.of(context)}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => context.push(AppRoutes.place(p.id)),
    );
  }
}

class _RelationsTile extends StatelessWidget {
  const _RelationsTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.relations()),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(Icons.account_tree_outlined, color: colors.accentText),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.relationsTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      l10n.exploreRelationsBody,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceDim,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
