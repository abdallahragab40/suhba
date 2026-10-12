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
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/location/location_service.dart';
import 'package:suhba/features/atlas/domain/visiting.dart';
import 'package:suhba/features/atlas/presentation/place_page.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';
import 'package:suhba/shared/visuals/presentation/schematic_map.dart';

/// Visiting Madinah and Makkah (S23): the places of the Seerah and the
/// Companions' lives in and around each city, on a map and in a list. On
/// request the list is ordered by distance from the reader, whose position
/// stays on the device. It introduces each place's history; it is not a
/// guide to rites or to visiting practices.
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

class _Visit extends ConsumerStatefulWidget {
  const _Visit({required this.places, required this.initial});

  final Map<String, HistoricalPlace> places;
  final HolyCity initial;

  @override
  ConsumerState<_Visit> createState() => _VisitState();
}

class _VisitState extends ConsumerState<_Visit> {
  late HolyCity _city = widget.initial;
  ({double lat, double lon})? _position;
  LocationProblem? _problem;
  var _locating = false;

  Future<void> _locate() async {
    setState(() {
      _locating = true;
      _problem = null;
    });
    final result = await ref.read(locationServiceProvider).currentPosition();
    if (!mounted) return;
    setState(() {
      _locating = false;
      switch (result) {
        case LocationFound(:final lat, :final lon):
          final position = (lat: lat, lon: lon);
          _position = position;
          // Show the city the reader is in.
          _city = cityAt(position, widget.places) ?? _city;
        case LocationUnavailable(:final problem):
          _problem = problem;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final position = _position;
    // The reader's position orders the list only while they are in this
    // city; from elsewhere, distances from them would mean nothing here.
    final here = position != null && cityAt(position, widget.places) == _city
        ? position
        : null;
    final places = placesIn(_city, widget.places, from: here);
    final cityName = holyCityLabel(l10n, _city);

    final String? status;
    if (_locating) {
      status = l10n.visitLocating;
    } else if (_problem case final p?) {
      status = switch (p) {
        LocationProblem.serviceOff => l10n.visitLocationOff,
        LocationProblem.denied => l10n.visitLocationDenied,
        LocationProblem.deniedForever => l10n.visitLocationDeniedForever,
        LocationProblem.failed => l10n.visitLocationFailed,
      };
    } else if (position != null) {
      status = here != null
          ? l10n.visitOrderedFromYou
          : l10n.visitNotInCity(cityName);
    } else {
      status = null;
    }

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
                  onSelectionChanged: (s) => setState(() => _city = s.first),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: _locating ? null : _locate,
                      icon: const Icon(Icons.my_location),
                      label: Text(l10n.visitNearMe),
                    ),
                    if (_problem == LocationProblem.deniedForever)
                      TextButton(
                        onPressed: () =>
                            ref.read(locationServiceProvider).openSettings(),
                        child: Text(l10n.visitOpenSettings),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                if (status != null)
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      status,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.accentText,
                      ),
                    ),
                  ),
                Text(
                  l10n.visitPrivacy,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceDim,
                  ),
                ),
                if (places.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  SchematicMap(
                    places: places,
                    height: 300,
                    onOpenPlace: (p) => context.push(AppRoutes.place(p.id)),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final p in places)
                    _VisitRow(
                      place: p,
                      km: here == null
                          ? null
                          : distanceKm(
                              here.lat,
                              here.lon,
                              p.location.lat,
                              p.location.lon,
                            ),
                    ),
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

/// One place: its name, how well its site is known, its distance from
/// the reader when known, and the start of its summary.
class _VisitRow extends StatelessWidget {
  const _VisitRow({required this.place, required this.km});

  final HistoricalPlace place;
  final double? km;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final p = place;
    final km = this.km;
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
              [
                geoPrecisionLabel(l10n, p.location.precision),
                if (km != null)
                  km < 1
                      ? l10n.visitUnderOneKm
                      : l10n.visitKmAway(format.integer(km.round())),
              ].join(' · '),
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
