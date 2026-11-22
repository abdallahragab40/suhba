import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/companion_card.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';

/// A companion in a scannable list (review F07): an initial in a disc, the
/// name with its honorific, one line of kunya and titles, and how deep the
/// biography goes. About a third of a [CompanionCard]'s height.
///
/// The disc is filled for a full biography and outlined for a brief one, so
/// depth reads at a glance down the list; the label beside it says it in
/// words.
class CompanionRow extends StatelessWidget {
  const CompanionRow({
    required this.name,
    required this.honorific,
    this.subtitle,
    this.depth,
    this.isFull = false,
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

  /// Whether [depth] is the full biography (drawn stronger).
  final bool isFull;
  final bool isDraft;
  final bool isPreliminary;
  final VoidCallback? onTap;

  /// Shared with the profile header for the hero transition.
  final Object? heroTag;

  /// The name in a row: the title face, a step above the subtitle; the
  /// hero grows it into the profile header.
  static TextStyle? nameStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 17);

  /// The disc's letter: the name's first letter, skipping a leading «ال».
  static String initialOf(String name) {
    final n = name.trim();
    if (n.isEmpty) return '';
    final bare = n.startsWith('ال') && n.length > 2 ? n.substring(2) : n;
    return String.fromCharCode(bare.runes.first);
  }

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final scheme = Theme.of(context).colorScheme;
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

    final disc = ExcludeSemantics(
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isFull ? scheme.secondaryContainer : null,
          border: Border.all(
            color: isFull ? scheme.secondaryContainer : colors.line,
            width: 1.5,
          ),
        ),
        child: Text(
          initialOf(name),
          textScaler: TextScaler.noScaling,
          style: textTheme.titleMedium?.copyWith(
            height: 1,
            color: isFull ? scheme.onSecondaryContainer : colors.onSurfaceDim,
          ),
        ),
      ),
    );

    return MergeSemantics(
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                disc,
                const SizedBox(width: AppSpacing.sm),
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
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.onSurfaceDim,
                            ),
                          ),
                        ],
                      ),
                      if (subtitle != null && subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceDim,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (depth != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    depth,
                    style: textTheme.labelSmall?.copyWith(
                      color: isFull ? colors.link : colors.onSurfaceDim,
                    ),
                  ),
                ],
                if (isDraft) ...[
                  const SizedBox(width: AppSpacing.xs),
                  DraftBadge.mark(preliminary: isPreliminary),
                ],
                const SizedBox(width: AppSpacing.xxs),
                ExcludeSemantics(
                  child: Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: colors.onSurfaceDim,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
