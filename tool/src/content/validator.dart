import 'package:suhba/shared/content/domain/review.dart';

import 'content_files.dart';
import 'content_tree.dart';
import 'hadith_dataset.dart';
import 'issues.dart';
import 'rules.dart';
import 'schema_set.dart';

class ValidationReport {
  ValidationReport({
    required this.tree,
    required this.issues,
    required this.channel,
    required this.pendingByItem,
  });

  final ContentTree tree;
  final List<Issue> issues;
  final ContentChannel channel;

  /// Draft channel only: pending locators, texts and gradings per item key.
  final Map<String, int> pendingByItem;

  int get errorCount =>
      issues.where((i) => i.severity == Severity.error).length;
  int get warningCount =>
      issues.where((i) => i.severity == Severity.warning).length;
  bool get hasErrors => errorCount > 0;

  int get approvedCount => tree.allItems.where((i) => i.isApproved).length;
  int get unapprovedCount => tree.allItems.length - approvedCount;

  String summary() {
    final lines = [
      'Channel: ${channel.name}',
      'Items: ${tree.allItems.length} '
          '($approvedCount approved, $unapprovedCount not approved)',
      'Errors: $errorCount, warnings: $warningCount',
      if (pendingByItem.isNotEmpty)
        'Pending before publication (locators, quoted texts, gradings): '
            '${pendingByItem.values.fold<int>(0, (a, b) => a + b)} across '
            '${pendingByItem.length} items',
    ];
    return lines.join('\n');
  }
}

/// Validates [files] for [channel]: schema (V1) and rules V2–V14.
ValidationReport validateContent(
  ContentFiles files,
  SchemaSet schemas, {
  required ContentChannel channel,
}) {
  final sink = IssueSink();
  final tree = parseContent(files, schemas, sink);
  final pending = checkRules(tree, channel, sink);
  checkCitedHadith(files, sink);
  return ValidationReport(
    tree: tree,
    issues: sink.issues,
    channel: channel,
    pendingByItem: pending,
  );
}
