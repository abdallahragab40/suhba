import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/content/content_files.dart';
import '../../tool/src/content/hadith_dataset.dart';
import '../../tool/src/content/issues.dart';

/// O6: hadith locators and quoted wording are checked against the pinned
/// open dataset (V14).
void main() {
  Map<String, dynamic> entry(int n, String text, {Object? arabic}) => {
    'hadithnumber': n,
    'arabicnumber': ?arabic,
    'text': text,
  };

  test('Muslim is cited by Abd al-Baqi\'s number, narrations together', () {
    expect(
      HadithDataset.numberOf('muslim', entry(6359, 'x', arabic: '2473.01')),
      '2473',
    );
    expect(
      HadithDataset.numberOf('muslim', entry(6360, 'x', arabic: 2515)),
      '2515',
    );
    expect(HadithDataset.numberOf('muslim', entry(1, 'x')), isNull);
    // A documented gap in the dataset, numbered from its neighbours.
    expect(HadithDataset.numberOf('muslim', entry(7017, 'x')), '2769');
    expect(HadithDataset.numberOf('bukhari', entry(3905, 'x')), '3905');

    final file =
        jsonDecode(
              citedHadithFile(
                {
                  'muslim': [
                    entry(6359, 'الأولى', arabic: '2473.01'),
                    entry(6360, 'الثانية', arabic: '2473.02'),
                    entry(6361, 'غيرها', arabic: '2474'),
                  ],
                },
                {
                  'muslim': {'2473'},
                },
              ),
            )
            as Map<String, dynamic>;
    expect(file['hadiths'], {
      'muslim': {
        '2473': ['الأولى', 'الثانية'],
      },
    });
    expect((file['dataset'] as Map)['commit'], HadithDataset.commit);
  });

  ContentFiles files(Map<String, Object> content, {required Object cited}) =>
      ContentFiles({
        for (final MapEntry(:key, :value) in content.entries)
          key: jsonEncode(value),
      }, citedHadith: jsonEncode({'hadiths': cited}));

  Map<String, Object> quote(String text, String number) => {
    'blocks': [
      {
        'type': 'hadithQuote',
        'textStatus': 'complete',
        'text': {'ar': text},
        'citations': [
          {
            'sourceId': 'bukhari',
            'locatorStatus': 'complete',
            'hadithNumber': number,
          },
        ],
      },
    ],
  };

  List<Issue> check(ContentFiles f) {
    final sink = IssueSink();
    checkCitedHadith(f, sink);
    return sink.issues;
  }

  final cited = {
    'bukhari': {
      '1': ['حدثنا الحميدي ... إنما الأعمال بالنيات'],
    },
  };

  test('a quote found verbatim in its hadith passes', () {
    expect(
      check(
        files({'a.json': quote('إنما الأعمال بالنيات', '1')}, cited: cited),
      ),
      isEmpty,
    );
  });

  test('a quote not in its hadith, or a missing number, is an error', () {
    final changed = check(
      files({'a.json': quote('إنما الأعمال بالنية', '1')}, cited: cited),
    );
    expect(changed.single.rule, 'V14');
    expect(changed.single.severity, Severity.error);

    final missing = check(
      files({'a.json': quote('إنما الأعمال بالنيات', '2')}, cited: cited),
    );
    // Reported once, as the missing number.
    expect(
      missing.where((i) => i.severity == Severity.error).single.message,
      contains('bukhari 2 is not in'),
    );
  });

  test('a hadith no longer cited is a warning', () {
    final issues = check(
      files({
        'a.json': {'x': 1},
      }, cited: cited),
    );
    expect(issues.single.severity, Severity.warning);
  });

  test('the committed file names the pinned dataset', () {
    final committed =
        jsonDecode(File('content/$citedHadithPath').readAsStringSync())
            as Map<String, dynamic>;
    final dataset = committed['dataset'] as Map<String, dynamic>;
    expect(dataset['commit'], HadithDataset.commit);
    expect(dataset['licence'], 'The Unlicense');
    for (final MapEntry(key: source, value: (edition, sha))
        in HadithDataset.editions.entries) {
      expect((dataset['editions'] as Map)[source], {
        'edition': edition,
        'sha256': sha,
      });
    }
  });
}
