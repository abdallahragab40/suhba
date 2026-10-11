import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Shown on list screens while the app runs on the draft content channel.
class DraftBanner extends StatelessWidget {
  const DraftBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.draftSurface,
        borderRadius: const BorderRadius.all(AppRadii.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.edit_note, color: colors.draft),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.draftBannerTitle,
                  style: textTheme.labelLarge?.copyWith(color: colors.draft),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.draftBannerMessage,
                  style: textTheme.bodySmall?.copyWith(color: colors.draft),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
