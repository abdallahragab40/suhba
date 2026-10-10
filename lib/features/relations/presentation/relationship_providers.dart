import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/features/relations/domain/relationship_index.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// Every sourced relation, from all companion files and the relationship
/// visuals. Companion files that fail to load are counted, not hidden, so
/// the explorer can say it is incomplete.
final relationshipIndexProvider = FutureProvider<RelationshipIndex>((
  ref,
) async {
  final repo = ref.watch(contentRepositoryProvider);
  final summaries = await ref.watch(companionIndexProvider.future);
  final visuals = await ref.watch(visualsProvider.future);
  final people = await ref.watch(peopleProvider.future);
  final loaded = await Future.wait(summaries.map((c) => repo.companion(c.id)));
  final companions = [for (final r in loaded) ?r.valueOrNull];
  return buildRelationshipIndex(
    companions: companions,
    visuals: visuals.values,
    genders: {
      for (final c in summaries)
        personKey(PersonRef(displayName: c.name, companionId: c.id)): c.gender,
      for (final p in people.values)
        personKey(PersonRef(displayName: p.name, personId: p.id)): ?p.gender,
    },
    failedLoads: loaded.length - companions.length,
  );
});
