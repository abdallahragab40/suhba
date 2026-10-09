// Summarises coverage/lcov.info (from `flutter test --coverage`) without
// generated code: *.g.dart, *.freezed.dart, *.steps.dart and the generated
// localizations. Prints the total and each lib/ folder, and writes the
// Markdown to stdout so CI can append it to the run summary.
//
//   flutter test --coverage && dart run tool/coverage_summary.dart
//   dart run tool/coverage_summary.dart --min=80   # fail below 80% (only
//       once a baseline is agreed; see docs/performance.md)
import 'dart:io';

import 'src/cli_args.dart';

final _generated = RegExp(
  r'(\.g\.dart|\.freezed\.dart|\.steps\.dart)$|/l10n/generated/',
);

void main(List<String> args) {
  requireProjectRoot();
  final file = File('coverage/lcov.info');
  if (!file.existsSync()) {
    fail('No coverage/lcov.info: run flutter test --coverage first.');
  }

  final hitsByFolder = <String, (int, int)>{};
  String? current;
  var found = 0;
  var hit = 0;
  void close() {
    final path = current;
    if (path == null || _generated.hasMatch(path)) return;
    final parts = path.split('/');
    final folder = parts.length > 3 ? parts.sublist(0, 3).join('/') : path;
    final (f, h) = hitsByFolder[folder] ?? (0, 0);
    hitsByFolder[folder] = (f + found, h + hit);
  }

  for (final line in file.readAsLinesSync()) {
    if (line.startsWith('SF:')) {
      current = line.substring(3);
      found = 0;
      hit = 0;
    } else if (line.startsWith('LF:')) {
      found = int.parse(line.substring(3));
    } else if (line.startsWith('LH:')) {
      hit = int.parse(line.substring(3));
    } else if (line == 'end_of_record') {
      close();
      current = null;
    }
  }

  String pct(int h, int f) =>
      f == 0 ? '–' : '${(100 * h / f).toStringAsFixed(1)}%';
  var totalFound = 0;
  var totalHit = 0;
  final rows = hitsByFolder.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  final out = StringBuffer()
    ..writeln('## Coverage (generated code excluded)\n')
    ..writeln('| Folder | Lines | Covered |')
    ..writeln('|---|---|---|');
  for (final MapEntry(key: folder, value: (f, h)) in rows) {
    totalFound += f;
    totalHit += h;
    out.writeln('| `$folder` | $f | ${pct(h, f)} |');
  }
  out.writeln('| **Total** | $totalFound | **${pct(totalHit, totalFound)}** |');
  stdout.write(out);

  final min = args
      .where((a) => a.startsWith('--min='))
      .map((a) => double.parse(a.substring(6)))
      .firstOrNull;
  if (min != null && totalFound > 0 && 100 * totalHit / totalFound < min) {
    fail('\nCoverage is below the agreed minimum of $min%.');
  }
}
