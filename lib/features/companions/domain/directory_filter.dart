import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/companion.dart';

/// The category to filter by, or null for all. A category id that does not
/// exist (e.g. from an outdated link) means all.
String? effectiveCategory(
  String? requested,
  List<CompanionCategory> categories,
) => requested != null && categories.any((c) => c.id == requested)
    ? requested
    : null;

/// [all] restricted to [categoryId], keeping their order.
List<CompanionSummary> filterCompanions(
  List<CompanionSummary> all,
  String? categoryId,
) => categoryId == null
    ? all
    : [
        for (final c in all)
          if (c.categoryIds.contains(categoryId)) c,
      ];

/// [companions] grouped under their first category in [categories] order,
/// each companion once; those in no known category come last under a null
/// key. Empty groups are left out (review F07).
List<(CompanionCategory?, List<CompanionSummary>)> groupByCategory(
  List<CompanionSummary> companions,
  List<CompanionCategory> categories,
) {
  final rank = {for (final (i, c) in categories.indexed) c.id: i};
  final groups = <int, List<CompanionSummary>>{};
  final others = <CompanionSummary>[];
  for (final c in companions) {
    final ranks = [for (final id in c.categoryIds) ?rank[id]];
    if (ranks.isEmpty) {
      others.add(c);
    } else {
      final first = ranks.reduce((a, b) => a < b ? a : b);
      (groups[first] ??= []).add(c);
    }
  }
  return [
    for (final (i, cat) in categories.indexed)
      if (groups[i] case final members?) (cat, members),
    if (others.isNotEmpty) (null, others),
  ];
}
