// Validates content/ and writes the bundled assets to assets/content/.
//
//   dart run tool/content_build.dart                      # draft channel
//   dart run tool/content_build.dart --channel=published  # approved only
//   dart run tool/content_build.dart --check              # CI: up to date?
//
// The published channel fails while nothing is approved, which is the
// intended gate until a qualified reviewer approves content.
import 'dart:io';

import 'package:siyar_sahaba/shared/content/domain/review.dart';

import 'src/cli_args.dart';
import 'src/content/builder.dart';
import 'src/content/content_files.dart';
import 'src/content/quran_text.dart';
import 'src/content/schema_set.dart';

const outDir = 'assets/content';

void main(List<String> args) {
  requireProjectRoot();
  final channel = channelOption(args);
  final check = args.contains('--check');

  final files = ContentFiles.fromDirectory(Directory('content'));
  if (files.quranText == null) {
    fail('Missing content/$quranTextPath: the verified Qur\'an text.');
  }
  final result = buildContent(
    files,
    SchemaSet.fromFile(SchemaSet.defaultPath),
    channel: channel,
  );
  final report = result.report;
  report.issues.forEach(stdout.writeln);
  if (report.issues.isNotEmpty) stdout.writeln();
  stdout.writeln(report.summary());
  if (report.hasErrors) fail('\nBuild failed: fix the errors above.');

  final existing = <String, String>{};
  final dir = Directory(outDir);
  if (dir.existsSync()) {
    for (final f in dir.listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.json')) continue;
      existing[f.path.substring(outDir.length + 1).replaceAll(r'\', '/')] = f
          .readAsStringSync();
    }
  }

  final stale = existing.keys.where((k) => !result.outputs.containsKey(k));
  final changed = result.outputs.keys.where(
    (k) => existing[k] != result.outputs[k],
  );

  if (check) {
    if (stale.isNotEmpty || changed.isNotEmpty) {
      fail(
        '\n$outDir is out of date (run dart run tool/content_build.dart'
        '${channel == ContentChannel.draft ? '' : ' --channel=${channel.name}'}):'
        '\n${[...changed, ...stale].join('\n')}',
      );
    }
    stdout.writeln('\n$outDir is up to date (${channel.name}).');
    return;
  }

  for (final path in stale) {
    File('$outDir/$path').deleteSync();
  }
  for (final path in changed) {
    File('$outDir/$path')
      ..createSync(recursive: true)
      ..writeAsStringSync(result.outputs[path]!);
  }
  stdout.writeln(
    '\nWrote ${changed.length} and removed ${stale.length} '
    'file(s) in $outDir (${channel.name}).',
  );
}
