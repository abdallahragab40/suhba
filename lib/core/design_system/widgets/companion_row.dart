import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/companion_card.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';

/// A companion in a scannable list (review F07): the name in the
/// calligraphic face with its honorific, one line of kunya and titles, and
/// how deep the biography goes. About a third of a [CompanionCard]'s height.
class CompanionRow extends StatelessWidget {
  const CompanionRow({
    required this.name,
    required this.honorific,
    this.subtitle,
    this.depth,
    this.isDraft = false,
    this.isPreliminary = false,
    this.onTap,
    this.heroTag,
    super.key,
  });

  final String name;
  final String honorific;
  final String? subtitle;

  /// "سيرة كاملة" or "تعريف موجز"; nothing when unknown.
  final String? depth;
  final bool isDraft;
  final bool isPreliminary;
  final VoidCallback? onTap;

  /// Shared with the profile header for the hero transition.
  final Object? heroTag;

  /// The name is smaller than on a card; the hero grows it on the profile.
  static TextStyle? nameStyle(BuildContext context) =>
      CompanionCard.nameStyle(context)?.copyWith(fontSize: 22);

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final subtitle = this.subtitle;
    final depth = this.depth;

    Widget nameText = Text(name, style: nameStyle(context));
    if (heroTag != null) {
      nameText = Hero(
        tag: heroTag!,
        child: Material(type: MaterialType.transparency, child: nameText),
      );
    }

    return MergeSemantics(
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.xs,
                        children: [
                          nameText,
                          Text(
                            honorific,
                            style: SuhbaTextStyles.of(context).kicker,
                          ),
                        ],
                      ),
                      if (subtitle != null && subtitle.isNotEmpty)
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceDim,
                          ),
                        ),
                    ],
                  ),
                ),
                if (depth != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    depth,
                    style: SuhbaTextStyles.of(
                      context,
                    ).kicker.copyWith(color: colors.onSurfaceDim),
                  ),
                ],
                if (isDraft) ...[
                  const SizedBox(width: AppSpacing.xs),
                  DraftBadge.mark(preliminary: isPreliminary),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
