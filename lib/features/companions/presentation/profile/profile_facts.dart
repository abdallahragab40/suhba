import 'package:flutter/material.dart';
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

/// "في سطور": birth, death and the companion's at-a-glance facts, each with
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
