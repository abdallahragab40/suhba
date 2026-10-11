// Gates for a public release (plan task E03). Run both in the pipeline that
// produces the public artifact:
//
//   dart run tool/release_check.dart pre
//       Final identity, published content, and the complete first release.
//   dart run tool/release_check.dart artifact <app.aab|app.apk|Runner.ipa>
//       [--channel=published|draft]
//       The content inside the built artifact: channel, version, approvals
//       and file hashes. --channel=draft checks a preview build instead.
//
// Exits non-zero, listing every problem, if anything fails.
import 'dart:convert';
import 'dart:io';

import 'package:suhba/shared/content/domain/review.dart';

import 'src/app_identity.dart';
import 'src/cli_args.dart';
import 'src/content/content_files.dart';
import 'src/content/readiness.dart';
import 'src/content/schema_set.dart';
import 'src/release/release_checks.dart';

void main(List<String> args) {
  requireProjectRoot();
  final positional = args.where((a) => !a.startsWith('--')).toList();
  switch (positional) {
    case ['pre']:
      _report(
        'Pre-build',
        preBuildProblems(
          identity: parseAppIdentity(
            File('config/app_identity.yaml').readAsStringSync(),
          ),
          readiness: contentReadiness(
            ContentFiles.fromDirectory(Directory('content')),
            SchemaSet.fromFile(SchemaSet.defaultPath),
          ),
        ),
      );
    case ['artifact', final path]:
      final channel = args.contains('--channel=draft')
          ? ContentChannel.draft
          : ContentChannel.published;
      final meta =
          jsonDecode(File('content/meta.json').readAsStringSync())
              as Map<String, dynamic>;
      _report(
        'Artifact ($path, ${channel.name})',
        artifactProblems(
          bundled: _bundledContent(path),
          channel: channel,
          contentVersion: meta['contentVersion'] as String,
        ),
      );
    default:
      fail(
        'Usage: dart run tool/release_check.dart pre\n'
        '       dart run tool/release_check.dart artifact <file> '
        '[--channel=published|draft]',
      );
  }
}

void _report(String stage, List<String> problems) {
  if (problems.isEmpty) {
    stdout.writeln('$stage: all checks passed.');
    return;
  }
  problems.forEach(stderr.writeln);
  fail('\n$stage: ${problems.length} problems; no public artifact.');
}

/// Reads the bundled content out of an APK, AAB or IPA (all zip files).
Map<String, String> _bundledContent(String archive) {
  if (!File(archive).existsSync()) fail('No such file: $archive');
  final list = Process.runSync('unzip', ['-Z1', archive]);
  if (list.exitCode != 0) fail('Cannot read $archive: ${list.stderr}');
  final files = <String, String>{};
  for (final entry in LineSplitter.split(list.stdout as String)) {
    final match = contentEntry.firstMatch(entry);
    if (match == null) continue;
    final read = Process.runSync('unzip', [
      '-p',
      archive,
      entry,
    ], stdoutEncoding: utf8);
    if (read.exitCode != 0) fail('Cannot extract $entry: ${read.stderr}');
    files[match.group(1)!] = read.stdout as String;
  }
  return files;
}
