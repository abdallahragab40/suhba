import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/search/domain/search_index.dart';
import 'package:siyar_sahaba/features/search/presentation/search_providers.dart';

/// Global search (S10).
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  // Reopening search restores the last query and its results.
  late final _field = TextEditingController(
    text: ref.read(searchQueryProvider),
  );

  @override
  void dispose() {
    _field.dispose();
    super.dispose();
  }

  void _setQuery(String text) {
    _field
      ..text = text
      ..selection = TextSelection.collapsed(offset: text.length);
    ref.read(searchQueryProvider.notifier).type(text);
  }

  /// Opens the result in its own place in the app (so back leads through
  /// that tab), leaving search; the query is kept for when it reopens.
  void _open(SearchDocument doc) {
    ref.read(recentSearchesProvider.notifier).add(_field.text);
    switch (doc.kind) {
      // Events and places sit above the destinations: they replace search,
      // so back returns to where search was opened.
      case SearchKind.event:
        context.pushReplacement(AppRoutes.event(doc.id));
      case SearchKind.place:
        context.pushReplacement(AppRoutes.place(doc.id));
      case _:
        context.go(switch (doc.kind) {
          SearchKind.companion => AppRoutes.companion(doc.id),
          SearchKind.section => AppRoutes.section(doc.parentId!, doc.id),
          SearchKind.story => AppRoutes.story(doc.id),
          SearchKind.chapter => AppRoutes.chapter(doc.parentId!, doc.id),
          SearchKind.seerahChapter => AppRoutes.seerahChapter(doc.id),
          SearchKind.seerahTopic => AppRoutes.seerahTopic(doc.id),
          SearchKind.event || SearchKind.place => AppRoutes.home,
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider);
    final recent = ref.watch(recentSearchesProvider);

    final Widget body;
    if (query.trim().isEmpty) {
      body = _StartState(recent: recent, onPick: _setQuery);
    } else {
      body = switch (results) {
        AsyncData(:final value) => _ResultsView(
          query: query,
          hits: value.hits,
          incomplete: value.unavailable > 0,
          onOpen: _open,
          onRetry: () => ref.invalidate(searchIndexProvider),
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(searchIndexProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(),
        ),
      };
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _field,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: ref.read(searchQueryProvider.notifier).type,
          decoration: InputDecoration(
            hintText: l10n.searchHint,
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (_field.text.isNotEmpty)
            IconButton(
              tooltip: l10n.searchClear,
              icon: const Icon(Icons.close),
              onPressed: () {
                _field.clear();
                ref.read(searchQueryProvider.notifier).clear();
                setState(() {});
              },
            ),
        ],
      ),
      body: body,
    );
  }
}

class _StartState extends StatelessWidget {
  const _StartState({required this.recent, required this.onPick});

  final List<String> recent;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (recent.isEmpty) {
      return EmptyState(icon: Icons.search, title: l10n.searchStart);
    }
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      children: [
        Text(l10n.searchRecent, style: SahabaTextStyles.of(context).kicker),
        for (final q in recent)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.history),
            title: Text(q),
            onTap: () => onPick(q),
          ),
      ],
    );
  }
}

/// The filters, a notice when the index is incomplete, and the results
/// (or why there are none).
class _ResultsView extends ConsumerWidget {
  const _ResultsView({
    required this.query,
    required this.hits,
    required this.incomplete,
    required this.onOpen,
    required this.onRetry,
  });

  final String query;
  final List<SearchHit> hits;

  /// Some content failed to load, so results may be missing.
  final bool incomplete;
  final ValueChanged<SearchDocument> onOpen;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final (scope, parentId) = ref.watch(searchFilterProvider);
    final filters = ref.read(searchFilterProvider.notifier);

    // Passages can be narrowed to one companion or story: offer the ones
    // among the results.
    final parents = <String, String>{
      for (final h in hits) ?h.document.parentId: h.document.subtitle ?? '',
    };

