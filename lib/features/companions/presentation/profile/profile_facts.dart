import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/design_system/widgets/fact_tile.dart';
import 'package:suhba/core/design_system/widgets/reliability_badge.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/sources/presentation/citation_sheet.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

/// "في سطور": key sentences from the biography (E2), then birth, death and
/// the companion's at-a-glance facts, each with
/// its reliability and sources.
class ProfileFacts extends StatelessWidget {
  const ProfileFacts({
    required this.companion,
    required this.provisional,
    super.key,
  });

  final Companion companion;

  /// True for unreviewed content.
  final bool provisional;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final c = companion;

    Widget tile(
      String label,
      String value,
      Reliability reliability,
      List<Citation> citations,
    ) => FactTile(
      label: label,
      value: value,
      badge: ReliabilityBadge(reliability, provisional: provisional),
      marker: citations.isEmpty
          ? null
          : CitationMarker(
              count: citations.length,
              onPressed: () => showCitationSheet(
                context,
                citations: citations,
                reliability: reliability,
                provisional: provisional,
              ),
            ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Layer 1 (E2): key sentences from the biography, each opening
        // the section it comes from, with that section's own sources.
        for (final f in c.overview)
          _OverviewLine(
            fact: f,
            provisional: provisional,
            onOpen: () => context.push(AppRoutes.section(c.id, f.sectionId)),
          ),
        if (c.overview.isNotEmpty) const SizedBox(height: AppSpacing.sm),
        if (c.birth case final b?)
          tile(
            l10n.profileBirth,
            format.historicalDate(b.date),
            b.reliability,
            b.citations,
          ),
        if (c.death case final d?)
          tile(
            l10n.profileDeath,
            format.historicalDate(d.date),
            d.reliability,
            d.citations,
          ),
        for (final f in c.atAGlance)
          tile(
            f.label.of(context),
            f.text?.of(context) ??
                (f.date == null ? '' : format.historicalDate(f.date!)),
            f.reliability,
            f.citations,
          ),
      ],
    );
  }
}

class _OverviewLine extends StatelessWidget {
  const _OverviewLine({
    required this.fact,
    required this.provisional,
    required this.onOpen,
  });

  final OverviewFact fact;
  final bool provisional;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    return InkWell(
      onTap: onOpen,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 10,
                end: AppSpacing.sm,
              ),
              child: ExcludeSemantics(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: colors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                fact.text.of(context),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            CitationMarker(
              count: fact.citations.length,
              onPressed: () => showCitationSheet(
                context,
                citations: fact.citations,
                reliability: fact.reliability,
                provisional: provisional,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
