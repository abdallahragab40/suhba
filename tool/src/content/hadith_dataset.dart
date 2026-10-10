import 'dart:collection';
import 'dart:convert';

import 'content_files.dart';
import 'issues.dart';

/// Where the cited hadith texts live, relative to the content directory.
const citedHadithPath = 'hadith/cited.json';

/// The open hadith dataset the locators and quoted wording are checked
/// against (O6): fawazahmed0/hadith-api, released under The Unlicense,
/// pinned to one commit. Its Arabic editions follow the common numbering:
/// al-Bukhari 1–7563 (Fath al-Bari), Muslim by Muhammad Fuad Abd al-Baqi's
/// numbers, and the usual printed numbering of al-Tirmidhi and Abu Dawud.
abstract final class HadithDataset {
  static const name = 'hadith-api';
  static const url = 'https://github.com/fawazahmed0/hadith-api';
  static const licence = 'The Unlicense';
  static const commit = 'df57907be35291c91ad6a6691180e22ca9920784';

  /// Source id → (edition, SHA-256 of `editions/<edition>.min.json`).
  static const editions = {
    'bukhari': (
      'ara-bukhari',
      'f887d8724f75fb6e1d5d29342a173af5346ad9b933173c85e6e3cb570063ea33',
    ),
    'muslim': (
      'ara-muslim',
      '2cb296f3455ff8a3da9f6a0ca3de75da675788b2fb446ad316df297838e48217',
    ),
    'tirmidhi': (
      'ara-tirmidhi',
      '22b7ffbbca9beb5d4f108cc0389a3cd16917876b3ceb32993c46e1554afd871b',
    ),
    'abu-dawud': (
      'ara-abudawud',
      '30dd3792ea65abe7fd0be8d568809d4eac04e38cbbd588b9c6055218fe43675f',
    ),
  };

  /// Muslim entries the dataset leaves without Abd al-Baqi's number, by
  /// `hadithnumber`, numbered here only where the text was read and a
  /// neighbouring narration of the same hadith carries the number.
  static const muslimNumberOverrides = {
    // Ka'b ibn Malik on Tabuk (Abu al-Tahir's chain); between 2768 and
    // 2769.04, its own continuation. 7018 duplicates it and is left out.
    7017: '2769',
    // Buraydah on the commander's instructions (Sufyan's chain); between
    // 1730.02 and 1731.03, which refers back to it. 4522 duplicates it.
    4521: '1731',
  };

  static String editionUrl(String edition) =>
      'https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@$commit/'
      'editions/$edition.min.json';

  /// The citation number of one dataset entry: Abd al-Baqi's number for
  /// Muslim (its `arabicnumber`, without the narration suffix), the
  /// `hadithnumber` otherwise. Null for entries without one.
  static String? numberOf(String sourceId, Map<String, dynamic> entry) {
    if (sourceId == 'muslim') {
      final arabic = entry['arabicnumber'];
      if (arabic == null) return muslimNumberOverrides[entry['hadithnumber']];
      return '$arabic'.split('.').first;
    }
    return '${entry['hadithnumber']}';
  }
}

/// Every (source, hadith number) cited in [files], for the dataset's
/// collections.
SplayTreeMap<String, SplayTreeSet<String>> citedHadithNumbers(
  ContentFiles files,
) {
  final cited = SplayTreeMap<String, SplayTreeSet<String>>();
  for (final contents in files.files.values) {
    _walk(jsonDecode(contents), r'$', (path, node) {
      final source = node['sourceId'];
      final number = node['hadithNumber'];
      if (HadithDataset.editions.containsKey(source) && number is String) {
        cited
            .putIfAbsent(source as String, () => SplayTreeSet(_byNumber))
            .add(number);
      }
    });
  }
  return cited;
}

