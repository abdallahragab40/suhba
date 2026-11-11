import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/shared/content/domain/content_format.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../../tool/src/release/release_checks.dart';

void main() {
  Map<String, String> bundle({
    bool record = true,
    bool indexed = true,
    bool index = true,
    bool approved = true,
    String id = 'journey-a',
    ContentChannel channel = ContentChannel.published,
    String? indexOverride,
  }) {
    final files = <String, String>{
      if (index)
        'index/journeys.json':
            indexOverride ??
            jsonEncode({
              'schemaVersion': ContentFormat.current,
              'journeyIds': [if (indexed) 'journey-a'],
            }),
      if (record)
        'journeys/journey-a.json': jsonEncode({
          'schemaVersion': ContentFormat.current,
          'id': id,
          'review': {'status': approved ? 'approved' : 'draft'},
        }),
    };
    files['manifest.json'] = jsonEncode({
      'schemaVersion': ContentFormat.current,
      'contentVersion': 'test',
      'channel': channel.name,
      'unapprovedCount': 0,
      'files': {
        for (final entry in files.entries)
          entry.key: sha256.convert(utf8.encode(entry.value)).toString(),
      },
    });
    return files;
  }

  List<String> problems(
    Map<String, String> files, {
    ContentChannel channel = ContentChannel.published,
  }) => artifactProblems(
    bundled: files,
    channel: channel,
    contentVersion: 'test',
    requiredJourneyIds: ['journey-a'],
  );

  test(
    'required approved journey and catalog entry pass artifact verification',
    () {
      expect(problems(bundle()), isEmpty);
    },
  );
  test('a self-consistent manifest cannot omit a launch journey', () {
    expect(
      problems(bundle(record: false)),
      contains('Required journey is missing from the artifact: journey-a'),
    );
  });
  test('a journey file is insufficient if the catalog cannot reach it', () {
    expect(
      problems(bundle(indexed: false)),
      contains('Required journey is absent from the index: journey-a'),
    );
  });
  test('missing or malformed indexes fail without throwing', () {
    for (final files in [
      bundle(index: false),
      bundle(indexOverride: '{'),
      bundle(indexOverride: '[]'),
    ]) {
      expect(
        problems(files),
        contains('Required journey index is missing or malformed.'),
      );
    }
  });
  test(
    'a misleading zero unapproved count cannot hide a draft launch journey',
    () {
      expect(
        problems(bundle(approved: false)),
        contains('Required published journey is not approved: journey-a'),
      );
    },
  );
  test(
    'wrong journey identity is rejected even when its hash is consistent',
    () {
      expect(
        problems(bundle(id: 'other')),
        contains(
          'Required journey record is malformed or has the wrong id: journey-a',
        ),
      );
    },
  );
  test('draft preview journeys remain valid on the draft channel', () {
    expect(
      problems(
        bundle(approved: false, channel: ContentChannel.draft),
        channel: ContentChannel.draft,
      ),
      isEmpty,
    );
  });
}
