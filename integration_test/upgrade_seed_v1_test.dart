// Built only from the pinned 1.0 checkout by tool/check_android_upgrade.sh.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/bookmarks/data/drift_bookmark_repository.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/reading_progress/data/drift_reading_progress_repository.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    '1.0 seeds real SQLite and preferences for an install upgrade',
    (tester) async {
      final info = await PackageInfo.fromPlatform();
      // Fail before opening or writing any data if the wrong APK was installed.
      expect(info.packageName, 'com.abdallahragab.suhba.integration_test');
      expect(info.version, '1.0.0');
      final db = AppDatabase.open();
      expect(db.schemaVersion, 3);
      final storedVersion = await db
          .customSelect('PRAGMA user_version')
          .getSingle();
      expect(storedVersion.data.values.single, 3);
      expect(await db.select(db.bookmarks).get(), isEmpty);
      expect(await db.select(db.readingProgressEntries).get(), isEmpty);
      final saved = DriftBookmarkRepository(
        db,
        clock: () => DateTime.utc(2026, 11, 1, 12),
      );
      const targets = [
        (BookmarkTarget.companion, 'abu-bakr', null),
        (BookmarkTarget.section, 'abu-bakr.hijrah', 'abu-bakr'),
        (BookmarkTarget.story, 'the-archers-of-uhud', null),
        (
          BookmarkTarget.chapter,
          'the-archers-of-uhud.3',
          'the-archers-of-uhud',
        ),
        (BookmarkTarget.seerahChapter, 'hijrah-to-madinah', 'seerah'),
        (BookmarkTarget.seerahTopic, 'mercy', 'seerah'),
      ];
      for (final (target, id, parent) in targets) {
        await saved.toggle(target, id, parentId: parent);
      }
      final progress = DriftReadingProgressRepository(db);
      const readings = [
        (ProgressTarget.section, 'abu-bakr.hijrah', 'abu-bakr'),
        (
          ProgressTarget.chapter,
          'the-archers-of-uhud.3',
          'the-archers-of-uhud',
        ),
        (ProgressTarget.seerahChapter, 'hijrah-to-madinah', 'seerah'),
        (ProgressTarget.seerahTopic, 'mercy', 'seerah'),
      ];
      for (final (index, (target, id, parent)) in readings.indexed) {
        await progress.save(
          ReadingProgress(
            target: target,
            targetId: id,
            parentId: parent,
            fraction: index == 3 ? 1 : 0.25 + index * 0.2,
            completed: index == 3,
            contentVersion: '0.3.0',
            updatedAt: DateTime.utc(2026, 11, 1, 12, index),
            blockIndex: index + 1,
            blockOffset: 0.15 + index * 0.1,
          ),
        );
      }
      final settings = await PrefsSettingsStore.open();
      const strings = {
        'welcomeSeen': '1',
        'themeMode': 'dark',
        'digitStyle': 'western',
        'haptics': 'off',
      };
      const doubles = {
        'readingTextSize': 23.0,
        'quizBest.mixed': 9.0,
        'quizBest.companions': 7.0,
        'quizBest.seerah': 6.0,
      };
      for (final entry in strings.entries) {
        await settings.setString(entry.key, entry.value);
      }
      for (final entry in doubles.entries) {
        await settings.setDouble(entry.key, entry.value);
      }
      final bookmarks = await db
          .customSelect(
            'SELECT * FROM bookmarks ORDER BY target_type, target_id',
          )
          .get();
      final positions = await db
          .customSelect(
            'SELECT * FROM reading_progress_entries ORDER BY target_type, target_id',
          )
          .get();
      final snapshot = File(
        '${(await getApplicationDocumentsDirectory()).path}/v1-upgrade-snapshot.json',
      );
      await snapshot.writeAsString(
        jsonEncode({
          'schema': 3,
          'bookmarks': bookmarks.map((r) => r.data).toList(),
          'positions': positions.map((r) => r.data).toList(),
          'strings': strings,
          'doubles': doubles,
        }),
      );
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Text('1.0 upgrade data ready'))),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(db.close);
      debugPrintSynchronously(
        'UPGRADE_V1_SEEDED 6 bookmarks, 4 positions, 3 quiz best scores',
      );
    },
    skip: !const bool.fromEnvironment('SUHBA_UPGRADE_SEED'),
  );
}
