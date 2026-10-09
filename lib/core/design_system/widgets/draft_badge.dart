import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';

/// "مسودة — لم يُراجَع": shown on every item whose content a qualified
/// reviewer has not approved, so a draft is never presented as
/// authenticated.
class DraftBadge extends StatelessWidget {
  const DraftBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SahabaColors.of(context);
    final label = AppLocalizations.of(context).draftBadge;
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
