import 'dart:async';
import 'dart:ui' as ui;

// Run only in the isolated application sandbox:
// SUHBA_INTEGRATION_TEST=true flutter drive --keep-app-running --driver=test_driver/v2_driver.dart \
//   --target=integration_test/v2_journey_test.dart -d emulator-5554
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suhba/app/app.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/app/router/app_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';
import 'package:suhba/features/welcome/presentation/welcome_controller.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const id = 'moments-and-lessons';
  const step = '$id.mercy';
  const databaseName = 'suhba_v2_device_flow';
  var now = DateTime(2026, 11, 10, 12);
  late AppDatabase db;
  late ProviderContainer app;
  final settings = MemorySettingsStore();
  final screen = GlobalKey();
  final screenshots = <Map<String, Object>>[];
  Future<void> screenshot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final boundary =
          screen.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(
        pixelRatio: tester.view.devicePixelRatio,
      );
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      screenshots.add({
        'screenshotName': name,
        'bytes': data!.buffer.asUint8List().toList(),
      });
      binding.reportData = {'screenshots': screenshots};
    });
    debugPrintSynchronously('V2_SCREENSHOT $name');
  }

  Future<void> launch(WidgetTester tester, String route) async {
    db = AppDatabase(driftDatabase(name: databaseName));
    app = ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        settingsStoreProvider.overrideWithValue(settings),
        clockProvider.overrideWithValue(() => now),
        appRouterProvider.overrideWithValue(
          buildAppRouter(initialLocation: route),
        ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: app,
        child: RepaintBoundary(key: screen, child: const SuhbaApp()),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    app.dispose();
    await tester.pumpAndSettle();
    debugPrintSynchronously('V2_CLOSE_DATABASE');
    await tester.runAsync(() => db.close());
    debugPrintSynchronously('V2_DATABASE_CLOSED');
  }

  testWidgets('read, answer, reopen database, resume and review tomorrow', (
    tester,
  ) async {
    await settings.setString(SettingsKeys.welcomeSeen, WelcomeController.seen);
    // Reset only the test database, never the reader app's sandbox.
    final fresh = AppDatabase(driftDatabase(name: databaseName));
    await fresh.transaction(() async {
      await fresh.delete(fresh.journeyProgressEntries).go();
      await fresh.delete(fresh.journeyEnrollments).go();
      await fresh.delete(fresh.reviewItems).go();
      await fresh.delete(fresh.readingProgressEntries).go();
    });
    await fresh.close();
    // Keep the real Home shell underneath the journey: entering directly at
    // /journeys misses duplicate-shell regressions when a reading is opened.
    await launch(tester, AppRoutes.home);
    unawaited(app.read(appRouterProvider).push<void>(AppRoutes.journeys));
    await tester.pumpAndSettle();
    await screenshot(tester, 'v2-journeys-draft');
    unawaited(app.read(appRouterProvider).push<void>(AppRoutes.journey(id)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ابدأ الرحلة'));
    await tester.pumpAndSettle();
    final runtime = await app.read(journeyRuntimeProvider(id).future);
    expect(runtime.questions[step], isNotEmpty);
    for (final reading in runtime.readings[step]!.nonNulls) {
      final link = find.text(reading.title.ar).last;
      await tester.ensureVisible(link);
      await tester.tap(link);
      await tester.pumpAndSettle();
      final done = find.text('أنهيتُ القراءة');
      await tester.scrollUntilVisible(
        done,
        400,
        scrollable: find.byType(Scrollable).hitTestable().last,
      );
      debugPrintSynchronously('V2_READ ${reading.ref.targetId}');
      await tester.tap(done);
      await tester.pumpAndSettle();
      app.read(appRouterProvider).pop();
      await tester.pumpAndSettle();
    }
    for (final q in runtime.questions[step]!) {
      final wrong = (q.correct + 1) % q.choices.length;
      final choice = find.byKey(ValueKey('journey-answer:${q.key}:$wrong'));
      await tester.scrollUntilVisible(
        choice,
        300,
        scrollable: find.byType(Scrollable).hitTestable().last,
      );
      await tester.tap(choice);
      await tester.pumpAndSettle();
    }
    final complete = find.byKey(const ValueKey('complete-journey-step'));
    await tester.ensureVisible(complete);
    debugPrintSynchronously('V2_COMPLETE_STEP');
    await tester.tap(complete);
    await tester.pumpAndSettle();
    final expectedKeys = runtime.questions[step]!.map((q) => q.key).toSet();
    expect(
      (await app.read(journeyRepositoryProvider).steps()).single.finished,
      isTrue,
    );
    unawaited(app.read(appRouterProvider).push<void>(AppRoutes.review));
    await tester.pumpAndSettle();
    debugPrintSynchronously('V2_CHECK_TODAY_DUE');
    expect(
      await app
          .read(dueReviewsProvider.future)
          .timeout(const Duration(seconds: 30)),
      isEmpty,
    );
    debugPrintSynchronously('V2_TODAY_DUE_CHECKED');
    await close(tester);

    debugPrintSynchronously('V2_REOPEN');
    await launch(tester, AppRoutes.journey(id));
    expect(
      (await app.read(journeyRepositoryProvider).steps()).single.finished,
      isTrue,
    );
    expect(
      (await app.read(reviewRepositoryProvider).all())
          .map((r) => r.questionKey)
          .toSet(),
      expectedKeys,
    );
    await tester.tap(find.text('تابع الرحلة'));
    await tester.pumpAndSettle();
    expect(
      app.read(appRouterProvider).state.uri.path,
      AppRoutes.journeyStep(id, runtime.journey.steps[1].id),
    );
    await screenshot(tester, 'v2-next-step-draft');
    await close(tester);

    now = DateTime(2026, 11, 11, 12);
    await launch(tester, AppRoutes.review);
    final due = await app.read(dueReviewsProvider.future);
    expect(due.map((d) => d.question.key).toSet(), expectedKeys);
    await screenshot(tester, 'v2-review-draft');
    final first = due.first;
    final correct = find.byKey(
      ValueKey('review-choice:${first.question.correct}'),
    );
    await tester.ensureVisible(correct);
    await tester.tap(correct);
    await tester.pumpAndSettle();
    final updated = (await app.read(reviewRepositoryProvider).all())
        .singleWhere((r) => r.questionKey == first.question.key);
    expect(updated.timesRight, 1);
    expect(updated.timesWrong, 1);
    expect(updated.box, 2);
    expect(updated.dueOn, DateTime.utc(2026, 11, 14));
    expect(tester.takeException(), isNull);
    await close(tester);
  });
}
