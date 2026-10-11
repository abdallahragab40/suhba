import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/share/share_service.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/personal_data/data/file_opener.dart';
import 'package:siyar_sahaba/features/personal_data/domain/reading_data_archive.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/recording_share.dart';

class _FakeOpener implements FileOpener {
  _FakeOpener(this.text);

  /// What the "chosen" file holds; null when the reader cancels.
  final String? text;

  @override
  Future<String?> openJsonText() async => text;
}

ReadingProgress _p(
  String id, {
  bool completed = false,
  double fraction = 0.4,
  int day = 1,
}) => ReadingProgress(
  target: ProgressTarget.section,
  targetId: id,
  parentId: 'abu-bakr',
  fraction: fraction,
  completed: completed,
  contentVersion: '0.1.0',
  updatedAt: DateTime.utc(2026, 10, day),
);

Bookmark _companion(String id) => Bookmark(
  target: BookmarkTarget.companion,
  targetId: id,
  createdAt: DateTime.utc(2026, 10, 2),
);

/// E10: exporting and importing saved items and reading positions.
void main() {
  void tall(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
  }

  Future<AppUnderTest> settings(
    WidgetTester tester, {
    String? file,
    RecordingShare? share,
    List<Bookmark> bookmarks = const [],
    List<ReadingProgress> progress = const [],
  }) async {
    tall(tester);
    final app = AppUnderTest(
      location: '/settings',
      overrides: [
        fileOpenerProvider.overrideWithValue(_FakeOpener(file)),
        shareServiceProvider.overrideWithValue(share ?? RecordingShare()),
      ],
    );
    for (final b in bookmarks) {
      await app.container.read(bookmarkRepositoryProvider).restore(b);
    }
    for (final p in progress) {
      await app.container.read(readingProgressRepositoryProvider).save(p);
    }
    await app.pump(tester);
    return app;
  }

  Future<List<ReadingProgress>> positions(AppUnderTest app) =>
      app.container.read(readingProgressRepositoryProvider).all();
  Future<List<Bookmark>> saved(AppUnderTest app) =>
      app.container.read(bookmarkRepositoryProvider).all();

  String export({
    List<Bookmark> bookmarks = const [],
    List<ReadingProgress> progress = const [],
  }) => encodeArchive(
    ReadingDataArchive(
      bookmarks: bookmarks,
      progress: progress,
      exportedAt: DateTime.utc(2026, 10, 10),
    ),
  );

  testApp('export hands a dated JSON file to the share sheet', (tester) async {
    final share = RecordingShare();
    await settings(
      tester,
      share: share,
      bookmarks: [_companion('umar')],
      progress: [_p('abu-bakr.hijrah'), _p('abu-bakr.virtues', day: 2)],
    );
    await tester.tap(find.text('تصدير بيانات القراءة'));
    await tester.pumpAndSettle();

    final file = share.files.single;
    expect(file.name, 'siyar-sahaba-reading-data-2026-10-09.json');
    expect(file.mimeType, 'application/json');
    final archive = (decodeArchive(file.content) as ArchiveDecoded).archive;
    expect(archive.bookmarks.single.targetId, 'umar');
    expect(archive.progress.map((p) => p.targetId), [
      'abu-bakr.virtues',
      'abu-bakr.hijrah',
    ]);
  });

  testApp('there is nothing to export on an empty device', (tester) async {
    await settings(tester);
    final tile = tester.widget<ListTile>(
      find.ancestor(
        of: find.text('تصدير بيانات القراءة'),
        matching: find.byType(ListTile),
      ),
    );
    expect(tile.enabled, isFalse);
  });

  testApp('import says what it will add, then adds it', (tester) async {
    final file = export(
      bookmarks: [_companion('umar')],
      progress: [_p('abu-bakr.hijrah'), _p('abu-bakr.virtues')],
    );
    final app = await settings(tester, file: file);
    await tester.tap(find.text('استيراد بيانات القراءة'));
    await tester.pumpAndSettle();
    expect(find.textContaining('عنصر واحد'), findsOneWidget);
    expect(find.textContaining('نصّان'), findsWidgets);
    expect(find.textContaining('لا يُحذف شيء'), findsWidgets);

    await tester.tap(find.widgetWithText(FilledButton, 'استيراد'));
    await tester.pumpAndSettle();
    expect(find.text('تم الاستيراد.'), findsOneWidget);
    final umar = (await saved(app)).single;
    expect((umar.target, umar.targetId), (BookmarkTarget.companion, 'umar'));
    // Saved with its original date, not the date of the import.
    expect(
      umar.createdAt.isAtSameMomentAs(_companion('umar').createdAt),
      isTrue,
    );
    expect((await positions(app)).map((p) => p.targetId), {
      'abu-bakr.hijrah',
      'abu-bakr.virtues',
    });
  });

  testApp('cancelling the confirmation writes nothing', (tester) async {
    final app = await settings(
      tester,
      file: export(bookmarks: [_companion('umar')]),
    );
    await tester.tap(find.text('استيراد بيانات القراءة'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('إلغاء'));
    await tester.pumpAndSettle();
    expect(await saved(app), isEmpty);
  });

  testApp('cancelling the file chooser does nothing', (tester) async {
    await settings(tester);
    await tester.tap(find.text('استيراد بيانات القراءة'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
  });

  testApp('a file from elsewhere is refused and nothing changes', (
    tester,
  ) async {
    final app = await settings(
      tester,
      file: '{"bookmarks": []}',
      bookmarks: [_companion('ali')],
    );
    await tester.tap(find.text('استيراد بيانات القراءة'));
    await tester.pumpAndSettle();
    expect(
      find.text('هذا الملف ليس تصديرًا لبيانات القراءة من هذا التطبيق.'),
      findsOneWidget,
    );
    await tester.tap(find.text('حسنًا'));
    await tester.pumpAndSettle();
    expect((await saved(app)).single.targetId, 'ali');
  });

  testApp('an invalid record names where it is', (tester) async {
    final file = export(
      progress: [_p('abu-bakr.hijrah')],
    ).replaceFirst('"fraction": 0.4', '"fraction": 4');
    await settings(tester, file: file);
    await tester.tap(find.text('استيراد بيانات القراءة'));
    await tester.pumpAndSettle();
    expect(find.textContaining('progress[0].fraction'), findsOneWidget);
  });

  testApp('a file with nothing new says so', (tester) async {
    final hijrah = _p('abu-bakr.hijrah', day: 5);
    await settings(
      tester,
      file: export(progress: [hijrah]),
      progress: [hijrah],
    );
    await tester.tap(find.text('استيراد بيانات القراءة'));
    await tester.pumpAndSettle();
    expect(
      find.text('لا جديد في هذا الملف؛ كل ما فيه موجود على هذا الجهاز.'),
      findsOneWidget,
    );
  });

  testApp('imported data is checked against the content like a new build', (
    tester,
  ) async {
    final file = export(
      bookmarks: [_companion('no-such-companion')],
      progress: [_p('abu-bakr.hijrah'), _p('abu-bakr.no-such-section')],
    );
    final app = await settings(tester, file: file);
    await tester.tap(find.text('استيراد بيانات القراءة'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'استيراد'));
    await tester.pumpAndSettle();
    // A position in a passage that does not exist cannot be shown: dropped.
    expect((await positions(app)).map((p) => p.targetId), ['abu-bakr.hijrah']);
    // A saved item is never deleted; Saved shows it as unavailable.
    expect((await saved(app)).single.targetId, 'no-such-companion');
  });

  testApp('a later position on this device is not moved back', (tester) async {
    final app = await settings(
      tester,
      file: export(
        bookmarks: [_companion('umar')],
        progress: [_p('abu-bakr.hijrah', fraction: 0.1)],
      ),
      progress: [_p('abu-bakr.hijrah', fraction: 0.8, day: 9)],
    );
    await tester.tap(find.text('استيراد بيانات القراءة'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'استيراد'));
    await tester.pumpAndSettle();
    expect((await positions(app)).single.fraction, 0.8);
    expect((await saved(app)).single.targetId, 'umar');
  });
}
