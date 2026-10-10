import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Thrown when a content file is not in the bundle.
class ContentFileNotFound implements Exception {
  const ContentFileNotFound(this.path);

  final String path;

  @override
  String toString() => 'ContentFileNotFound: $path';
}

/// Reads the bundled content JSON from `assets/content/`.
class AssetContentSource {
  AssetContentSource(
    this._bundle, {
    this.root = 'assets/content',
    this.isolateThreshold = defaultIsolateThreshold,
  });

  final AssetBundle _bundle;
  final String root;

  /// Files at least this long are decoded on a background isolate so large
  /// biographies never stall a frame.
  static const defaultIsolateThreshold = 32 * 1024;

  /// The length from which a file is decoded on a background isolate; null
  /// decodes every file in place (widget tests, whose fake clock never
  /// delivers an isolate's result).
  final int? isolateThreshold;

  Future<Map<String, dynamic>> readJson(String path) async {
    final String text;
    try {
      // The repository caches parsed results; the bundle need not keep text.
      text = await _bundle.loadString('$root/$path', cache: false);
    } on FlutterError {
      throw ContentFileNotFound(path);
    }
    final threshold = isolateThreshold;
    if (threshold == null || text.length < threshold) {
      return jsonDecode(text) as Map<String, dynamic>;
    }
    return Isolate.run(() => jsonDecode(text) as Map<String, dynamic>);
  }
}
