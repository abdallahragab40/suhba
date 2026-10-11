import 'dart:math';

import 'package:meta/meta.dart';

import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/search/domain/search_documents.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/seerah.dart';
import 'package:suhba/shared/content/domain/story.dart';

/// Everything the generator draws on.
class QuizContent {
  const QuizContent({
    required this.companions,
    required this.categories,
    required this.events,
    required this.places,
    required this.stories,
    required this.chapters,
    this.people = const {},
  });

  final List<Companion> companions;
  final List<CompanionCategory> categories;
  final List<HistoricalEvent> events;
  final Map<String, HistoricalPlace> places;

  /// Stories with their text, so a wrong answer is never someone the
  /// story mentions.
  final List<Story> stories;
  final List<SeerahChapterSummary> chapters;
  final Map<String, Person> people;
}

/// Builds rounds of questions from the content. Every question has exactly
/// one correct answer, and every answer is a fact the content states; the
/// wrong answers are drawn from the same kind of fact elsewhere, with rules
/// that keep them wrong (see each builder). Rounds differ each time: the
/// subjects, the kinds and the order of the choices are random.
class QuizGenerator {
  QuizGenerator(this.content, {Random? random}) : _random = random ?? Random();

  final QuizContent content;
  final Random _random;

  static const choiceCount = 4;

  /// Kunyas shared by many (in the content or in the sources), which could
  /// make a wrong answer right.
  static const _commonKunyas = {
    'أبو عبد الله',
    'أبو محمد',
    'أبو عبد الرحمن',
    'أم عبد الله',
    'أبو عمرو',
  };

  /// Places grouped by area, so a wrong answer is never a place inside or
  /// beside the right one (Quba is in Madinah; Hira is by Makkah).
  static const _deathAreas = {
    'المدينة': 'madinah',
    'المدينة المنورة': 'madinah',
    'العقيق': 'madinah',
    'أحد': 'madinah',
    'الجرف': 'madinah',
    'مكة': 'makkah',
    'الطائف': 'taif',
    'الكوفة': 'iraq',
    'البصرة': 'iraq',
    'وادي السباع': 'iraq',
    'المدائن': 'iraq',
    'الشام': 'sham',
    'دمشق': 'sham',
    'حمص': 'sham',
    'مؤتة': 'sham',
    'الأردن': 'sham',
    'الربذة': 'rabadhah',
    'القسطنطينية': 'constantinople',
  };

  static const _placeAreas = {
    'makkah': 'makkah',
    'ghar-hira': 'makkah',
    'ghar-thawr': 'makkah',
    'al-aqabah': 'makkah',
    'arafat': 'makkah',
    'al-hudaybiyah': 'makkah',
    'madinah': 'madinah',
    'quba': 'madinah',
    'uhud': 'madinah',
  };

  /// A round of up to [count] questions in [mode], avoiding [recent] keys
  /// while there are enough others. Kinds are mixed as evenly as the
  /// content allows.
  List<QuizQuestion> round(
    QuizMode mode, {
    int count = 10,
    Set<String> recent = const {},
  }) {
    final kinds =
        QuizKind.values
            .where((k) => mode == QuizMode.mixed || k.mode == mode)
            .toList()
          ..shuffle(_random);
    final pools = {for (final k in kinds) k: _questions(k)..shuffle(_random)};
    // Fresh questions first, then recent ones if a pool runs short.
    for (final pool in pools.values) {
      pool.sort(
        (a, b) =>
            (recent.contains(a.key) ? 1 : 0) - (recent.contains(b.key) ? 1 : 0),
      );
    }
    final round = <QuizQuestion>[];
    final used = <String>{};
    var progress = true;
    while (round.length < count && progress) {
      progress = false;
      for (final kind in kinds) {
        if (round.length == count) break;
        final pool = pools[kind]!;
        while (pool.isNotEmpty) {
          final q = pool.removeAt(0);
          if (used.add(q.key)) {
            round.add(q);
            progress = true;
            break;
          }
        }
      }
    }
    return round..shuffle(_random);
  }

  /// Every question of [kind] the content supports (each built once).
  @visibleForTesting
  List<QuizQuestion> questionsOf(QuizKind kind) => _questions(kind);

  List<QuizQuestion> _questions(QuizKind kind) => switch (kind) {
    QuizKind.companionByKunya => _byKunya(),
    QuizKind.kunyaOfCompanion => _kunyaOf(),
    QuizKind.companionByTitle => _byTitle(),
    QuizKind.deathPlace => _deathPlace(),
    QuizKind.memberOfCategory => _memberOf(),
    QuizKind.fatherOf => _parentOf(RelationType.father),
    QuizKind.motherOf => _parentOf(RelationType.mother),
    QuizKind.companionInStory => _inStory(),
    QuizKind.eventYear => _eventYear(),
    QuizKind.earliestEvent => _earliestEvent(),
    QuizKind.eventPlace => _eventPlace(),
    QuizKind.eventAtPlace => _eventAtPlace(),
    QuizKind.earliestChapter => _earliestChapter(),
  };

