// Frame timings while scrolling the heaviest screens. Run in profile mode
// on a real device (an emulator gives only a rough picture):
//   flutter drive --keep-app-running --profile --driver=test_driver/perf_driver.dart \
//     --target=integration_test/scroll_perf_test.dart -d <device>
// The summaries are written to build/integration_response_data.json.
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suhba/app/app.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/app/router/app_router.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';
import 'package:suhba/features/welcome/presentation/welcome_controller.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
    ..framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  late AppDatabase db;
  setUpAll(() => db = AppDatabase(driftDatabase(name: 'suhba_perf')));

  const screens = {
    // A plain list: the device's own floor for comparison.
    'baseline': '/settings',
    'journeys': '/journeys',
    'journey overview': '/journeys/moments-and-lessons',
    'journey step':
        '/journeys/moments-and-lessons/steps/moments-and-lessons.mercy',
    'review': '/review',
    'learned': '/review/learned',
    'directory': '/companions',
    'profile': '/companions/abu-bakr',
    'reader': '/companions/abu-bakr/sections/abu-bakr.hijrah',
    // Revision 4: the richest new screens.
    'home': '/home',
    'seerah hub': '/seerah',
    'seerah chapter': '/seerah/chapters/hijrah-to-madinah',
    'seerah timeline': '/seerah/timeline',
    'map': '/visuals/hijrah-route',
    'explore': '/explore',
    'story chapter':
        '/stories/the-archers-of-uhud/chapters/the-archers-of-uhud.3',
  };

  for (final MapEntry(key: name, value: location) in screens.entries) {
    if (const bool.fromEnvironment('SUHBA_V2_PERF_ONLY') &&
        ![
          'baseline',
          'journeys',
          'journey overview',
          'journey step',
          'review',
          'learned',
        ].contains(name)) {
      continue;
    }
    testWidgets('scrolling $name', (tester) async {
      var now = DateTime(2026, 11, 10, 12);
      final settings = MemorySettingsStore();
      await settings.setString(
        SettingsKeys.welcomeSeen,
        WelcomeController.seen,
      );
      final container = ProviderContainer(
        retry: noAutomaticRetry,
        overrides: [
          appRouterProvider.overrideWithValue(
            buildAppRouter(initialLocation: location),
          ),
          appDatabaseProvider.overrideWithValue(db),
          settingsStoreProvider.overrideWithValue(settings),
          clockProvider.overrideWithValue(() => now),
        ],
      );
      await db.delete(db.reviewItems).go();
      await db.delete(db.journeyProgressEntries).go();
      await db.delete(db.journeyEnrollments).go();
      final runtime = await container.read(
        journeyRuntimeProvider('moments-and-lessons').future,
      );
      await container.read(journeyActionsProvider).start('moments-and-lessons');
      final questions = ['review', 'learned'].contains(name)
          ? QuizGenerator(
              await container.read(quizContentProvider.future),
            ).questionBank().values.take(80)
          : runtime.questions['moments-and-lessons.mercy']!;
      for (final q in questions) {
        await container
            .read(reviewRepositoryProvider)
            .recordAnswer(q.key, correct: false);
      }
      now = DateTime(2026, 11, 11, 12);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const SuhbaApp(),
        ),
      );
      await tester.pumpAndSettle();

      // The main vertical list, not a horizontal chip row.
      final scrollable = find
          .byWidgetPredicate(
            (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
          )
          .hitTestable()
          .first;
      await binding.watchPerformance(() async {
        for (var i = 0; i < 3; i++) {
          await tester.fling(scrollable, const Offset(0, -400), 2000);
          await tester.pumpAndSettle();
          await tester.fling(scrollable, const Offset(0, 400), 2000);
          await tester.pumpAndSettle();
        }
      }, reportKey: name);

      await tester.pumpWidget(const SizedBox.shrink());
      container.dispose();
    });
  }
}
