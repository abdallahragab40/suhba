@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';

import '../helpers/app_harness.dart';
import '../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);

  void frame(WidgetTester tester, Brightness brightness) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(400, 900);
    tester.platformDispatcher.platformBrightnessTestValue = brightness;
    addTearDown(() {
      tester.view.reset();
      tester.platformDispatcher.clearPlatformBrightnessTestValue();
    });
  }

  Future<void> snapshot(String name) => expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('goldens/$name.png'),
  );

  for (final brightness in Brightness.values) {
    testApp('home, ${brightness.name}', (tester) async {
      frame(tester, brightness);
      await AppUnderTest().pump(tester);
      await snapshot('home_${brightness.name}');
    });
  }

  testApp('saved with progress and bookmarks, light', (tester) async {
    frame(tester, Brightness.light);
    final app = AppUnderTest(location: '/saved');
    await app.container
        .read(readingProgressRepositoryProvider)
        .save(
          ReadingProgress(
            target: ProgressTarget.section,
            targetId: 'abu-bakr.hijrah',
            parentId: 'abu-bakr',
            fraction: 0.35,
            completed: false,
            contentVersion: '0.1.0',
            updatedAt: DateTime(2026, 10, 9),
          ),
        );
    final bookmarks = app.container.read(bookmarkRepositoryProvider);
    await bookmarks.toggle(BookmarkTarget.companion, 'umar');
    await bookmarks.toggle(BookmarkTarget.story, 'the-cave');
    await app.pump(tester);
    await snapshot('saved_light');
  });

  testApp('search results, light', (tester) async {
    frame(tester, Brightness.light);
    await AppUnderTest(location: '/search').pump(tester);
    await tester.enterText(find.byType(TextField), 'الهجرة');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();
    await snapshot('search_light');
  });

  for (final brightness in Brightness.values) {
    testApp('relationship explorer, ${brightness.name}', (tester) async {
      frame(tester, brightness);
      await AppUnderTest(location: '/relations').pump(tester);
      await snapshot('relations_${brightness.name}');
    });
  }

  testApp('relationship explorer for one companion, light', (tester) async {
    frame(tester, Brightness.light);
    await AppUnderTest(location: '/relations?companion=zubayr').pump(tester);
    await snapshot('relations_zubayr_light');
  });

  testApp('settings, light', (tester) async {
    frame(tester, Brightness.light);
    await AppUnderTest(location: '/settings').pump(tester);
    await snapshot('settings_light');
  });

  testApp('about, dark', (tester) async {
    frame(tester, Brightness.dark);
    await AppUnderTest(location: '/settings/about').pump(tester);
    await snapshot('about_dark');
  });
}
