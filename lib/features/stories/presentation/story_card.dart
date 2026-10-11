import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';

/// A story in a list: title, synopsis and reading time. Opens the story.
class StoryCard extends StatelessWidget {
  const StoryCard({required this.story, super.key});

  final StorySummary story;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final s = story;
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(AppRadii.md),
      ),
      child: InkWell(
        onTap: () => context.push(AppRoutes.story(s.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!s.review.isApproved) ...[
                DraftBadge(preliminary: s.review.isPreliminary),
                const SizedBox(height: AppSpacing.xs),
              ],
              Text(
                s.title.of(context),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                s.synopsis.of(context),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceDim),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.storyReadingMinutes(
                  s.readingMinutes,
                  format.integer(s.readingMinutes),
                ),
                style: SahabaTextStyles.of(context).kicker,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
