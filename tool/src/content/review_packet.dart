import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:suhba/features/journeys/data/journey_dto.dart';
import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/shared/content/domain/review.dart';

import 'content_files.dart';
import 'content_hash.dart';
import 'content_tree.dart';
import 'issues.dart';
import 'readiness.dart';
import 'schema_set.dart';
import 'validator.dart';

const _encoder = JsonEncoder.withIndent('  ');

/// A deterministic handoff, never an approval. All paths are relative to an
/// output directory outside content/; the caller writes these files.
Map<String, String> reviewPacket(ContentFiles files, SchemaSet schemas) {
  final draft = validateContent(files, schemas, channel: ContentChannel.draft);
  if (draft.hasErrors) {
    throw StateError(
      'Fix draft validation errors before preparing a packet:\n'
      '${draft.issues.where((i) => i.severity == Severity.error).join('\n')}',
    );
  }
  final readiness = contentReadiness(files, schemas);
  final tree = draft.tree;
  final items = tree.allItems.toList()..sort((a, b) => a.key.compareTo(b.key));
  final snapshotHash = sha256
      .convert(
        utf8.encode(
          canonicalJson({
            'files': files.files,
            'quranText': files.quranText,
            'citedHadith': files.citedHadith,
          }),
        ),
      )
      .toString();
  final output = <String, String>{
    'readiness.json': '${readiness.toJsonString()}\n',
    'readiness.md': readiness.toMarkdown(),
    'editorial-checks.txt':
        '${draft.summary()}\n\n'
        '${draft.issues.join('\n')}\n',
  };
  final index = StringBuffer()
    ..writeln('# حزمة المراجعة العلمية / Scholarly review packet\n')
    ..writeln('هذه حزمة إعداد للمراجعة وليست إجازة علمية أو موافقة للنشر.\n')
    ..writeln(
      'Preparation only: automated checks do not verify that a claim '
      'matches its source, authenticate a report, or establish a grading. '
      'Every checklist starts unchecked.\n',
    )
    ..writeln('Content version: ${readiness.contentVersion}  ')
    ..writeln('Edition: ${readiness.editionId}  ')
    ..writeln('Snapshot SHA-256: `$snapshotHash`\n')
    ..writeln(
      'Registered reviewers: ${tree.reviewers.length}. '
      'Items: ${items.length}.\n',
    )
    ..writeln(
      'Read editorial-checks.txt and readiness.md first. Review each '
      'item against the actual cited edition and numbering scheme. '
      'The source records below are catalog metadata, not source scans.\n',
    )
    ..writeln(
      'Return a separate written decision identifying your real name, '
      'qualification, item key, content hash, date, checklist decisions and '
      'corrections. Do not edit generated packets in place: retain decisions '
      'separately so regeneration cannot overwrite them.\n',
    )
    ..writeln(
      'Approval templates are unsigned and deliberately incomplete. '
      'They must only be completed after a qualified reviewer explicitly '
      'approves the exact hash. Recheck hashes after any correction. '
      'Source metadata has its own hash; review linked items separately.\n',
    )
    ..writeln('## Recording an actual approval\n')
    ..writeln(
      '1. Obtain the qualified reviewer’s explicit decision for each '
      'item and hash, with all five general checks and explicit fitna '
      'sign-off where applicable. Keep that evidence separately.\n',
    )
    ..writeln(
      '2. Register their real name and stated qualification in '
      '`content/reviewers.json`: `id`, `name`, `qualification`, `addedAt` '
      '(YYYY-MM-DD). Do not register an editor or AI as a qualified '
      'specialist.\n',
    )
    ..writeln(
      '3. Recompute each approved item’s hash with '
      '`dart run tool/content_hash.dart <kind> <id>`. If it differs from '
      'the signed decision, obtain a new review of the changed item.\n',
    )
    ..writeln(
      '4. Complete only the explicitly approved templates with the '
      'registered reviewer ID, actual approval date and attested checks. '
      'Copy those records to `content/reviews/<kind>.<id>.json` and set '
      'those items’ `review.status` to `approved`. The review block is '
      'excluded from item hashes. Never bulk-check boxes from silence.\n',
    )
    ..writeln(
      '5. Run `dart run tool/content_validate.dart --channel=published` '
      'and `dart run tool/content_readiness.dart --require-edition`. '
      'All linked dependencies and the edition requirements must pass '
      'before a public build.\n',
    )
    ..writeln('## Items\n')
    ..writeln('| Item | Flags | Pending checks |\n|---|---|---|');
  final journeyReadings = <Map<String, Object>>[];
  for (final item in items) {
    final state = readiness.items.singleWhere((r) => r.key == item.key);
    final sources = <String>{};
    final text = <(String, String)>[];
    void walk(Object? node, String path, {bool includeText = true}) {
      if (node is Map) {
        if (node['sourceId'] case final String id) sources.add(id);
        if (includeText && node['ar'] is String) {
          text.add(('$path.ar', node['ar'] as String));
        }
        if (node['references'] case final List<dynamic> refs) {
          sources.addAll(refs.cast<String>());
        }
        for (final key in node.keys) {
          walk(node[key], '$path.$key', includeText: includeText);
        }
      } else if (node is List) {
        for (var i = 0; i < node.length; i++) {
          walk(node[i], '$path[$i]', includeText: includeText);
        }
      }
    }

    walk(item.raw, r'$');
    final flags = item.review.editorialFlags.map((f) => f.name).join(', ');
    final hash = contentHash(item.raw);
    final b = StringBuffer()
      ..writeln('# ${item.key}\n')
      ..writeln('**غير معتمد للنشر — UNSIGNED REVIEW MATERIAL**\n')
      ..writeln('Original: `content/${item.file}` `${item.path}`  ')
      ..writeln('Content SHA-256: `$hash`  ')
      ..writeln('Status: ${item.review.status.name}  ')
      ..writeln('Editorial flags: ${flags.isEmpty ? "none" : flags}  ')
      ..writeln('Pending automated checks: ${state.pendingChecks}\n')
      ..writeln('## Checklist / قائمة المراجعة\n')
      ..writeln('- [ ] sourcesMatch — مطابقة جميع الدعاوى لمصادرها ومواضعها')
      ..writeln('- [ ] gradingsCorrect — صحة عزو أحكام الأحاديث وألفاظها')
      ..writeln('- [ ] noEmbellishment — خلو النص من الزيادات غير المسندة')
      ..writeln('- [ ] reliabilityCorrect — مناسبة درجات الثبوت والخلاف')
      ..writeln('- [ ] honorificsCorrect — صحة الأسماء وألفاظ الترضي والتوقير')
      ..writeln('- [ ] fitnaSignOff — مراجعة صريحة لمادة الفتنة عند وجودها\n')
      ..writeln(
        'Fitna sign-off required by current flags: '
        '${item.review.editorialFlags.contains(EditorialFlag.fitnaAdjacent)}. '
        'Also flag any sensitive material missed by those flags.\n',
      )
      ..writeln('## Arabic text in content order\n');
    for (final (path, ar) in text) {
      b
        ..writeln('`$path`\n')
        ..writeln('$ar\n');
    }
    if (item.dto case final JourneyDto journey) {
      b
        ..writeln('## Ordered journey readings and separate approvals\n')
        ..writeln(
          'Journey approval does not approve these referenced items. '
          'Review their passage text, citations and gradings independently. '
          'Owner-item approval covers the full owner snapshot, not only the extracted passage. '
          'Reflection fallback is accepted; question counts are not an approval.\n',
        );
      for (final (stepIndex, step) in journey.steps.indexed) {
        b
          ..writeln('### Step ${stepIndex + 1}: ${step.title.ar}\n')
          ..writeln('Stable step ID: `${step.id}`  ')
          ..writeln(
            'Supported generated questions: ${draft.journeyQuestionCounts[step.id] ?? 0}\n',
          );
        for (final reading in step.readings) {
          final passage = _journeyPassage(tree, reading);
          final ownerHash = contentHash(passage.owner.raw);
          final passageHash = contentHash(passage.raw);
          walk(passage.raw, passage.path, includeText: false);
          journeyReadings.add({
            'journey': item.key,
            'stepId': step.id,
            'type': reading.type.name,
            'targetId': reading.targetId,
            'owner': passage.owner.key,
            'ownerPacket': 'items/${passage.owner.key}.md',
            'ownerContentHash': ownerHash,
            'passageHash': passageHash,
            'file': passage.owner.file,
            'path': passage.path,
          });
          b
            ..writeln('#### ${reading.type.name}: ${reading.targetId}\n')
            ..writeln(
              'Owner: [${passage.owner.key}](${passage.owner.key}.md)  ',
            )
            ..writeln(
              'Original passage: `content/${passage.owner.file}` `${passage.path}`  ',
            )
            ..writeln('Owner content SHA-256: `$ownerHash`  ')
            ..writeln('Extracted passage SHA-256: `$passageHash`\n');
          _jsonBlock(b, passage.raw);
        }
      }
    }
    b.writeln('## Automated findings (not scholarly verification)\n');
    final findings = draft.issues.where(
      (i) =>
          i.file == item.file &&
          (item.path.isEmpty ||
              i.path.isEmpty ||
              i.path == item.path ||
              i.path.startsWith('${item.path}.') ||
              i.path.startsWith('${item.path}[')),
    );
    for (final issue in findings) {
      b.writeln('- $issue');
    }
    if (findings.isEmpty) b.writeln('No automated findings for this item.');
    for (final gap in state.gaps) {
      b.writeln('- Edition coverage: $gap');
    }
    b.writeln(
      '\n## Full item snapshot (citations, gradings and reliability)\n',
    );
    _jsonBlock(b, item.raw);
    b.writeln('## Cited source catalog records\n');
    final sourceIds = sources.toList()..sort();
    for (final id in sourceIds) {
      final source = tree.sourceById[id]!;
      b.writeln('### $id\n\nSource SHA-256: `${contentHash(source.raw)}`\n');
      _jsonBlock(b, source.raw);
    }
    output['items/${item.key}.md'] = b.toString();
    output['templates/${item.key}.json'] =
        '${_encoder.convert({
          'schemaVersion': 1,
          'kind': item.kind.name,
          'id': item.id,
          'reviewerId': '<registered reviewer id>',
          'approvedAt': '<YYYY-MM-DD>',
          'contentHash': hash,
          'checklist': {'sourcesMatch': false, 'gradingsCorrect': false, 'noEmbellishment': false, 'reliabilityCorrect': false, 'honorificsCorrect': false, 'fitnaSignOff': false},
          'notes': '',
        })}\n';
    index.writeln(
      '| [${item.key}](items/${item.key}.md) | $flags | '
      '${state.pendingChecks} |',
    );
  }
  output['README.md'] = index.toString();
  output['manifest.json'] =
      '${_encoder.convert({
        'contentVersion': readiness.contentVersion,
        'edition': readiness.editionId,
        'snapshotHash': snapshotHash,
        'registeredReviewers': tree.reviewers.length,
        'journeyReadings': journeyReadings,
        'items': [
          for (final item in items) {'key': item.key, 'file': item.file, 'path': item.path, 'contentHash': contentHash(item.raw), 'packet': 'items/${item.key}.md', 'template': 'templates/${item.key}.json'},
        ],
      })}\n';
  return output;
}

