import 'package:json_annotation/json_annotation.dart';
import 'package:siyar_sahaba/core/result/failure.dart';
import 'package:siyar_sahaba/core/result/result.dart';
import 'package:siyar_sahaba/shared/content/data/asset_content_source.dart';
import 'package:siyar_sahaba/shared/content/data/dto/atlas_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/companion_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/seerah_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/story_dto.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/content_mappers.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/seerah_mappers.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_format.dart';
import 'package:siyar_sahaba/shared/content/domain/content_manifest.dart';
import 'package:siyar_sahaba/shared/content/domain/content_repository.dart';
import 'package:siyar_sahaba/shared/content/domain/seerah.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';

/// [ContentRepository] over the bundled assets. Each file is read and parsed
/// once per session; failures are not cached, so a retry can succeed.
class AssetContentRepository implements ContentRepository {
  AssetContentRepository(this._source);

  final AssetContentSource _source;
  final _cache = <String, Future<Object>>{};

  static final _slug = RegExp(r'^[a-z0-9]+(?:[-.][a-z0-9]+)*$');

  @override
  Future<Result<ContentManifest>> manifest() =>
      _load('manifest.json', (json) => ManifestDto.fromJson(json).toDomain());

  @override
  Future<Result<List<CompanionSummary>>> companionIndex() => _load(
    'index/companions.json',
    (json) => [
      for (final c in CompanionIndexDto.fromJson(json).companions) c.toDomain(),
    ],
  );

  @override
  Future<Result<List<StorySummary>>> storyIndex() => _load(
    'index/stories.json',
    (json) => [
      for (final s in StoryIndexDto.fromJson(json).stories) s.toDomain(),
    ],
  );

  @override
  Future<Result<Companion>> companion(String id) => _byId(
    id,
    'companions/$id.json',
    (json) => CompanionDto.fromJson(json).toDomain(),
  );

  @override
  Future<Result<Story>> story(String id) => _byId(
    id,
    'stories/$id.json',
    (json) => StoryDto.fromJson(json).toDomain(),
  );

  @override
  Future<Result<List<CompanionCategory>>> categories() => _load(
    'categories.json',
    (json) => [
      for (final c in CategoriesFileDto.fromJson(json).categories) c.toDomain(),
    ]..sort((a, b) => a.order.compareTo(b.order)),
  );

  @override
  Future<Result<Map<String, HistoricalEvent>>> events() => _load(
    'events.json',
    (json) => {
      for (final e in EventsFileDto.fromJson(json).events) e.id: e.toDomain(),
    },
  );

  @override
  Future<Result<Map<String, SourceReference>>> sources() => _load(
    'sources.json',
    (json) => {
      for (final s in SourcesFileDto.fromJson(json).sources) s.id: s.toDomain(),
    },
  );

  @override
  Future<Result<Map<String, Person>>> people() => _load(
    'people.json',
    (json) => {
      for (final p in PeopleFileDto.fromJson(json).people) p.id: p.toDomain(),
    },
  );

  @override
  Future<Result<SeerahIndex>> seerahIndex() => _load(
    'seerah/index.json',
    (json) => SeerahIndexDto.fromJson(json).toDomain(),
  );

  @override
  Future<Result<SeerahChapter>> seerahChapter(String id) => _numbered(
    id,
    'seerah/chapters/$id.json',
    (index) => index.chapters.map((c) => c.id),
    (json, number) => SeerahChapterDto.fromJson(json).toDomain(number: number),
  );

  @override
  Future<Result<SeerahTopic>> seerahTopic(String id) => _numbered(
    id,
    'seerah/topics/$id.json',
    (index) => index.topics.map((t) => t.id),
    (json, number) => SeerahTopicDto.fromJson(json).toDomain(number: number),
  );

  @override
  Future<Result<Map<String, HistoricalPlace>>> places() => _load(
    'places.json',
    (json) => {
      for (final p in PlacesFileDto.fromJson(json).places) p.id: p.toDomain(),
    },
  );

  @override
  Future<Result<Map<String, Infographic>>> visuals() => _load(
    'visuals.json',
    (json) => {
      for (final v in VisualsFileDto.fromJson(json).visuals) v.id: v.toDomain(),
    },
  );

  /// A chapter or topic, numbered by its place in the Seerah index. One
  /// that is not in the index is not part of the section: not found.
  Future<Result<T>> _numbered<T>(
    String id,
    String path,
    Iterable<String> Function(SeerahIndex) order,
    T Function(Map<String, dynamic>, int number) parse,
  ) async {
    final index = await seerahIndex();
    switch (index) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value):
        final position = order(value).toList().indexOf(id);
        if (position < 0) {
          return Err(NotFoundFailure('"$id" is not in the Seerah index'));
        }
        return _byId(id, path, (json) => parse(json, position + 1));
    }
  }

  /// IDs come from routes and deep links: only well-formed slugs may become
  /// file paths.
  Future<Result<T>> _byId<T>(
    String id,
    String path,
    T Function(Map<String, dynamic>) parse,
  ) {
    if (!_slug.hasMatch(id)) {
      return Future.value(Err(NotFoundFailure('Invalid content id "$id"')));
    }
    return _load(path, parse);
  }

  Future<Result<T>> _load<T>(
    String path,
    T Function(Map<String, dynamic>) parse,
  ) {
    final cached = _cache[path];
    if (cached != null) return cached as Future<Result<T>>;

    final future = Result.guard<T>(
      () async => parse(_checkFormat(path, await _source.readJson(path))),
      onError: _failureFor,
    );
    _cache[path] = future;
    future.then((result) {
      if (!result.isOk) _cache.remove(path);
    });
    return future;
  }

  /// Rejects files in a format this app does not read, before any mapping.
  static Map<String, dynamic> _checkFormat(
    String path,
    Map<String, dynamic> json,
  ) {
    final version = json['schemaVersion'];
    if (version is! int) {
      throw FormatException('$path has no integer schemaVersion');
    }
    if (!ContentFormat.supported.contains(version)) {
      throw UnsupportedFormatFailure(
        '$path is schema version $version; '
        'this app reads ${ContentFormat.supported}',
        found: version,
        supported: ContentFormat.supported,
      );
    }
    return json;
  }

  static Failure _failureFor(Object error, StackTrace stackTrace) =>
      switch (error) {
        Failure() => error,
        ContentFileNotFound(:final path) => NotFoundFailure(
          'No content file $path',
          cause: error,
          stackTrace: stackTrace,
        ),
        CheckedFromJsonException() ||
        FormatException() ||
        TypeError() => DataFormatFailure(
          'Content file did not match its schema: $error',
          cause: error,
          stackTrace: stackTrace,
        ),
        _ => UnexpectedFailure('$error', cause: error, stackTrace: stackTrace),
      };
}
