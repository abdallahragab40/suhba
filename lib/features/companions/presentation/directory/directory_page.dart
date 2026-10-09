import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/widgets/companion_card.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_banner.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/companions/domain/directory_filter.dart';
import 'package:siyar_sahaba/features/companions/presentation/directory/category_filter_bar.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

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
    final manifest = ref.watch(contentManifestProvider);

    final Widget body;
    if (index.hasError || categories.hasError || manifest.hasError) {
      body = ErrorView(
        error: index.error ?? categories.error ?? manifest.error,
        onRetry: () => ref
          ..invalidate(companionIndexProvider)
          ..invalidate(categoriesProvider)
          ..invalidate(contentManifestProvider),
      );
    } else if (index.value case final all?
        when categories.value != null && manifest.value != null) {
      body = _DirectoryList(
        companions: all,
        categories: categories.value!,
        selected: effectiveCategory(categoryId, categories.value!),
        showDraftBanner: manifest.value!.isDraft,
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
        actions: [
          IconButton(
            tooltip: l10n.searchTooltip,
            icon: const Icon(Icons.search),
            onPressed: () => context.push(AppRoutes.search),
          ),
        ],
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
    required this.showDraftBanner,
  });

  final List<CompanionSummary> companions;
  final List<CompanionCategory> categories;
  final String? selected;
  final bool showDraftBanner;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final shown = filterCompanions(companions, selected);
    final categoryNames = {
      for (final c in categories) c.id: c.name.of(context),
    };

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: CustomScrollView(
          slivers: [
            if (showDraftBanner)
              const SliverPadding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.gutter,
                  AppSpacing.xs,
                  AppSpacing.gutter,
                  0,
                ),
                sliver: SliverToBoxAdapter(child: DraftBanner()),
              ),
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
                  icon: Icons.people_alt_outlined,
                  title: l10n.directoryEmpty,
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.gutter,
                  0,
                  AppSpacing.gutter,
                  AppSpacing.xl,
                ),
                sliver: SliverList.separated(
                  itemCount: shown.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) {
                    final c = shown[i];
                    return CompanionCard(
                      key: ValueKey(c.id),
                      name: c.name.of(context),
                      honorific: companionHonorific(c.gender),
                      subtitle: [
                        if (c.kunya case final k?) k.of(context),
                        for (final t in c.titles) t.of(context),
                      ].join(' · '),
                      tags: [
                        for (final id in c.categoryIds) ?categoryNames[id],
                      ],
                      ordinal: c.order,
                      isDraft: !c.review.isApproved,
                      heroTag: DirectoryPage.heroTag(c.id),
                      onTap: () => context.push(AppRoutes.companion(c.id)),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
