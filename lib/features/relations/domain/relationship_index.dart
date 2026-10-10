import 'package:flutter/foundation.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

/// How the explorer groups relations.
enum RelationCategory { kinship, marriage, companionship, learning }

RelationCategory relationCategory(RelationType type) => switch (type) {
  RelationType.father ||
  RelationType.mother ||
  RelationType.child ||
  RelationType.sibling ||
  RelationType.relative => RelationCategory.kinship,
  RelationType.spouse => RelationCategory.marriage,
  RelationType.companion ||
  RelationType.brotherhood => RelationCategory.companionship,
  RelationType.teacher || RelationType.student => RelationCategory.learning,
};

/// A stable key for a person: the catalog ID, else the people ID, else the
/// displayed name.
String personKey(PersonRef p) => switch (p) {
  PersonRef(:final companionId?) => 'c:$companionId',
  PersonRef(:final personId?) => 'p:$personId',
  _ => 'n:${p.displayName.ar}',
};

/// One relation seen from its subject: [other] is [subject]'s [type]
/// (for example, the subject's child).
@immutable
class RelationEntry {
  const RelationEntry({
    required this.subject,
    required this.other,
    required this.type,
    required this.reliability,
    required this.citations,
    required this.review,
    this.note,
  });

  final PersonRef subject;
  final PersonRef other;
  final RelationType type;
  final Reliability reliability;
  final List<Citation> citations;

  /// The review state of the record that states the relation; the least
  /// reviewed one when several do.
  final ReviewInfo review;
  final LocalizedText? note;

  RelationCategory get category => relationCategory(type);
}

/// Every sourced relation in the content, from the companions' files and
/// the relationship visuals, each listed under both people.
@immutable
class RelationshipIndex {
  const RelationshipIndex({required this.entries, this.failedLoads = 0});

  /// Entries in subject order (see [buildRelationshipIndex]).
  final List<RelationEntry> entries;

  /// Companion files that could not be read; the index is then partial.
  final int failedLoads;

  bool get isComplete => failedLoads == 0;

  /// Subjects in display order, each with its entries.
  List<(PersonRef, List<RelationEntry>)> bySubject({
    RelationCategory? category,
    String? subjectKey,
  }) {
    final groups = <String, (PersonRef, List<RelationEntry>)>{};
    for (final e in entries) {
      if (category != null && e.category != category) continue;
      final key = personKey(e.subject);
      if (subjectKey != null && key != subjectKey) continue;
      groups.putIfAbsent(key, () => (e.subject, [])).$2.add(e);
    }
    return groups.values.toList();
  }
}

/// Builds the index. [genders] gives each known person's gender by
/// [personKey]; a parent's link is only reversed when the parent's gender
/// is known (father or mother). Subjects are ordered with the Prophet ﷺ
/// first, then companions by catalog order, then everyone else by name.
RelationshipIndex buildRelationshipIndex({
  required List<Companion> companions,
  required Iterable<Infographic> visuals,
  required Map<String, Gender> genders,
  int failedLoads = 0,
}) {
  final merged = <(String, String, RelationType), RelationEntry>{};

  void add(RelationEntry e) {
    final key = (personKey(e.subject), personKey(e.other), e.type);
    final prior = merged[key];
    if (prior == null) {
      merged[key] = e;
      return;
    }
    merged[key] = RelationEntry(
      subject: prior.subject,
      other: prior.other,
      type: prior.type,
      reliability: prior.reliability.index >= e.reliability.index
          ? prior.reliability
          : e.reliability,
      citations: [
        ...prior.citations,
        for (final c in e.citations)
          if (!prior.citations.contains(c)) c,
      ],
      review: prior.review.isApproved ? e.review : prior.review,
      note: prior.note ?? e.note,
    );
  }

  void both(RelationEntry e) {
    add(e);
    final inverse = _inverse(e.type, genders[personKey(e.subject)]);
    if (inverse == null) return;
    add(
      RelationEntry(
        subject: e.other,
        other: e.subject,
        type: inverse,
        reliability: e.reliability,
        citations: e.citations,
        review: e.review,
        note: e.note,
      ),
    );
  }

  for (final c in companions) {
    final self = PersonRef(displayName: c.name, companionId: c.id);
    for (final r in c.relations) {
      both(
        RelationEntry(
          subject: self,
          other: r.person,
          type: r.type,
          // A companion's relations are nasab and marriage records the
          // biography states as fact.
          reliability: Reliability.established,
          citations: r.citations,
          review: c.review,
        ),
      );
    }
  }
  for (final v in visuals) {
    if (v.data case RelationshipsData(:final edges)) {
      for (final edge in edges) {
        both(
          RelationEntry(
            subject: edge.from,
            other: edge.to,
            type: edge.type,
            reliability: edge.reliability,
            citations: edge.citations,
            review: v.review,
            note: edge.note,
          ),
        );
      }
    }
  }

  final order = {
    for (final c in companions)
      personKey(PersonRef(displayName: c.name, companionId: c.id)):
          c.order ?? 1 << 20,
  };
  int rank(PersonRef p) =>
      p.personId == prophetPersonId ? -1 : order[personKey(p)] ?? 1 << 21;
  final entries = merged.values.toList()
    ..sort((a, b) {
      final bySubject = rank(a.subject).compareTo(rank(b.subject));
      if (bySubject != 0) return bySubject;
      final byName = a.subject.displayName.ar.compareTo(
        b.subject.displayName.ar,
      );
      if (byName != 0) return byName;
      return a.type.index.compareTo(b.type.index);
    });
  return RelationshipIndex(entries: entries, failedLoads: failedLoads);
}

/// The people record of the Prophet ﷺ.
const prophetPersonId = 'muhammad';

/// The reverse relation: if B is A's [type], what A is to B. A child's
/// parent needs the parent's gender.
RelationType? _inverse(RelationType type, Gender? subjectGender) =>
    switch (type) {
      RelationType.child => switch (subjectGender) {
        Gender.male => RelationType.father,
        Gender.female => RelationType.mother,
        null => null,
      },
      RelationType.father || RelationType.mother => RelationType.child,
      RelationType.teacher => RelationType.student,
      RelationType.student => RelationType.teacher,
      RelationType.spouse ||
      RelationType.sibling ||
      RelationType.relative ||
      RelationType.brotherhood ||
      RelationType.companion => type,
    };
