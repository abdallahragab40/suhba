import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/database/app_database.dart';
import 'package:siyar_sahaba/core/result/failure.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/continue_reading.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

import '../../helpers/app_harness.dart';

void main() {
  // A short view, so the passage scrolls.
  void shortView(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(400, 700);
    addTearDown(tester.view.reset);
  }

  const virtues = '/companions/abu-bakr/sections/abu-bakr.virtues';

  // A one-shot query: awaiting a Drift *stream* inside a widget test would
  // wait on a timer the fake clock never fires.
  Future<ProgressRow?> row(AppUnderTest app, String id) => (app.database.select(
    app.database.readingProgressEntries,
  )..where((p) => p.targetId.equals(id))).getSingleOrNull();

  Future<ProgressRow?> saved(AppUnderTest app) => row(app, 'abu-bakr.virtues');

  testApp('scrolling records the position, batched', (tester) async {
    shortView(tester);
    final app = AppUnderTest(location: virtues);
    await app.pump(tester);
    expect(await saved(app), isNull);

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -400),
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(await saved(app), isNull, reason: 'not before the interval');

    await tester.pump(const Duration(seconds: 2));
    final p = await saved(app);
    expect(p, isNotNull);
    expect(p!.fraction, greaterThan(0));
    expect(p.completed, isFalse);
    expect(p.parentId, 'abu-bakr');
    expect(p.contentVersion, '0.1.0');
  });

  testApp('reaching the end completes the passage', (tester) async {
    shortView(tester);
    final app = AppUnderTest(location: virtues);
    await app.pump(tester);
    await tester.fling(
      find.byType(SingleChildScrollView),
      const Offset(0, -5000),
      5000,
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    expect((await saved(app))!.completed, isTrue);
  });

  testApp('leaving the reader saves at once', (tester) async {
    shortView(tester);
    final app = AppUnderTest(location: '/companions/abu-bakr');
    await app.pump(tester);
    unawaited(app.router.push(virtues));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -300),
    );
    await tester.pump();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(await saved(app), isNotNull);
  });

  testApp('reopening restores the position', (tester) async {
    shortView(tester);
    final db = AppDatabase(NativeDatabase.memory());
    final first = AppUnderTest(location: virtues, database: db);
    await first.container
        .read(readingProgressRepositoryProvider)
        .save(
          ReadingProgress(
            target: ProgressTarget.section,
            targetId: 'abu-bakr.virtues',
            parentId: 'abu-bakr',
            fraction: 0.6,
            completed: false,
            contentVersion: '0.1.0',
            updatedAt: DateTime(2026, 10, 9),
          ),
        );
    await first.pump(tester);
    final scrollable = tester.state<ScrollableState>(
      find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.byType(Scrollable),
      ),
    );
    final position = scrollable.position;
    expect(position.pixels, greaterThan(0));
    // Within one screen of the saved spot.
    expect(
      (position.pixels - 0.6 * position.maxScrollExtent).abs(),
      lessThan(position.viewportDimension),
    );
  });

  testApp('unfinished reading appears in "continue reading"', (tester) async {
    final app = AppUnderTest(location: '/saved');
    await app.container
        .read(readingProgressRepositoryProvider)
        .save(
          ReadingProgress(
            target: ProgressTarget.chapter,
            targetId: 'the-cave.2',
            parentId: 'the-cave',
            fraction: 0.42,
            completed: false,
            contentVersion: '0.1.0',
            updatedAt: DateTime(2026, 10, 9),
          ),
        );
    await app.pump(tester);
    expect(find.text('تابع القراءة'), findsOneWidget);
    expect(find.byType(ContinueReadingTile), findsOneWidget);
    expect(find.text('في الغار'), findsOneWidget);
    expect(find.text('قُرئ ٤٢٪'), findsOneWidget);
  });

  testApp('a position in a passage that no longer exists is removed', (
    tester,
  ) async {
    final app = AppUnderTest(location: '/saved');
    final repo = app.container.read(readingProgressRepositoryProvider);
    await repo.save(
      ReadingProgress(
        target: ProgressTarget.section,
        targetId: 'abu-bakr.removed',
        parentId: 'abu-bakr',
        fraction: 0.5,
        completed: false,
        contentVersion: '0.0.9',
        updatedAt: DateTime(2026, 10, 9),
      ),
    );
    await app.pump(tester);
    await tester.pumpAndSettle();
    expect(await row(app, 'abu-bakr.removed'), isNull);
    expect(find.byType(ContinueReadingTile), findsNothing);
  });

  group('a position saved against another text of the passage', () {
    Future<String> currentRevision(AppUnderTest app) async {
      final c = await app.container.read(companionProvider('abu-bakr').future);
      return c.sections.firstWhere((s) => s.id == 'abu-bakr.virtues').revision;
    }

    Future<AppUnderTest> openWith(
      WidgetTester tester,
      String Function(String current) revision,
    ) async {
      shortView(tester);
      final app = AppUnderTest(location: virtues);
      final current = await currentRevision(app);
      await app.container
          .read(readingProgressRepositoryProvider)
          .save(
            ReadingProgress(
              target: ProgressTarget.section,
              targetId: 'abu-bakr.virtues',
              parentId: 'abu-bakr',
              fraction: 0.6,
              completed: false,
              contentVersion: '0.1.0',
              updatedAt: DateTime(2026, 10, 9),
              targetRevision: revision(current),
            ),
          );
      await app.pump(tester);
      return app;
    }

    ScrollPosition readerPosition(WidgetTester tester) => tester
        .state<ScrollableState>(
          find.descendant(
            of: find.byType(SingleChildScrollView),
            matching: find.byType(Scrollable),
          ),
        )
        .position;

    testApp('same revision: restored without a word', (tester) async {
      await openWith(tester, (current) => current);
      expect(readerPosition(tester).pixels, greaterThan(0));
      expect(find.text('موضعي السابق'), findsNothing);
    });

    testApp('edited: opens at the top and offers the old position', (
      tester,
    ) async {
      await openWith(tester, (_) => 'an-older-text');
      expect(readerPosition(tester).pixels, 0);
      expect(
        find.text('تغيّر هذا النص منذ قراءتك الأخيرة، فعرضناه من أوله.'),
        findsOneWidget,
      );

      await tester.tap(find.text('موضعي السابق'));
      await tester.pumpAndSettle();
      final position = readerPosition(tester);
      expect(
        (position.pixels - 0.6 * position.maxScrollExtent).abs(),
        lessThan(1),
      );
    });
  });

  testApp('a failed save is reported and retried on the next flush', (
    tester,
  ) async {
    shortView(tester);
    final real = AppUnderTest(location: '/companions/abu-bakr');
    final flaky = _FlakyProgress(
      real.container.read(readingProgressRepositoryProvider),
    )..failSaves = true;
    final app = AppUnderTest(
      location: '/companions/abu-bakr',
      database: real.database,
      overrides: [readingProgressRepositoryProvider.overrideWithValue(flaky)],
    );
    await app.pump(tester);
    unawaited(app.router.push(virtues));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -300),
    );
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('تعذّر حفظ موضع القراءة.'), findsOneWidget);
    expect(tester.takeException(), isA<StorageFailure>());
    expect(await saved(app), isNull);

    // Storage recovers: leaving the reader writes the kept position.
    flaky.failSaves = false;
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect((await saved(app))!.fraction, greaterThan(0));
  });

  testApp('leaving right after reaching the end keeps it finished', (
    tester,
  ) async {
    shortView(tester);
    final app = AppUnderTest(location: '/companions/abu-bakr');
    await app.pump(tester);
    unawaited(app.router.push(virtues));
    await tester.pumpAndSettle();
    await tester.fling(
      find.byType(SingleChildScrollView),
      const Offset(0, -5000),
      5000,
    );
    await tester.pumpAndSettle();
    // Back before the batching interval ends.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    final p = (await saved(app))!;
    expect(p.completed, isTrue);
    expect(p.targetRevision, isNotNull);
  });
}

