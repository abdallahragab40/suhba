import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every image shipped in assets/images/ must have a credits entry with its
/// licence, and every entry must point at a real file.
void main() {
  final dir = Directory('assets/images');
  final register =
      jsonDecode(File('assets/images/credits.json').readAsStringSync())
          as Map<String, dynamic>;
  final entries = (register['images'] as List).cast<Map<String, dynamic>>();

  test('the register is well formed', () {
    expect(register['schemaVersion'], 1);
    for (final e in entries) {
      for (final key in ['file', 'title', 'author', 'license', 'sourceUrl']) {
        expect(e[key], isA<String>(), reason: '${e['file']}: $key');
        expect((e[key] as String).isNotEmpty, isTrue);
      }
    }
  });

  test('every image file is credited and every credit has a file', () {
    final files = {
      for (final f in dir.listSync().whereType<File>())
        if (!f.path.endsWith('credits.json')) f.uri.pathSegments.last,
    };
    final credited = {for (final e in entries) e['file'] as String};
    expect(files.difference(credited), isEmpty, reason: 'uncredited files');
    expect(credited.difference(files), isEmpty, reason: 'missing files');
  });
}
