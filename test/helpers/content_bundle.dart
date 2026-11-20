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

  /// The committed build as a draft: the draft channel, and every item back
  /// in preliminary review. The shipped content is approved and published
  /// (2026-11-20); this keeps the draft paths (banners, badges, notices,
  /// no share cards) under test.
  factory MemoryAssetBundle.draftContent() {
    final bundle = MemoryAssetBundle.builtContent();
    Object? unapprove(Object? node) {
      if (node is Map<String, dynamic>) {
        final review = node['review'];
        if (review is Map<String, dynamic> && review['status'] == 'approved') {
          review['status'] = 'preliminaryReview';
        }
        node.values.forEach(unapprove);
      } else if (node is List) {
        node.forEach(unapprove);
      }
      return node;
    }

    for (final key in [...bundle.files.keys]) {
      bundle.editJson(key, (json) {
        unapprove(json);
        if (key.endsWith('/manifest.json')) {
          final total =
              (json['approvedCount'] as int) + (json['unapprovedCount'] as int);
          json
            ..['channel'] = 'draft'
            ..['approvedCount'] = 0
            ..['unapprovedCount'] = total;
        }
      });
    }
    return bundle;
  }

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
