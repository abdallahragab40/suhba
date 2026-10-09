import 'dart:collection';
import 'dart:convert';

import 'package:siyar_sahaba/shared/content/data/dto/atlas_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/block_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/companion_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/seerah_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/story_dto.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/content_mappers.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

import 'content_files.dart';
import 'content_hash.dart';
import 'content_tree.dart';
import 'schema_set.dart';
import 'validator.dart';

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
    this.coverage,
    this.words,
    this.gaps = const [],
  });

  /// `kind.id`, e.g. `companion.abu-bakr`.
  final String key;
  final ApprovalState approval;

  /// Locators, quoted texts and gradings still to be supplied.
  final int pendingChecks;

  /// The hash an approval record must carry (see tool/content_hash.dart).
  final String contentHash;

  /// The editor's coverage statement (skeleton, sample, complete); null
  /// when none was made.
  final Coverage? coverage;

  /// Words of readable prose, for passages (companions, stories, Seerah
  /// chapters and topics). A diagnostic of thin drafts, not of quality.
  final int? words;

  /// What the release checklist finds missing in this item, e.g. a
  /// required section or too few timeline entries. Empty when nothing is
  /// missing or the item is not checked.
  final List<String> gaps;

  Map<String, Object?> toJson() => {
    'key': key,
    'approval': approval.name,
    'pendingChecks': pendingChecks,
    'contentHash': contentHash,
    if (coverage != null) 'coverage': coverage!.name,
    if (words != null) 'words': words,
    if (gaps.isNotEmpty) 'gaps': gaps,
  };
}

/// Every reviewable item's readiness, plus what still blocks the next
/// public edition (content/release/edition.json). Deterministic: items are
/// sorted by key, and nothing depends on the clock or the machine.
class ReadinessReport {
  ReadinessReport({
    required this.contentVersion,
    required this.editionId,
    required this.items,
    required this.publishedBuildErrors,
    required this.editionProblems,
  });

  final String contentVersion;

  /// The checklist's id, or null when there is none.
  final String? editionId;
  final List<ItemReadiness> items;

  /// Errors from validating the published channel.
  final List<String> publishedBuildErrors;

  /// Why the content is not yet the complete edition; empty when it is.
  final List<String> editionProblems;

  bool get editionReady =>
      publishedBuildErrors.isEmpty && editionProblems.isEmpty;

  String toJsonString() => const JsonEncoder.withIndent('  ').convert({
    'contentVersion': contentVersion,
    'edition': editionId,
    'editionReady': editionReady,
    'editionProblems': editionProblems,
    'publishedBuildErrors': publishedBuildErrors,
    'items': [for (final i in items) i.toJson()],
  });