void _jsonBlock(StringBuffer b, Object value) {
  // A longer fence prevents backticks in authored text closing the block.
  final json = _encoder.convert(value);
  var fence = '```';
  while (json.contains(fence)) {
    fence += '`';
  }
  b
    ..writeln('${fence}json')
    ..writeln(json)
    ..writeln('$fence\n');
}

({Item<Object> owner, Map<String, dynamic> raw, String path}) _journeyPassage(
  ContentTree tree,
  StepRefDto ref,
) {
  final Item<Object> owner = switch (ref.type) {
    StepRefType.companionSection => tree.companionById[ref.parentId]!,
    StepRefType.storyChapter => tree.storyById[ref.parentId]!,
    StepRefType.seerahChapter => tree.seerahChapterById[ref.targetId]!,
    StepRefType.seerahTopic => tree.seerahTopicById[ref.targetId]!,
  };
  final field = switch (ref.type) {
    StepRefType.companionSection => 'sections',
    StepRefType.storyChapter => 'chapters',
    _ => null,
  };
  if (field == null) return (owner: owner, raw: owner.raw, path: r'$');
  final children = owner.raw[field] as List<dynamic>;
  final index = children.indexWhere(
    (child) => (child as Map)['id'] == ref.targetId,
  );
  if (index < 0) throw StateError('Missing journey passage ${ref.targetId}');
  return (
    owner: owner,
    raw: children[index] as Map<String, dynamic>,
    path: '\$.$field[$index]',
  );
}
