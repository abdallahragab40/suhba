import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/features/journeys/data/journey_reconciliation.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/personal_data/domain/reading_data_archive.dart';
import 'package:suhba/features/personal_data/presentation/reading_data_transfer.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';
import 'package:suhba/shared/content/providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/journey_bundle.dart';

void main() {
  const id = 'meet-the-companions';
  testApp(
    'removed readings skip a step without losing its history; corrupt content does not',
    (tester) async {
      final original = AppUnderTest(bundle: journeyBundle());
      final actions = original.container.read(journeyActionsProvider);
      await actions.start(id);
      final repo = original.container.read(journeyRepositoryProvider);
      final enrollment = (await repo.enrollments()).single;
      final old = JourneyStepProgress(
        journeyId: id,
        stepId: '$id.first',
        startedAt: enrollment.startedAt,
        updatedAt: enrollment.startedAt,
        completedAt: enrollment.startedAt,
        answeredKeys: const {'story:the-cave:abu-bakr'},
      );
      await repo.saveStep(old);
      final brokenBundle = journeyBundle();
      brokenBundle.files['assets/content/stories/the-cave.json'] =
          '{"schemaVersion":2,"id":7}';
      final broken = AppUnderTest(
        bundle: brokenBundle,
        database: original.database,
      );
      final failed = await reconcileJourneys(
        content: broken.container.read(contentRepositoryProvider),
        journeys: repo,
        clock: broken.container.read(clockProvider),
      );
      expect(failed, 1);
      expect((await repo.steps()).single.skipped, isFalse);
      final removedBundle = journeyBundle();
      removedBundle.editJson('assets/content/stories/the-cave.json', (j) {
        j['chapters'] = (j['chapters'] as List<Object?>)
            .cast<Map<String, dynamic>>()
            .where((c) => c['id'] != 'the-cave.2')
            .toList();
      });
      final updated = AppUnderTest(
        bundle: removedBundle,
        database: original.database,
      );
      final runtime = await updated.container.read(
        journeyRuntimeProvider(id).future,
      );
      final restored = (await repo.steps()).single;
      expect(restored.skipped, isTrue);
      expect(restored.completedAt, old.completedAt);
      expect(restored.answeredKeys, old.answeredKeys);
      expect(runtime.unlocked('$id.second', await repo.steps()), isTrue);
      // The retained row remains part of a 2.0 export.
      expect(
        (await updated.container.read(readingDataTransferProvider).snapshot())
            .journeySteps
            .single
            .skipped,
        isTrue,
      );
    },
  );

  testApp(
    'reading through the existing readers enables questions and completion',
    (tester) async {
      final app = AppUnderTest(
        bundle: journeyBundle(),
        location: AppRoutes.journeyStep(id, '$id.first'),
      );
      await app.container.read(journeyActionsProvider).start(id);
      await app.pump(tester);
      final runtime = await app.container.read(
        journeyRuntimeProvider(id).future,
      );
      for (final r in runtime.readings['$id.first']!.nonNulls) {
        await tester.ensureVisible(find.text(r.title.ar));
        await tester.tap(find.text(r.title.ar));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('أنهيتُ القراءة'));
        await tester.tap(find.text('أنهيتُ القراءة'));
        await tester.pumpAndSettle();
        app.router.pop();
        await tester.pumpAndSettle();
      }
      final questions = runtime.questions['$id.first']!;
      expect(questions, isNotEmpty);
      for (final (i, q) in questions.indexed) {
        // The first answer is wrong, the others right: each says which.
        final pick = i == 0 ? (q.correct + 1) % q.choices.length : q.correct;
        final choice = find.byKey(ValueKey('journey-answer:${q.key}:$pick'));
        // Choices are shuffled and the list builds lazily: scroll until the
        // one to tap is built and on screen.
        await tester.scrollUntilVisible(
          choice,
          120,
          scrollable: find
              .byWidgetPredicate(
                (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
              )
              .first,
        );
        await tester.pumpAndSettle();
        await tester.tap(choice);
        await tester.pumpAndSettle();
      }
      expect(find.text('ليست هذه'), findsOneWidget);
      expect(find.text('أحسنت!'), findsNWidgets(questions.length - 1));
      final complete = find.byKey(const ValueKey('complete-journey-step'));
      await tester.ensureVisible(complete);
      expect(tester.widget<FilledButton>(complete).onPressed, isNotNull);
      await tester.tap(complete);
      await tester.pumpAndSettle();
      final progress =
          (await app.container.read(journeyRepositoryProvider).steps()).single;
      expect(progress.completedAt, isNotNull);
      expect(progress.answeredKeys, isNotEmpty);
    },
  );
  testApp('all launch journeys resolve offline and finish in order', (
    tester,
  ) async {
    final app = AppUnderTest();
    final journeys = await app.container.read(journeysProvider.future);
    expect(
      {for (final j in journeys) j.id: j.steps.length},
      {
        'meet-the-companions': 14,
        'moments-and-lessons': 10,
        'seerah-in-thirty-steps': 30,
      },
    );
    final actions = app.container.read(journeyActionsProvider);
    for (final journey in journeys) {
      final runtime = await app.container.read(
        journeyRuntimeProvider(journey.id).future,
      );
      expect(runtime.readings.values.expand((r) => r).contains(null), isFalse);
      await actions.start(journey.id);
      for (final step in journey.steps) {
        if (journey.id == 'meet-the-companions' &&
            step == journey.steps.first) {
          await expectLater(
            actions.complete(runtime, step.id),
            throwsStateError,
          );
        }
        for (final r in step.readings) {
          await app.container
              .read(readingProgressRepositoryProvider)
              .save(
                ReadingProgress(
                  target: r.progressTarget,
                  targetId: r.targetId,
                  parentId: r.parentId ?? 'seerah',
                  fraction: 1,
                  completed: true,
                  contentVersion: '0.3.0',
                  updatedAt: DateTime(2026, 10, 9),
                ),
              );
        }
        for (final q in runtime.questions[step.id]!) {
          await actions.answer(
            runtime,
            step.id,
            q.key,
            (q.correct + 1) % q.choices.length,
          );
        }
        await actions.complete(runtime, step.id);
      }
    }
    final repo = app.container.read(journeyRepositoryProvider);
    expect(
      (await repo.steps()).where((s) => s.completedAt != null),
      hasLength(54),
    );
    expect(await repo.enrollments(), hasLength(3));
  });

  testApp(
    'wrong answers count, duplicate taps do not add history, pause and restart are isolated',
    (tester) async {
      final app = AppUnderTest(bundle: journeyBundle());
      final runtime = await app.container.read(
        journeyRuntimeProvider(id).future,
      );
      final actions = app.container.read(journeyActionsProvider);
      final repo = app.container.read(journeyRepositoryProvider);
      final first = runtime.journey.steps.first;
      await actions.start(id);
      await actions.start('moments-and-lessons');
      await expectLater(
        actions.complete(runtime, runtime.journey.steps.last.id),
        throwsStateError,
      );
      for (final r in first.readings) {
        await app.container
            .read(readingProgressRepositoryProvider)
            .save(
              ReadingProgress(
                target: r.progressTarget,
                targetId: r.targetId,
                parentId: r.parentId!,
                fraction: 1,
                completed: true,
                contentVersion: '0.3.0',
                updatedAt: DateTime(2026, 10, 9),
              ),
            );
      }
      await actions.pause(id, true);
      await expectLater(actions.complete(runtime, first.id), throwsStateError);
      await actions.pause(id, false);
      expect(runtime.questions[first.id], isNotEmpty);
      await expectLater(actions.complete(runtime, first.id), throwsStateError);
      for (final q in runtime.questions[first.id]!) {
        final wrong = (q.correct + 1) % q.choices.length;
        await actions.answer(runtime, first.id, q.key, wrong);
        await actions.answer(runtime, first.id, q.key, wrong);
      }
      await actions.complete(runtime, first.id);
      final review =
          (await app.container.read(reviewRepositoryProvider).all()).first;
      expect(review.timesWrong, 1);
      expect(review.dueOn, DateTime.utc(2026, 10, 10));
      expect(
        runtime.unlocked(runtime.journey.steps.last.id, await repo.steps()),
        isTrue,
      );
      await actions.restart(id);
      expect((await repo.steps()).where((s) => s.journeyId == id), isEmpty);
      expect(await repo.enrollments(), hasLength(2));
      expect(
        await app.container.read(readingProgressRepositoryProvider).all(),
        isNotEmpty,
      );
      expect(
        await app.container.read(reviewRepositoryProvider).all(),
        isNotEmpty,
      );
    },
  );

  testApp(
    'journey-only export imports to a fresh database and an old attempt cannot undo restart',
    (tester) async {
      final app = AppUnderTest(bundle: journeyBundle());
      await app.container.read(journeyActionsProvider).start(id);
      await app.container.read(journeyActionsProvider).pause(id, true);
      final localRepo = app.container.read(journeyRepositoryProvider);
      final localEnrollment = (await localRepo.enrollments()).single;
      await localRepo.saveStep(
        JourneyStepProgress(
          journeyId: id,
          stepId: '$id.first',
          startedAt: localEnrollment.startedAt,
          updatedAt: localEnrollment.updatedAt,
          completedAt: localEnrollment.updatedAt,
          answeredKeys: const {'story:the-cave:abu-bakr'},
        ),
      );
      final archive =
          (decodeArchive(
                    encodeArchive(
                      await app.container
                          .read(readingDataTransferProvider)
                          .snapshot(),
                    ),
                  )
                  as ArchiveDecoded)
              .archive;
      final fresh = AppUnderTest(bundle: journeyBundle());
      await fresh.container
          .read(readingDataTransferProvider)
          .apply(
            planImport(
              localBookmarks: const [],
              localProgress: const [],
              archive: archive,
            ),
          );
      final repo = fresh.container.read(journeyRepositoryProvider);
      expect((await repo.enrollments()).single.paused, isTrue);
      expect((await repo.steps()).single.completedAt, isNotNull);
      expect((await repo.steps()).single.answeredKeys, {
        'story:the-cave:abu-bakr',
      });

      await fresh.container.read(journeyActionsProvider).restart(id);
      final plan = planImport(
        localBookmarks: const [],
        localProgress: const [],
        localJourneys: await repo.enrollments(),
        localJourneySteps: await repo.steps(),
        archive: archive,
      );
      expect(plan.isEmpty, isTrue);
      final bad = jsonDecode(encodeArchive(archive)) as Map<String, dynamic>;
      bad['journeySteps'] = [
        {
          'journeyId': id,
          'stepId': '$id.first',
          'startedAt': '2026-01-01T00:00:00Z',
          'updatedAt': '2026-10-09T00:00:00Z',
          'skipped': false,
          'answeredKeys': <String>[],
        },
      ];
      expect(decodeArchive(jsonEncode(bad)), isA<ArchiveRejected>());
    },
  );

  testApp('journeys can be opened from Explore and direct links stay locked', (
    tester,
  ) async {
    final app = AppUnderTest(location: AppRoutes.explore);
    await app.pump(tester);
    await tester.tap(find.text('الرحلات'));
    await tester.pumpAndSettle();
    expect(find.text('تعرّف على الصحابة'), findsOneWidget);
    await tester.tap(find.text('تعرّف على الصحابة'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('ابدأ الرحلة'));
    await tester.tap(find.text('ابدأ الرحلة'));
    await tester.pumpAndSettle();
    expect(app.location, AppRoutes.journeyStep(id, '$id.abu-bakr'));
    expect(find.text('قراءة الخطوة'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('complete-journey-step')),
      300,
      scrollable: find.byType(Scrollable).hitTestable().last,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('complete-journey-step')),
          )
          .onPressed,
      isNull,
    );
  });
}
