// Built only from the pinned 2.0 checkout (ae0f338) by
// tool/check_android_upgrade.sh. Uses 2.0's own repositories to store what a
// 2.0 closed tester can have, then snapshots the raw rows for the verifier.
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
import 'package:suhba/features/journeys/data/drift_journey_repository.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/reading_progress/data/drift_reading_progress_repository.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reminders/domain/reading_reminder.dart';
import 'package:suhba/features/review/data/drift_review_repository.dart';
import 'package:suhba/features/review/domain/review_item.dart';

/// Every user table and its key order, as 2.0 (schema 5) defines them.
const _tables = {
  'bookmarks': 'target_type, target_id',
  'reading_progress_entries': 'target_type, target_id',
  'review_items': 'question_key',
  'journey_enrollments': 'journey_id',
  'journey_progress_entries': 'journey_id, step_id',
};

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    '2.0 seeds real SQLite and preferences for an install upgrade',
    (tester) async {
      final info = await PackageInfo.fromPlatform();
      // Fail before opening or writing any data if the wrong APK was installed.
      expect(info.packageName, 'com.abdallahragab.suhba.integration_test');
      expect(info.version, const String.fromEnvironment('SUHBA_UPGRADE_FROM'));
      final db = AppDatabase.open();
      expect(db.schemaVersion, 5);
      final storedVersion = await db
          .customSelect('PRAGMA user_version')
          .getSingle();
      expect(storedVersion.data.values.single, 5);
      for (final table in _tables.keys) {
        final rows = await db.customSelect('SELECT * FROM $table').get();
        expect(rows, isEmpty, reason: '$table must start empty');
      }

      final saved = DriftBookmarkRepository(
        db,
        clock: () => DateTime.utc(2026, 11, 12, 12),
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
            contentVersion: '2.0.0',
            updatedAt: DateTime.utc(2026, 11, 12, 12, index),
            blockIndex: index + 1,
            blockOffset: 0.15 + index * 0.1,
          ),
        );
      }

      // Spaced review history: unknown keys are retained by design, so these
      // need not match the current generated questions.
      final review = DriftReviewRepository(db);
      for (final (index, key) in [
        'kunya:abu-bakr',
        'kunya-of:umar',
        'death-place:uthman',
      ].indexed) {
        await review.save(
          ReviewItem(
            questionKey: key,
            box: index + 1,
            dueOn: DateTime.utc(2026, 11, 14 + index),
            lastAnsweredAt: DateTime.utc(2026, 11, 12, 20, index),
            timesRight: index + 1,
            timesWrong: index,
          ),
        );
      }

      // Journeys: one in progress (a finished step, a started step), one
      // paused. Real journey and step IDs, so reconciliation keeps them as is.
      final journeys = DriftJourneyRepository(db);
      final started = DateTime.utc(2026, 11, 11, 18);
      await journeys.saveEnrollment(
        JourneyEnrollment(
          journeyId: 'meet-the-companions',
          startedAt: started,
          updatedAt: DateTime.utc(2026, 11, 12, 18),
          paused: false,
        ),
      );
      await journeys.saveStep(
        JourneyStepProgress(
          journeyId: 'meet-the-companions',
          stepId: 'meet-the-companions.abu-bakr',
          startedAt: started,
          updatedAt: DateTime.utc(2026, 11, 11, 19),
          completedAt: DateTime.utc(2026, 11, 11, 19),
          answeredKeys: const {'kunya:abu-bakr'},
        ),
      );
      await journeys.saveStep(
        JourneyStepProgress(
          journeyId: 'meet-the-companions',
          stepId: 'meet-the-companions.umar',
          startedAt: started,
          updatedAt: DateTime.utc(2026, 11, 12, 18),
        ),
      );
      await journeys.saveEnrollment(
        JourneyEnrollment(
          journeyId: 'seerah-in-thirty-steps',
          startedAt: DateTime.utc(2026, 11, 10, 7),
          updatedAt: DateTime.utc(2026, 11, 10, 8),
          paused: true,
        ),
      );
      await journeys.saveStep(
        JourneyStepProgress(
          journeyId: 'seerah-in-thirty-steps',
          stepId: 'seerah-in-thirty-steps.birth',
          startedAt: DateTime.utc(2026, 11, 10, 7),
          updatedAt: DateTime.utc(2026, 11, 10, 8),
          completedAt: DateTime.utc(2026, 11, 10, 8),
        ),
      );

      final settings = await PrefsSettingsStore.open();
      // An explicit choice, unlike 2.1's new light default; the reminder is
      // stored but off, so the verifier never schedules a notification.
      final strings = {
        'welcomeSeen': '1',
        'themeMode': 'dark',
        'digitStyle': 'western',
        'haptics': 'off',
        SettingsKeys.readingReminder: const ReadingReminder(
          hour: 7,
          minute: 30,
          permissionRequested: true,
        ).encode(),
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

      final tables = <String, List<Map<String, Object?>>>{};
      for (final MapEntry(key: table, value: order) in _tables.entries) {
        tables[table] = [
          for (final row
              in await db
                  .customSelect('SELECT * FROM $table ORDER BY $order')
                  .get())
            row.data,
        ];
      }
      final snapshot = File(
        '${(await getApplicationDocumentsDirectory()).path}/upgrade-snapshot.json',
      );
      await snapshot.writeAsString(
        jsonEncode({
          'fromVersion': info.version,
          'schema': db.schemaVersion,
          'tables': tables,
          'orders': _tables,
          'strings': strings,
          'doubles': doubles,
        }),
      );
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Text('2.0 upgrade data ready'))),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(db.close);
      debugPrintSynchronously(
        'UPGRADE_SEEDED ${info.version} schema 5: '
        '${[for (final t in tables.entries) '${t.value.length} ${t.key}'].join(', ')}',
      );
    },
    skip: !const bool.fromEnvironment('SUHBA_UPGRADE_SEED'),
  );
}