/// A progress repository whose saves can be made to fail.
class _FlakyProgress implements ReadingProgressRepository {
  _FlakyProgress(this._inner);

  final ReadingProgressRepository _inner;
  bool failSaves = false;

  @override
  Future<void> save(ReadingProgress progress) => failSaves
      ? Future.error(const StorageFailure('disk full'))
      : _inner.save(progress);

  @override
  Stream<ReadingProgress?> watch(ProgressTarget target, String targetId) =>
      _inner.watch(target, targetId);

  @override
  Stream<List<ReadingProgress>> watchInProgress({int limit = 10}) =>
      _inner.watchInProgress(limit: limit);

  @override
  Future<List<ReadingProgress>> all() => _inner.all();

  @override
  Stream<List<ReadingProgress>> watchForParent(
    ProgressTarget target,
    String parentId,
  ) => _inner.watchForParent(target, parentId);

  @override
  Future<void> remove(ProgressTarget target, String targetId) =>
      _inner.remove(target, targetId);

  @override
  Future<void> confirmRevision(
    ProgressTarget target,
    String targetId, {
    required String revision,
    required String contentVersion,
  }) => _inner.confirmRevision(
    target,
    targetId,
    revision: revision,
    contentVersion: contentVersion,
  );

  @override
  Stream<List<ReadingProgress>> watchCompleted() => _inner.watchCompleted();

  @override
  Stream<List<ReadingProgress>> watchAll() => _inner.watchAll();

  @override
  Future<void> restore(ReadingProgress progress) => _inner.restore(progress);

  @override
  Future<int> clearAll() => _inner.clearAll();
}
