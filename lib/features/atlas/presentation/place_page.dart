import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/design_system/widgets/scene_backdrop.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/presentation/record_links.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/infographic_view.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/place_panel.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/schematic_map.dart';

/// How well a place's location is known, in words.
String geoPrecisionLabel(AppLocalizations l10n, GeoPrecision p) => switch (p) {
  GeoPrecision.identified => l10n.mapLegendIdentified,
  GeoPrecision.approximate => l10n.mapLegendApproximate,
  GeoPrecision.uncertain => l10n.mapLegendUncertain,
};

/// A place (S21): an illustrative scene, why it matters, how well its
/// site is known, a schematic map in context, the events there and the
/// visuals that show it.
class PlacePage extends ConsumerWidget {
  const PlacePage({required this.placeId, super.key});

  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final places = ref.watch(placesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.placePageTitle)),
      body: switch (places) {
        AsyncData(:final value) => switch (value[placeId]) {
          final p? => _Place(place: p, all: value),
          null => EmptyState(
            icon: Icons.wrong_location_outlined,
            title: l10n.placeNotFound,
          ),
        },
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(placesProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 8),
        ),
      },
    );
  }
}

class _Place extends ConsumerWidget {
  const _Place({required this.place, required this.all});

  final HistoricalPlace place;
  final Map<String, HistoricalPlace> all;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final p = place;
    final provisional = !p.review.isApproved;
    final events = [
      for (final e in (ref.watch(eventsProvider).value ?? const {}).values)
        if (e.placeIds.contains(p.id)) e,
    ]..sort((a, b) => a.date.compareTo(b.date));
    final visuals = [
      for (final v in (ref.watch(visualsProvider).value ?? const {}).values)
        if (switch (v.data) {
          MapData(:final placeIds) => placeIds.contains(p.id),
          PlacePanelData(:final placeId) => placeId == p.id,
          _ => false,
        })
          v,
    ];
    // The place among the two cities of the Seerah, for orientation.
    final orientation = {
      p.id: p,
      for (final id in ['makkah', 'madinah']) id: ?all[id],
    };

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Theme(
          data: AppTheme.dark,
          child: SizedBox(
            height: 220,
            child: Stack(
              children: [
                Positioned.fill(child: SceneBackdrop(kind: sceneFor(p))),
                PositionedDirectional(
                  start: AppSpacing.gutter,
                  end: AppSpacing.gutter,
                  bottom: AppSpacing.lg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.sceneIllustration,
                        style: SahabaTextStyles.of(
                          context,
                        ).kicker.copyWith(color: Palette.goldOnInk),
                      ),
                      Semantics(
                        header: true,
                        child: Text(
                          p.name.of(context),
                          style: textTheme.displayMedium?.copyWith(
                            color: Palette.paper,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          [
                            geoPrecisionLabel(l10n, p.location.precision),
                            if (p.modernName case final m?)
                              l10n.placeToday(m.of(context)),
                          ].join(' · '),
                          style: SahabaTextStyles.of(
                            context,
                          ).kicker.copyWith(color: colors.accentText),
                        ),
                      ),
                      if (provisional)
                        DraftBadge(preliminary: p.review.isPreliminary),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    p.summary.of(context),
                    style: SahabaTextStyles.of(context).reading,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CitationMarker(
                      count: p.citations.length,
                      onPressed: () => showCitationSheet(
                        context,
                        citations: p.citations,
                        reliability: p.reliability,
                        provisional: provisional,
                      ),
                    ),
                  ),
                  if (p.contemporaryNote case final note?)
                    Text(
                      note.of(context),
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceDim,
                      ),
                    ),
                  LinkGroupTitle(l10n.placeOnMap),
                  SchematicMap(
                    places: orientation.values.toList(),
                    height: 260,
                    onOpenPlace: (other) {
                      if (other.id != p.id) {
                        context.push(AppRoutes.place(other.id));
                      }
                    },
                  ),
                  if (events.isNotEmpty) ...[
                    LinkGroupTitle(l10n.placeEvents),
                    for (final e in events) EventRow(event: e),
                  ],
                  if (visuals.isNotEmpty) ...[
                    LinkGroupTitle(l10n.placeVisuals),
                    for (final v in visuals)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(infographicTypeIcon(v.type)),
                        title: Text(v.title.of(context)),
                        subtitle: Text(infographicTypeLabel(l10n, v.type)),
                        onTap: () => context.push(AppRoutes.visual(v.id)),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
