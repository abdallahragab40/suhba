import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// A pill showing how well a claim is established: icon and text, never
/// color alone.
///
/// With [provisional] (the content is an unreviewed draft) the pill is drawn
/// as an outline only, and says so in its tooltip and screen-reader label,
/// so a draft is never presented as authenticated.
class ReliabilityBadge extends StatelessWidget {
  const ReliabilityBadge(
    this.reliability, {
    this.provisional = false,
    super.key,
  });

  final Reliability reliability;
  final bool provisional;

  /// Background tint behind the label of a non-provisional badge.
  static const tintAlpha = 0.10;

  static Color colorFor(Reliability reliability, SuhbaColors colors) =>
      switch (reliability) {
        Reliability.established => colors.established,
        Reliability.disputed => colors.disputed,
        Reliability.reported || Reliability.unknown => colors.onSurfaceDim,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = colorFor(reliability, SuhbaColors.of(context));
    final (label, icon) = switch (reliability) {
      Reliability.established => (
        l10n.reliabilityEstablished,
        Icons.verified_outlined,
      ),
      Reliability.reported => (
        l10n.reliabilityReported,
        Icons.menu_book_outlined,
      ),
      Reliability.disputed => (l10n.reliabilityDisputed, Icons.call_split),
      Reliability.unknown => (l10n.reliabilityUnknown, Icons.help_outline),
    };
    final semanticLabel = provisional
        ? '${l10n.reliabilitySemantics(label)}، ${l10n.reliabilityProvisional}'
        : l10n.reliabilitySemantics(label);
    final iconSize = MediaQuery.textScalerOf(context).scale(14);

    Widget badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: provisional ? null : color.withValues(alpha: tintAlpha),
        border: Border.all(color: provisional ? color : Colors.transparent),
        borderRadius: const BorderRadius.all(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );

    badge = Semantics(
      label: semanticLabel,
      excludeSemantics: true,
      child: badge,
    );
    if (!provisional) return badge;
    return Tooltip(
      message: l10n.reliabilityProvisional,
      excludeFromSemantics: true,
      child: badge,
    );
  }
}
