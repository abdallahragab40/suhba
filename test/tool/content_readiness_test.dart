import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

import '../../tool/src/content/content_files.dart';
import '../../tool/src/content/readiness.dart';
import '../../tool/src/content/schema_set.dart';
import 'content_fixture.dart';

/// A checklist small enough for the fixture: comp-a in full, and (when
/// [seerah]) the one-chapter, one-topic Seerah with one map visual.
EditionDto fixtureEdition({
  int size = 1,
  int minWords = 0,
  int minTimeline = 1,
  bool seerah = false,
}) => EditionDto(
  schemaVersion: 1,
  id: 'fixture-edition',
  companions: EditionCompanionsDto(
    categoryId: 'cat-a',
    size: size,
    minWords: minWords,
    minSections: 1,
    minTimeline: minTimeline,
    requiredSectionKinds: const [SectionKind.earlyLife],
  ),
  seerah: EditionSeerahDto(
    chapters: seerah ? 1 : 0,
    topics: seerah ? 1 : 0,
    minChapterWords: 0,
    minTopicWords: 0,
  ),
  stories: const EditionCountDto(count: 0, minWords: 0),
  events: const EditionCountDto(count: 1),
  visuals: EditionVisualsDto(
    count: seerah ? 1 : 0,
    requiredTypes: seerah ? const [InfographicType.map] : const [],
  ),
);

