import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../../tool/src/content/builder.dart';
import '../../tool/src/content/content_files.dart';
import '../../tool/src/content/issues.dart';
import '../../tool/src/content/schema_set.dart';
import '../../tool/src/content/validator.dart';

/// Guards the real content/ folder and the committed assets/content/.
void main() {
  final schemas = SchemaSet.fromFile(SchemaSet.defaultPath);
  final files = ContentFiles.fromDirectory(Directory('content'));

  test('content/ is valid on the draft channel', () {
    final report = validateContent(
      files,
      schemas,
      channel: ContentChannel.draft,
    );
    expect(
      report.issues.where((i) => i.severity == Severity.error),
      isEmpty,
      reason: report.issues.join('\n'),
    );
  });

  test('everything is approved by the one registered (editorial) reviewer', () {
    final report = validateContent(
      files,
      schemas,
      channel: ContentChannel.published,
    );
    // The owner's decision (2026-11-20): an editorial review, recorded as
    // such, stands in for the scholarly one there will not be.
    expect(report.tree.reviewers.map((r) => r.id), ['suhba-editorial']);
    expect(report.approvedCount, report.tree.allItems.length);
    expect(
      report.issues.where((i) => i.severity == Severity.error),
      isEmpty,
      reason: report.issues.join('\n'),
    );
  });

  test('assets/content/ is up to date with content/ (published build)', () {
    final result = buildContent(
      files,
      schemas,
      channel: ContentChannel.published,
    );
    final built = result.outputs;
    final onDisk = <String, String>{
      for (final f
          in Directory('assets/content')
              .listSync(recursive: true)
              .whereType<File>()
              .where((f) => f.path.endsWith('.json')))
        f.path.substring('assets/content/'.length): f.readAsStringSync(),
    };
    expect(
      onDisk.keys.toSet(),
      built.keys.toSet(),
      reason: 'Run: dart run tool/content_build.dart',
    );
    for (final key in built.keys) {
      expect(onDisk[key], built[key], reason: '$key is stale');
    }
  });
}
