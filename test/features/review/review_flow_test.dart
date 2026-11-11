import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/time/local_day_provider.dart';
import 'package:suhba/features/home/domain/next_step.dart';
import 'package:suhba/features/home/presentation/next_step_card.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/review/data/drift_review_repository.dart';
import 'package:suhba/features/review/domain/review_item.dart';
import 'package:suhba/features/review/presentation/review_page.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/review_fixture.dart';

class _FailingReview extends DriftReviewRepository {
  _FailingReview(super.db);
  @override
  Future<bool> answerDue(ReviewItem expected, {required bool correct}) async =>
      throw StateError('disk full');
}

void main() {
  void phone(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(400, 1000);
    addTearDown(tester.view.reset);
  }

  testApp(
    'an empty review page becomes ready at midnight without reopening it',
    (tester) async {
      phone(tester);
      var now = DateTime(2026, 10, 9, 23, 59, 59);
      final app = AppUnderTest(location: AppRoutes.review, clock: () => now);
      await seedReview(app, dueOn: DateTime.utc(2026, 10, 10));
      await app.pump(tester);
      expect(find.text('لا توجد أسئلة مستحقة الآن'), findsOneWidget);
      now = DateTime(2026, 10, 10, 0, 0, 1);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('review-choice:0')), findsOneWidget);
      expect(find.text('لا توجد أسئلة مستحقة الآن'), findsNothing);
    },
  );

  testApp(
    'review answers persist before feedback, link to the passage, and return tomorrow',
    (tester) async {
      phone(tester);
      final app = AppUnderTest(location: AppRoutes.review);
      await seedReview(app);
      await app.pump(tester);
      final due = app.container.read(dueReviewsProvider).requireValue.single;
      await tester.tap(
        find.byKey(ValueKey('review-choice:${(due.question.correct + 1) % 4}')),
      );
      await tester.pumpAndSettle();
      final saved =
          (await app.container.read(reviewRepositoryProvider).all()).single;
      expect(saved.timesWrong, 2);
      expect(saved.dueOn, DateTime.utc(2026, 10, 10));
      expect(find.text('اقرأ الموضع'), findsOneWidget);
      expect(find.byKey(const ValueKey('review-next')), findsOneWidget);
      // Live queue changes do not remove the current explanation.
      expect(app.container.read(dueReviewsProvider).requireValue, isEmpty);
      await tester.ensureVisible(find.text('اقرأ الموضع'));
      await tester.tap(find.text('اقرأ الموضع'));
      await tester.pumpAndSettle();
      expect(app.location, '/content${due.question.route}');
      app.router.pop();
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('review-next')));
      await tester.tap(find.byKey(const ValueKey('review-next')));
      await tester.pumpAndSettle();
      expect(find.text('أتممت هذه المراجعة'), findsOneWidget);
      final tomorrow = AppUnderTest(
        location: AppRoutes.review,
        database: app.database,
        now: DateTime(2026, 10, 10),
      );
      await tomorrow.pump(tester);
      expect(
        tomorrow.container.read(dueReviewsProvider).requireValue,
        hasLength(1),
      );
      expect(find.byKey(const ValueKey('review-choice:0')), findsOneWidget);
    },
  );

  testApp('unknown keys retain history but are excluded from the due entry', (
    tester,
  ) async {
    phone(tester);
    final app = AppUnderTest(location: AppRoutes.quiz);
    final repo = app.container.read(reviewRepositoryProvider);
    await repo.save(
      ReviewItem(
        questionKey: 'removed:record',
        box: 1,
        dueOn: DateTime.utc(2026, 10, 9),
        lastAnsweredAt: DateTime.utc(2026, 10, 8),
        timesRight: 0,
        timesWrong: 1,
      ),
    );
    await app.pump(tester);
    expect(find.byType(DueReviewTile), findsNothing);
    expect(find.text('سؤال واحد للمراجعة اليوم'), findsNothing);
    await seedReview(app);
    await tester.pumpAndSettle();
    expect(find.text('سؤال واحد للمراجعة اليوم'), findsOneWidget);
    await tester.tap(find.text('سؤال واحد للمراجعة اليوم'));
    await tester.pumpAndSettle();
    expect(app.location, AppRoutes.review);
    expect(await repo.all(), hasLength(2));
  });

  testApp('a failed answer leaves choices available and history unchanged', (
    tester,
  ) async {
    phone(tester);
    final app = AppUnderTest(
      location: AppRoutes.review,
      overrides: [
        reviewRepositoryProvider.overrideWith(
          (ref) => _FailingReview(ref.watch(appDatabaseProvider)),
        ),
      ],
    );
    await seedReview(app);
    await app.pump(tester);
    await tester.tap(find.byKey(const ValueKey('review-choice:0')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('review-next')), findsNothing);
    expect(
      tester
          .widget<OutlinedButton>(find.byKey(const ValueKey('review-choice:0')))
          .onPressed,
      isNotNull,
    );
    expect(
      (await app.container.read(reviewRepositoryProvider).all())
          .single
          .timesWrong,
      1,
    );
  });

  testApp(
    'Home changes from journey to review after today’s step, then refreshes on resume',
    (tester) async {
      phone(tester);
      var now = DateTime(2026, 10, 9, 21);
      final app = AppUnderTest(clock: () => now);
      await seedReview(app);
      const id = 'meet-the-companions';
      await app.container.read(journeyActionsProvider).start(id);
      await app.pump(tester);
      expect(
        app.container.read(nextStepProvider).requireValue,
        isA<JourneyNextStep>(),
      );
      final enrollment =
          (await app.container.read(journeyRepositoryProvider).enrollments())
              .single;
      await app.container
          .read(journeyRepositoryProvider)
          .saveStep(
            JourneyStepProgress(
              journeyId: id,
              stepId: '$id.abu-bakr',
              startedAt: enrollment.startedAt,
              updatedAt: now.toUtc(),
              completedAt: now.toUtc(),
            ),
          );
      await tester.pumpAndSettle();
      expect(
        app.container.read(nextStepProvider).requireValue,
        isA<ReviewNextStep>(),
      );
      expect(find.text('سؤال واحد للمراجعة اليوم'), findsOneWidget);
      now = DateTime(2026, 10, 10, 8);
      app.container
          .read(localDayProvider.notifier)
          .didChangeAppLifecycleState(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(
        (app.container.read(nextStepProvider).requireValue as JourneyNextStep)
            .step
            .id,
        '$id.umar',
      );
    },
  );

  testApp('learning topics describe only answered facts, with no score', (
    tester,
  ) async {
    phone(tester);
    final app = AppUnderTest(location: AppRoutes.learned);
    await seedReview(app, box: 4, right: 4, wrong: 0);
    await app.pump(tester);
    expect(find.text('راسخة'), findsOneWidget);
    expect(find.text('ثاني اثنين'), findsOneWidget);
    expect(find.text('أبو بكر الصديق'), findsOneWidget);
    await seedReview(app);
    await tester.pumpAndSettle();
    expect(find.text('تستحق المراجعة'), findsOneWidget);
    expect(find.text('راسخة'), findsNothing);
    await tester.tap(find.text('ثاني اثنين'));
    await tester.pumpAndSettle();
    expect(app.location, '/content${AppRoutes.story('the-cave')}');
  });
}
