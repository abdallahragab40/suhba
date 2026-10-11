import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/settings/presentation/reading_settings.dart';
import 'package:suhba/shared/content/presentation/reader_scaffold.dart';

import '../../helpers/app_harness.dart';

/// E06: positions anchored to blocks resume at the same text after text
/// size or screen changes; short passages are finished explicitly.
void main() {
  const hijrah = '/companions/abu-bakr/sections/abu-bakr.hijrah';
  const lessons = '/companions/abu-bakr/sections/abu-bakr.lessons';

  void view(WidgetTester tester, Size size) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = size;
    addTearDown(tester.view.reset);
  }

  Future<ProgressRow?> row(AppUnderTest app, String id) => (app.database.select(
    app.database.readingProgressEntries,
  )..where((p) => p.targetId.equals(id))).getSingleOrNull();

  /// The block whose box spans the top edge of the reading viewport.
  int? blockAtTop(WidgetTester tester) {
    final top = tester.getRect(find.byType(SingleChildScrollView)).top;
    for (final element in find.byType(ReaderAnchor).evaluate()) {
      final anchor = element.widget as ReaderAnchor;
      final rect = tester.getRect(find.byWidget(anchor));
      if (rect.top <= top + 1 && rect.bottom > top + 1) return anchor.index;
    }
    return null;
  }

  /// How far into block [index] the top of the viewport is (0–1).
  double offsetInBlock(WidgetTester tester, int index) {
    final top = tester.getRect(find.byType(SingleChildScrollView)).top;
    final rect = tester.getRect(
      find.byWidgetPredicate((w) => w is ReaderAnchor && w.index == index),
    );
    return (top - rect.top) / rect.height;
  }

  /// Scrolls until block [index] spans the top of the viewport.
  Future<void> scrollToBlock(WidgetTester tester, int index) async {
    final reader = find.byType(SingleChildScrollView);
    final viewportTop = tester.getRect(reader).top;
    final anchor = find.byWidgetPredicate(
      (w) => w is ReaderAnchor && w.index == index,
    );
    final rect = tester.getRect(anchor);
    // A third of the way into the block.
    final target = rect.top + rect.height / 3 - viewportTop;
    await tester.drag(reader, Offset(0, -target));
    await tester.pumpAndSettle();
    expect(blockAtTop(tester), index);
  }

  testApp('resumes at the same text after the text size and screen changed', (
    tester,
  ) async {
    view(tester, const Size(400, 700));
    final db = AppDatabase(NativeDatabase.memory());
    final settings = MemorySettingsStore();
    final first = AppUnderTest(
      location: '/companions/abu-bakr',
      database: db,
      settings: settings,
    );
    await first.pump(tester);
    unawaited(first.router.push(hijrah));
    await tester.pumpAndSettle();
    await scrollToBlock(tester, 2);
    final before = offsetInBlock(tester, 2);
    await tester.binding.handlePopRoute(); // leaving saves at once
    await tester.pumpAndSettle();
    final saved = (await row(first, 'abu-bakr.hijrah'))!;
    expect(saved.blockIndex, 2);
    expect(saved.blockOffset, closeTo(before, 0.01));

    // Much larger text on a turned screen: every block moves, and the
    // fraction no longer points at the same words.
    await settings.setDouble(SettingsKeys.readingTextSize, 28);
    tester.view.physicalSize = const Size(900, 400);
    final second = AppUnderTest(
      location: hijrah,
      database: db,
      settings: settings,
    );
    await second.pump(tester);
    expect(blockAtTop(tester), 2);
  });

  testApp('keeps the same block in view while the text size changes', (
    tester,
  ) async {
    view(tester, const Size(400, 700));
    final app = AppUnderTest(location: hijrah);
    await app.pump(tester);
    await scrollToBlock(tester, 2);
    final before = offsetInBlock(tester, 2);

    for (final size in [28.0, 16.0]) {
      app.container.read(readingTextSizeProvider.notifier).select(size);
      await tester.pumpAndSettle();
      expect(blockAtTop(tester), 2, reason: 'size $size');
      expect(offsetInBlock(tester, 2), closeTo(before, 0.01));
    }
  });

  testApp('keeps the same block in view when the screen turns', (tester) async {
    view(tester, const Size(400, 700));
    final app = AppUnderTest(location: hijrah);
    await app.pump(tester);
    await scrollToBlock(tester, 2);
    final before = offsetInBlock(tester, 2);

    tester.view.physicalSize = const Size(700, 400);
    await tester.pumpAndSettle();
    expect(blockAtTop(tester), 2);
    expect(offsetInBlock(tester, 2), closeTo(before, 0.01));
  });

  group('a passage shorter than the screen', () {
    testApp('is not finished by opening it', (tester) async {
      view(tester, const Size(600, 2400));
      final app = AppUnderTest(location: lessons);
      await app.pump(tester);
      await tester.pump(const Duration(seconds: 3));
      expect(await row(app, 'abu-bakr.lessons'), isNull);
      expect(find.text('أنهيتُ القراءة'), findsOneWidget);
    });

    testApp('is finished explicitly, and can be read again', (tester) async {
      view(tester, const Size(600, 2400));
      final app = AppUnderTest(location: lessons);
      await app.pump(tester);

      await tester.tap(find.text('أنهيتُ القراءة'));
      await tester.pumpAndSettle();
      expect((await row(app, 'abu-bakr.lessons'))!.completed, isTrue);
      expect(find.text('أتممتَ قراءة هذا النص.'), findsOneWidget);

      await tester.tap(find.text('اقرأه من جديد'));
      await tester.pumpAndSettle();
      expect(await row(app, 'abu-bakr.lessons'), isNull);
      expect(find.text('أنهيتُ القراءة'), findsOneWidget);
      expect(find.byType(PassageCompletion), findsOneWidget);
    });
  });

  testApp('reading again after finishing a long passage starts over', (
    tester,
  ) async {
    view(tester, const Size(400, 700));
    final app = AppUnderTest(location: hijrah);
    await app.pump(tester);
    await tester.fling(
      find.byType(SingleChildScrollView),
      const Offset(0, -5000),
      5000,
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    expect((await row(app, 'abu-bakr.hijrah'))!.completed, isTrue);

    await tester.ensureVisible(find.text('اقرأه من جديد'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('اقرأه من جديد'));
    await tester.pumpAndSettle();
    expect(await row(app, 'abu-bakr.hijrah'), isNull);
    final reader = tester.state<ScrollableState>(
      find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.byType(Scrollable),
      ),
    );
    expect(reader.position.pixels, 0, reason: 'back to the title');
    // Further reading is recorded afresh, not as finished.
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -200),
    );
    await tester.pump(const Duration(seconds: 2));
    expect((await row(app, 'abu-bakr.hijrah'))!.completed, isFalse);
  });
}