  // ── Companions ─────────────────────────────────────────────────────────

  /// Kunyas held by one companion only, not common ones, and not part of
  /// the name already (أبو بكر, أبو هريرة).
  Iterable<Companion> get _distinctKunyas {
    final counts = <String, int>{};
    for (final c in content.companions) {
      final k = c.kunya?.ar;
      if (k != null) counts[k] = (counts[k] ?? 0) + 1;
    }
    return content.companions.where((c) {
      final k = c.kunya?.ar;
      return k != null &&
          counts[k] == 1 &&
          !_commonKunyas.contains(k) &&
          !c.name.ar.contains(k);
    });
  }

  List<QuizQuestion> _byKunya() => [
    for (final c in _distinctKunyas)
      ?_build(
        key: 'kunya:${c.id}',
        kind: QuizKind.companionByKunya,
        subject: c.kunya,
        subjectGender: c.gender,
        correct: TextChoice(c.name),
        wrong: [
          for (final o in content.companions)
            if (o.id != c.id &&
                o.gender == c.gender &&
                o.kunya != null &&
                o.kunya != c.kunya)
              TextChoice(o.name),
        ],
        explanation: c.summary,
        route: _companionRoute(c.id),
      ),
  ];

  List<QuizQuestion> _kunyaOf() => [
    for (final c in _distinctKunyas)
      ?_build(
        key: 'kunya-of:${c.id}',
        kind: QuizKind.kunyaOfCompanion,
        subject: c.name,
        subjectGender: c.gender,
        correct: TextChoice(c.kunya!),
        wrong: [
          for (final o in _distinctKunyas)
            if (o.id != c.id && o.gender == c.gender) TextChoice(o.kunya!),
        ],
        explanation: c.summary,
        route: _companionRoute(c.id),
      ),
  ];

  List<QuizQuestion> _byTitle() {
    final holders = <String, int>{};
    for (final c in content.companions) {
      for (final t in c.titles) {
        holders[t.ar] = (holders[t.ar] ?? 0) + 1;
      }
    }
    bool overlaps(String a, String b) => a.contains(b) || b.contains(a);
    return [
      for (final c in content.companions)
        for (final t in c.titles)
          // One holder, short, not a family tie ("عم رسول الله ﷺ"), and
          // not carrying the name itself ("طلحة الخير").
          if (holders[t.ar] == 1 &&
              t.ar.split(' ').length <= 4 &&
              !t.ar.startsWith('عم ') &&
              !t.ar.contains(c.name.ar.split(' ').first))
            ?_build(
              key: 'title:${c.id}:${t.ar}',
              kind: QuizKind.companionByTitle,
              subject: t,
              subjectGender: c.gender,
              correct: TextChoice(c.name),
              wrong: [
                for (final o in content.companions)
                  if (o.id != c.id &&
                      !o.titles.any((ot) => overlaps(ot.ar, t.ar)))
                    TextChoice(o.name),
              ],
              explanation: c.summary,
              route: _companionRoute(c.id),
            ),
    ];
  }

  /// The place as the content names it, before any qualifier ("دمشق، على
  /// أشهر الأقوال" is not used: it is hedged).
  static String? _deathPlaceName(Companion c) {
    final place = c.deathPlace?.ar;
    if (place == null || place.contains('قيل') || place.contains('أشهر')) {
      return null;
    }
    final name = place.split('،').first.trim();
    return _deathAreas.containsKey(name) ? name : null;
  }

  List<QuizQuestion> _deathPlace() {
    final named = {for (final c in content.companions) c: ?_deathPlaceName(c)};
    return [
      for (final MapEntry(key: c, value: place) in named.entries)
        ?_build(
          key: 'death-place:${c.id}',
          kind: QuizKind.deathPlace,
          subject: c.name,
          subjectGender: c.gender,
          correct: TextChoice(LocalizedText(ar: place)),
          wrong: [
            for (final p in {...named.values})
              if (_deathAreas[p] != _deathAreas[place])
                TextChoice(LocalizedText(ar: p)),
          ],
          explanation: c.summary,
          route: _companionRoute(c.id),
        ),
    ];
  }

