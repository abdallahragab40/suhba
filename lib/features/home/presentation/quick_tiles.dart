import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';
import 'package:suhba/features/seerah/presentation/seerah_hub_page.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/domain/seerah.dart';
import 'package:suhba/shared/content/presentation/target_description.dart';
import 'package:suhba/shared/content/providers.dart';

/// Home's row of quick tiles (review K7): continue reading, the current
/// journey, review, and the map. Each opens a real place; a tile with
/// nowhere to go (no map in this build) is left out rather than shown as
/// "coming soon".
class QuickTiles extends ConsumerWidget {
  const QuickTiles({required this.seerah, super.key});

  final SeerahIndex? seerah;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final due = ref.watch(dueReviewsProvider).value?.length ?? 0;
    final map = seerah?.collection.mapVisualId;

    final tiles = [
      _Tile(
        icon: Icons.menu_book_outlined,
        label: l10n.homeTileContinue,
        route: _continueRoute(context, ref),
      ),
      _Tile(
        icon: Icons.route_outlined,
        label: l10n.homeTileJourney,
        route: _journeyRoute(ref),
      ),
      _Tile(
        icon: Icons.psychology_outlined,
        label: l10n.homeTileReview,
        route: AppRoutes.review,
        badge: due > 0 ? format.integer(due) : null,
        semanticsHint: due > 0
            ? l10n.reviewDueCount(due, format.integer(due))
            : null,
      ),
      if (map != null)
        _Tile(
          icon: Icons.map_outlined,
          label: l10n.homeTileMap,
          route: AppRoutes.visual(map),
        ),
    ];

    // Four across; two by two once large text no longer fits a quarter
    // of a phone's width.
    final wide = MediaQuery.textScalerOf(context).scale(14) <= 14 * 1.3;
    final perRow = wide ? tiles.length : 2;
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.md),
      child: Column(
        children: [
          for (var i = 0; i < tiles.length; i += perRow)
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: i == 0 ? 0 : AppSpacing.sm,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var j = i; j < i + perRow; j++) ...[
                      if (j > i) const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: j < tiles.length
                            ? tiles[j]
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// The passage read most recently and not finished; else the Seerah
  /// from where the reader stopped, or from its start.
  String _continueRoute(BuildContext context, WidgetRef ref) {
    final open = [...?ref.watch(inProgressProvider).value]
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    for (final p in open.take(1)) {
      final found = ref.watch(targetLookupProvider(p.contentTarget)).value;
      if (found != null) {
        if (describeTarget(context, found) case final d?) return d.route;
      }
    }
    final s = seerah;
    if (s == null || s.chapters.isEmpty) return AppRoutes.seerah;
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
    final chapter =
        seerahResumeChapter(s.chapters, progress) ?? s.chapters.first;
    return AppRoutes.seerahChapter(chapter.id);
  }

  /// The journey touched most recently and not paused; else the list.
  String _journeyRoute(WidgetRef ref) {
    final active = [
      ...?ref.watch(journeyEnrollmentsProvider).value?.where((e) => !e.paused),
    ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return switch (active.firstOrNull) {
      final e? => AppRoutes.journey(e.journeyId),
      null => AppRoutes.journeys,
    };
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.label,
    required this.route,
    this.badge,
    this.semanticsHint,
  });

  final IconData icon;
  final String label;
  final String route;
  final String? badge;
  final String? semanticsHint;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final glyph = Icon(icon, color: colors.accentText, size: 26);
    return Semantics(
      button: true,
      label: label,
      value: semanticsHint,
      excludeSemantics: true,
      onTap: () => context.push(route),
      child: Material(
        color: colors.surfaceAlt,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(AppRadii.md),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push(route),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 72),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (badge case final b?)
                    Badge(label: Text(b), child: glyph)
                  else
                    glyph,
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