  String toMarkdown() {
    final b = StringBuffer()
      ..writeln('# Content readiness — $contentVersion')
      ..writeln()
      ..writeln(
        editionReady
            ? '**Edition ${editionId ?? '?'}: ready.**'
            : '**Edition ${editionId ?? '?'}: not ready** '
                  '(${editionProblems.length + publishedBuildErrors.length} '
                  'problems).',
      )
      ..writeln();
    if (editionProblems.isNotEmpty) {
      b.writeln('## Edition problems\n');
      for (final p in editionProblems) {
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
      ..writeln('| Item | Approval | Pending checks | Coverage | Words | Gaps |')
      ..writeln('|---|---|---|---|---|---|');
    for (final i in items) {
      b.writeln(
        '| `${i.key}` | ${i.approval.name} | ${i.pendingChecks} | '
        '${i.coverage?.name ?? ''} | ${i.words ?? ''} | '
        '${i.gaps.join('; ')} |',
      );
    }
    return b.toString();
  }
}

/// Builds the [ReadinessReport] for [files]. It never approves anything; it
/// only reports.
///
/// The edition is described by [edition] or, when null, by the content's
/// own `release/edition.json`. Every item it requires must be declared
/// complete by the editor, meet the checklist's coverage minimums, carry a
/// current approval and have no unresolved checks; everything they link to
/// must be approved too.
ReadinessReport contentReadiness(
  ContentFiles files,
  SchemaSet schemas, {
  EditionDto? edition,
}) {
  final draft = validateContent(files, schemas, channel: ContentChannel.draft);
  final published = validateContent(
    files,
    schemas,
    channel: ContentChannel.published,
  );
  final tree = draft.tree;
  final checklist = edition ?? tree.edition;

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

  int wordsOf(List<ContentBlockDto> blocks) =>
      proseWordCount([for (final b in blocks) b.toDomain()]);

  int? wordsFor(Object dto) => switch (dto) {
    CompanionDto(:final sections) => wordsOf([
      for (final s in sections) ...s.blocks,
    ]),
    StoryDto(:final chapters) => wordsOf([
      for (final c in chapters) ...c.blocks,
    ]),
    SeerahChapterDto(:final blocks) || SeerahTopicDto(:final blocks) =>
      wordsOf(blocks),
    _ => null,
  };

  List<String> gapsFor(Item<Object> item, int? words) {
    final c = checklist;
    if (c == null) return const [];
    final dto = item.dto;
    return switch (dto) {
      CompanionDto()
          when dto.memberships.any(
            (m) => m.categoryId == c.companions.categoryId,
          ) =>
        [
          if ((words ?? 0) < c.companions.minWords)
            '$words of ${c.companions.minWords} words',
          if (dto.sections.length < c.companions.minSections)
            '${dto.sections.length} of ${c.companions.minSections} sections',
          if (dto.timeline.length < c.companions.minTimeline)
            '${dto.timeline.length} of ${c.companions.minTimeline} '
                'timeline entries',
          for (final kind in c.companions.requiredSectionKinds)
            if (!dto.sections.any((s) => s.kind == kind))
              'no ${kind.name} section',
        ],
      SeerahChapterDto() when (words ?? 0) < c.seerah.minChapterWords => [
        '$words of ${c.seerah.minChapterWords} words',
      ],
      SeerahTopicDto() when (words ?? 0) < c.seerah.minTopicWords => [
        '$words of ${c.seerah.minTopicWords} words',
      ],
      StoryDto()
          when c.stories.minWords != null &&
              (words ?? 0) < c.stories.minWords! =>
        ['$words of ${c.stories.minWords} words'],
      _ => const <String>[],
    };
  }

  final items = SplayTreeMap<String, ItemReadiness>();
  for (final item in tree.allItems) {
    final words = wordsFor(item.dto);
    items[item.key] = ItemReadiness(
      key: item.key,
      approval: approvalOf(item),
      pendingChecks: draft.pendingByItem[item.key] ?? 0,
      contentHash: contentHash(item.raw),
      coverage: item.review.coverage,
      words: words,
      gaps: gapsFor(item, words),
    );
  }

  final problems = <String>[
    for (final i in draft.issues.where((i) => i.severity.name == 'error'))
      'Draft validation error: $i',
  ];

  /// Whether [key] is fully ready: declared complete (when [coverage]),
  /// no gaps, a current approval and nothing pending. Adds a problem for
  /// each shortfall, prefixed with [why].
  bool require(String key, {String why = '', bool coverage = true}) {
    final r = items[key];
    if (r == null) {
      problems.add('$key: ${why}required, but it does not exist.');
      return false;
    }
    final before = problems.length;
    if (coverage && r.coverage != Coverage.complete) {
      problems.add(
        '$key: ${why}not declared complete by the editor '
        '(coverage: ${r.coverage?.name ?? 'none'}).',
      );
    }
    for (final gap in r.gaps) {
      problems.add('$key: $why$gap.');
    }
    switch (r.approval) {
      case ApprovalState.notApproved:
        problems.add('$key: ${why}not approved by a registered reviewer.');
      case ApprovalState.stale:
        problems.add('$key: ${why}approval is stale; review again.');
      case ApprovalState.current:
        break;
    }
    if (r.pendingChecks > 0) {
      problems.add('$key: $why${r.pendingChecks} unresolved checks.');
    }
    return problems.length == before;
  }

  bool ready(String key) {
    final r = items[key];
    return r != null &&
        r.approval == ApprovalState.current &&
        r.pendingChecks == 0 &&
        r.gaps.isEmpty;
  }

  if (checklist == null) {
    problems.add(
      'No release checklist: add content/release/edition.json describing '
      'the edition.',
    );
  } else {
    // The Ten (or whichever category the edition names), in full.
    final cc = checklist.companions;
    final members = [
      for (final c in tree.companions)
        if (c.dto.memberships.any((m) => m.categoryId == cc.categoryId)) c,
    ]..sort((a, b) => a.key.compareTo(b.key));
    if (members.length != cc.size) {
      problems.add(
        'Expected ${cc.size} companions in "${cc.categoryId}", found '
        '${members.length}.',
      );
    }
    for (final c in members) {
      require(c.key);
    }
    final linkedStories = {
      for (final c in members)
        for (final id in c.dto.storyIds) 'story.$id',
    }.toList()..sort();
    for (final key in linkedStories) {
      require(key, why: 'linked from a biography: ', coverage: false);
    }

    // The Seerah: the section, its chapters and its topics.
    final sc = checklist.seerah;
    final seerah = tree.seerah;
    if (sc.chapters == 0 && sc.topics == 0) {
      // This edition has no Seerah requirement.
    } else if (seerah == null) {
      problems.add('seerah.seerah: required, but it does not exist.');
    } else {
      require(seerah.key, coverage: false);
      final s = seerah.dto;
      if (s.chapterIds.length < sc.chapters) {
        problems.add(
          'The Seerah has ${s.chapterIds.length} of ${sc.chapters} chapters.',
        );
      }
      if (s.topicIds.length < sc.topics) {
        problems.add(
          'The Seerah has ${s.topicIds.length} of ${sc.topics} topics.',
        );
      }
      for (final id in s.chapterIds) {
        require('seerahChapter.$id');
      }
      for (final id in s.topicIds) {
        require('seerahTopic.$id');
      }
    }

    // Episodes, the event archive and the visuals: counted when ready.
    final readyStories = [
      for (final s in tree.stories)
        if (ready(s.key) && s.review.coverage == Coverage.complete) s,
    ];
    if (readyStories.length < checklist.stories.count) {
      problems.add(
        '${readyStories.length} of ${checklist.stories.count} stories are '
        'complete and approved.',
      );
    }
    final readyEvents = tree.events.where((e) => ready(e.key)).length;
    if (readyEvents < checklist.events.count) {
      problems.add(
        '$readyEvents of ${checklist.events.count} events are approved.',
      );
    }
    final readyVisuals = [
      for (final v in tree.visuals)
        if (ready(v.key)) v,
    ];
    if (readyVisuals.length < checklist.visuals.count) {
      problems.add(
        '${readyVisuals.length} of ${checklist.visuals.count} visuals are '
        'approved.',
      );
    }
    for (final type in checklist.visuals.requiredTypes) {
      if (!readyVisuals.any((v) => v.dto.type == type)) {
        problems.add('No approved ${type.name} visual.');
      }
    }
  }

  // A visual whose records changed since it was approved must be reviewed
  // again too: its layout may now say something different.
  for (final v in tree.visuals.where((v) => v.isApproved)) {
    for (final dep in _visualDependencies(tree, v.dto)) {
      final r = items[dep];
      if (r != null && r.approval != ApprovalState.current) {
        problems.add('${v.key}: shows $dep, which is not currently approved.');
      }
    }
  }

  return ReadinessReport(
    contentVersion: tree.meta?.contentVersion ?? 'unknown',
    editionId: checklist?.id,
    items: items.values.toList(),
    publishedBuildErrors: [
      for (final i in published.issues.where((i) => i.severity.name == 'error'))
        '$i',
    ],
    editionProblems: problems,
  );
}

/// The records a visual's marks resolve to, as item keys.
List<String> _visualDependencies(ContentTree tree, VisualDto v) => [
  for (final id in v.eventIds) 'event.$id',
  for (final id in {...v.placeIds, ?v.placeId, ...v.steps.map((s) => s.placeId).nonNulls})
    'place.$id',
  if (v.companionId case final id?) 'companion.$id',
  if (v.type == InfographicType.relationships)
    for (final e in v.edges)
      for (final ref in [e.from, e.to])
        if (ref.companionId case final id?) 'companion.$id',
];
