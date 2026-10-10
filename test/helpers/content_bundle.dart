import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An asset bundle over an in-memory map. Loads complete synchronously, so
/// widget tests do not wait on real I/O.
class MemoryAssetBundle extends CachingAssetBundle {
  MemoryAssetBundle(this.files);

  /// The committed draft build in assets/content/, read from disk once.
  factory MemoryAssetBundle.builtContent() => MemoryAssetBundle({
    for (final f
        in Directory('assets/content')
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.json')))
      f.path: f.readAsStringSync(),
  });

  /// The committed build with [companionId]'s written biography removed
  /// (no sections or timeline), as for a companion whose biography has not
  /// been written yet.
  factory MemoryAssetBundle.withSkeleton(String companionId) =>
      MemoryAssetBundle.builtContent()..editJson(
        'assets/content/companions/$companionId.json',
        (json) => json
          ..['sections'] = <Object>[]
          ..['timeline'] = <Object>[],
      );

  final Map<String, String> files;

  /// Edits one JSON file in place (e.g. to approve an item in a test).
  void editJson(String key, void Function(Map<String, dynamic>) edit) {
    final json = jsonDecode(files[key]!) as Map<String, dynamic>;
    edit(json);
    files[key] = jsonEncode(json);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) {
    final text = files[key];
    if (text == null) {
      return Future.error(FlutterError('Unable to load asset: $key'));
    }
    return SynchronousFuture(text);
  }

  @override
  Future<ByteData> load(String key) async {
    final text = files[key];
    if (text == null) throw FlutterError('Unable to load asset: $key');
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(text)));
  }
}
