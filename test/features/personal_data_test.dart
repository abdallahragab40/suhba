import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/database/app_database.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';
import 'package:siyar_sahaba/features/bookmarks/data/drift_bookmark_repository.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/reading_progress/data/drift_reading_progress_repository.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/reading_history_page.dart';

import '../helpers/app_harness.dart';

ReadingProgress _p(
  String id, {
  String parent = 'abu-bakr',
  ProgressTarget target = ProgressTarget.section,
  bool completed = true,
  double fraction = 1,
  int day = 1,
}) => ReadingProgress(
  target: target,
  targetId: id,
  parentId: parent,
  fraction: fraction,
  completed: completed,
  contentVersion: '0.1.0',
  updatedAt: DateTime(2026, 10, day),
  targetRevision: 'rev-$id',
  blockIndex: 2,
  blockOffset: 0.25,
);

/// E10: managing the reader's own data.
void main() {
  group('repositories', () {
    late AppDatabase db;
    late DriftBookmarkRepository bookmarks;
    late DriftReadingProgressRepository progress;

    setUp(() {
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      db = AppDatabase(NativeDatabase.memory());
      bookmarks = DriftBookmarkRepository(
        db,
        clock: () => DateTime(2026, 10, 9),
      );
      progress = DriftReadingProgressRepository(db);
    });
    tearDown(() => db.close());

    test('undoing a removal restores the saved item exactly', () async {
      await bookmarks.toggle(
        BookmarkTarget.section,
        'abu-bakr.hijrah',
        parentId: 'abu-bakr',
      );
      final before = (await bookmarks.all()).single;
      await bookmarks.remove(before.target, before.targetId);
      expect(await bookmarks.all(), isEmpty);
      await bookmarks.restore(before);
      expect((await bookmarks.all()).single, before);
    });

    test('undoing a reset restores the position exactly', () async {
      final before = _p('abu-bakr.hijrah', completed: false, fraction: 0.4);
      await progress.save(before);
      await progress.remove(before.target, before.targetId);
      await progress.restore(before);
      expect((await progress.all()).single, before);
    });

    test(
      'restoring never overwrites newer reading of the same passage',
      () async {
        final old = _p('abu-bakr.hijrah', completed: false, fraction: 0.4);
        await progress.save(old);
        await progress.remove(old.target, old.targetId);
        final newer = _p('abu-bakr.hijrah', completed: false, fraction: 0.8);
        await progress.save(newer);
        await progress.restore(old);
        expect((await progress.all()).single.fraction, 0.8);
      },
    );

    test('history: finished only, most recent first', () async {
      await progress.save(_p('a'));
      await progress.save(_p('b', day: 3));
      await progress.save(_p('c', completed: false, fraction: 0.5, day: 5));
      final history = await progress.watchCompleted().first;
      expect(history.map((p) => p.targetId), ['b', 'a']);
    });

    test('clearing one kind leaves the other alone', () async {
      await progress.save(_p('a'));
      await progress.save(_p('b', completed: false, fraction: 0.2));
      await bookmarks.toggle(BookmarkTarget.companion, 'umar');
      expect(await progress.clearAll(), 2);
      expect(await progress.all(), isEmpty);
      expect(await bookmarks.all(), hasLength(1));

      await progress.save(_p('a'));
      expect(await bookmarks.clearAll(), 1);
      expect(await progress.all(), hasLength(1));
    });
  });

  group('screens', () {
    void tall(WidgetTester tester) {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(600, 2400);
      addTearDown(tester.view.reset);
    }

    Future<List<ProgressRow>> rows(AppUnderTest app) =>
        app.database.select(app.database.readingProgressEntries).get();

    testApp('history lists finished passages; reset one, then undo', (
      tester,
    ) async {
      tall(tester);
      final app = AppUnderTest(location: '/saved/history');
      final repo = app.container.read(readingProgressRepositoryProvider);
      await repo.save(_p('abu-bakr.hijrah', day: 2));
      await repo.save(_p('abu-bakr.virtues', day: 4));
      await repo.save(
        _p(
          'the-cave.2',
          parent: 'the-cave',
          target: ProgressTarget.chapter,
          completed: false,
          fraction: 0.3,
        ),
      );
      await app.pump(tester);
      expect(find.byType(ReadingHistoryPage), findsOneWidget);
      expect(find.text('فضائله'), findsOneWidget);
      expect(find.text('صاحبه في الهجرة'), findsOneWidget);
      expect(find.text('في الغار'), findsNothing, reason: 'not finished');
      expect(
        tester.getTopLeft(find.text('فضائله')).dy,
        lessThan(tester.getTopLeft(find.text('صاحبه في الهجرة')).dy),
        reason: 'most recent first',
      );
      expect(find.textContaining('أُتمّت في ٤/١٠/٢٠٢٦'), findsOneWidget);

      await tester.tap(
        find.descendant(
          of: find.widgetWithText(ListTile, 'فضائله'),
          matching: find.byTooltip('إعادة تعيين التقدّم'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('فضائله'), findsNothing);
      expect(
        (await rows(app)).map((r) => r.targetId).toSet(),
        {'abu-bakr.hijrah', 'the-cave.2'},
        reason: 'only the selected record',
      );

      await tester.tap(find.text('تراجع'));
      await tester.pumpAndSettle();
      expect(find.text('فضائله'), findsOneWidget);
      expect(await rows(app), hasLength(3));
    });

    testApp('removing a saved item can be undone', (tester) async {
      tall(tester);
      final app = AppUnderTest(location: '/saved');
      await app.container
          .read(bookmarkRepositoryProvider)
          .toggle(BookmarkTarget.companion, 'umar');
      await app.pump(tester);
      await tester.tap(find.byTooltip('إزالة من المحفوظات'));
      await tester.pumpAndSettle();
      expect(find.text('أُزيل من المحفوظات.'), findsOneWidget);
      expect(find.text('عمر بن الخطاب رضي الله عنه'), findsNothing);
      await tester.tap(find.text('تراجع'));
      await tester.pumpAndSettle();
      expect(find.text('عمر بن الخطاب رضي الله عنه'), findsOneWidget);
    });

    testApp('an unfinished passage can be removed from Continue reading', (
      tester,
    ) async {
      tall(tester);
      final app = AppUnderTest(location: '/saved');
      await app.container
          .read(readingProgressRepositoryProvider)
          .save(_p('abu-bakr.hijrah', completed: false, fraction: 0.4));
      await app.pump(tester);
      await tester.tap(find.byTooltip('إزالة من «تابع القراءة»'));
      await tester.pumpAndSettle();
      expect(await rows(app), isEmpty);
      await tester.tap(find.text('تراجع'));
      await tester.pumpAndSettle();
      expect((await rows(app)).single.fraction, 0.4);
    });

    group('clearing from Settings', () {
      Future<AppUnderTest> withData(
        WidgetTester tester,
        SettingsStore settings,
      ) async {
        tall(tester);
        final app = AppUnderTest(location: '/settings', settings: settings);
        await app.container
            .read(readingProgressRepositoryProvider)
            .save(_p('abu-bakr.hijrah'));
        await app.container
            .read(readingProgressRepositoryProvider)
            .save(_p('abu-bakr.virtues', completed: false, fraction: 0.2));
        await app.container
            .read(bookmarkRepositoryProvider)
            .toggle(BookmarkTarget.companion, 'umar');
        await app.pump(tester);
        return app;
      }

      testApp('asks first; cancelling deletes nothing', (tester) async {
        final app = await withData(tester, MemorySettingsStore());
        expect(find.text('نصّان'), findsOneWidget);
        await tester.tap(find.text('مسح سجل القراءة'));
        await tester.pumpAndSettle();
        expect(find.text('مسح سجل القراءة؟'), findsOneWidget);
        expect(find.textContaining('لن تتأثر المحفوظات'), findsOneWidget);
        await tester.tap(find.text('إلغاء'));
        await tester.pumpAndSettle();
        expect(await rows(app), hasLength(2));
      });

      testApp('history: clears all positions, keeps saved items and '
          'settings', (tester) async {
        final settings = MemorySettingsStore();
        await settings.setString(SettingsKeys.digitStyle, 'western');
        final app = await withData(tester, settings);
        await tester.tap(find.text('مسح سجل القراءة'));
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(FilledButton, 'مسح'));
        await tester.pumpAndSettle();
        expect(find.text('مُسح سجل القراءة.'), findsOneWidget);
        expect(await rows(app), isEmpty);
        expect(
          await app.database.select(app.database.bookmarks).get(),
          hasLength(1),
        );
        expect(settings.getString(SettingsKeys.digitStyle), 'western');
      });

      testApp('saved items: clears them, keeps the history', (tester) async {
        final app = await withData(tester, MemorySettingsStore());
        await tester.tap(find.text('مسح المحفوظات'));
        await tester.pumpAndSettle();
        expect(find.textContaining('عنصر واحد'), findsWidgets);
        await tester.tap(find.widgetWithText(FilledButton, 'مسح'));
        await tester.pumpAndSettle();
        expect(
          await app.database.select(app.database.bookmarks).get(),
          isEmpty,
        );
        expect(await rows(app), hasLength(2));
      });
    });
  });
}
