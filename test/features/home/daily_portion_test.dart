import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/home/presentation/daily_portion.dart';
import 'package:suhba/features/home/presentation/next_step_card.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/reminders/presentation/reminder_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_reminder_service.dart';

/// K1 «ورد اليوم»: Home's first card names one item to read today, the
/// evening reminder names the same one, and a Seerah chapter can be
/// marked read in one tap.
void main() {
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

  testApp('names the next Seerah chapter, with its reading time', (
    tester,
  ) async {
    await open(tester);
    expect(inCard(find.text('ورد اليوم')), findsOneWidget);
    expect(inCard(find.text('مكة والنسب والمولد')), findsOneWidget);
    expect(
      inCard(find.text('السيرة النبوية، الفصل ١ من ١٢، ٥ دقائق قراءة')),
      findsOneWidget,
    );
  });

  testApp('«قرأتُه» marks it read and moves on; undo puts it back', (
    tester,
  ) async {
    final app = await open(tester);
    await tester.tap(inCard(find.text('قرأتُه')));
    await tester.pumpAndSettle();
    expect(inCard(find.text('النشأة والشباب')), findsOneWidget);
    final saved = await app.container
        .read(readingProgressRepositoryProvider)
        .all();
    expect(saved.single.targetId, 'makkah-lineage-birth');
    expect(saved.single.completed, isTrue);

    await tester.tap(find.text('تراجع'));
    await tester.pumpAndSettle();
    expect(inCard(find.text('مكة والنسب والمولد')), findsOneWidget);
    expect(
      await app.container.read(readingProgressRepositoryProvider).all(),
      isEmpty,
    );
  });

  testApp('a journey in progress: its next step, opened, not marked', (
    tester,
  ) async {
    final app = AppUnderTest();
    await app.container
        .read(journeyActionsProvider)
        .start('meet-the-companions');
    await open(tester, app: app);
    final portion = app.container.read(dailyPortionProvider).requireValue;
    expect(portion, isA<JourneyPortion>());
    // A step is finished in the journey, after its questions.
    expect(inCard(find.text('قرأتُه')), findsNothing);
    await tester.tap(inCard(find.text('اقرأ')));
    await tester.pumpAndSettle();
    expect(app.location, portion!.route);
  });

  testApp('after today\'s journey step, the card steps aside', (tester) async {
    final app = AppUnderTest();
    const id = 'meet-the-companions';
    await app.container.read(journeyActionsProvider).start(id);
    final e =
        (await app.container.read(journeyRepositoryProvider).enrollments())
            .single;
    final now = DateTime(2026, 10, 9, 12).toUtc();
    await app.container
        .read(journeyRepositoryProvider)
        .saveStep(
          JourneyStepProgress(
            journeyId: id,
            stepId: '$id.abu-bakr',
            startedAt: e.startedAt,
            updatedAt: now,
            completedAt: now,
          ),
        );
    await open(tester, app: app);
    expect(app.container.read(dailyPortionProvider).requireValue, isNull);
    expect(inCard(find.text('ورد اليوم')), findsNothing);
    expect(find.byType(NextStepCard), findsOneWidget);
  });

  testApp('the evening reminder names the same item, and follows it', (
    tester,
  ) async {
    final service = FakeReminderService()..granted = true;
    final app = AppUnderTest(
      overrides: [reminderServiceProvider.overrideWithValue(service)],
    );
    await open(tester, app: app);
    await app.container.read(reminderProvider.future);
    await app.container.read(reminderProvider.notifier).setEnabled(true);
    expect(service.copy?.body, 'ورد اليوم: مكة والنسب والمولد، ٥ دقائق قراءة');

    await tester.tap(inCard(find.text('قرأتُه')));
    await tester.pumpAndSettle();
    expect(service.copy?.body, startsWith('ورد اليوم: النشأة والشباب'));
  });
}
