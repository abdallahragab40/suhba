import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// What a screen features is chosen in content, not in code (review F05,
/// D7): no visual ID and no Seerah chapter ID appears as a string literal
/// in `lib/`, so changing a feature never needs an app release.
void main() {
  test('no visual or Seerah chapter ID is written in lib/', () {
    final ids = <String>{
      for (final dir in ['content/visuals', 'content/seerah/chapters'])
        for (final f in Directory(dir).listSync().whereType<File>())
          if (f.path.endsWith('.json'))
            f.uri.pathSegments.last.replaceAll('.json', ''),
    };
    expect(ids, isNotEmpty);

    final literal = RegExp('''['"]([a-z0-9]+(?:-[a-z0-9]+)+)['"]''');
    final found = <String>[];
    for (final f in Directory('lib').listSync(recursive: true)) {
      if (f is! File || !f.path.endsWith('.dart')) continue;
      if (f.path.endsWith('.g.dart') || f.path.endsWith('.freezed.dart')) {
        continue;
      }
      final lines = f.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        for (final m in literal.allMatches(lines[i])) {
          if (ids.contains(m.group(1))) {
            found.add('${f.path}:${i + 1}: ${m.group(1)}');
          }
        }
      }
    }
    expect(found, isEmpty);
  });
}
