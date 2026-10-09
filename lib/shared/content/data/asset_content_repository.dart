import 'package:json_annotation/json_annotation.dart';
import 'package:siyar_sahaba/core/result/failure.dart';
import 'package:siyar_sahaba/core/result/result.dart';
import 'package:siyar_sahaba/shared/content/data/asset_content_source.dart';
import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/companion_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/story_dto.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/content_mappers.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_format.dart';
import 'package:siyar_sahaba/shared/content/domain/content_manifest.dart';
import 'package:siyar_sahaba/shared/content/domain/content_repository.dart';
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
