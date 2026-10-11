import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/features/biography/presentation/section_reader_page.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:suhba/features/bookmarks/presentation/saved_page.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';

void main() {
  Future<AppUnderTest> open(WidgetTester tester, String location) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: location);
    await app.pump(tester);
    return app;
  }

  testApp('an empty Saved tab explains itself', (tester) async {
    await open(tester, '/saved');
    expect(find.text('لا توجد محفوظات بعد'), findsOneWidget);
  });

  testApp('save a companion from the profile; it appears in Saved', (
    tester,
  ) async {
    final app = await open(tester, '/companions/umar');
    await tester.tap(find.byTooltip('حفظ'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('إزالة من المحفوظات'), findsOneWidget);
    expect(find.text('حُفظ في المحفوظات'), findsOneWidget);

    app.router.go('/saved');
    await tester.pumpAndSettle();
    expect(find.byType(SavedPage), findsOneWidget);
    expect(find.text('عمر بن الخطاب رضي الله عنه'), findsOneWidget);
  });

  testApp('a saved section shows under its group and opens the reader', (
    tester,
  ) async {
    final app = await open(tester, '/saved');
    await app.container
        .read(bookmarkRepositoryProvider)
        .toggle(
          BookmarkTarget.section,
          'abu-bakr.hijrah',
          parentId: 'abu-bakr',
        );
    await tester.pumpAndSettle();
    expect(find.text('أقسام السيرة'), findsOneWidget);
    expect(find.text('صاحبه في الهجرة'), findsOneWidget);
    await tester.tap(find.text('صاحبه في الهجرة'));
    await tester.pumpAndSettle();
    expect(find.byType(SectionReaderPage), findsOneWidget);
  });

  testApp('removing from Saved', (tester) async {
    final app = await open(tester, '/saved');
    await app.container
        .read(bookmarkRepositoryProvider)
        .toggle(BookmarkTarget.story, 'the-cave');
    await tester.pumpAndSettle();
    expect(find.text('ثاني اثنين'), findsOneWidget);
    await tester.tap(find.byTooltip('إزالة من المحفوظات'));
    await tester.pumpAndSettle();
    expect(find.text('ثاني اثنين'), findsNothing);
    expect(find.text('لا توجد محفوظات بعد'), findsOneWidget);
  });

  testApp('a saved item that no longer exists is kept and can be removed', (
    tester,
  ) async {
    final app = await open(tester, '/saved');
    final repo = app.container.read(bookmarkRepositoryProvider);
    await repo.toggle(BookmarkTarget.companion, 'gone');
    await repo.toggle(BookmarkTarget.companion, 'ali');
    await tester.pumpAndSettle();
    expect(find.text('علي بن أبي طالب رضي الله عنه'), findsOneWidget);
    expect(find.text('لم يعد هذا العنصر متاحًا'), findsOneWidget);
    expect(await repo.all(), hasLength(2), reason: 'never deleted silently');

    await tester.tap(
      find.descendant(
        of: find.widgetWithText(ListTile, 'لم يعد هذا العنصر متاحًا'),
        matching: find.byTooltip('إزالة من المحفوظات'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('لم يعد هذا العنصر متاحًا'), findsNothing);
    expect((await repo.all()).single.targetId, 'ali');
  });

  testApp('an item whose content fails to load offers a retry', (tester) async {
    final bundle = MemoryAssetBundle.builtContent();
    const file = 'assets/content/stories/the-cave.json';
    final good = bundle.files[file]!;
    bundle.files[file] = '{}';
    final app = AppUnderTest(location: '/saved', bundle: bundle);
    await app.container
        .read(bookmarkRepositoryProvider)
        .toggle(BookmarkTarget.chapter, 'the-cave.2', parentId: 'the-cave');
    await app.pump(tester);
    expect(find.text('تعذّر تحميل هذا العنصر'), findsOneWidget);

    bundle.files[file] = good;
    await tester.tap(find.byTooltip('إعادة المحاولة'));
    await tester.pumpAndSettle();
    expect(find.text('في الغار'), findsOneWidget);
  });

  testApp('a failed load of Saved is an error with retry, not "empty"', (
    tester,
  ) async {
    final real = AppUnderTest(location: '/saved');
    final failing = _FlakyBookmarks(
      real.container.read(bookmarkRepositoryProvider),
    );
    await failing.toggle(BookmarkTarget.companion, 'umar');
    final app = AppUnderTest(
      location: '/saved',
      database: real.database,
      overrides: [bookmarkRepositoryProvider.overrideWithValue(failing)],
    );
    failing.failWatch = true;
    await app.pump(tester);
    expect(find.text('لا توجد محفوظات بعد'), findsNothing);
    expect(find.textContaining('تعذّر تحميل المحفوظات'), findsOneWidget);

    failing.failWatch = false;
    await tester.tap(find.text('إعادة المحاولة'));
    await tester.pumpAndSettle();
    expect(find.text('عمر بن الخطاب رضي الله عنه'), findsOneWidget);
  });

  testApp('a failed save is reported, and nothing changes', (tester) async {
    final real = AppUnderTest(location: '/companions/umar');
    final failing = _FlakyBookmarks(
      real.container.read(bookmarkRepositoryProvider),
    )..failWrites = true;
    final app = AppUnderTest(
      location: '/companions/umar',
      database: real.database,
      overrides: [bookmarkRepositoryProvider.overrideWithValue(failing)],
    );
    await app.pump(tester);
    await tester.tap(find.byTooltip('حفظ'));
    await tester.pumpAndSettle();
    expect(find.text('تعذّر حفظ التغيير. حاول مرة أخرى.'), findsOneWidget);
    expect(find.byTooltip('حفظ'), findsOneWidget);
    expect(await failing.all(), isEmpty);
    // Logged for diagnosis, not thrown.
    expect(tester.takeException(), isA<StorageFailure>());
  });
}

/// A bookmark repository whose reads or writes can be made to fail.
class _FlakyBookmarks implements BookmarkRepository {
  _FlakyBookmarks(this._inner);

  final BookmarkRepository _inner;
  bool failWatch = false;
  bool failWrites = false;

  @override
  Stream<List<Bookmark>> watchAll() => failWatch
      ? Stream.error(const StorageFailure('disk unavailable'))
      : _inner.watchAll();

  @override
  Future<List<Bookmark>> all() => _inner.all();

  @override
  Stream<bool> watchIsSaved(BookmarkTarget target, String targetId) =>
      _inner.watchIsSaved(target, targetId);

  @override
  Future<bool> toggle(
    BookmarkTarget target,
    String targetId, {
    String? parentId,
  }) => failWrites
      ? Future.error(const StorageFailure('disk full'))
      : _inner.toggle(target, targetId, parentId: parentId);

  @override
  Future<void> remove(BookmarkTarget target, String targetId) => failWrites
      ? Future.error(const StorageFailure('disk full'))
      : _inner.remove(target, targetId);

  @override
  Future<void> restore(Bookmark bookmark) => _inner.restore(bookmark);

  @override
  Future<int> clearAll() => _inner.clearAll();
}
