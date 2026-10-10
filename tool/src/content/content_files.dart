import 'dart:collection';
import 'dart:io';

import 'quran_text.dart';

/// The JSON files of a content directory, keyed by their path relative to
/// it with '/' separators (e.g. `companions/abu-bakr.json`). The `schema/`
/// folder is not content and is skipped.
///
/// [quranText] is the verbatim Tanzil file at [quranTextPath], when present.
class ContentFiles {
  ContentFiles(Map<String, String> files, {this.quranText})
    : files = SplayTreeMap<String, String>.of(files);

  factory ContentFiles.fromDirectory(Directory dir) {
    final root = dir.absolute.path;
    final files = <String, String>{};
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.json')) continue;
      final relative = entity.absolute.path
          .substring(root.length + 1)
          .replaceAll(r'\', '/');
      if (relative.startsWith('schema/')) continue;
      files[relative] = entity.readAsStringSync();
    }
    final quran = File('$root/$quranTextPath');
    return ContentFiles(
      files,
      quranText: quran.existsSync() ? quran.readAsStringSync() : null,
    );
  }

  /// Sorted by path, so processing order (and output) is deterministic.
  final SplayTreeMap<String, String> files;

  final String? quranText;
}
