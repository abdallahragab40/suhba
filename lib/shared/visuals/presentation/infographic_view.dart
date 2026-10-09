import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/core/result/failure.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/period_bands.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/place_panel.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/relationship_diagram.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/resolved_visual.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/schematic_map.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/sequence_explainer.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/timeline_chart.dart';

/// The display name of an infographic type.
String infographicTypeLabel(AppLocalizations l10n, InfographicType type) =>
    switch (type) {
      InfographicType.timeline => l10n.visualTypeTimeline,
      InfographicType.map => l10n.visualTypeMap,
      InfographicType.relationships => l10n.visualTypeRelationships,
      InfographicType.sequence => l10n.visualTypeSequence,
      InfographicType.periods => l10n.visualTypePeriods,
      InfographicType.placePanel => l10n.visualTypePlacePanel,
    };

IconData infographicTypeIcon(InfographicType type) => switch (type) {
  InfographicType.timeline => Icons.timeline,
  InfographicType.map => Icons.map_outlined,
  InfographicType.relationships => Icons.hub_outlined,
  InfographicType.sequence => Icons.format_list_numbered,
  InfographicType.periods => Icons.view_week_outlined,
  InfographicType.placePanel => Icons.landscape_outlined,
};

/// A visual by id, with its frame: what kind it is and its review state,
/// the title, the takeaway in plain words, the chart or its equivalent
/// list, notes on uncertainty, and its sources.
///
/// [inline] is the form shown inside a passage: the chart is not
/// zoomable there (so it never fights the page's scrolling), and a link
/// opens the full page.
class InfographicView extends ConsumerStatefulWidget {
  const InfographicView({
    required this.visualId,
    this.inline = false,
    this.caption,
    super.key,
  });

  final String visualId;
  final bool inline;

  /// The passage's own caption for the visual, shown under it.
  final String? caption;

  @override
  ConsumerState<InfographicView> createState() => _InfographicViewState();
}

