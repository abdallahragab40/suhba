import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "·" next to an Arabic-Indic numeral reads as a zero ("٢١:··"), so the
/// interface separates items with the Arabic comma instead (review F06).
void main() {
  test('no middle-dot separator in Arabic strings', () {
    final arb = File('lib/core/l10n/app_ar.arb').readAsLinesSync();
    final offenders = [
      for (final (i, line) in arb.indexed)
        if (line.contains('·') && !line.trimLeft().startsWith('"description"'))
          'app_ar.arb:${i + 1}: ${line.trim()}',
    ];
    expect(offenders, isEmpty);
  });

  test('no middle-dot separator in interface code', () {
    final offenders = <String>[];
    for (final file in Directory('lib').listSync(recursive: true)) {
      final path = file.path;
      if (file is! File || !path.endsWith('.dart')) continue;
      // Generated localizations mirror the ARB; the gallery is a dev tool.
      if (path.contains('/generated/') || path.contains('/gallery/')) continue;
      for (final (i, line) in file.readAsLinesSync().indexed) {
        final code = line.trimLeft();
        if (code.startsWith('//')) continue;
        if (code.contains("'·'") || code.contains(' · ')) {
          offenders.add('$path:${i + 1}: $code');
        }
      }
    }
    expect(offenders, isEmpty);
  });
}