void main() {
  final schemas = SchemaSet.fromFile(SchemaSet.defaultPath);
  late ContentFixture fx;

  setUp(() {
    fx = ContentFixture();
    (fx.companionA['review'] as Map<String, dynamic>)['coverage'] = 'complete';
  });

  ReadinessReport report({EditionDto? edition}) => contentReadiness(
    fx.toFiles(),
    schemas,
    edition: edition ?? fixtureEdition(),
  );

  void approveAll() {
    for (final id in ['quran', 'hadith-a', 'bio-a']) {
      fx.approve('source', id, fx.source(id));
    }
    fx
      ..approve(
        'category',
        'cat-a',
        fx.list('categories.json', 'categories')[0] as Map<String, dynamic>,
      )
      ..approve(
        'event',
        'event-a',
        fx.list('events.json', 'events')[0] as Map<String, dynamic>,
      )
      ..approve('companion', 'comp-a', fx.companionA)
      ..approve('story', 'story-a', fx.files['stories/story-a.json']!);
  }

  ItemReadiness item(ReadinessReport r, String key) =>
      r.items.firstWhere((i) => i.key == key);

  test('draft content is not ready, and says why', () {
    final r = report();
    expect(r.editionReady, isFalse);
    expect(
      r.editionProblems,
      contains('companion.comp-a: not approved by a registered reviewer.'),
    );
    expect(r.publishedBuildErrors.join(), contains('V11'));
    expect(item(r, 'companion.comp-a').approval, ApprovalState.notApproved);
    expect(item(r, 'companion.comp-a').pendingChecks, greaterThan(0));
    expect(item(r, 'companion.comp-a').coverage, Coverage.complete);
    expect(item(r, 'companion.comp-a').gaps, isEmpty);
  });

  test('approved, complete content is ready', () {
    approveAll();
    final r = report();
    expect(r.editionProblems, isEmpty);
    expect(r.publishedBuildErrors, isEmpty);
    expect(r.editionReady, isTrue);
    expect(item(r, 'companion.comp-a').approval, ApprovalState.current);
  });

  test('a one-paragraph biography is not a full biography', () {
    approveAll();
    final r = report(edition: fixtureEdition(minWords: 1500, minTimeline: 8));
    expect(r.editionReady, isFalse);
    expect(
      r.editionProblems,
      containsAll([
        'companion.comp-a: 8 of 1500 words.',
        'companion.comp-a: 1 of 8 timeline entries.',
      ]),
    );
  });

  test('the editor must declare a text complete; approval alone is not '
      'enough', () {
    (fx.companionA['review'] as Map<String, dynamic>)['coverage'] = 'sample';
    approveAll();
    expect(
      report().editionProblems,
      contains(
        'companion.comp-a: not declared complete by the editor '
        '(coverage: sample).',
      ),
    );
  });

  test('a nonempty approved subset is not the complete edition', () {
    approveAll();
    // comp-b joins the release category but is only a skeleton, unapproved.
    fx.files['companions/comp-b.json']!['memberships'] = [
      {
        'categoryId': 'cat-a',
        'citations': [
          {'sourceId': 'bio-a', 'locatorStatus': 'complete', 'page': '1'},
        ],
      },
    ];
    final r = report(edition: fixtureEdition(size: 2));
    expect(r.publishedBuildErrors, isEmpty, reason: 'it would publish');
    expect(r.editionReady, isFalse, reason: 'but it is not the edition');
    expect(
      r.editionProblems,
      containsAll([
        'companion.comp-b: not declared complete by the editor '
            '(coverage: none).',
        'companion.comp-b: 0 of 1 sections.',
        'companion.comp-b: no earlyLife section.',
        'companion.comp-b: not approved by a registered reviewer.',
      ]),
    );
  });

  test('editing approved content makes its approval stale', () {
    approveAll();
    fx.companionA['summary'] = {'ar': 'نص بعد المراجعة'};
    final r = report();
    expect(item(r, 'companion.comp-a').approval, ApprovalState.stale);
    expect(
      r.editionProblems,
      contains('companion.comp-a: approval is stale; review again.'),
    );
    expect(r.editionReady, isFalse);
  });

  test('a story linked from a biography must be approved', () {
    approveAll();
    fx.files['stories/story-a.json']!['review'] = {'status': 'draft'};
    fx.files.remove('reviews/story.story-a.json');
    expect(
      report().editionProblems,
      contains(
        'story.story-a: linked from a biography: not approved by a '
        'registered reviewer.',
      ),
    );
  });

  test('the wrong number of companions in the edition is reported', () {
    approveAll();
    expect(
      report(edition: fixtureEdition(size: 10)).editionProblems,
      contains('Expected 10 companions in "cat-a", found 1.'),
    );
  });

  group('the Seerah', () {
    setUp(() => fx.addSeerah());

    test('an approved, complete Seerah makes the edition ready', () {
      approveAll();
      fx.approveSeerah();
      final r = report(edition: fixtureEdition(seerah: true));
      expect(r.publishedBuildErrors, isEmpty);
      expect(r.editionProblems, isEmpty);
    });

    test('a missing chapter cannot satisfy the edition', () {
      approveAll();
      fx.approveSeerah();
      fx.files.remove('seerah/chapters/chapter-a.json');
      fx.files.remove('reviews/seerahChapter.chapter-a.json');
      final r = report(edition: fixtureEdition(seerah: true));
      expect(r.editionReady, isFalse);
      expect(
        r.editionProblems,
        contains('seerahChapter.chapter-a: required, but it does not exist.'),
      );
    });

    test('a broken visual reference cannot satisfy the edition', () {
      approveAll();
      fx.approveSeerah();
      fx.files.remove('visuals/visual-a.json');
      fx.files.remove('reviews/visual.visual-a.json');
      final r = report(edition: fixtureEdition(seerah: true));
      expect(r.editionReady, isFalse);
      expect(
        r.editionProblems.join('\n'),
        contains('Unknown visual "visual-a"'),
      );
      expect(r.editionProblems, contains('0 of 1 visuals are approved.'));
    });

    test('an approved visual whose record changed is reported', () {
      approveAll();
      fx.approveSeerah();
      final place = fx.list('places.json', 'places')[0] as Map<String, dynamic>;
      place['summary'] = {'ar': 'نص بعد المراجعة'};
      final r = report(edition: fixtureEdition(seerah: true));
      expect(
        r.editionProblems,
        contains(
          'visual.visual-a: shows place.place-a, which is not currently '
          'approved.',
        ),
      );
    });
  });

  test('the report is deterministic', () {
    expect(report().toMarkdown(), report().toMarkdown());
    expect(report().toJsonString(), report().toJsonString());
  });

  test('the committed content: every companion is listed, none ready yet', () {
    final r = contentReadiness(
      ContentFiles.fromDirectory(Directory('content')),
      schemas,
    );
    final companions = r.items.where((i) => i.key.startsWith('companion.'));
    expect(companions, hasLength(40));
    expect(r.editionId, 'expanded-edition-1');
    expect(r.editionReady, isFalse);
    expect(
      r.items.where((i) => i.approval != ApprovalState.notApproved),
      isEmpty,
      reason: 'no reviewer is registered yet',
    );
    // The first wave: the Hijrah chapter and Abu Bakr meet the checklist's
    // coverage; only review is missing.
    for (final key in [
      'companion.abu-bakr',
      'seerahChapter.hijrah-to-madinah',
    ]) {
      expect(item(r, key).coverage, Coverage.complete, reason: key);
      expect(item(r, key).gaps, isEmpty, reason: key);
    }
  });
}
