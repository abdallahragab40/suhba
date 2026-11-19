import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/app_shell.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/app_icons.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/widgets/companion_row.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/companions/domain/directory_filter.dart';
import 'package:suhba/features/companions/presentation/directory/category_filter_bar.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// The companions directory (S03). The category filter lives in the URL
/// (`?category=`), so it survives navigation and can be linked to.
class DirectoryPage extends ConsumerWidget {
  const DirectoryPage({this.categoryId, super.key});

  /// From the `category` query parameter.
  final String? categoryId;

  static String heroTag(String id) => 'companion-name-$id';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final index = ref.watch(companionIndexProvider);
    final categories = ref.watch(categoriesProvider);

    final Widget body;
    if (index.hasError || categories.hasError) {
      body = ErrorView(
        error: index.error ?? categories.error,
        onRetry: () => ref
          ..invalidate(companionIndexProvider)
          ..invalidate(categoriesProvider),
      );
    } else if (index.value case final all? when categories.value != null) {
      body = _DirectoryList(
        companions: all,
        categories: categories.value!,
        selected: effectiveCategory(categoryId, categories.value!),
      );
    } else {
      body = const Padding(
        padding: EdgeInsets.all(AppSpacing.gutter),
        child: LoadingSkeleton(lines: 6),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabCompanions),
        actions: shellActions(context),
      ),
      body: body,
    );
  }
}

class _DirectoryList extends StatelessWidget {
  const _DirectoryList({
    required this.companions,
    required this.categories,
    required this.selected,
  });

  final List<CompanionSummary> companions;
  final List<CompanionCategory> categories;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final shown = filterCompanions(companions, selected);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CategoryFilterBar(
                categories: categories,
                selected: selected,
                onSelected: (id) =>
                    context.go(AppRoutes.companionsInCategory(id)),
              ),
            ),
            if (shown.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: AppIcons.companions,
                  title: l10n.directoryEmpty,
                ),
              )
            else ...[
              if (shown.any((c) => !c.review.isApproved))
                const SliverPadding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.gutter,
                    AppSpacing.xs,
                    AppSpacing.gutter,
                    AppSpacing.xs,
                  ),
                  sliver: SliverToBoxAdapter(child: ListStatusNote()),
                ),
              // All companions: grouped by category. One category: a list.
              for (final (category, members)
                  in selected == null
                      ? groupByCategory(shown, categories)
                      : [(null, shown)]) ...[
                if (selected == null)
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.gutter,
                      AppSpacing.lg,
                      AppSpacing.gutter,
                      AppSpacing.xxs,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Semantics(
                        header: true,
                        child: Text(
                          category?.name.of(context) ?? l10n.directoryOthers,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.gutter,
                  ),
                  sliver: SliverList.separated(
                    itemCount: members.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final c = members[i];
                      return CompanionRow(
                        key: ValueKey(c.id),
                        name: c.name.of(context),
                        honorific: companionHonorific(c.gender),
                        subtitle: [
                          if (c.kunya case final k?) k.of(context),
                          for (final t in c.titles) t.of(context),
                        ].join(DisplayFormatter.separator),
                        depth: switch (BiographyDepth.of(c)) {
                          BiographyDepth.full => l10n.depthFull,
                          BiographyDepth.brief => l10n.depthBrief,
                          null => null,
                        },
                        isDraft: !c.review.isApproved,
                        isPreliminary: c.review.isPreliminary,
                        heroTag: DirectoryPage.heroTag(c.id),
                        onTap: () => context.push(AppRoutes.companion(c.id)),
                      );
                    },
                  ),
                ),
              ],
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
            ],
          ],
        ),
      ),
    );
  }
}
