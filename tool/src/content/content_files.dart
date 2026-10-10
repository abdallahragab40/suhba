import 'dart:collection';
import 'dart:io';

import 'hadith_dataset.dart';
import 'quran_text.dart';

/// The JSON files of a content directory, keyed by their path relative to
/// it with '/' separators (e.g. `companions/abu-bakr.json`). The `schema/`
/// folder is not content and is skipped.
///
/// [quranText] is the verbatim Tanzil file at [quranTextPath], and
/// [citedHadith] the cited hadith texts at [citedHadithPath], when present.
class ContentFiles {
  ContentFiles(Map<String, String> files, {this.quranText, this.citedHadith})
    : files = SplayTreeMap<String, String>.of(files);

  factory ContentFiles.fromDirectory(Directory dir) {
    final root = dir.absolute.path;
    final files = <String, String>{};
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.json')) continue;
      final relative = entity.absolute.path
          .substring(root.length + 1)
          .replaceAll(r'\', '/');
      if (relative.startsWith('schema/') || relative == citedHadithPath) {
        continue;
      }
      files[relative] = entity.readAsStringSync();
    }
    String? optional(String path) {
      final file = File('$root/$path');
      return file.existsSync() ? file.readAsStringSync() : null;
    }

    return ContentFiles(
      files,
      quranText: optional(quranTextPath),
      citedHadith: optional(citedHadithPath),
    );
  }

  /// Sorted by path, so processing order (and output) is deterministic.
  final SplayTreeMap<String, String> files;

  final String? quranText;

  final String? citedHadith;
}