  /// Only categories checked against every companion ([complete]), so a
  /// non-member is certainly not one; disputed members are never used.
  List<QuizQuestion> _memberOf() => [
    for (final cat in content.categories)
      if (cat.complete)
        for (final c in content.companions)
          if (c.memberships.any((m) => m.categoryId == cat.id) &&
              !cat.contested.contains(c.id))
            ?_build(
              key: 'member:${cat.id}:${c.id}',
              kind: QuizKind.memberOfCategory,
              subject: cat.name,
              correct: TextChoice(c.name),
              wrong: [
                for (final o in content.companions)
                  if (!o.memberships.any((m) => m.categoryId == cat.id) &&
                      !cat.contested.contains(o.id))
                    TextChoice(o.name),
              ],
              explanation: cat.description ?? c.summary,
              route: _companionRoute(c.id),
            ),
  ];

  List<QuizQuestion> _parentOf(RelationType type) {
    final gender = type == RelationType.father ? Gender.male : Gender.female;
    // Everyone of that gender the content names, except the Prophet ﷺ,
    // who is never offered as a wrong answer.
    final pool = <String, LocalizedText>{
      for (final c in content.companions)
        if (c.gender == gender) 'c:${c.id}': c.name,
      for (final p in content.people.values)
        if (p.gender == gender && p.id != 'muhammad') 'p:${p.id}': p.name,
    };
    return [
      for (final c in content.companions)
        for (final r in c.relations)
          if (r.type == type)
            ?_build(
              key: '${type.name}:${c.id}',
              kind: type == RelationType.father
                  ? QuizKind.fatherOf
                  : QuizKind.motherOf,
              subject: c.name,
              subjectGender: c.gender,
              correct: TextChoice(_withHonorific(r.person)),
              wrong: [
                for (final MapEntry(:key, :value) in pool.entries)
                  if (key != 'c:${c.id}' &&
                      key != 'c:${r.person.companionId}' &&
                      key != 'p:${r.person.personId}' &&
                      value != r.person.displayName)
                    TextChoice(value),
              ],
              explanation: c.summary,
              route: _companionRoute(c.id),
            ),
    ];
  }

  List<QuizQuestion> _inStory() {
    String textOf(Story s) => [
      s.title.ar,
      s.synopsis.ar,
      for (final ch in s.chapters) ...searchableText(ch.blocks),
    ].join(' ');
    bool mentioned(Companion c, String text) =>
        [c.name.ar, ...c.aliases].any((n) => n.isNotEmpty && text.contains(n));
    final byId = {for (final c in content.companions) c.id: c};
    return [
      for (final s in content.stories)
        for (final id in s.companionIds)
          if (byId[id] case final c?)
            ?_build(
              key: 'story:${s.id}:$id',
              kind: QuizKind.companionInStory,
              subject: s.title,
              correct: TextChoice(c.name),
              wrong: [
                for (final o in content.companions)
                  if (!s.companionIds.contains(o.id) &&
                      !mentioned(o, textOf(s)))
                    TextChoice(o.name),
              ],
              explanation: s.synopsis,
              route: '/stories/${s.id}',
            ),
    ];
  }

  // ── The Seerah ─────────────────────────────────────────────────────────

  /// The event's year alone, when the content records it as a year or a
  /// month (not approximate, a range or unknown).
  static HistoricalDate? _yearOf(HistoricalEvent e) {
    final d = e.date;
    if (d.hijriYear == null ||
        !(d.precision == DatePrecision.year ||
            d.precision == DatePrecision.month ||
            d.precision == DatePrecision.exact)) {
      return null;
    }
    return HistoricalDate(
      precision: DatePrecision.year,
      era: d.era,
      hijriYear: d.hijriYear,
    );
  }

  List<QuizQuestion> _eventYear() {
    final dated = {for (final e in content.events) e: ?_yearOf(e)};
    return [
      for (final MapEntry(key: e, value: year) in dated.entries)
        ?_build(
          key: 'event-year:${e.id}',
          kind: QuizKind.eventYear,
          subject: e.name,
          correct: DateChoice(year),
          wrong: [
            for (final y in {...dated.values})
              if (y != year) DateChoice(y),
          ],
          explanation: e.summary,
          route: '/events/${e.id}',
        ),
    ];
  }

