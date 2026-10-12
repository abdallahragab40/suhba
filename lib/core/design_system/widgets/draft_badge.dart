import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Compact review status for content awaiting specialist approval.
class DraftBadge extends StatelessWidget {
  const DraftBadge({this.preliminary = false, super.key});

  /// The item had a preliminary review (see `ReviewStatus`).
  final bool preliminary;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final l10n = AppLocalizations.of(context);
    final label = preliminary ? l10n.draftBadgePreliminary : l10n.draftBadge;
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colors.draftSurface,
          borderRadius: const BorderRadius.all(AppRadii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit_note,
              size: MediaQuery.textScalerOf(context).scale(14),
              color: colors.draft,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: colors.draft),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
