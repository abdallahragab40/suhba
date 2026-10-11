import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/features/quiz/domain/quiz_generator.dart';
import 'package:siyar_sahaba/features/quiz/domain/quiz_question.dart';
import 'package:siyar_sahaba/features/quiz/presentation/quiz_providers.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';

import '../../helpers/app_harness.dart';

/// The quiz is generated from the content, so these tests check every
/// question it can ask against the content itself: one right answer, three
/// distinct wrong ones, and the right one really right.
void main() {
  late QuizContent content;

  setUpAll(() async {
    final app = AppUnderTest();
    content = await app.container.read(quizContentProvider.future);
  });

  String text(QuizChoice c) => switch (c) {
    TextChoice(:final text) => text.ar,
    DateChoice(:final date) => '${date.era.name} ${date.hijriYear}',
  };

  Companion companionNamed(String name) =>
      content.companions.firstWhere((c) => c.name.ar == name);
  bool isCompanion(QuizChoice c) =>
      c is TextChoice && content.companions.any((o) => o.name == c.text);

  /// How many of [q]'s choices satisfy [right].
  int rightCount(QuizQuestion q, bool Function(QuizChoice) right) =>
      q.choices.where(right).length;

  test('every kind has questions, and each has exactly one right answer', () {
    final generator = QuizGenerator(content, random: Random(1));
    for (final kind in QuizKind.values) {
      final questions = generator.questionsOf(kind);
      expect(questions, isNotEmpty, reason: '$kind has no questions');
      for (final q in questions) {
        final where = '${q.key}: ${q.choices.map(text).join(' / ')}';
        expect(q.choices, hasLength(QuizGenerator.choiceCount), reason: where);
        expect(q.choices.toSet(), hasLength(q.choices.length), reason: where);
        expect(q.correct, inInclusiveRange(0, q.choices.length - 1));

        bool Function(QuizChoice) right;
        switch (kind) {
          case QuizKind.companionByKunya:
            right = (c) =>
                isCompanion(c) && companionNamed(text(c)).kunya == q.subject;
          case QuizKind.kunyaOfCompanion:
            final kunya = companionNamed(q.subject!.ar).kunya!.ar;
            right = (c) => text(c) == kunya;
          case QuizKind.companionByTitle:
            right = (c) =>
                isCompanion(c) &&
                companionNamed(text(c)).titles.any(
                  (t) =>
                      t.ar.contains(q.subject!.ar) ||
                      q.subject!.ar.contains(t.ar),
                );
          case QuizKind.deathPlace:
            final place = companionNamed(q.subject!.ar).deathPlace!.ar;
            right = (c) => place.split('،').first.trim() == text(c);
          case QuizKind.memberOfCategory:
            final category = content.categories.firstWhere(
              (c) => c.name == q.subject,
            );
            expect(category.complete, isTrue, reason: where);
            for (final c in q.choices) {
              expect(
                category.contested,
                isNot(contains(companionNamed(text(c)).id)),
                reason: '$where: a disputed member is offered',
              );
            }
            right = (c) => companionNamed(
              text(c),
            ).memberships.any((m) => m.categoryId == category.id);
          case QuizKind.fatherOf || QuizKind.motherOf:
            final type = kind == QuizKind.fatherOf
                ? RelationType.father
                : RelationType.mother;
            final parent = companionNamed(
              q.subject!.ar,
            ).relations.firstWhere((r) => r.type == type).person.displayName.ar;
            right = (c) => text(c).replaceAll(' ﷺ', '') == parent;
          case QuizKind.companionInStory:
            final story = content.stories.firstWhere(
              (s) => s.title == q.subject,
            );
            right = (c) =>
                story.companionIds.contains(companionNamed(text(c)).id);
          case QuizKind.eventYear:
            final event = content.events.firstWhere((e) => e.name == q.subject);
            right = (c) =>
                c is DateChoice &&
                c.date.era == event.date.era &&
                c.date.hijriYear == event.date.hijriYear;
          case QuizKind.earliestEvent:
            final events = [
              for (final c in q.choices)
                content.events.firstWhere((e) => e.name.ar == text(c)),
            ];
            final first =
                (events..sort((a, b) => a.date.compareTo(b.date))).first;
            right = (c) => text(c) == first.name.ar;
          case QuizKind.eventPlace:
            final event = content.events.firstWhere((e) => e.name == q.subject);
            final place = content.places[event.placeIds.single]!.name.ar;
            right = (c) => text(c) == place;
          case QuizKind.eventAtPlace:
            final place = content.places.values.firstWhere(
              (p) => p.name == q.subject,
            );
            right = (c) => content.events.any(
              (e) => e.name.ar == text(c) && e.placeIds.contains(place.id),
            );
          case QuizKind.earliestChapter:
            final first = content.chapters
                .where((ch) => q.choices.contains(TextChoice(ch.title)))
                .reduce((a, b) => a.number < b.number ? a : b);
            right = (c) => text(c) == first.title.ar;
        }
        expect(rightCount(q, right), 1, reason: where);
        expect(right(q.answer), isTrue, reason: where);
      }
    }
  });

  test('every category is used, and disputed members never appear', () {
    final generator = QuizGenerator(content, random: Random(8));
    final asked = {
      for (final q in generator.questionsOf(QuizKind.memberOfCategory))
        q.subject!.ar,
    };
    expect(asked, {for (final c in content.categories) c.name.ar});
  });

  test('wrong answers never repeat the right one in another form', () {
    final generator = QuizGenerator(content, random: Random(2));
    for (final q in generator.questionsOf(QuizKind.companionByTitle)) {
      // Zayd's title is part of Usamah's; they are never offered together.
      final names = q.choices.map(text).toSet();
      expect(
        names.containsAll({'زيد بن حارثة', 'أسامة بن زيد'}),
        isFalse,
        reason: q.key,
      );
    }
  });

  test('rounds differ, mix kinds and keep to their mode', () {
    final a = QuizGenerator(content, random: Random(3)).round(QuizMode.mixed);
    final b = QuizGenerator(content, random: Random(4)).round(QuizMode.mixed);
    expect(a, hasLength(10));
    expect(a.map((q) => q.key).toSet(), hasLength(10));
    expect(a.map((q) => q.key).toSet(), isNot(b.map((q) => q.key).toSet()));
    expect(a.map((q) => q.kind).toSet().length, greaterThanOrEqualTo(6));

    for (final mode in [QuizMode.companions, QuizMode.seerah]) {
      final round = QuizGenerator(content, random: Random(5)).round(mode);
      expect(round, hasLength(10), reason: '$mode');
      expect(round.every((q) => q.kind.mode == mode), isTrue);
    }
  });

  test('recently asked questions wait their turn', () {
    final generator = QuizGenerator(content, random: Random(6));
    final first = generator.round(QuizMode.mixed);
    final second = generator.round(
      QuizMode.mixed,
      recent: {for (final q in first) q.key},
    );
    expect(
      second.map((q) => q.key).toSet().intersection({
        for (final q in first) q.key,
      }),
      isEmpty,
    );
  });
}
