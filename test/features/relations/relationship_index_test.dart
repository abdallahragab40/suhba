import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/features/relations/domain/relationship_index.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

const _draft = ReviewInfo(status: ReviewStatus.draft);
const _approved = ReviewInfo(status: ReviewStatus.approved);

Citation _page(String source, int page) => Citation(
  sourceId: source,
  locatorStatus: LocatorStatus.complete,
  volume: 1,
  page: '$page',
);

PersonRef _person(String id, String name) => PersonRef(
  displayName: LocalizedText(ar: name),
  personId: id,
);

Companion _companion(
  String id,
  String name, {
  int? order,
  List<Relation> relations = const [],
  ReviewInfo review = _draft,
}) => Companion(
  id: id,
  gender: Gender.male,
  name: LocalizedText(ar: name),
  fullName: LocalizedText(ar: name),
  summary: const LocalizedText(ar: ''),
  review: review,
  references: const [],
  order: order,
  relations: relations,
);

Infographic _family(List<RelationEdge> edges, {ReviewInfo review = _draft}) =>
    Infographic(
      id: 'family',
      type: InfographicType.relationships,
      title: const LocalizedText(ar: 'أسرة'),
      takeaway: const LocalizedText(ar: ''),
      review: review,
      data: InfographicData.relationships(edges: edges),
    );

void main() {
  const abuBakr = PersonRef(
    displayName: LocalizedText(ar: 'أبو بكر'),
    companionId: 'abu-bakr',
  );
  final aisha = _person('aisha', 'عائشة');
  final prophet = _person(prophetPersonId, 'محمد رسول الله');
  const genders = {'c:abu-bakr': Gender.male, 'p:aisha': Gender.female};

  test('each relation is listed under both people', () {
    final index = buildRelationshipIndex(
      companions: [
        _companion(
          'abu-bakr',
          'أبو بكر',
          relations: [
            Relation(
              type: RelationType.child,
              person: aisha,
              citations: [_page('isabah', 16)],
            ),
          ],
        ),
      ],
      visuals: const [],
      genders: genders,
    );
    final rows = {
      for (final e in index.entries)
        (personKey(e.subject), personKey(e.other)): e.type,
    };
    expect(rows, {
      ('c:abu-bakr', 'p:aisha'): RelationType.child,
      ('p:aisha', 'c:abu-bakr'): RelationType.father,
    });
  });

  test("a child's parent needs a known gender to be reversed", () {
    final index = buildRelationshipIndex(
      companions: const [],
      visuals: [
        _family([
          RelationEdge(
            from: _person('unknown', 'مجهول'),
            to: aisha,
            type: RelationType.child,
            reliability: Reliability.established,
            citations: [_page('isabah', 1)],
          ),
        ]),
      ],
      genders: genders,
    );
    expect(index.entries, hasLength(1));
    expect(index.entries.single.type, RelationType.child);
  });

  test('teacher and student, spouse and sibling reverse', () {
    final teacher = _person('t', 'شيخ');
    final student = _person('s', 'تلميذ');
    final index = buildRelationshipIndex(
      companions: const [],
      visuals: [
        _family([
          RelationEdge(
            from: student,
            to: teacher,
            type: RelationType.teacher,
            reliability: Reliability.reported,
            citations: const [],
          ),
          RelationEdge(
            from: prophet,
            to: aisha,
            type: RelationType.spouse,
            reliability: Reliability.established,
            citations: const [],
          ),
        ]),
      ],
      genders: genders,
    );
    final types = {
      for (final e in index.entries)
        (personKey(e.subject), personKey(e.other)): e.type,
    };
    expect(types[('p:s', 'p:t')], RelationType.teacher);
    expect(types[('p:t', 'p:s')], RelationType.student);
    expect(types[('p:muhammad', 'p:aisha')], RelationType.spouse);
    expect(types[('p:aisha', 'p:muhammad')], RelationType.spouse);
  });

  test('the same relation from a file and a visual is merged', () {
    final fromFile = _page('isabah', 16);
    final fromVisual = _page('bukhari', 3894);
    final index = buildRelationshipIndex(
      companions: [
        _companion(
          'abu-bakr',
          'أبو بكر',
          review: _approved,
          relations: [
            Relation(
              type: RelationType.child,
              person: aisha,
              citations: [fromFile],
            ),
          ],
        ),
      ],
      visuals: [
        _family([
          RelationEdge(
            from: abuBakr,
            to: aisha,
            type: RelationType.child,
            reliability: Reliability.reported,
            citations: [fromFile, fromVisual],
          ),
        ]),
      ],
      genders: genders,
    );
    final child = index.entries.singleWhere(
      (e) => personKey(e.subject) == 'c:abu-bakr',
    );
    expect(child.citations, [fromFile, fromVisual]);
    // The weaker grade and the least-reviewed record win.
    expect(child.reliability, Reliability.reported);
    expect(child.review.isApproved, isFalse);
  });

  test('the Prophet ﷺ first, then companions by order, then others', () {
    final index = buildRelationshipIndex(
      companions: [
        _companion(
          'umar',
          'عمر',
          order: 2,
          relations: [
            Relation(type: RelationType.child, person: _person('h', 'حفصة')),
          ],
        ),
        _companion(
          'abu-bakr',
          'أبو بكر',
          order: 1,
          relations: [Relation(type: RelationType.child, person: aisha)],
        ),
      ],
      visuals: [
        _family([
          RelationEdge(
            from: prophet,
            to: aisha,
            type: RelationType.spouse,
            reliability: Reliability.established,
            citations: const [],
          ),
        ]),
      ],
      genders: const {...genders, 'c:umar': Gender.male},
    );
    expect(
      [for (final (p, _) in index.bySubject()) personKey(p)],
      ['p:muhammad', 'c:abu-bakr', 'c:umar', 'p:h', 'p:aisha'],
    );
    expect(
      [
        for (final (p, _) in index.bySubject(
          category: RelationCategory.marriage,
        ))
          personKey(p),
      ],
      ['p:muhammad', 'p:aisha'],
    );
    expect(
      index.bySubject(subjectKey: 'p:aisha').single.$2.map((e) => e.type),
      unorderedEquals([RelationType.father, RelationType.spouse]),
    );
  });

  test('every relation type has a category', () {
    expect({
      for (final t in RelationType.values) relationCategory(t),
    }, RelationCategory.values.toSet());
  });
}