/// `hadith/cited.json`: the full text of each cited hadith (every
/// narration under one number), verbatim from the pinned editions.
String citedHadithFile(
  Map<String, List<Map<String, dynamic>>> editions,
  Map<String, Set<String>> cited,
) {
  final hadiths = SplayTreeMap<String, Object>();
  for (final MapEntry(key: source, value: numbers) in cited.entries) {
    final byNumber = SplayTreeMap<String, List<String>>(_byNumber);
    for (final entry in editions[source] ?? const <Map<String, dynamic>>[]) {
      final number = HadithDataset.numberOf(source, entry);
      if (number != null && numbers.contains(number)) {
        byNumber.putIfAbsent(number, () => []).add(entry['text'] as String);
      }
    }
    hadiths[source] = byNumber;
  }
  return '${const JsonEncoder.withIndent('  ').convert({
    'dataset': {
      'name': HadithDataset.name,
      'url': HadithDataset.url,
      'licence': HadithDataset.licence,
      'commit': HadithDataset.commit,
      'editions': {
        for (final MapEntry(:key, value: (edition, sha)) in HadithDataset.editions.entries) key: {'edition': edition, 'sha256': sha},
      },
    },
    'hadiths': hadiths,
  })}\n';
}

/// V14: hadith locators and quoted wording agree with the pinned dataset.
///
/// Each cited (collection, number) must be in `hadith/cited.json`, and a
/// hadith or report quote marked complete must appear there verbatim, in
/// one of the narrations it cites. Skipped when the file is absent.
void checkCitedHadith(ContentFiles files, IssueSink sink) {
  final cited = files.citedHadith;
  if (cited == null) return;
  final hadiths =
      (jsonDecode(cited) as Map<String, dynamic>)['hadiths']
          as Map<String, dynamic>;
  List<String>? textsOf(String source, String number) =>
      ((hadiths[source] as Map<String, dynamic>?)?[number] as List?)
          ?.cast<String>();

  final used = <String>{};
  for (final MapEntry(key: file, value: contents) in files.files.entries) {
    _walk(jsonDecode(contents), r'$', (path, node) {
      final source = node['sourceId'];
      final number = node['hadithNumber'];
      if (HadithDataset.editions.containsKey(source) && number is String) {
        used.add('$source:$number');
        if (textsOf(source as String, number) == null) {
          sink.error(
            'V14',
            file,
            path,
            '$source $number is not in content/$citedHadithPath. Run: dart '
                'run tool/hadith_extract.dart',
          );
        }
      }
      final type = node['type'];
      if ((type == 'hadithQuote' || type == 'reportQuote') &&
          node['textStatus'] == 'complete') {
        final text = (node['text'] as Map<String, dynamic>?)?['ar'];
        final sources = [
          for (final c in (node['citations'] as List? ?? const []))
            if (c case {
              'sourceId': final String s,
              'hadithNumber': final String n,
            } when HadithDataset.editions.containsKey(s))
              ...?textsOf(s, n),
        ];
        if (sources.isNotEmpty &&
            text is String &&
            !sources.any((t) => t.contains(text))) {
          sink.error(
            'V14',
            file,
            path,
            'The quoted text is not found verbatim in the hadith it cites.',
          );
        }
      }
    });
  }
  for (final MapEntry(key: source, value: numbers) in hadiths.entries) {
    for (final number in (numbers as Map<String, dynamic>).keys) {
      if (!used.contains('$source:$number')) {
        sink.warning(
          'V14',
          citedHadithPath,
          '\$.hadiths.$source.$number',
          'No longer cited. Run: dart run tool/hadith_extract.dart',
        );
      }
    }
  }
}

void _walk(
  Object? node,
  String path,
  void Function(String path, Map<String, dynamic> node) visit,
) {
  switch (node) {
    case final Map<String, dynamic> map:
      visit(path, map);
      for (final MapEntry(:key, :value) in map.entries) {
        _walk(value, '$path.$key', visit);
      }
    case final List<dynamic> list:
      for (var i = 0; i < list.length; i++) {
        _walk(list[i], '$path[$i]', visit);
      }
  }
}

int _byNumber(String a, String b) {
  final byValue = (int.tryParse(a) ?? 0).compareTo(int.tryParse(b) ?? 0);
  return byValue != 0 ? byValue : a.compareTo(b);
}
