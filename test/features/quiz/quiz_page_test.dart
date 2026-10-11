import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_home_page.dart';
import 'package:suhba/features/quiz/presentation/quiz_play_page.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/quiz/presentation/quiz_widgets.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);

  void tall(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(400, 1600);
    addTearDown(tester.view.reset);
  }

  /// The app at [location], with rounds drawn from a fixed seed; returns
  /// the app and the round it will play (the same seed, the same content).
  Future<(AppUnderTest, List<QuizQuestion>)> open(
    WidgetTester tester,
    String location, {
    QuizMode mode = QuizMode.mixed,
    MemorySettingsStore? store,
  }) async {
    final app = AppUnderTest(
      location: location,
      settings: store,
      overrides: [quizRandomProvider.overrideWithValue(Random(42))],
    );
    final content = await app.container.read(quizContentProvider.future);
    final round = QuizGenerator(content, random: Random(42)).round(mode);
    await app.pump(tester);
    return (app, round);
  }

  String label(WidgetTester tester, QuizChoice c) => quizChoiceLabel(
    DisplayFormatter.of(tester.element(find.byType(QuizPlayPage))),
    c,
  );

  Finder tile(String text) => find.widgetWithText(QuizChoiceTile, text);

  testApp('the quiz opens from Explore, then a mode starts a round', (
    tester,
  ) async {
    tall(tester);
    final (app, _) = await open(tester, '/explore');
    await tester.tap(find.text('اختبر معلوماتك'));
    await tester.pumpAndSettle();
    expect(find.byType(QuizHomePage), findsOneWidget);
    expect(app.location, '/quiz');
    await tester.tap(find.text('الصحابة'));
    await tester.pumpAndSettle();
    expect(find.byType(QuizPlayPage), findsOneWidget);
    expect(app.location, '/quiz/companions');
    expect(find.text('السؤال ١ من ١٠'), findsOneWidget);
  });

  testApp('the right answer is praised; a wrong one shows the answer', (
    tester,
  ) async {
    tall(tester);
    final (_, round) = await open(tester, '/quiz/mixed');
    final first = round.first;
    await tester.tap(tile(label(tester, first.answer)));
    await tester.pumpAndSettle();
    expect(find.text('أحسنت!'), findsOneWidget);
    expect(find.text('اقرأ المزيد'), findsOneWidget);

    await tester.tap(find.text('التالي'));
    await tester.pumpAndSettle();
    expect(find.text('السؤال ٢ من ١٠'), findsOneWidget);
    final second = round[1];
    final wrong = second.choices.firstWhere((c) => c != second.answer);
    await tester.tap(tile(label(tester, wrong)));
    await tester.pumpAndSettle();
    expect(
      find.text('الإجابة الصحيحة: ${label(tester, second.answer)}'),
      findsOneWidget,
    );
  });

  testApp('a whole round ends with the score, saved as the best', (
    tester,
  ) async {
    tall(tester);
    final store = MemorySettingsStore();
    final (_, round) = await open(tester, '/quiz/mixed', store: store);
    var expected = 0;
    for (var i = 0; i < round.length; i++) {
      // Right on even questions, wrong on odd ones.
      final q = round[i];
      final pick = i.isEven
          ? q.answer
          : q.choices.firstWhere((c) => c != q.answer);
      if (i.isEven) expected++;
      await tester.tap(tile(label(tester, pick)));
      await tester.pumpAndSettle();
      await tester.tap(find.text(i == round.length - 1 ? 'النتيجة' : 'التالي'));
      await tester.pumpAndSettle();
    }
    expect(find.bySemanticsLabel('٥ من ١٠'), findsOneWidget);
    expect(expected, 5);
    expect(find.text('بداية طيبة، والقراءة تزيدك.'), findsOneWidget);
    expect(find.text('أفضل نتيجة لك حتى الآن'), findsOneWidget);
    expect(store.getDouble(SettingsKeys.quizBest('mixed')), 5);
    expect(store.getString(SettingsKeys.quizRecent), contains(round.first.key));

    await tester.tap(find.text('راجع إجاباتك'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.cancel), findsNWidgets(5));

    await tester.tap(find.text('جولة جديدة'));
    await tester.pumpAndSettle();
    expect(find.text('السؤال ١ من ١٠'), findsOneWidget);
  });

  testApp('no overflow at text scale 2.0', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final (_, round) = await open(
      tester,
      '/quiz/seerah',
      mode: QuizMode.seerah,
    );
    expect(tester.takeException(), isNull);
    await tester.tap(tile(label(tester, round.first.answer)));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  group('goldens', () {
    Future<void> phone(WidgetTester tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(390, 844);
      addTearDown(tester.view.reset);
    }

    testApp('quiz home', (tester) async {
      await phone(tester);
      await open(tester, '/quiz');
      await expectLater(
        find.byType(QuizHomePage),
        matchesGoldenFile('goldens/quiz_home.png'),
      );
    });

    testApp('a question answered right', (tester) async {
      await phone(tester);
      final (_, round) = await open(tester, '/quiz/mixed');
      await tester.tap(tile(label(tester, round.first.answer)));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(QuizPlayPage),
        matchesGoldenFile('goldens/quiz_answered.png'),
      );
    });

    testApp('the result', (tester) async {
      await phone(tester);
      final (_, round) = await open(tester, '/quiz/mixed');
      for (var i = 0; i < round.length; i++) {
        final q = round[i];
        await tester.tap(
          tile(
            label(tester, i < 8 ? q.answer : q.choices[(q.correct + 1) % 4]),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.text(i == round.length - 1 ? 'النتيجة' : 'التالي'),
        );
        await tester.pumpAndSettle();
      }
      await expectLater(
        find.byType(QuizPlayPage),
        matchesGoldenFile('goldens/quiz_result.png'),
      );
    });
  });
}
