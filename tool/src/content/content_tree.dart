import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/companion_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/story_dto.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

import 'content_files.dart';
import 'issues.dart';
import 'schema_set.dart';

/// One reviewable content item, with its raw JSON (for hashing) and its
/// parsed DTO.
class Item<T> {
  Item({
    required this.kind,
    required this.id,
    required this.file,
    required this.path,
    required this.raw,
    required this.dto,
    required this.review,
  });

  final ContentKind kind;
  final String id;
  final String file;

  /// JSON path of the item inside [file]; empty when the file is the item.
  final String path;
  final Map<String, dynamic> raw;
  final T dto;
  final ReviewDto review;

  String get key => '${kind.name}.$id';
  bool get isApproved => review.status == ReviewStatus.approved;

  /// [sub] (a path relative to the item, starting with `$`) inside the file.
  String at(String sub) => path.isEmpty ? sub : path + sub.substring(1);
}

class ApprovalRecord {
  ApprovalRecord(this.file, this.dto);

  final String file;
  final ApprovalDto dto;
}

/// All content, parsed. Files that failed the schema are left out (their
/// problems are already reported).
class ContentTree {
  ContentMetaDto? meta;
  final sources = <Item<SourceReferenceDto>>[];
  final categories = <Item<CategoryDto>>[];
  final people = <Item<PersonDto>>[];
  final events = <Item<HistoricalEventDto>>[];
  final companions = <Item<CompanionDto>>[];
  final stories = <Item<StoryDto>>[];
  final reviewers = <ReviewerDto>[];

  /// Approval records by item key (`kind.id`).
  final approvals = <String, ApprovalRecord>{};

  /// Keys (`kind.id`) of items whose file failed the schema. They are not
  /// in the tree, but references to them are not reported again.
  final invalidKeys = <String>{};

  Iterable<Item<Object>> get allItems => [
    ...sources,
    ...categories,
    ...people,
    ...events,
    ...companions,
    ...stories,
  ];

  Map<String, Item<T>> _byId<T>(List<Item<T>> items) => {
    for (final i in items) i.id: i,
  };

  late final sourceById = _byId(sources);
  late final categoryById = _byId(categories);
  late final personById = _byId(people);
  late final eventById = _byId(events);
  late final companionById = _byId(companions);
  late final storyById = _byId(stories);
}

