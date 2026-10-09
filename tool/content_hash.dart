// Prints the hash a reviewer records when approving an item, with an
// approval record template.
//
//   dart run tool/content_hash.dart companion abu-bakr
import 'dart:convert';
import 'dart:io';

import 'src/cli_args.dart';
import 'src/content/content_files.dart';
import 'src/content/content_hash.dart';
import 'src/content/content_tree.dart';
import 'src/content/issues.dart';
import 'src/content/schema_set.dart';

void main(List<String> args) {
  requireProjectRoot();
  if (args.length != 2) {
    fail(
      'Usage: dart run tool/content_hash.dart <kind> <id>\n'
      'kinds: companion, story, event, category, source, person',
    );
  }
  final [kind, id] = args;
  final tree = parseContent(
    ContentFiles.fromDirectory(Directory('content')),
    SchemaSet.fromFile(SchemaSet.defaultPath),
    IssueSink(),
  );
  final item = tree.allItems.where((i) => i.kind.name == kind && i.id == id);
  if (item.isEmpty) fail('No $kind "$id" (or its file does not validate).');

  final hash = contentHash(item.single.raw);
  stdout
    ..writeln(hash)
    ..writeln()
    ..writeln('Template for content/reviews/$kind.$id.json:')
    ..writeln(
      const JsonEncoder.withIndent('  ').convert({
        'schemaVersion': 1,
        'kind': kind,
        'id': id,
        'reviewerId': '<registered reviewer id>',
        'approvedAt': '<YYYY-MM-DD>',
        'contentHash': hash,
        'checklist': {
          'sourcesMatch': false,
          'gradingsCorrect': false,
          'noEmbellishment': false,
          'reliabilityCorrect': false,
          'honorificsCorrect': false,
          'fitnaSignOff': false,
        },
        'notes': '',
      }),
    );
}
