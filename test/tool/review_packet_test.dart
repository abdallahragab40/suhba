import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/content/content_hash.dart';
import '../../tool/src/content/review_packet.dart';
import '../../tool/src/content/schema_set.dart';
import 'content_fixture.dart';

void main() {
  final schemas = SchemaSet.fromFile(SchemaSet.defaultPath);

  test(
    'packets preserve content and bind unsigned templates to exact hashes',
    () {
      final fx = ContentFixture();
      final before = jsonEncode(fx.files);
      final files = fx.toFiles();
      final packet = reviewPacket(files, schemas);
      expect(jsonEncode(fx.files), before);
      expect(reviewPacket(files, schemas), packet);
      final manifest = jsonDecode(packet['manifest.json']!) as Map;
      expect(manifest['items'], hasLength(9));
      expect(packet.keys.any((p) => p.startsWith('reviews/')), isFalse);
      final template =
          jsonDecode(packet['templates/companion.comp-a.json']!) as Map;
      expect(template['contentHash'], contentHash(fx.companionA));
      expect((template['checklist'] as Map).values, everyElement(isFalse));
      expect(template['reviewerId'], '<registered reviewer id>');
      expect(template['approvedAt'], '<YYYY-MM-DD>');
      final item = packet['items/companion.comp-a.md']!;
      expect(item, contains('ملخص'));
      expect(item, contains('quranRef'));
      expect(item, contains('كتاب bio-a'));
      expect(item, contains(contentHash(fx.source('bio-a'))));
      expect(item, contains('pending'));
      expect(item, contains('gradingsCorrect'));
    },
  );

  test('snapshot changes for source edits while item hash stays stable', () {
    final fx = ContentFixture();
    final before = reviewPacket(fx.toFiles(), schemas);
    (fx.source('bio-a')['title'] as Map)['ar'] = 'عنوان مصحح';
    final after = reviewPacket(fx.toFiles(), schemas);
    expect(
      after['templates/companion.comp-a.json'],
      before['templates/companion.comp-a.json'],
    );
    expect(after['manifest.json'], isNot(before['manifest.json']));
    expect(after['items/companion.comp-a.md'], contains('عنوان مصحح'));
  });

  test('schema errors refuse a partial review handoff', () {
    final fx = ContentFixture();
    fx.companionA.remove('name');
    expect(() => reviewPacket(fx.toFiles(), schemas), throwsStateError);
  });

  test('fitna flag requires explicit sign-off but never checks the box', () {
    final fx = ContentFixture();
    (fx.companionA['review'] as Map)['editorialFlags'] = ['fitnaAdjacent'];
    final packet = reviewPacket(fx.toFiles(), schemas);
    expect(
      packet['items/companion.comp-a.md'],
      contains('Fitna sign-off required by current flags: true'),
    );
    final template =
        jsonDecode(packet['templates/companion.comp-a.json']!) as Map;
    expect((template['checklist'] as Map)['fitnaSignOff'], isFalse);
  });
  group('journey reviewer handoff', () {
    late ContentFixture fx;
    setUp(() {
      fx = ContentFixture()..addSeerah();
      fx.files['journeys/journey-a.json'] = {
        'schemaVersion': 1,
        'id': 'journey-a',
        'title': {'ar': 'رحلة تجريبية'},
        'description': {'ar': 'قراءات'},
        'steps': [
          {
            'id': 'journey-a.first',
            'title': {'ar': 'الخطوة الأولى'},
            'readings': [
              {
                'type': 'companionSection',
                'parentId': 'comp-a',
                'targetId': 'comp-a.early',
              },
              {
                'type': 'storyChapter',
                'parentId': 'story-a',
                'targetId': 'story-a.1',
              },
              {'type': 'seerahChapter', 'targetId': 'chapter-a'},
              {'type': 'seerahTopic', 'targetId': 'topic-a'},
            ],
            'reflection': {'ar': 'ماذا تعلمت؟'},
          },
        ],
        'review': {'status': 'draft', 'coverage': 'complete'},
      };
    });

    test(
      'all reference types include ordered passage snapshots, owner links and sources',
      () {
        final before = jsonEncode(fx.files);
        final packet = reviewPacket(fx.toFiles(), schemas);
        expect(jsonEncode(fx.files), before);
        expect(reviewPacket(fx.toFiles(), schemas), packet);
        final manifest = jsonDecode(packet['manifest.json']!) as Map;
        final readings = manifest['journeyReadings'] as List;
        expect(readings.map((r) => (r as Map)['targetId']), [
          'comp-a.early',
          'story-a.1',
          'chapter-a',
          'topic-a',
        ]);
        expect(readings.map((r) => (r as Map)['path']), [
          r'$.sections[0]',
          r'$.chapters[0]',
          r'$',
          r'$',
        ]);
        final page = packet['items/journey.journey-a.md']!;
        expect(page, contains('[companion.comp-a](companion.comp-a.md)'));
        expect(page, contains('[story.story-a](story.story-a.md)'));
        expect(
          page,
          contains('[seerahChapter.chapter-a](seerahChapter.chapter-a.md)'),
        );
        expect(page, contains('[seerahTopic.topic-a](seerahTopic.topic-a.md)'));
        expect(
          page,
          contains('Journey approval does not approve these referenced items.'),
        );
        expect(
          page,
          contains('Source SHA-256: `${contentHash(fx.source('bio-a'))}`'),
        );
        expect(page, contains('كتاب bio-a'));
        expect(page, contains('Reflection fallback is accepted'));
        expect(
          page,
          contains('Owner-item approval covers the full owner snapshot'),
        );
        final template =
            jsonDecode(packet['templates/journey.journey-a.json']!) as Map;
        expect((template['checklist'] as Map).values, everyElement(isFalse));
      },
    );

    test(
      'a passage edit updates linked hashes without silently changing journey approval scope',
      () {
        final before = reviewPacket(fx.toFiles(), schemas);
        final section = (fx.companionA['sections'] as List).first as Map;
        final blocks = section['blocks'] as List;
        final paragraph =
            blocks.firstWhere((b) => (b as Map)['type'] == 'paragraph') as Map;
        paragraph['text'] = {'ar': 'نص مصحح للمراجعة'};
        final after = reviewPacket(fx.toFiles(), schemas);
        expect(
          after['templates/journey.journey-a.json'],
          before['templates/journey.journey-a.json'],
        );
        final oldReadings =
            (jsonDecode(before['manifest.json']!) as Map)['journeyReadings']
                as List;
        final newReadings =
            (jsonDecode(after['manifest.json']!) as Map)['journeyReadings']
                as List;
        expect(
          (newReadings.first as Map)['ownerContentHash'],
          isNot((oldReadings.first as Map)['ownerContentHash']),
        );
        expect(
          (newReadings.first as Map)['passageHash'],
          isNot((oldReadings.first as Map)['passageHash']),
        );
        expect(
          after['items/journey.journey-a.md'],
          contains('نص مصحح للمراجعة'),
        );
      },
    );
  });
}
