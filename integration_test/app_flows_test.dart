// End-to-end flows on a real device: real asset loading, a real database
// file and real preferences. Run with:
//   flutter test integration_test -d <device>
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suhba/app/app.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/atlas/presentation/visual_page.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_chapter_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_hub_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late SettingsStore settings;

  setUpAll(() async {
    // A separate database file, so the tests never touch real user data.
    db = AppDatabase(driftDatabase(name: 'suhba_e2e'));
    settings = await PrefsSettingsStore.open();
  });

  setUp(() async {
    await db.delete(db.bookmarks).go();
    await db.delete(db.readingProgressEntries).go();
    await settings.setString(SettingsKeys.themeMode, 'system');
    await settings.setString(SettingsKeys.digitStyle, 'arabicIndic');
    await settings.setDouble(SettingsKeys.readingTextSize, 19);
    // On a fresh install the welcome screens would cover the app; they
    // have their own tests.
    await settings.setString(SettingsKeys.welcomeSeen, '1');
  });

  // The database is not closed: the test process ends with the last test,
  // and closing would wait on stream timers that no longer run.

  /// Starts the app as bootstrap would, on the shared database and prefs.
  Future<ProviderContainer> launch(WidgetTester tester) async {
    final container = ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        settingsStoreProvider.overrideWithValue(settings),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const SuhbaApp()),
    );
    await tester.pumpAndSettle();
    return container;
  }

  /// Closes the app (keeping the database file), as a restart would.
  Future<void> close(WidgetTester tester, ProviderContainer container) async {
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    await tester.pumpAndSettle();
  }

  /// Opens a destination from the bottom bar, or from the side rail on
  /// wide screens (tablets).
  Future<void> tab(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byWidgetPredicate(
          (w) => w is NavigationBar || w is NavigationRail,
        ),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> wait(WidgetTester tester, Duration duration) async {
    await Future<void>.delayed(duration);
    await tester.pumpAndSettle();
  }

  testWidgets('browse, save, read, restart: everything is still there', (
    tester,
  ) async {
    var app = await launch(tester);

    await tab(tester, 'الصحابة');
    await tester.tap(find.text('أبو بكر الصديق'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('حفظ'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('إزالة من المحفوظات'), findsOneWidget);

    // The directory stays mounted under the profile: scope to the profile.
    final onProfile = find.descendant(
      of: find.byType(CompanionProfilePage),
      matching: find.text('فضائله'),
    );
    await tester.scrollUntilVisible(
      onProfile,
      300,
      scrollable: find
          .descendant(
            of: find.byType(CompanionProfilePage),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(onProfile);
    await tester.pumpAndSettle();
    // Read halfway: a drag to the end would mark the section finished.
    final reader = find.byType(SingleChildScrollView);
    final position = tester
        .state<ScrollableState>(
          find.descendant(of: reader, matching: find.byType(Scrollable)),
        )
        .position;
    expect(position.maxScrollExtent, greaterThan(0));
    await tester.drag(reader, Offset(0, -position.maxScrollExtent / 2));
    await wait(tester, const Duration(seconds: 2)); // progress is batched

    await close(tester, app);
    app = await launch(tester);

    await tab(tester, 'المحفوظات');
    expect(find.text('أبو بكر الصديق رضي الله عنه'), findsOneWidget);
    expect(find.text('تابع القراءة'), findsOneWidget);
    expect(find.text('فضائله'), findsOneWidget);

    // Continue reading reopens the section where it was left.
    await tester.tap(find.text('فضائله'));
    await tester.pumpAndSettle();
    final scrollable = tester.state<ScrollableState>(
      find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.byType(Scrollable),
      ),
    );
    expect(scrollable.position.pixels, greaterThan(0));
    await close(tester, app);
  });

  testWidgets('the Seerah journey, offline, resumes after a restart', (
    tester,
  ) async {
    var app = await launch(tester);

    /// The vertical list of the page of type [page].
    Finder listOf(Type page) => find
        .descendant(
          of: find.byType(page),
          matching: find.byWidgetPredicate(
            (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
          ),
        )
        .first;

    await tab(tester, 'السيرة');
    expect(find.byType(SeerahHubPage), findsOneWidget);
    final chapterTitle = find.descendant(
      of: find.byType(SeerahHubPage),
      matching: find.text('الهجرة إلى المدينة'),
    );
    await tester.scrollUntilVisible(
      chapterTitle,
      300,
      scrollable: listOf(SeerahHubPage),
    );
    await tester.pumpAndSettle();
    await tester.tap(chapterTitle);
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage), findsOneWidget);

    // The route graphic opens in full, from bundled data only.
    final fullView = find.descendant(
      of: find.byType(SeerahChapterPage),
      matching: find.text('عرض كامل'),
    );
    await tester.scrollUntilVisible(
      fullView.first,
      300,
      scrollable: listOf(SeerahChapterPage),
    );
    await tester.pumpAndSettle();
    await tester.tap(fullView.first);
    await tester.pumpAndSettle();
    expect(find.byType(VisualPage), findsOneWidget);
    // The system back gesture.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('حفظ'));
    await tester.pumpAndSettle();
    // Read on, short of the end, and let the batched progress save.
    final list = listOf(SeerahChapterPage);
    final position = tester.state<ScrollableState>(list).position;
    await tester.drag(
      list,
      Offset(0, -(position.maxScrollExtent / 2 - position.pixels)),
    );
    await wait(tester, const Duration(seconds: 2));

    await close(tester, app);
    app = await launch(tester);

    // Home offers the chapter again, and it opens where it was left.
    expect(find.text('تابع: الهجرة إلى المدينة'), findsOneWidget);
    await tester.tap(find.text('تابع: الهجرة إلى المدينة'));
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage), findsOneWidget);
    expect(
      tester.state<ScrollableState>(listOf(SeerahChapterPage)).position.pixels,
      greaterThan(0),
    );

    await tab(tester, 'المحفوظات');
    expect(find.text('من فصول السيرة'), findsOneWidget);
    await close(tester, app);
  });

  testWidgets('search finds a companion by title and opens the profile', (
    tester,
  ) async {
    final app = await launch(tester);
    await tester.tap(find.byTooltip('بحث'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'الفاروق');
    await wait(tester, const Duration(milliseconds: 400));
    // The companion itself (passages that mention it are listed after).
    await tester.tap(
      find.byWidgetPredicate(
        (w) =>
            w is ListTile &&
            w.title is Text &&
            (w.title! as Text).data == 'عمر بن الخطاب',
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('أبو حفص · الفاروق'), findsOneWidget);
    await close(tester, app);
  });

  testWidgets('the digit setting applies everywhere and survives a restart', (
    tester,
  ) async {
    var app = await launch(tester);
    // Settings is an app-bar action, above the tabs.
    await tester.tap(find.byTooltip('الإعدادات'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('غربية (123)'));
    await tester.pumpAndSettle();
    await close(tester, app);

    app = await launch(tester);
    await tab(tester, 'الصحابة');
    await tester.tap(find.text('أبو بكر الصديق'));
    await tester.pumpAndSettle();
    expect(
      find.text('المدينة المنورة · جمادى الآخرة 13 هـ / 634 م'),
      findsOneWidget,
    );
    await close(tester, app);
  });
}
