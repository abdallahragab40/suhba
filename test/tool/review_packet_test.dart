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
}
