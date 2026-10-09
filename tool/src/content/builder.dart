import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/companion_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/story_dto.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/content_mappers.dart';
import 'package:siyar_sahaba/shared/content/domain/content_format.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

import 'content_files.dart';
import 'content_tree.dart';
import 'schema_set.dart';
import 'validator.dart';

/// The bundled-content schema version written into every output file.
const outputSchemaVersion = ContentFormat.current;

class BuildResult {
  BuildResult(this.report, this.outputs);

  final ValidationReport report;

  /// Output path (relative to assets/content/) → file contents. Empty when
  /// validation failed.
  final SplayTreeMap<String, String> outputs;
}

/// Validates [files] and, if there are no errors, produces the bundled
/// assets for [channel]. The output is deterministic: the same input always
/// gives the same bytes (no timestamps, stable ordering).
BuildResult buildContent(
  ContentFiles files,
  SchemaSet schemas, {
  required ContentChannel channel,
}) {
  final report = validateContent(files, schemas, channel: channel);
  final outputs = SplayTreeMap<String, String>();
  if (report.hasErrors) return BuildResult(report, outputs);

  final tree = report.tree;
  bool include(Item<Object> item) =>
      channel == ContentChannel.draft || item.isApproved;

  // Shipped review blocks keep status and flags; drop internal authorship.
  ReviewDto shipped(ReviewDto r) => r.copyWith(authoredBy: null);

  final companions = [
    for (final c in tree.companions.where(include))
      c.dto.copyWith(review: shipped(c.dto.review)),
  ]..sort(_companionOrder);
  final stories = [
    for (final s in tree.stories.where(include))
      s.dto.copyWith(review: shipped(s.dto.review)),
  ]..sort((a, b) => a.id.compareTo(b.id));

  String encode(Object json) => jsonEncode(json);

  outputs['index/companions.json'] = encode(
    CompanionIndexDto(
      schemaVersion: outputSchemaVersion,
      companions: [for (final c in companions) c.toSummary()],
    ).toJson(),
  );
  outputs['index/stories.json'] = encode(
    StoryIndexDto(
      schemaVersion: outputSchemaVersion,
      stories: [for (final s in stories) s.toSummary()],
    ).toJson(),
  );
  for (final c in companions) {
    outputs['companions/${c.id}.json'] = encode(c.toJson());
  }
  for (final s in stories) {
    outputs['stories/${s.id}.json'] = encode(s.toJson());
  }
  outputs['categories.json'] = encode(
    CategoriesFileDto(
      schemaVersion: outputSchemaVersion,
      categories: [
        for (final c in tree.categories.where(include))
          c.dto.copyWith(review: shipped(c.dto.review)),
      ]..sort((a, b) => a.order.compareTo(b.order)),
    ).toJson(),
  );
  outputs['events.json'] = encode(
    EventsFileDto(
      schemaVersion: outputSchemaVersion,
      events: [
        for (final e in tree.events.where(include))
          e.dto.copyWith(review: shipped(e.dto.review)),
      ],
    ).toJson(),
  );
  outputs['sources.json'] = encode(
    SourcesFileDto(
      schemaVersion: outputSchemaVersion,
      sources: [
        for (final s in tree.sources.where(include))
          s.dto.copyWith(review: shipped(s.dto.review)),
      ],
    ).toJson(),
  );
  outputs['people.json'] = encode(
    PeopleFileDto(
      schemaVersion: outputSchemaVersion,
      people: [
        for (final p in tree.people.where(include))
          p.dto.copyWith(review: shipped(p.dto.review)),
      ],
    ).toJson(),
  );

  final included = tree.allItems.where(include).toList();
  final approved = included.where((i) => i.isApproved).length;
  outputs['manifest.json'] = encode(
    ManifestDto(
      schemaVersion: outputSchemaVersion,
      contentVersion: tree.meta!.contentVersion,
      channel: channel,
      companionCount: companions.length,
      storyCount: stories.length,
      approvedCount: approved,
      unapprovedCount: included.length - approved,
      files: SplayTreeMap.of({
        for (final MapEntry(:key, :value) in outputs.entries)
          key: sha256.convert(utf8.encode(value)).toString(),
      }),
    ).toJson(),
  );
  return BuildResult(report, outputs);
}

/// By `order` (missing last), then Arabic name, then id.
int _companionOrder(CompanionDto a, CompanionDto b) {
  const last = 1 << 30;
  final byOrder = (a.order ?? last).compareTo(b.order ?? last);
  if (byOrder != 0) return byOrder;
  final byName = a.name.ar.compareTo(b.name.ar);
  return byName != 0 ? byName : a.id.compareTo(b.id);
}
