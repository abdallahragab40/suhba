import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';

import '../helpers/app_harness.dart';
import '../helpers/content_bundle.dart';

/// T5.1: every screen, in both themes, against Flutter's accessibility
/// guidelines: tap targets (Android 48 dp, iOS 44 pt), labelled tappables,
/// and text contrast (WCAG AA).
void main() {
  const screens = <String, String>{
    'home': '/home',
    'directory': '/companions',
    'directory filtered': '/companions?category=khulafa-rashidun',
    'profile (full)': '/companions/abu-bakr',
    'profile (skeleton)': '/companions/talha',
    'profile (Ali)': '/companions/ali',
    'section reader (Uthman)': '/companions/uthman/sections/uthman.death',
    'section reader': '/companions/abu-bakr/sections/abu-bakr.hijrah',
    'timeline': '/companions/umar/timeline',
    'story': '/stories/the-cave',
    'chapter': '/stories/the-cave/chapters/the-cave.2',
    'saved': '/saved',
    'reading history': '/saved/history',
    'search': '/search',
    'settings': '/settings',
    'about': '/settings/about',
    'sources': '/settings/sources',
    'seerah hub': '/seerah',
    'seerah chapter': '/seerah/chapters/hijrah-to-madinah',
    'seerah topic': '/seerah/topics/mercy',
    'seerah timeline': '/seerah/timeline',
    'explore': '/explore',
    'event': '/events/hijrah',
    'place': '/places/makkah',
    'visual (map)': '/visuals/hijrah-route',
    'visual (relationships)': '/visuals/abu-bakr-family',
    'visual (sequence)': '/visuals/hijrah-sequence',
    'visual (place panel)': '/visuals/makkah-panel',
    'relations': '/relations',
    'relations (one companion)': '/relations?companion=zubayr',
  };

  for (final brightness in Brightness.values) {
    for (final MapEntry(key: name, value: location) in screens.entries) {
      testApp('$name (${brightness.name}) meets the guidelines', (
        tester,
      ) async {
        tester.platformDispatcher.platformBrightnessTestValue = brightness;
        addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
        final handle = tester.ensureSemantics();

        final app = AppUnderTest(
          location: location,
          // No companion is a skeleton any more; strip one for this screen.
          bundle: name == 'profile (skeleton)'
              ? MemoryAssetBundle.withSkeleton('talha')
              : null,
        );
        if (name == 'reading history') {
          await app.container
              .read(readingProgressRepositoryProvider)
              .save(
                ReadingProgress(
                  target: ProgressTarget.section,
                  targetId: 'abu-bakr.hijrah',
                  parentId: 'abu-bakr',
                  fraction: 1,
                  completed: true,
                  contentVersion: '0.1.0',
                  updatedAt: DateTime(2026, 10, 9),
                ),
              );
        }
        if (name == 'saved') {
          // Give Saved something to show.
          await app.container
              .read(bookmarkRepositoryProvider)
              .toggle(BookmarkTarget.companion, 'umar');
          await app.container
              .read(readingProgressRepositoryProvider)
              .save(
                ReadingProgress(
                  target: ProgressTarget.chapter,
                  targetId: 'the-cave.1',
                  parentId: 'the-cave',
                  fraction: 0.3,
                  completed: false,
                  contentVersion: '0.1.0',
                  updatedAt: DateTime(2026, 10, 9),
                ),
              );
        }
        await app.pump(tester);
        if (name == 'search') {
          await tester.enterText(find.byType(TextField), 'عمر');
          await tester.pump(const Duration(milliseconds: 200));
          await tester.pumpAndSettle();
        }

        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
    }
  }

  testApp('every screen survives text scale 2.0 without overflow', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    for (final location in screens.values) {
      final app = AppUnderTest(location: location);
      await app.pump(tester);
      expect(tester.takeException(), isNull, reason: location);
    }
  });

  // A phone on its side: little height for the bars and the content.
  for (final MapEntry(key: name, value: location) in screens.entries) {
    testApp('$name fits a landscape phone without overflow', (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(900, 400);
      addTearDown(tester.view.reset);
      await AppUnderTest(location: location).pump(tester);
      expect(tester.takeException(), isNull, reason: location);
    });
  }
}
