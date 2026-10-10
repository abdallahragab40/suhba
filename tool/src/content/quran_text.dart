import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Where the verified Qur'an text lives, relative to the content directory.
const quranTextPath = 'quran/quran-uthmani.txt';

/// SHA-256 of the pinned Tanzil file (Uthmani, version 1.1, downloaded on
/// 2026-10-10). The licence forbids changing the text, so the build refuses
/// any other bytes; updating to a newer Tanzil release means replacing the
/// file verbatim and this hash together.
const quranTextSha256 =
    '7f30c647331a61100ebf24a80507dc0fcdd9f2df97f1312b5b2dfcb982a7f326';

const quranTextSourceName = 'Tanzil Quran Text (Uthmani, Version 1.1)';
const quranTextSourceUrl = 'https://tanzil.net';

/// The Tanzil text: every ayah by `surah:ayah`, and its copyright notice.
///
/// In Tanzil's files the first ayah of every surah but al-Fatihah and
/// at-Tawbah begins with the basmala. The basmala is not counted as part of
/// that ayah, so it is split off here, unchanged, and shown on its own line
/// above an opening ayah. No other character is altered.
class QuranText {
  QuranText._(this.ayahs, this.notice);

  /// Parses [contents], the verbatim Tanzil file. Throws [FormatException]
  /// if the bytes are not the pinned file or the file is malformed.
  factory QuranText.parse(String contents) {
    final hash = sha256.convert(utf8.encode(contents)).toString();
    if (hash != quranTextSha256) {
      throw FormatException(
        '$quranTextPath is not the pinned Tanzil text (sha256 $hash). The '
        'licence does not allow changes; replace it with the verbatim '
        'download and update quranTextSha256.',
      );
    }
    final ayahs = <String, String>{};
    final notice = <String>[];
    for (final line in const LineSplitter().convert(contents)) {
      if (line.startsWith('#')) {
        notice.add(line);
        continue;
      }
      if (line.trim().isEmpty) continue;
      final parts = line.split('|');
      if (parts.length != 3) throw FormatException('Malformed line: $line');
      ayahs['${int.parse(parts[0])}:${int.parse(parts[1])}'] = parts[2];
    }
    if (ayahs.length != 6236) {
      throw FormatException('Expected 6236 ayahs, found ${ayahs.length}.');
    }
    // The copyright block as text: comment marks and the framing rules
    // removed, paragraphs kept.
    final block = [
      for (final l in notice)
        if (!RegExp(r'^#\s*=+\s*$').hasMatch(l)) l.substring(1).trim(),
    ].join('\n').replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
    return QuranText._(ayahs, block);
  }

  /// Ayah text by `surah:ayah`, exactly as in the file.
  final Map<String, String> ayahs;

  /// Tanzil's copyright notice, to be reproduced with any derived file.
  final String notice;

  /// The basmala as written at the head of [surah] (null for al-Fatihah,
  /// whose first ayah it is, and at-Tawbah, which has none). Tanzil marks
  /// it slightly differently in a few surahs (a shadda on the bā' in 95 and
  /// 97), so each surah keeps its own.
  String? basmalaOf(int surah) {
    if (surah == 1 || surah == 9) return null;
    final text = ayahs['$surah:1'];
    if (text == null) throw RangeError('No surah $surah');
    final words = text.split(' ');
    final head = words.take(4).join(' ');
    if (words.length < 5 || _bare(head) != _bare(ayahs['1:1']!)) {
      throw FormatException('Ayah $surah:1 does not begin with the basmala.');
    }
    return head;
  }

  /// The text of one ayah, without the basmala that Tanzil prefixes to the
  /// first ayah of a surah.
  String ayah(int surah, int ayah) {
    final text = ayahs['$surah:$ayah'];
    if (text == null) throw RangeError('No ayah $surah:$ayah');
    if (ayah != 1) return text;
    final basmala = basmalaOf(surah);
    return basmala == null ? text : text.substring(basmala.length + 1);
  }

  /// Letters only: harakat, shadda, sukun, dagger alif and tatweel removed.
  static String _bare(String s) =>
      s.replaceAll(RegExp('[\u064B-\u0652\u0670\u0640]'), '');
}
