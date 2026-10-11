import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/outlined_numeral.dart';

/// A companion in a list: the name in the calligraphic face, the honorific,
/// kunya and titles, category tags, and an outlined ordinal as ornament.
class CompanionCard extends StatelessWidget {
  const CompanionCard({
    required this.name,
    required this.honorific,
    this.subtitle,
    this.tags = const [],
    this.ordinal,
    this.isDraft = false,
    this.isPreliminary = false,
    this.onTap,
    this.heroTag,
    super.key,
  });

  final String name;

  /// e.g. رضي الله عنه.
  final String honorific;

  /// Kunya and titles.
  final String? subtitle;
  final List<String> tags;

  /// Decorative watermark (the list position), if any.
  final int? ordinal;
  final bool isDraft;

  /// A draft that had a preliminary review.
  final bool isPreliminary;
  final VoidCallback? onTap;

  /// Shared with the profile header for the hero transition.
  final Object? heroTag;

  /// Display style for companion names on cards and in the profile header.
  static TextStyle? nameStyle(BuildContext context) => Theme.of(
    context,
  ).textTheme.displaySmall?.copyWith(fontSize: 30, height: 1.35);

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final subtitle = this.subtitle;
    final ordinal = this.ordinal;

    Widget nameText = Text(name, style: nameStyle(context));
    if (heroTag != null) {
      nameText = Hero(
        tag: heroTag!,
        child: Material(type: MaterialType.transparency, child: nameText),
      );
    }

    return MergeSemantics(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              if (ordinal != null)
                PositionedDirectional(
                  end: AppSpacing.md,
                  top: AppSpacing.sm,
                  child: OutlinedNumeral(
                    ordinal,
                    size: 56,
                    strokeWidth: 1,
                    color: colors.accent.withValues(alpha: 0.5),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isDraft) ...[
                      DraftBadge(preliminary: isPreliminary),
                      const SizedBox(height: AppSpacing.xs),
                    ],
                    nameText,
                    Text(honorific, style: SuhbaTextStyles.of(context).kicker),
                    if (subtitle != null && subtitle.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        subtitle,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceDim,
                        ),
                      ),
                    ],
                    if (tags.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.xxs,
                        runSpacing: AppSpacing.xxs,
                        children: [for (final tag in tags) _Tag(tag)],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: colors.line),
        borderRadius: const BorderRadius.all(AppRadii.pill),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: colors.onSurfaceDim),
      ),
    );
  }
}