/// Reads [files] into a [ContentTree], reporting JSON and schema problems
/// (rule V1) and unknown or missing files (V2) to [sink].
ContentTree parseContent(
  ContentFiles files,
  SchemaSet schemas,
  IssueSink sink,
) {
  final tree = ContentTree();

  Map<String, dynamic>? load(
    String file,
    String def, {
    ContentKind? kind,
    String? listKey,
  }) {
    final Object? json;
    try {
      json = jsonDecode(files.files[file]!);
    } on FormatException catch (e) {
      sink.error('V1', file, '', 'Not valid JSON: ${e.message}');
      return null;
    }
    final errors = schemas.validate(def, json);
    for (final (path, message) in errors) {
      sink.error('V1', file, path, message);
    }
    if (errors.isNotEmpty && kind != null) {
      final items = listKey == null
          ? [json]
          : (json is Map && json[listKey] is List
                ? json[listKey] as List
                : const <Object?>[]);
      for (final item in items) {
        if (item is Map && item['id'] is String) {
          tree.invalidKeys.add('${kind.name}.${item['id']}');
        }
      }
    }
    return errors.isEmpty ? json! as Map<String, dynamic> : null;
  }

  T? parse<T>(String file, T Function() fromJson) {
    try {
      return fromJson();
    } on CheckedFromJsonException catch (e) {
      // The schema should have caught this; report it rather than crash.
      sink.error('V1', file, '\$.${e.key ?? ''}', '${e.message}');
      return null;
    }
  }

  void list<D, F>({
    required String file,
    required String def,
    required String key,
    required ContentKind kind,
    required F Function(Map<String, dynamic>) fromJson,
    required List<D> Function(F) itemsOf,
    required String Function(D) idOf,
    required ReviewDto Function(D) reviewOf,
    required List<Item<D>> into,
  }) {
    final json = load(file, def, kind: kind, listKey: key);
    if (json == null) return;
    final dto = parse(file, () => fromJson(json));
    if (dto == null) return;
    final raws = (json[key] as List).cast<Map<String, dynamic>>();
    final dtos = itemsOf(dto);
    for (var i = 0; i < dtos.length; i++) {
      into.add(
        Item(
          kind: kind,
          id: idOf(dtos[i]),
          file: file,
          path: '\$.$key[$i]',
          raw: raws[i],
          dto: dtos[i],
          review: reviewOf(dtos[i]),
        ),
      );
    }
  }

  for (final file in files.files.keys) {
    switch (file) {
      case 'meta.json':
        final json = load(file, 'metaFile');
        if (json != null) {
          tree.meta = parse(file, () => ContentMetaDto.fromJson(json));
        }
      case 'reviewers.json':
        final json = load(file, 'reviewersFile');
        if (json != null) {
          final dto = parse(file, () => ReviewersFileDto.fromJson(json));
          if (dto != null) tree.reviewers.addAll(dto.reviewers);
        }
      case 'sources.json':
        list(
          file: file,
          def: 'sourcesFile',
          key: 'sources',
          kind: ContentKind.source,
          fromJson: SourcesFileDto.fromJson,
          itemsOf: (f) => f.sources,
          idOf: (d) => d.id,
          reviewOf: (d) => d.review,
          into: tree.sources,
        );
      case 'categories.json':
        list(
          file: file,
          def: 'categoriesFile',
          key: 'categories',
          kind: ContentKind.category,
          fromJson: CategoriesFileDto.fromJson,
          itemsOf: (f) => f.categories,
          idOf: (d) => d.id,
          reviewOf: (d) => d.review,
          into: tree.categories,
        );
      case 'people.json':
        list(
          file: file,
          def: 'peopleFile',
          key: 'people',
          kind: ContentKind.person,
          fromJson: PeopleFileDto.fromJson,
          itemsOf: (f) => f.people,
          idOf: (d) => d.id,
          reviewOf: (d) => d.review,
          into: tree.people,
        );
      case 'events.json':
        list(
          file: file,
          def: 'eventsFile',
          key: 'events',
          kind: ContentKind.event,
          fromJson: EventsFileDto.fromJson,
          itemsOf: (f) => f.events,
          idOf: (d) => d.id,
          reviewOf: (d) => d.review,
          into: tree.events,
        );
      case _ when file.startsWith('companions/'):
        final json = load(file, 'companionFile', kind: ContentKind.companion);
        final dto = json == null
            ? null
            : parse(file, () => CompanionDto.fromJson(json));
        if (dto != null) {
          tree.companions.add(
            Item(
              kind: ContentKind.companion,
              id: dto.id,
              file: file,
              path: '',
              raw: json!,
              dto: dto,
              review: dto.review,
            ),
          );
        }
      case _ when file.startsWith('stories/'):
        final json = load(file, 'storyFile', kind: ContentKind.story);
        final dto = json == null
            ? null
            : parse(file, () => StoryDto.fromJson(json));
        if (dto != null) {
          tree.stories.add(
            Item(
              kind: ContentKind.story,
              id: dto.id,
              file: file,
              path: '',
              raw: json!,
              dto: dto,
              review: dto.review,
            ),
          );
        }
      case _ when file.startsWith('reviews/'):
        final json = load(file, 'approvalFile');
        final dto = json == null
            ? null
            : parse(file, () => ApprovalDto.fromJson(json));
        if (dto != null) {
          tree.approvals['${dto.kind.name}.${dto.id}'] = ApprovalRecord(
            file,
            dto,
          );
        }
      default:
        sink.warning('V2', file, '', 'Unexpected file; it is ignored.');
    }
  }

  for (final required in ['meta.json', 'sources.json', 'reviewers.json']) {
    if (!files.files.containsKey(required)) {
      sink.error('V2', required, '', 'Required file is missing.');
    }
  }
  return tree;
}
