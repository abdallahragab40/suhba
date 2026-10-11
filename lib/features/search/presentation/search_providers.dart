import 'dart:async';
import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/features/search/domain/search_documents.dart';
import 'package:suhba/features/search/domain/search_index.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/seerah.dart';
import 'package:suhba/shared/content/domain/story.dart';
import 'package:suhba/shared/content/providers.dart';

/// Above this many documents the index is built on a background isolate;
/// null builds it in place (tests, where isolate results never arrive under
/// the fake clock).
final searchIsolateThresholdProvider = Provider<int?>((ref) => 300);

/// The search index over every companion, section, story and chapter,
/// Seerah chapter and essay, event and place.
final searchIndexProvider = FutureProvider<SearchIndex>((ref) async {
  final repo = ref.watch(contentRepositoryProvider);
  final summaries = (await repo.companionIndex()).getOrThrow();
  final storySummaries = (await repo.storyIndex()).getOrThrow();
  final categories = (await repo.categories()).getOrThrow();

  // A companion or story that fails to load is left out, not fatal; the
  // index counts it, so results can say they may be incomplete.
  final companionResults = await Future.wait(
    summaries.map((s) => repo.companion(s.id)),
  );
  final storyResults = await Future.wait(
    storySummaries.map((s) => repo.story(s.id)),
  );
  final companions = <Companion>[
    for (final r in companionResults) ?r.valueOrNull,
  ];
  final stories = <Story>[for (final r in storyResults) ?r.valueOrNull];
  final unavailable =
      companionResults.length -
      companions.length +
      storyResults.length -
      stories.length;

  // The Seerah, events and places are part of search when the build has
  // them; failures count like any other.
  final seerah = (await repo.seerahIndex()).valueOrNull;
  final seerahChapterResults = await Future.wait([
    for (final c in seerah?.chapters ?? const <SeerahChapterSummary>[])
      repo.seerahChapter(c.id),
  ]);
  final seerahTopicResults = await Future.wait([
    for (final t in seerah?.topics ?? const <SeerahTopicSummary>[])
      repo.seerahTopic(t.id),
  ]);
  final seerahChapters = [for (final r in seerahChapterResults) ?r.valueOrNull];
  final seerahTopics = [for (final r in seerahTopicResults) ?r.valueOrNull];
  final events = (await repo.events()).valueOrNull;
  final places = (await repo.places()).valueOrNull;
  final unavailableAll =
      unavailable +
      seerahChapterResults.length -
      seerahChapters.length +
      seerahTopicResults.length -
      seerahTopics.length +
      (events == null ? 1 : 0) +
      (places == null ? 1 : 0);

  final documents = buildSearchDocuments(
    companions: companions,
    stories: stories,
    categories: categories,
    seerahChapters: seerahChapters,
    seerahTopics: seerahTopics,
    events: events?.values.toList() ?? const [],
    places: places?.values.toList() ?? const [],
  );
  final threshold = ref.watch(searchIsolateThresholdProvider);
  return threshold == null || documents.length < threshold
      ? SearchIndex(documents, unavailable: unavailableAll)
      : _buildOnIsolate(documents, unavailableAll);
});

/// Builds the index on a background isolate. A separate function, so the
/// closure sent to the isolate captures only its arguments (not the
/// provider's repository, whose cache cannot cross isolates).
Future<SearchIndex> _buildOnIsolate(
  List<SearchDocument> documents,
  int unavailable,
) => Isolate.run(() => SearchIndex(documents, unavailable: unavailable));

/// The query as typed, applied after a short pause in typing.
final searchQueryProvider = NotifierProvider<SearchQueryController, String>(
  SearchQueryController.new,
);

class SearchQueryController extends Notifier<String> {
  static const debounce = Duration(milliseconds: 150);
  Timer? _timer;

  @override
  String build() {
    ref.onDispose(() => _timer?.cancel());
    return '';
  }

  void type(String text) {
    _timer?.cancel();
    _timer = Timer(debounce, () => state = text);
  }

  void clear() {
    _timer?.cancel();
    state = '';
  }
}

/// The kind of result shown, chosen by the reader.
enum SearchScope { all, seerah, companions, biographies, stories, archive }

/// The reader's filters: a [SearchScope] and, optionally, one companion or
/// story whose passages to search.
final searchFilterProvider =
    NotifierProvider<SearchFilterController, (SearchScope, String?)>(
      SearchFilterController.new,
    );

class SearchFilterController extends Notifier<(SearchScope, String?)> {
  @override
  (SearchScope, String?) build() => (SearchScope.all, null);

  void scope(SearchScope scope) => state = (scope, state.$2);

  void within(String? parentId) => state = (state.$1, parentId);
}

SearchFilter _filterFor((SearchScope, String?) f) => SearchFilter(
  kinds: switch (f.$1) {
    SearchScope.all => null,
    SearchScope.seerah => {SearchKind.seerahChapter, SearchKind.seerahTopic},
    SearchScope.archive => {SearchKind.event, SearchKind.place},
    SearchScope.companions => {SearchKind.companion},
    SearchScope.biographies => {SearchKind.section},
    SearchScope.stories => {SearchKind.story, SearchKind.chapter},
  },
  parentId: f.$2,
);

/// Results for the current query and filters, best first, with whether the
/// index is complete.
final searchResultsProvider =
    Provider<AsyncValue<({List<SearchHit> hits, int unavailable})>>((ref) {
      final query = ref.watch(searchQueryProvider);
      final filter = _filterFor(ref.watch(searchFilterProvider));
      return ref
          .watch(searchIndexProvider)
          .whenData(
            (i) => (
              hits: i.search(query, filter: filter),
              unavailable: i.unavailable,
            ),
          );
    });

/// Queries the reader opened a result from, newest first. In memory only:
/// nothing about searches is stored or sent anywhere.
final recentSearchesProvider =
    NotifierProvider<RecentSearchesController, List<String>>(
      RecentSearchesController.new,
    );

class RecentSearchesController extends Notifier<List<String>> {
  static const max = 5;

  @override
  List<String> build() => const [];

  void add(String query) {
    final q = query.trim();
    if (q.isEmpty) return;
    state = [q, ...state.where((s) => s != q)].take(max).toList();
  }
}
