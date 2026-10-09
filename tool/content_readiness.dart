// Reports how close the content is to publication, item by item, and what
// still blocks the first public release (the Ten in full, reviewed).
//
//   dart run tool/content_readiness.dart                   # Markdown
//   dart run tool/content_readiness.dart --json            # JSON
//   dart run tool/content_readiness.dart --require-public-v1
//       # exits non-zero unless the content is the complete public release
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
  if (args.contains('--require-public-v1') && !report.publicV1Ready) {
    fail('\nThe content is not the complete public release (see above).');
  }
}
