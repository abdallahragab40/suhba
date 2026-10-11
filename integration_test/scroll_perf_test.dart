// Frame timings while scrolling the heaviest screens. Run in profile mode
// on a real device (an emulator gives only a rough picture):
//   flutter drive --profile --driver=test_driver/perf_driver.dart \
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

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
    ..framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  late AppDatabase db;
  setUpAll(() => db = AppDatabase(driftDatabase(name: 'suhba_perf')));

  const screens = {
    // A plain list: the device's own floor for comparison.
    'baseline': '/settings',
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
    testWidgets('scrolling $name', (tester) async {
      final container = ProviderContainer(
        retry: noAutomaticRetry,
        overrides: [
          appRouterProvider.overrideWithValue(
            buildAppRouter(initialLocation: location),
          ),
          appDatabaseProvider.overrideWithValue(db),
        ],
      );
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
