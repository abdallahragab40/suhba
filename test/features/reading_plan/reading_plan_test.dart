import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/home/presentation/daily_portion.dart';
import 'package:suhba/features/reading_plan/domain/reading_plan.dart';
import 'package:suhba/features/reading_plan/presentation/reading_plan_providers.dart';
import 'package:suhba/features/reminders/presentation/reminder_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_reminder_service.dart';

/// K3: a daily pace, and two neutral ways on after a missed day. No streak
/// counter, no guilt wording.
void main() {
  group('the daily target', () {
    final start = DateTime(2026, 10);
    ReadingPlan plan({int pace = 1, bool catchUp = false, int baseline = 0}) =>
        ReadingPlan(
          pace: pace,
          startedOn: start,
          baseline: baseline,
          catchUp: catchUp,
        );

    test('on the first day: the pace, nothing behind', () {
      final t = dailyTarget(
        plan: plan(pace: 2),
        today: start,
        finished: 0,
        finishedToday: 0,
        total: 12,
      );
      expect((t.chapters, t.behind, t.askHowToContinue), (2, 0, false));
    });

    test('on pace: nothing to ask', () {
      final t = dailyTarget(
        plan: plan(),
        today: DateTime(2026, 10, 3),
        finished: 2,
        finishedToday: 0,
        total: 12,
      );
      expect((t.chapters, t.behind, t.askHowToContinue), (1, 0, false));
    });

    test('a missed day: what remains, and the question', () {
      final t = dailyTarget(
        plan: plan(baseline: 3),
        today: DateTime(2026, 10, 3, 20),
        finished: 4,
        finishedToday: 0,
        total: 12,
      );
      expect((t.chapters, t.behind, t.askHowToContinue), (1, 1, true));
    });

    test('catching up adds one chapter a day, never more', () {
      final t = dailyTarget(
        plan: plan(pace: 2, catchUp: true),
        today: DateTime(2026, 10, 6),
        finished: 0,
        finishedToday: 0,
        total: 12,
      );
      expect((t.chapters, t.behind, t.askHowToContinue), (3, 10, false));
    });

    test('never more than remains', () {
      final t = dailyTarget(
        plan: plan(pace: 3),
        today: DateTime(2026, 10, 9),
        finished: 11,
        finishedToday: 0,
        total: 12,
      );
      expect((t.chapters, t.behind), (1, 1));
    });

    test('chapters read today count toward today, not against yesterday', () {
      final t = dailyTarget(
        plan: plan(pace: 2),
        today: DateTime(2026, 10, 2),
        finished: 3,
        finishedToday: 1,
        total: 12,
      );
      expect((t.chapters, t.doneToday, t.behind, t.done), (2, 1, 0, false));
    });
  });

  Future<AppUnderTest> open(WidgetTester tester, {AppUnderTest? app}) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
    final a = app ?? AppUnderTest();
    await a.pump(tester);
    return a;
  }

  Finder inCard(Finder f) =>
      find.descendant(of: find.byType(DailyPortionCard), matching: f);

  testApp('a pace of two: one of two, then a calm close', (tester) async {
    final service = FakeReminderService()..granted = true;
    final app = AppUnderTest(
      overrides: [reminderServiceProvider.overrideWithValue(service)],
    );
    await app.container.read(readingPlanActionsProvider).setPace(2);
    await open(tester, app: app);
    await app.container.read(reminderProvider.future);
    await app.container.read(reminderProvider.notifier).setEnabled(true);
    expect(inCard(find.text('ورد اليوم: ١ من ٢')), findsOneWidget);

    await tester.tap(inCard(find.text('قرأتُه')));
    await tester.pumpAndSettle();
    expect(inCard(find.text('ورد اليوم: ٢ من ٢')), findsOneWidget);
    expect(inCard(find.text('النشأة والشباب')), findsOneWidget);

    await tester.tap(inCard(find.text('قرأتُه')));
    await tester.pumpAndSettle();
    expect(inCard(find.text('تمّ ورد اليوم')), findsOneWidget);
    expect(
      inCard(find.text('وغدًا: الأسرة والحياة قبل البعثة')),
      findsOneWidget,
    );
    expect(inCard(find.text('قرأتُه')), findsNothing);
    // The evening reminder no longer names a chapter.
    expect(service.copy?.body, isNot(startsWith('ورد اليوم')));
  });

  group('after a missed day', () {
    Future<AppUnderTest> missed(WidgetTester tester) async {
      final app = AppUnderTest(); // 9 October 2026
      await app.container
          .read(readingPlanRepositoryProvider)
          .save(
            ReadingPlan(pace: 1, startedOn: DateTime(2026, 10, 7), baseline: 0),
          );
      return open(tester, app: app);
    }

    testApp('two neutral choices, and no count of days', (tester) async {
      await missed(tester);
      expect(inCard(find.text('بقي من الأيام الماضية فصلان.')), findsOneWidget);
      expect(inCard(find.text('تابع من حيث توقفت')), findsOneWidget);
      expect(inCard(find.text('تدارك تدريجيًا')), findsOneWidget);
    });

    testApp('continuing from here owes nothing', (tester) async {
      final app = await missed(tester);
      await tester.tap(inCard(find.text('تابع من حيث توقفت')));
      await tester.pumpAndSettle();
      expect(inCard(find.textContaining('بقي من الأيام')), findsNothing);
      final plan = await app.container
          .read(readingPlanRepositoryProvider)
          .get();
      expect(plan!.startedOn, DateTime(2026, 10, 9));
      expect(plan.catchUp, isFalse);
    });

    testApp('catching up gradually adds one chapter today', (tester) async {
      await missed(tester);
      await tester.tap(inCard(find.text('تدارك تدريجيًا')));
      await tester.pumpAndSettle();
      expect(inCard(find.textContaining('بقي من الأيام')), findsNothing);
      expect(inCard(find.text('ورد اليوم: ١ من ٢')), findsOneWidget);
    });
  });

  testApp('the pace is chosen in Settings', (tester) async {
    final app = AppUnderTest(location: '/settings');
    await open(tester, app: app);
    await tester.tap(find.text('٣ فصول'));
    await tester.pumpAndSettle();
    expect(
      (await app.container.read(readingPlanRepositoryProvider).get())?.pace,
      3,
    );
    await tester.tap(find.text('بلا خطة'));
    await tester.pumpAndSettle();
    expect(
      await app.container.read(readingPlanRepositoryProvider).get(),
      isNull,
    );
  });
}