  /// Four events a whole year or more apart; the first is the answer.
  List<QuizQuestion> _earliestEvent() {
    final dated = [
      for (final e in content.events)
        if (e.date.precision != DatePrecision.unknown &&
            e.date.precision != DatePrecision.range &&
            e.date.sortKey != null)
          e,
    ];
    final questions = <QuizQuestion>[];
    for (var attempt = 0; attempt < 12; attempt++) {
      final pick = <HistoricalEvent>[];
      for (final e in [...dated]..shuffle(_random)) {
        final year = e.date.sortKey!.floor();
        if (pick.every((p) => (p.date.sortKey!.floor() - year).abs() >= 1)) {
          pick.add(e);
        }
        if (pick.length == choiceCount) break;
      }
      if (pick.length < choiceCount) break;
      pick.sort((a, b) => a.date.compareTo(b.date));
      final first = pick.first;
      questions.add(
        _ordered(
          key:
              'first-event:${(pick.map((e) => e.id).toList()..sort()).join(',')}',
          kind: QuizKind.earliestEvent,
          items: [for (final e in pick) TextChoice(e.name)],
          explanation: first.summary,
          route: '/events/${first.id}',
        ),
      );
    }
    return questions;
  }

  String _areaOf(String placeId) => _placeAreas[placeId] ?? placeId;

  List<QuizQuestion> _eventPlace() => [
    for (final e in content.events)
      if (e.placeIds.length == 1 && content.places[e.placeIds.single] != null)
        ?_build(
          key: 'event-place:${e.id}',
          kind: QuizKind.eventPlace,
          subject: e.name,
          correct: TextChoice(content.places[e.placeIds.single]!.name),
          wrong: [
            for (final p in content.places.values)
              if (_areaOf(p.id) != _areaOf(e.placeIds.single))
                TextChoice(p.name),
          ],
          explanation: e.summary,
          route: '/events/${e.id}',
        ),
  ];

  List<QuizQuestion> _eventAtPlace() {
    final single = [
      for (final e in content.events)
        if (e.placeIds.length == 1) e,
    ];
    return [
      for (final e in single)
        if (content.places[e.placeIds.single] case final place?)
          ?_build(
            key: 'event-at:${place.id}:${e.id}',
            kind: QuizKind.eventAtPlace,
            subject: place.name,
            correct: TextChoice(e.name),
            wrong: [
              for (final o in content.events)
                if (o.placeIds.isNotEmpty &&
                    o.placeIds.every((p) => _areaOf(p) != _areaOf(place.id)))
                  TextChoice(o.name),
            ],
            explanation: e.summary,
            route: '/places/${place.id}',
          ),
    ];
  }

  List<QuizQuestion> _earliestChapter() {
    final chapters = [...content.chapters];
    if (chapters.length < choiceCount) return const [];
    return [
      for (var attempt = 0; attempt < 8; attempt++)
        () {
          final pick =
              ([...chapters]..shuffle(_random)).take(choiceCount).toList()
                ..sort((a, b) => a.number.compareTo(b.number));
          return _ordered(
            key:
                'first-chapter:${(pick.map((c) => c.id).toList()..sort()).join(',')}',
            kind: QuizKind.earliestChapter,
            items: [for (final c in pick) TextChoice(c.title)],
            explanation: pick.first.abstract,
            route: '/seerah/chapters/${pick.first.id}',
          );
        }(),
    ];
  }

  // ── Assembly ───────────────────────────────────────────────────────────

  String _companionRoute(String id) => '/companions/$id';

  /// The Prophet's name with ﷺ, as everywhere in the app.
  static LocalizedText _withHonorific(PersonRef p) =>
      p.personId == 'muhammad' && !p.displayName.ar.contains('ﷺ')
      ? LocalizedText(ar: '${p.displayName.ar} ﷺ')
      : p.displayName;

  /// A question with [correct] and three of [wrong] (distinct, never equal
  /// to the answer), in random order; null when there are too few.
  QuizQuestion? _build({
    required String key,
    required QuizKind kind,
    required QuizChoice correct,
    required List<QuizChoice> wrong,
    LocalizedText? subject,
    Gender? subjectGender,
    LocalizedText? explanation,
    String? route,
  }) {
    final distractors = ({...wrong}..remove(correct)).toList()
      ..shuffle(_random);
    if (distractors.length < choiceCount - 1) return null;
    final choices = [correct, ...distractors.take(choiceCount - 1)]
      ..shuffle(_random);
    return QuizQuestion(
      key: key,
      kind: kind,
      subject: subject,
      subjectGender: subjectGender,
      choices: choices,
      correct: choices.indexOf(correct),
      explanation: explanation,
      route: route,
    );
  }

  /// "Which comes first?": [items] are in order; the first is the answer.
  QuizQuestion _ordered({
    required String key,
    required QuizKind kind,
    required List<QuizChoice> items,
    LocalizedText? explanation,
    String? route,
  }) {
    final choices = [...items]..shuffle(_random);
    return QuizQuestion(
      key: key,
      kind: kind,
      choices: choices,
      correct: choices.indexOf(items.first),
      explanation: explanation,
      route: route,
    );
  }
}
