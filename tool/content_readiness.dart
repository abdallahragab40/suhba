// Reports how close the content is to publication, item by item, and what
// still blocks the next public edition (content/release/edition.json).
//
//   dart run tool/content_readiness.dart                   # Markdown
//   dart run tool/content_readiness.dart --json            # JSON
//   dart run tool/content_readiness.dart --require-edition
//       # exits non-zero unless the content is the complete edition
//       # (--require-public-v1 is the old name of this flag)
//
// It never approves anything: approvals come only from a registered
// reviewer's record in content/reviews/.
import 'dart:io';

import 'src/cli_args.dart';
import 'src/content/content_files.dart';
import 'src/content/readiness.dart';
import 'src/content/schema_set.dart';

void main(List<String> args) {
  requireProjectRoot();
  final report = contentReadiness(
    ContentFiles.fromDirectory(Directory('content')),
    SchemaSet.fromFile(SchemaSet.defaultPath),
  );
  stdout.write(
    args.contains('--json')
        ? '${report.toJsonString()}\n'
        : report.toMarkdown(),
  );
  final require =
      args.contains('--require-edition') ||
      args.contains('--require-public-v1');
  if (require && !report.editionReady) {
    fail('\nThe content is not the complete edition (see above).');
  }
}
