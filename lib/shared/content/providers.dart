import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/shared/content/data/asset_content_repository.dart';
import 'package:siyar_sahaba/shared/content/data/asset_content_source.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_manifest.dart';
import 'package:siyar_sahaba/shared/content/domain/content_repository.dart';
import 'package:siyar_sahaba/shared/content/domain/content_target.dart';
import 'package:siyar_sahaba/shared/content/domain/seerah.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';

/// The asset bundle content is read from; overridden in tests.
final assetBundleProvider = Provider<AssetBundle>((ref) => rootBundle);

final contentRepositoryProvider = Provider<ContentRepository>(
  (ref) => AssetContentRepository(
    AssetContentSource(ref.watch(assetBundleProvider)),
  ),
);

// The repository caches parsed files, so these providers stay cheap; the
// catalog-wide ones are kept alive for the session.

/// The bundled content build: version and channel (draft or published).
final contentManifestProvider = FutureProvider<ContentManifest>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).manifest()).getOrThrow(),
);

/// Every companion summary, in display order.
final companionIndexProvider = FutureProvider<List<CompanionSummary>>(
  (ref) async => (await ref.watch(contentRepositoryProvider).companionIndex())
      .getOrThrow(),
);

final storyIndexProvider = FutureProvider<List<StorySummary>>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).storyIndex()).getOrThrow(),
);

/// Categories in display order.
final categoriesProvider = FutureProvider<List<CompanionCategory>>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).categories()).getOrThrow(),
);

final sourcesProvider = FutureProvider<Map<String, SourceReference>>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).sources()).getOrThrow(),
);

final peopleProvider = FutureProvider<Map<String, Person>>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).people()).getOrThrow(),
);

final eventsProvider = FutureProvider<Map<String, HistoricalEvent>>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).events()).getOrThrow(),
);

/// The Seerah section, with its chapter and topic summaries.
final seerahIndexProvider = FutureProvider<SeerahIndex>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).seerahIndex()).getOrThrow(),
);

final placesProvider = FutureProvider<Map<String, HistoricalPlace>>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).places()).getOrThrow(),
);

final visualsProvider = FutureProvider<Map<String, Infographic>>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).visuals()).getOrThrow(),
);

/// One full Seerah chapter; disposed when no screen shows it.
final seerahChapterProvider = FutureProvider.autoDispose
    .family<SeerahChapter, String>(
      (ref, id) async =>
          (await ref.watch(contentRepositoryProvider).seerahChapter(id))
              .getOrThrow(),
    );

/// One thematic essay; disposed when no screen shows it.
final seerahTopicProvider = FutureProvider.autoDispose
    .family<SeerahTopic, String>(
      (ref, id) async =>
          (await ref.watch(contentRepositoryProvider).seerahTopic(id))
              .getOrThrow(),
    );

/// Every Seerah chapter in full, in reading order (for cross-links such as
/// "the chapter that tells this event"). Chapters that fail to load are
/// left out.
final allSeerahChaptersProvider = FutureProvider<List<SeerahChapter>>((
  ref,
) async {
  final repo = ref.watch(contentRepositoryProvider);
  final index = await ref.watch(seerahIndexProvider.future);
  final loaded = await Future.wait(
    index.chapters.map((c) => repo.seerahChapter(c.id)),
  );
  return [for (final r in loaded) ?r.valueOrNull];
});

/// One full companion; disposed when no screen shows it.
final companionProvider = FutureProvider.autoDispose.family<Companion, String>(
  (ref, id) async =>
      (await ref.watch(contentRepositoryProvider).companion(id)).getOrThrow(),
);

/// One full story; disposed when no screen shows it.
final storyProvider = FutureProvider.autoDispose.family<Story, String>(
  (ref, id) async =>
      (await ref.watch(contentRepositoryProvider).story(id)).getOrThrow(),
);

/// What a saved item or reading position points at. Throws the load
/// [Failure] when the content could not be read, which is distinct from
/// [TargetMissing] (it loaded and the target is gone).
final targetLookupProvider = FutureProvider.autoDispose
    .family<TargetLookup, ContentTarget>(
      (ref, target) async => (await lookUpTarget(
        ref.watch(contentRepositoryProvider),
        target,
      )).getOrThrow(),
    );
