// Validates content/ against the schema and the editorial rules.
//
//   dart run tool/content_validate.dart                      # draft rules
//   dart run tool/content_validate.dart --channel=published  # release rules
import 'dart:io';

import 'src/cli_args.dart';
import 'src/content/content_files.dart';
import 'src/content/schema_set.dart';
import 'src/content/validator.dart';

void main(List<String> args) {
  requireProjectRoot();
  final report = validateContent(
    ContentFiles.fromDirectory(Directory('content')),
    SchemaSet.fromFile(SchemaSet.defaultPath),
    channel: channelOption(args),
  );
  report.issues.forEach(stdout.writeln);
  if (report.issues.isNotEmpty) stdout.writeln();
  stdout.writeln(report.summary());
  if (report.hasErrors) exit(1);
}
