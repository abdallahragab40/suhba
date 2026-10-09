import 'dart:collection';
import 'dart:convert';

import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

import 'content_files.dart';
import 'content_hash.dart';
import 'content_tree.dart';
import 'schema_set.dart';
import 'validator.dart';

/// The category whose members make up the first public release: the Ten
/// Promised Paradise (decision D3).
const publicV1Category = 'ashara-mubashshara';
const publicV1Size = 10;

/// Where an item stands with its approval.
enum ApprovalState {
  /// Not marked approved.
  notApproved,

  /// Approved, and the approval matches the current content.
  current,

  /// Approved, but the content changed afterwards (or the record is
  /// missing): it must be reviewed again.
  stale,
}

/// One reviewable item's readiness.
class ItemReadiness {
  const ItemReadiness({
    required this.key,
    required this.approval,
    required this.pendingChecks,
    required this.contentHash,
    this.fullBiography,
  });

  /// `kind.id`, e.g. `companion.abu-bakr`.
  final String key;
  final ApprovalState approval;

  /// Locators, quoted texts and gradings still to be supplied.
  final int pendingChecks;

  /// The hash an approval record must carry (see tool/content_hash.dart).
  final String contentHash;

  /// Companions only: whether the biography is written out (sections and a
  /// timeline) rather than a skeleton profile.
  final bool? fullBiography;

  Map<String, Object?> toJson() => {
    'key': key,
    'approval': approval.name,
    'pendingChecks': pendingChecks,
    'contentHash': contentHash,
    if (fullBiography != null) 'fullBiography': fullBiography,
  };
}

/// Every reviewable item's readiness, plus what still blocks the first
/// public release. Deterministic: items are sorted by key, and nothing
/// depends on the clock or the machine.
class ReadinessReport {
  ReadinessReport({
    required this.contentVersion,
    required this.items,
    required this.publishedBuildErrors,
    required this.publicV1Problems,
  });

  final String contentVersion;
  final List<ItemReadiness> items;

  /// Errors from validating the published channel.
  final List<String> publishedBuildErrors;

  /// Why the content is not yet the complete public release; empty when it
  /// is.
  final List<String> publicV1Problems;

  bool get publicV1Ready =>
      publishedBuildErrors.isEmpty && publicV1Problems.isEmpty;

  String toJsonString() => const JsonEncoder.withIndent('  ').convert({
    'contentVersion': contentVersion,
    'publicV1Ready': publicV1Ready,
    'publicV1Problems': publicV1Problems,
    'publishedBuildErrors': publishedBuildErrors,
    'items': [for (final i in items) i.toJson()],
  });

  String toMarkdown() {
    final b = StringBuffer()
      ..writeln('# Content readiness — $contentVersion')
      ..writeln()
      ..writeln(
        publicV1Ready
            ? '**Public v1: ready.**'
            : '**Public v1: not ready** '
                  '(${publicV1Problems.length + publishedBuildErrors.length} '
                  'problems).',
      )
      ..writeln();
    if (publicV1Problems.isNotEmpty) {
      b.writeln('## Public v1 problems\n');
      for (final p in publicV1Problems) {
        b.writeln('- $p');
      }
      b.writeln();
    }
    if (publishedBuildErrors.isNotEmpty) {
      b.writeln('## Published build errors\n');
      for (final e in publishedBuildErrors) {
        b.writeln('- $e');
      }
      b.writeln();
    }
    b
      ..writeln('## Items\n')
      ..writeln('| Item | Approval | Pending checks | Biography | Hash |')
      ..writeln('|---|---|---|---|---|');
    for (final i in items) {
      final bio = switch (i.fullBiography) {
        true => 'full',
        false => 'skeleton',
        null => '',
      };
      b.writeln(
        '| `${i.key}` | ${i.approval.name} | ${i.pendingChecks} | $bio | '
        '`${i.contentHash.substring(0, 12)}` |',
      );
    }
    return b.toString();
  }
}

/// Builds the [ReadinessReport] for [files]. It never approves anything; it
/// only reports.
///
/// The first public release is the companions of [category] — exactly
/// [size] of them — each with a full biography, a current approval and no
/// unresolved checks, plus every story they link to, approved.
ReadinessReport contentReadiness(
  ContentFiles files,
  SchemaSet schemas, {
  String category = publicV1Category,
  int size = publicV1Size,
}) {
  final draft = validateContent(files, schemas, channel: ContentChannel.draft);
  final published = validateContent(
    files,
    schemas,
    channel: ContentChannel.published,
  );
  final tree = draft.tree;

  ApprovalState approvalOf(Item<Object> item) {
    if (!item.isApproved) return ApprovalState.notApproved;
    final record = tree.approvals[item.key];
    final reviewerKnown =
        record != null &&
        tree.reviewers.any((r) => r.id == record.dto.reviewerId);
    return reviewerKnown && record.dto.contentHash == contentHash(item.raw)
        ? ApprovalState.current
        : ApprovalState.stale;
  }

  final companionsByKey = {for (final c in tree.companions) c.key: c};
  bool fullBiography(Item<Object> item) {
    final c = companionsByKey[item.key]!.dto;
    return c.sections.isNotEmpty && c.timeline.isNotEmpty;
  }

  final items = SplayTreeMap<String, ItemReadiness>();
  for (final item in tree.allItems) {
    items[item.key] = ItemReadiness(
      key: item.key,
      approval: approvalOf(item),
      pendingChecks: draft.pendingByItem[item.key] ?? 0,
      contentHash: contentHash(item.raw),
      fullBiography: item.kind == ContentKind.companion
          ? fullBiography(item)
          : null,
    );
  }

  final problems = <String>[
    for (final i in draft.issues.where((i) => i.severity.name == 'error'))
      'Draft validation error: $i',
  ];
  final ten = [
    for (final c in tree.companions)
      if (c.dto.memberships.any((m) => m.categoryId == category)) c,
  ]..sort((a, b) => a.key.compareTo(b.key));
  if (ten.length != size) {
    problems.add(
      'Expected $size companions in "$category", found ${ten.length}.',
    );
  }
  for (final c in ten) {
    final r = items[c.key]!;
    if (r.fullBiography != true) {
      problems.add('${c.key}: skeleton profile, not a full biography.');
    }
    switch (r.approval) {
      case ApprovalState.notApproved:
        problems.add('${c.key}: not approved by a registered reviewer.');
      case ApprovalState.stale:
        problems.add('${c.key}: approval is stale; review again.');
      case ApprovalState.current:
        break;
    }
    if (r.pendingChecks > 0) {
      problems.add('${c.key}: ${r.pendingChecks} unresolved checks.');
    }
  }
  final storyKeys = {
    for (final c in ten)
      for (final id in c.dto.storyIds) 'story.$id',
  }.toList()..sort();
  for (final key in storyKeys) {
    final r = items[key];
    if (r == null) {
      problems.add('$key: linked from the release but does not exist.');
    } else if (r.approval != ApprovalState.current) {
      problems.add('$key: linked from the release but not approved.');
    } else if (r.pendingChecks > 0) {
      problems.add('$key: ${r.pendingChecks} unresolved checks.');
    }
  }

  return ReadinessReport(
    contentVersion: tree.meta?.contentVersion ?? 'unknown',
    items: items.values.toList(),
    publishedBuildErrors: [
      for (final i in published.issues.where((i) => i.severity.name == 'error'))
        '$i',
    ],
    publicV1Problems: problems,
  );
}
