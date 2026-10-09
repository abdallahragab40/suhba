import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/content/content_files.dart';
import '../../tool/src/content/readiness.dart';
import '../../tool/src/content/schema_set.dart';
import 'content_fixture.dart';

void main() {
  final schemas = SchemaSet.fromFile(SchemaSet.defaultPath);
  late ContentFixture fx;

  setUp(() => fx = ContentFixture());

  ReadinessReport report({int size = 1}) =>
      contentReadiness(fx.toFiles(), schemas, category: 'cat-a', size: size);

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
    expect(r.publicV1Ready, isFalse);
    expect(
      r.publicV1Problems,
      contains('companion.comp-a: not approved by a registered reviewer.'),
    );
    expect(r.publishedBuildErrors.join(), contains('V11'));
    expect(item(r, 'companion.comp-a').approval, ApprovalState.notApproved);
    expect(item(r, 'companion.comp-a').pendingChecks, greaterThan(0));
    expect(item(r, 'companion.comp-a').fullBiography, isTrue);
  });

  test('approved, complete content is ready', () {
    approveAll();
    final r = report();
    expect(r.publicV1Problems, isEmpty);
    expect(r.publishedBuildErrors, isEmpty);
    expect(r.publicV1Ready, isTrue);
    expect(item(r, 'companion.comp-a').approval, ApprovalState.current);
  });

  test('a nonempty approved subset is not the complete release', () {
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
    final r = report(size: 2);
    expect(r.publishedBuildErrors, isEmpty, reason: 'it would publish');
    expect(r.publicV1Ready, isFalse, reason: 'but it is not the release');
    expect(
      r.publicV1Problems,
      containsAll([
        'companion.comp-b: skeleton profile, not a full biography.',
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
      r.publicV1Problems,
      contains('companion.comp-a: approval is stale; review again.'),
    );
    expect(r.publicV1Ready, isFalse);
  });

  test('a story linked from the release must be approved', () {
    approveAll();
    fx.files['stories/story-a.json']!['review'] = {'status': 'draft'};
    fx.files.remove('reviews/story.story-a.json');
    expect(
      report().publicV1Problems,
      contains('story.story-a: linked from the release but not approved.'),
    );
  });

  test('the wrong number of companions in the release is reported', () {
    approveAll();
    expect(
      report(size: 10).publicV1Problems,
      contains('Expected 10 companions in "cat-a", found 1.'),
    );
  });

  test('the report is deterministic', () {
    expect(report().toMarkdown(), report().toMarkdown());
    expect(report().toJsonString(), report().toJsonString());
  });

  test('the committed content: the Ten are listed, none ready yet', () {
    final r = contentReadiness(
      ContentFiles.fromDirectory(Directory('content')),
      schemas,
    );
    final companions = r.items.where((i) => i.key.startsWith('companion.'));
    expect(companions, hasLength(10));
    expect(r.publicV1Ready, isFalse);
    expect(
      companions.where((i) => i.approval != ApprovalState.notApproved),
      isEmpty,
      reason: 'no reviewer is registered yet',
    );
  });
}
