import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/design_system/widgets/scene_backdrop.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

/// The landscape drawn for [place]: an illustration of its kind of land,
/// never a picture of the place itself.
SceneKind sceneFor(HistoricalPlace place) => switch (place.id) {
  'madinah' || 'quba' || 'khaybar' => SceneKind.oasis,
  'habashah' => SceneKind.sea,
  _ => switch (place.kind) {
    PlaceKind.mountain ||
    PlaceKind.cave ||
    PlaceKind.city => SceneKind.mountains,
    _ => SceneKind.nightDesert,
  },
};

/// Why a place matters: an illustrative scene with the place's name, then
/// numbered, sourced callouts. The scene is labelled as an illustration,
/// and any present-day note is shown, so it is never taken for the
/// historical setting.
class PlacePanel extends StatelessWidget {
  const PlacePanel({
    required this.place,
    required this.callouts,
    required this.onCitations,
    super.key,
  });

  final HistoricalPlace place;
  final List<PlaceCallout> callouts;
  final void Function(List<Citation>, Reliability) onCitations;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final kicker = SuhbaTextStyles.of(context).kicker;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(AppRadii.md),
          child: SizedBox(
            height: 180,
            child: Stack(
              children: [
                Positioned.fill(child: SceneBackdrop(kind: sceneFor(place))),
                PositionedDirectional(
                  start: AppSpacing.md,
                  end: AppSpacing.md,
                  bottom: AppSpacing.md,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.sceneIllustration,
                        style: kicker.copyWith(color: Palette.goldOnInk),
                      ),
                      Text(
                        place.name.of(context),
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(color: Palette.paper),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (place.contemporaryNote case final note?)
          Padding(
            padding: const EdgeInsetsDirectional.only(top: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 18, color: colors.onSurfaceDim),
                const SizedBox(width: AppSpacing.xxs),
                Expanded(
                  child: Text(
                    note.of(context),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        for (final (i, c) in callouts.indexed)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExcludeSemantics(
                  child: Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.accent, width: 2),
                    ),
                    child: Text(
                      format.integer(i + 1),
                      style: kicker.copyWith(
                        color: colors.accentText,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          c.label.of(context),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Text(
                        c.text.of(context),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (c.citations.isNotEmpty)
                  CitationMarker(
                    count: c.citations.length,
                    onPressed: () => onCitations(c.citations, c.reliability),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
