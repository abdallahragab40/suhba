import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/companion_card.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/landscape_hero.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/features/companions/presentation/directory/directory_page.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// The profile hero: name (shared with the directory card), honorific,
/// kunya and titles, death place and date, and categories.
class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({required this.companion, super.key});

  final Companion companion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = companion;
    final format = DisplayFormatter.of(context);
    final categories = ref.watch(categoriesProvider).value ?? const [];
    final names = {for (final cat in categories) cat.id: cat.name.of(context)};
    final death = c.death?.date;

    final subtitle = [
      if (c.kunya case final k?) k.of(context),
      for (final t in c.titles) t.of(context),
    ].join(' · ');
    final meta = [
      if (c.deathPlace case final p?) p.of(context),
      if (death != null && !death.isUnknown) format.historicalDate(death),
    ].join(' · ');

    return LandscapeHero(
      child: Builder(
        builder: (context) {
          final textTheme = Theme.of(context).textTheme;
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!c.review.isApproved) ...[
                    DraftBadge(preliminary: c.review.isPreliminary),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  Hero(
                    tag: DirectoryPage.heroTag(c.id),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Semantics(
                        header: true,
                        child: Text(
                          c.name.of(context),
                          style: CompanionCard.nameStyle(context),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    companionHonorific(c.gender),
                    style: SuhbaTextStyles.of(context).kicker,
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(subtitle, style: textTheme.titleSmall),
                  ],
                  if (meta.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(meta, style: textTheme.bodySmall),
                  ],
                  if (c.memberships.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        for (final m in c.memberships)
                          if (names[m.categoryId] case final name?)
                            ActionChip(
                              label: Text(name),
                              onPressed: () => context.go(
                                AppRoutes.companionsInCategory(m.categoryId),
                              ),
                            ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
