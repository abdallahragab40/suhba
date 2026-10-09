import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The app is RTL-first, so layout code must use start/end, never left/right.
/// This scans lib/ for the physical-direction APIs that have a directional
/// equivalent.
void main() {
  final banned = <RegExp, String>{
    RegExp(r'EdgeInsets\.only\([^)]*\b(left|right)\s*:'):
        'EdgeInsetsDirectional.only(start:/end:)',
    RegExp(r'EdgeInsets\.fromLTRB\('): 'EdgeInsetsDirectional.fromSTEB',
    RegExp(
      r'\bAlignment\.(topLeft|topRight|centerLeft|centerRight|bottomLeft|bottomRight)\b',
    ): 'AlignmentDirectional',
    RegExp(r'TextAlign\.(left|right)\b'): 'TextAlign.start/end',
    RegExp(
      r'BorderRadius\.only\([^)]*\b(topLeft|topRight|bottomLeft|bottomRight)\s*:',
    ): 'BorderRadiusDirectional.only',
    RegExp(r'BorderRadius\.horizontal\('): 'BorderRadiusDirectional.horizontal',
    RegExp(r'\bPositioned\([^)]*\b(left|right)\s*:'): 'PositionedDirectional',
    RegExp(r'\bBorder\([^)]*\b(left|right)\s*:'): 'BorderDirectional',
  };

  test('lib/ uses directional layout APIs only', () {
    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .where((f) => !f.path.contains('/generated/'))
        .where((f) => !f.path.endsWith('.g.dart'))
        .where((f) => !f.path.endsWith('.freezed.dart'));

    final violations = <String>[];
    for (final file in files) {
      final source = file.readAsStringSync();
      for (final MapEntry(key: pattern, value: fix) in banned.entries) {
        for (final match in pattern.allMatches(source)) {
          final line = '\n'.allMatches(source.substring(0, match.start)).length;
          violations.add('${file.path}:${line + 1}: ${match[0]} → use $fix');
        }
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}
