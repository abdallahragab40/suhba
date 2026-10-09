import 'dart:collection';
import 'dart:io';

/// The JSON files of a content directory, keyed by their path relative to
/// it with '/' separators (e.g. `companions/abu-bakr.json`). The `schema/`
/// folder is not content and is skipped.
class ContentFiles {
  ContentFiles(Map<String, String> files)
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
    return ContentFiles(files);
  }

  /// Sorted by path, so processing order (and output) is deterministic.
  final SplayTreeMap<String, String> files;
}
