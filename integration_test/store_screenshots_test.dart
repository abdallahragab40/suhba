// Walks the app through the eight store-listing screens. At each one it
// prints `STORE_SHOT <name>` and holds the screen, so a host script can take
// a device screenshot (status bar included) with `xcrun simctl io` or
// `adb exec-out screencap`. Run with:
//   SUHBA_INTEGRATION_TEST=true flutter drive --driver=test_driver/v2_driver.dart \
//     --target=integration_test/store_screenshots_test.dart -d <device>
import 'dart:math';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suhba/app/app.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/app/router/app_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/biography/presentation/section_reader_page.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/quiz/presentation/quiz_widgets.dart';
import 'package:suhba/features/seerah/presentation/seerah_chapter_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_hub_page.dart';
import 'package:suhba/features/welcome/presentation/welcome_controller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// How long each screen is held for the host to capture it.
  const hold = Duration(seconds: 5);

  late AppDatabase db;
  final settings = MemorySettingsStore();

  Future<ProviderContainer> launch(
    WidgetTester tester,
    String route, {
    int? quizSeed,
  }) async {
    final container = ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        settingsStoreProvider.overrideWithValue(settings),
        appRouterProvider.overrideWithValue(
          buildAppRouter(initialLocation: route),
        ),
        if (quizSeed != null)
          quizRandomProvider.overrideWithValue(Random(quizSeed)),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const SuhbaApp()),
    );
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> close(WidgetTester tester, ProviderContainer container) async {
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    await tester.pumpAndSettle();
  }

  Future<void> shot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    debugPrintSynchronously('STORE_SHOT $name');
    await Future<void>.delayed(hold);
    await tester.pumpAndSettle();
  }

  Future<void> save(WidgetTester tester, String companionId) async {
    final app = await launch(tester, AppRoutes.companion(companionId));
    await tester.tap(
      find.descendant(
        of: find.byType(CompanionProfilePage),
        matching: find.byTooltip('حفظ'),
      ),
    );
    await tester.pumpAndSettle();
    await close(tester, app);
  }

  testWidgets('store screenshots', (tester) async {
    db = AppDatabase(driftDatabase(name: 'suhba_store_screenshots'));
    await db.delete(db.bookmarks).go();
    await db.delete(db.readingProgressEntries).go();
    await settings.setString(SettingsKeys.themeMode, 'light');
    await settings.setString(SettingsKeys.digitStyle, 'arabicIndic');
    await settings.setString(SettingsKeys.welcomeSeen, WelcomeController.seen);

    // Saved companions, for «مكتبتي».
    await save(tester, 'khadijah');
    await save(tester, 'aisha');

    // The reader, its source sheet, then half a section read so that Home
    // and «مكتبتي» offer to continue.
    var app = await launch(
      tester,
      AppRoutes.section('aisha', 'aisha.early-life'),
    );
    await shot(tester, '04-reader');
    await tester.tap(
      find
          .descendant(
            of: find.byType(SectionReaderPage),
            matching: find.byType(CitationMarker),
          )
          .first,
    );
    await shot(tester, '05-sources');
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    final reader = find.byType(SingleChildScrollView);
    final position = tester
        .state<ScrollableState>(
          find.descendant(of: reader, matching: find.byType(Scrollable)),
        )
        .position;
    await tester.drag(reader, Offset(0, -position.maxScrollExtent / 2));
    await tester.pumpAndSettle();
    await Future<void>.delayed(const Duration(seconds: 2)); // batched progress
    await tester.pumpAndSettle();
    await close(tester, app);

    // A Seerah chapter half read as well: on a tablet the section above fits
    // on one screen, so it has no reading position to continue from.
    app = await launch(tester, AppRoutes.seerahChapter('hijrah-to-madinah'));
    final chapter = find
        .descendant(
          of: find.byType(SeerahChapterPage),
          matching: find.byWidgetPredicate(
            (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
          ),
        )
        .first;
    await tester.drag(
      chapter,
      Offset(
        0,
        -tester.state<ScrollableState>(chapter).position.maxScrollExtent / 2,
      ),
    );
    await tester.pumpAndSettle();
    await Future<void>.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await close(tester, app);

    for (final (name, route) in [
      ('01-home', AppRoutes.home),
      ('02-companions', AppRoutes.companions),
      ('03-profile', AppRoutes.companion('khadijah')),
      ('06-seerah', AppRoutes.seerah),
      ('07-library', AppRoutes.saved),
    ]) {
      app = await launch(tester, route);
      if (route == AppRoutes.seerah) {
        // Past the opening card, to the chapters in order.
        final heading = find.text('فصول السيرة بالترتيب');
        await tester.scrollUntilVisible(
          heading,
          300,
          scrollable: find
              .descendant(
                of: find.byType(SeerahHubPage),
                matching: find.byWidgetPredicate(
                  (w) =>
                      w is Scrollable && w.axisDirection == AxisDirection.down,
                ),
              )
              .first,
        );
        await tester.pumpAndSettle();
        await Scrollable.ensureVisible(
          tester.element(heading),
          alignment: 0.04,
        );
      }
      await shot(tester, name);
      await close(tester, app);
    }

    // The quiz with a right answer: try seeds until the first choice is it.
    for (var seed = 1; seed <= 40; seed++) {
      app = await launch(tester, AppRoutes.quizPlay('seerah'), quizSeed: seed);
      await tester.tap(find.byType(QuizChoiceTile).first);
      await tester.pumpAndSettle();
      final right = tester
          .widgetList<QuizChoiceTile>(find.byType(QuizChoiceTile))
          .any((t) => t.burst);
      if (right || seed == 40) {
        await shot(tester, '08-quiz');
        await close(tester, app);
        break;
      }
      await close(tester, app);
    }
  });
}