    String scopeLabel(SearchScope s) => switch (s) {
      SearchScope.all => l10n.searchScopeAll,
      SearchScope.companions => l10n.searchScopeCompanions,
      SearchScope.biographies => l10n.searchScopeBiographies,
      SearchScope.stories => l10n.searchScopeStories,
      SearchScope.seerah => l10n.searchScopeSeerah,
      SearchScope.archive => l10n.searchScopeArchive,
    };

    final chips = Semantics(
      label: l10n.searchFilterLabel,
      container: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        child: Row(
          children: [
            for (final s in SearchScope.values) ...[
              ChoiceChip(
                label: Text(scopeLabel(s)),
                selected: s == scope,
                onSelected: (_) => filters.scope(s),
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            if (parentId != null)
              InputChip(
                label: Text(l10n.searchWithin(parents[parentId] ?? parentId)),
                selected: true,
                onDeleted: () => filters.within(null),
                onPressed: () => filters.within(null),
              )
            else if (parents.length > 1)
              for (final MapEntry(key: id, value: name) in parents.entries) ...[
                ActionChip(
                  label: Text(l10n.searchWithin(name)),
                  onPressed: () => filters.within(id),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
          ],
        ),
      ),
    );

    final notice = incomplete
        ? Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.gutter,
              AppSpacing.sm,
              AppSpacing.gutter,
              0,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.xs,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: colors.onSurfaceDim),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Semantics(
                        liveRegion: true,
                        child: Text(l10n.searchIncomplete),
                      ),
                    ),
                    TextButton(onPressed: onRetry, child: Text(l10n.retry)),
                  ],
                ),
              ),
            ),
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.xs),
        chips,
        ?notice,
        Expanded(
          child: hits.isEmpty
              ? EmptyState(
                  icon: Icons.search_off,
                  title: incomplete
                      ? l10n.searchNoResultsIncomplete(query)
                      : l10n.searchNoResults(query),
                )
              : _Results(hits: hits, onOpen: onOpen),
        ),
      ],
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({required this.hits, required this.onOpen});

  final List<SearchHit> hits;
  final ValueChanged<SearchDocument> onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final groups = [
      for (final kind in SearchKind.values)
        (
          kind,
          [
            for (final h in hits)
              if (h.document.kind == kind) h,
          ],
        ),
    ].where((g) => g.$2.isNotEmpty);

    String label(SearchKind kind) => switch (kind) {
      SearchKind.companion => l10n.searchKindCompanions,
      SearchKind.story => l10n.searchKindStories,
      SearchKind.section => l10n.searchKindSections,
      SearchKind.chapter => l10n.searchKindChapters,
      SearchKind.seerahChapter => l10n.searchKindSeerahChapters,
      SearchKind.seerahTopic => l10n.searchKindSeerahTopics,
      SearchKind.event => l10n.searchKindEvents,
      SearchKind.place => l10n.searchKindPlaces,
    };
    final dim = TextStyle(color: colors.onSurfaceDim);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      children: [
        for (final (kind, kindHits) in groups) ...[
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.gutter,
              AppSpacing.md,
              AppSpacing.gutter,
              AppSpacing.xxs,
            ),
            child: Semantics(
              header: true,
              child: Text(
                label(kind),
                style: SahabaTextStyles.of(context).kicker,
              ),
            ),
          ),
          for (final hit in kindHits)
            ListTile(
              title: Text(hit.document.title),
              subtitle: _subtitle(hit, dim, colors),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onOpen(hit.document),
            ),
        ],
      ],
    );
  }

  Widget? _subtitle(SearchHit hit, TextStyle dim, SahabaColors colors) {
    final doc = hit.document;
    final context = doc.subtitle == null || doc.subtitle!.isEmpty
        ? null
        : Text(
            doc.subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: dim,
          );
    final excerpt = hit.excerpt;
    if (excerpt == null) return context;
    // Where the words were found, with the match marked.
    final found = Text.rich(
      TextSpan(
        style: dim,
        children: [
          TextSpan(text: excerpt.text.substring(0, excerpt.matchStart)),
          TextSpan(
            text: excerpt.text.substring(excerpt.matchStart, excerpt.matchEnd),
            style: TextStyle(
              color: colors.accentText,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: excerpt.text.substring(excerpt.matchEnd)),
        ],
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [?context, found],
    );
  }
}