class _InfographicViewState extends ConsumerState<InfographicView> {
  bool _asList = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final resolved = ref.watch(resolvedVisualProvider(widget.visualId));
    return switch (resolved) {
      AsyncData(:final value) => _frame(context, value),
      AsyncError(error: NotFoundFailure()) => Text(
        l10n.visualNotFound,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      AsyncError(:final error) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(resolvedVisualProvider(widget.visualId)),
      ),
      _ => const LoadingSkeleton(lines: 4),
    };
  }

  void _citations(
    List<Citation> citations,
    Reliability? reliability,
    bool provisional,
  ) => showCitationSheet(
    context,
    citations: citations,
    reliability: reliability,
    provisional: provisional,
  );

  void _openMark(TimelineMark mark, ResolvedVisual r) {
    final provisional = !r.visual.review.isApproved;
    if (mark.eventId case final id? when r.events.containsKey(id)) {
      context.push(AppRoutes.event(id));
    } else if ((r.companion, mark.sectionId) case (final c?, final s?)) {
      context.push(AppRoutes.section(c.id, s));
    } else {
      _citations(mark.citations, mark.reliability, provisional);
    }
  }

  Widget _frame(BuildContext context, ResolvedVisual r) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final v = r.visual;
    final provisional = !v.review.isApproved;
    final citations = r.allCitations;

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              infographicTypeIcon(v.type),
              size: 18,
              color: colors.accentText,
            ),
            const SizedBox(width: AppSpacing.xxs),
            Expanded(
              child: Text(
                infographicTypeLabel(l10n, v.type),
                style: SahabaTextStyles.of(context).kicker,
              ),
            ),
            if (provisional) const DraftBadge(),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Semantics(
          header: true,
          child: Text(
            v.title.of(context),
            style: widget.inline
                ? textTheme.titleLarge
                : textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          v.takeaway.of(context),
          style: textTheme.bodyLarge?.copyWith(color: colors.onSurfaceDim),
        ),
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: false,
                icon: Icon(infographicTypeIcon(v.type)),
                label: Text(l10n.visualShowChart),
              ),
              ButtonSegment(
                value: true,
                icon: const Icon(Icons.list),
                label: Text(l10n.visualShowList),
              ),
            ],
            selected: {_asList},
            onSelectionChanged: (s) => setState(() => _asList = s.first),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (_asList) _list(context, r) else _chart(context, r),
        if (widget.caption case final caption?) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(caption, style: textTheme.bodySmall),
        ],
        if (v.notes.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(l10n.visualNotes, style: SahabaTextStyles.of(context).kicker),
          for (final n in v.notes)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: colors.onSurfaceDim,
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                  Expanded(
                    child: Text(n.of(context), style: textTheme.bodySmall),
                  ),
                ],
              ),
            ),
        ],
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            if (citations.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.visualSources, style: textTheme.labelLarge),
                  CitationMarker(
                    count: citations.length,
                    onPressed: () => _citations(citations, null, provisional),
                  ),
                ],
              ),
            if (widget.inline)
              TextButton.icon(
                onPressed: () => context.push(AppRoutes.visual(v.id)),
                icon: const Icon(Icons.open_in_full),
                label: Text(l10n.visualOpen),
              ),
          ],
        ),
      ],
    );

    if (!widget.inline) return body;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(AppRadii.md),
        border: Border.all(color: colors.line),
      ),
      child: Padding(padding: const EdgeInsets.all(AppSpacing.md), child: body),
    );
  }

  Widget _chart(BuildContext context, ResolvedVisual r) {
    final provisional = !r.visual.review.isApproved;
    return switch (r.visual.data) {
      TimelineData() => TimelineChart(
        marks: r.timelineMarks,
        onOpen: (m) => _openMark(m, r),
      ),
      MapData(:final placeIds, :final route) => SchematicMap(
        places: [for (final id in placeIds) ?r.places[id]],
        route: route,
        interactive: !widget.inline,
        height: widget.inline ? 280 : 420,
        onOpenPlace: (p) => context.push(AppRoutes.place(p.id)),
      ),
      RelationshipsData(:final edges) => RelationshipDiagram(
        edges: edges,
        people: r.people,
      ),
      SequenceData(:final steps) => SequenceExplainer(
        steps: steps,
        places: r.places,
        provisional: provisional,
        onCitations: (c, rel) => _citations(c, rel, provisional),
        onOpenPlace: (p) => context.push(AppRoutes.place(p.id)),
      ),
      PeriodsData(:final bands) => PeriodBands(bands: bands),
      PlacePanelData(:final placeId, :final callouts) =>
        r.places[placeId] == null
            ? const SizedBox.shrink()
            : PlacePanel(
                place: r.places[placeId]!,
                callouts: callouts,
                onCitations: (c, rel) => _citations(c, rel, provisional),
              ),
    };
  }

  /// The equivalent of the chart as text, in reading order.
  Widget _list(BuildContext context, ResolvedVisual r) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final textTheme = Theme.of(context).textTheme;
    final kicker = SahabaTextStyles.of(context).kicker;
    final provisional = !r.visual.review.isApproved;

    Widget row(
      String title,
      String? subtitle, {
      VoidCallback? onTap,
      String? lead,
    }) => ListTile(
      contentPadding: EdgeInsets.zero,
      leading: lead == null
          ? null
          : SizedBox(width: 28, child: Text(lead, style: kicker)),
      title: Text(title, style: textTheme.titleSmall),
      subtitle: subtitle == null ? null : Text(subtitle),
      onTap: onTap,
    );

    String precision(GeoPrecision p) => switch (p) {
      GeoPrecision.identified => l10n.mapLegendIdentified,
      GeoPrecision.approximate => l10n.mapLegendApproximate,
      GeoPrecision.uncertain => l10n.mapLegendUncertain,
    };

    final children = switch (r.visual.data) {
      TimelineData() => [
        for (final m in r.timelineMarks)
          row(
            m.title.of(context),
            format.historicalDate(m.date),
            onTap: () => _openMark(m, r),
          ),
      ],
      MapData(:final placeIds, :final route) => [
        for (final id in placeIds)
          if (r.places[id] case final p?)
            row(
              p.name.of(context),
              '${precision(p.location.precision)} · ${p.summary.of(context)}',
              onTap: () => context.push(AppRoutes.place(p.id)),
            ),
        if (route.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.mapRouteTitle, style: kicker),
          for (final (i, leg) in route.indexed)
            row(
              l10n.mapRouteLeg(
                r.places[leg.fromPlaceId]?.name.of(context) ?? leg.fromPlaceId,
                r.places[leg.toPlaceId]?.name.of(context) ?? leg.toPlaceId,
              ),
              [
                if (leg.approximate) l10n.mapApproximatePath,
                ?leg.note?.of(context),
              ].join(' · '),
              lead: format.integer(i + 1),
              onTap: () =>
                  _citations(leg.citations, leg.reliability, provisional),
            ),
        ],
      ],
      RelationshipsData(:final edges) => [
        for (final e in edges)
          row(
            personName(context, e.to, r.people),
            l10n.visualRelationOf(
              relationLabel(l10n, e.type),
              personName(context, e.from, r.people),
            ),
            onTap: () => _citations(e.citations, e.reliability, provisional),
          ),
      ],
      SequenceData(:final steps) => [
        for (final (i, s) in steps.indexed)
          row(
            s.title.of(context),
            [
              s.text.of(context),
              if (s.orderUncertain) l10n.sequenceOrderUncertain,
            ].join(' · '),
            lead: format.integer(i + 1),
            onTap: () => _citations(s.citations, s.reliability, provisional),
          ),
      ],
      PeriodsData(:final bands) => [
        for (final (i, b) in bands.indexed)
          row(
            b.label.of(context),
            [format.historicalDate(b.date), ?b.note?.of(context)].join(' · '),
            lead: format.integer(i + 1),
            onTap: () => _citations(b.citations, b.reliability, provisional),
          ),
      ],
      PlacePanelData(:final placeId, :final callouts) => [
        if (r.places[placeId] case final p?)
          row(
            p.name.of(context),
            p.summary.of(context),
            onTap: () => context.push(AppRoutes.place(p.id)),
          ),
        for (final (i, c) in callouts.indexed)
          row(
            c.label.of(context),
            c.text.of(context),
            lead: format.integer(i + 1),
            onTap: () => _citations(c.citations, c.reliability, provisional),
          ),
      ],
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}
