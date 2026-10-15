// Creates an unsigned review handoff; never writes content or approvals.
// dart run tool/content_review_packet.dart --output=build/content-review
import 'dart:io';

import 'src/cli_args.dart';
import 'src/content/content_files.dart';
import 'src/content/review_packet.dart';
import 'src/content/schema_set.dart';

void main(List<String> args) {
  requireProjectRoot();
  if (args.any((a) => !a.startsWith('--output='))) {
    fail(
      'Usage: dart run tool/content_review_packet.dart [--output=<new directory>]',
    );
  }
  final output = Directory(option(args, 'output') ?? 'build/content-review');
  // Never overwrite a reviewer's annotations or mix two snapshots.
  if (output.existsSync() || File(output.path).existsSync()) {
    fail(
      'Output already exists. Choose a new directory to preserve review notes.',
    );
  }
  final contentPath = Directory('content').resolveSymbolicLinksSync();
  Directory ancestor = output.absolute;
  while (!ancestor.existsSync() && ancestor.parent.path != ancestor.path) {
    ancestor = ancestor.parent;
  }
  final resolvedAncestor = ancestor.resolveSymbolicLinksSync();
  if (resolvedAncestor == contentPath ||
      resolvedAncestor.startsWith('$contentPath${Platform.pathSeparator}')) {
    fail('Review packets must be written outside content/.');
  }
  final Map<String, String> packet;
  try {
    packet = reviewPacket(
      ContentFiles.fromDirectory(Directory('content')),
      SchemaSet.fromFile(SchemaSet.defaultPath),
    );
  } on StateError catch (e) {
    fail(e.message.toString());
  }
  for (final entry in packet.entries) {
    final file = File('${output.path}/${entry.key}');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(entry.value);
  }
  stdout.writeln('Unsigned review packet: ${output.path}/README.md');
}
