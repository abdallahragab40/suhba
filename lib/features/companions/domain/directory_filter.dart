import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';

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
