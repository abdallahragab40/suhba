import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/feedback/haptics.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/atlas/domain/visiting.dart';
import 'package:suhba/features/atlas/presentation/place_page.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';
import 'package:suhba/shared/visuals/presentation/schematic_map.dart';

/// Visiting Madinah and Makkah (S23): the places of the Seerah and the
/// Companions' lives in and around each city, on a map and in a list. The
/// reader chooses the city; its places are ordered by distance from its
/// Haram. The app never reads the reader's location. It introduces each
/// place's history; it is not a guide to rites or to visiting practices.
class VisitPage extends ConsumerWidget {
  const VisitPage({this.city, super.key});

  /// The initial city's name, from the route; Madinah when unknown.
  final String? city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final places = ref.watch(placesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.visitTitle)),
      body: switch (places) {
        AsyncData(:final value) => _Visit(
          places: value,
          initial:
              HolyCity.values.where((c) => c.name == city).firstOrNull ??
              HolyCity.madinah,
        ),
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

class _Visit extends StatefulWidget {
  const _Visit({required this.places, required this.initial});

  final Map<String, HistoricalPlace> places;
  final HolyCity initial;

  @override
  State<_Visit> createState() => _VisitState();
}

class _VisitState extends State<_Visit> {
  late HolyCity _city = widget.initial;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final places = placesIn(_city, widget.places);
    final cityName = holyCityLabel(l10n, _city);

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.gutter,
        AppSpacing.sm,
        AppSpacing.gutter,
        AppSpacing.xxl,
      ),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.visitIntro, style: textTheme.bodyLarge),
                const SizedBox(height: AppSpacing.md),
                SegmentedButton<HolyCity>(
                  segments: [
                    for (final c in HolyCity.values)
                      ButtonSegment(
                        value: c,
                        label: Text(holyCityLabel(l10n, c)),
                      ),
                  ],
                  selected: {_city},
                  onSelectionChanged: (s) {
                    Haptics.selection(context);
                    setState(() => _city = s.first);
                  },
                ),
                if (places.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  SchematicMap(
                    places: places,
                    height: 300,
                    onOpenPlace: (p) => context.push(AppRoutes.place(p.id)),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final p in places) _VisitRow(place: p),
                ] else
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.lg),
                    child: Text(l10n.visitNoPlaces(cityName)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// One place: its name, how well its site is known, and the start of its
/// summary.
class _VisitRow extends StatelessWidget {
  const _VisitRow({required this.place});

  final HistoricalPlace place;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final p = place;
    return InkWell(
      onTap: () => context.push(AppRoutes.place(p.id)),
      child: Container(
        constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          border: BorderDirectional(bottom: BorderSide(color: colors.line)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              geoPrecisionLabel(l10n, p.location.precision),
              style: SuhbaTextStyles.of(
                context,
              ).kicker.copyWith(color: colors.accentText),
            ),
            Text(p.name.of(context), style: textTheme.titleMedium),
            Text(
              p.summary.of(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
            ),
            if (!p.review.isApproved) ...[
              const SizedBox(height: AppSpacing.xs),
              DraftBadge(preliminary: p.review.isPreliminary),
            ],
          ],
        ),
      ),
    );
  }
}
