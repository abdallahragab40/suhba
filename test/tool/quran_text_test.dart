import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

import '../../tool/src/content/builder.dart';
import '../../tool/src/content/content_files.dart';
import '../../tool/src/content/quran_text.dart';
import '../../tool/src/content/schema_set.dart';
import 'content_fixture.dart';

/// O3: the Qur'an text is the pinned Tanzil file, verbatim.
void main() {
  final contents = File('content/$quranTextPath').readAsStringSync();
  final quran = QuranText.parse(contents);

  test('the pinned file: every ayah, and its notice', () {
    expect(quran.ayahs, hasLength(6236));
    expect(quran.notice, contains('Tanzil Project'));
    expect(quran.notice, contains('CHANGING IT IS NOT ALLOWED'));
    expect(quran.notice, isNot(contains('#')));
  });

  test('any changed byte is refused', () {
    // One tatweel added to the first ayah.
    final changed = contents.replaceFirst('1|1|', '1|1|\u0640');
    expect(changed, isNot(contents));
    expect(() => QuranText.parse(changed), throwsFormatException);
    expect(() => QuranText.parse('$contents\n'), throwsFormatException);
  });

  test('the basmala is split off the first ayah of every surah but two', () {
    for (var surah = 2; surah <= 114; surah++) {
      final first = quran.ayah(surah, 1);
      final basmala = quran.basmalaOf(surah);
      if (surah == 9) {
        expect(basmala, isNull);
        expect(first, quran.ayahs['9:1']);
        continue;
      }
      expect(
        quran.ayahs['$surah:1'],
        '$basmala $first',
        reason: 'only the prefix is removed, nothing else',
      );
    }
    // Written with a shadda on the bā' in two surahs; kept as written.
    expect(quran.basmalaOf(95), isNot(quran.ayahs['1:1']));
    expect(quran.basmalaOf(96), quran.ayahs['1:1']);
    expect(quran.basmalaOf(1), isNull, reason: 'it is al-Fatihah\'s 1:1');
    expect(quran.ayah(1, 1), quran.ayahs['1:1']);
    expect(() => quran.ayah(1, 8), throwsRangeError);
  });

  test('the build ships the quoted ayahs only, verbatim', () {
    final fx = ContentFixture();
    final files = fx.toFiles();
    final result = buildContent(
      ContentFiles(files.files, quranText: contents),
      SchemaSet.fromFile(SchemaSet.defaultPath),
      channel: ContentChannel.draft,
    );
    final json =
        jsonDecode(result.outputs['quran.json']!) as Map<String, dynamic>;
    expect(json['ayahs'], {'9:40': quran.ayahs['9:40']});
    expect(json['basmalas'], isEmpty, reason: '9:40 opens no surah');
    final source = json['source'] as Map<String, dynamic>;
    expect(source['url'], 'https://tanzil.net');
    expect(source['notice'], quran.notice);
    final manifest =
        jsonDecode(result.outputs['manifest.json']!) as Map<String, dynamic>;
    expect(
      manifest['files'],
      contains('quran.json'),
      reason: 'hashed with the other bundled files',
    );

    // Without the text (as in fixtures), no file: the app falls back to
    // the reference.
    final without = buildContent(
      files,
      SchemaSet.fromFile(SchemaSet.defaultPath),
      channel: ContentChannel.draft,
    );
    expect(without.outputs.keys, isNot(contains('quran.json')));
  });
}
