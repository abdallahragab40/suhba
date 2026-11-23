// Verifies an installed older APK (seeded by upgrade_seed_v1/v2_test.dart)
// upgraded in place to this checkout. Never seeds or resets data: a missing
// snapshot must fail the upgrade. The expected app version comes from
// SUHBA_UPGRADE_TO (pubspec), the expected schema from AppDatabase.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:suhba/app/app.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/app/reconciliation/user_data_reconciliation.dart';
import 'package:suhba/app/router/app_router.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    'an in-place upgrade preserves older data before and after reconciliation',
    (tester) async {
      final info = await PackageInfo.fromPlatform();
      expect(info.packageName, 'com.abdallahragab.suhba.integration_test');
      const toVersion = String.fromEnvironment('SUHBA_UPGRADE_TO');
      expect(toVersion, isNotEmpty, reason: 'Pass SUHBA_UPGRADE_TO.');
      expect(info.version, toVersion);
      final snapshot = File(
        '${(await getApplicationDocumentsDirectory()).path}/upgrade-snapshot.json',
      );
      expect(
        await snapshot.exists(),
        isTrue,
        reason: 'The older install must not be uninstalled or reset.',
      );
      final expected =
          jsonDecode(await snapshot.readAsString()) as Map<String, dynamic>;
      final fromSchema = expected['schema'] as int;
      final db = AppDatabase.open();
      final toSchema = db.schemaVersion;
      expect(fromSchema, lessThanOrEqualTo(toSchema));
      final seeded = (expected['tables'] as Map<String, dynamic>).map(
        (table, rows) => MapEntry(table, [
          for (final row in rows as List) Map<String, dynamic>.from(row as Map),
        ]),
      );
      final orders = (expected['orders'] as Map<String, dynamic>)
          .cast<String, String>();

      Future<void> checkRows({required bool reconciled}) async {
        for (final MapEntry(key: table, value: prior) in seeded.entries) {
          final rows = await db
              .customSelect('SELECT * FROM $table ORDER BY ${orders[table]}')
              .get();
          // Columns added by a later schema are not part of the comparison.
          final actual = [
            for (final (i, r) in rows.indexed)
              {
                for (final key in (i < prior.length ? prior[i] : r.data).keys)
                  key: r.data[key],
              },
          ];
          final want = [
            for (final row in prior) {...row},
          ];
          if (reconciled && table == 'reading_progress_entries') {
            // Reconciliation may attach a current revision to legacy null anchors.
            for (final row in [...actual, ...want]) {
              row.remove('target_revision');
            }
          }
          expect(actual, want, reason: '$table (reconciled: $reconciled)');
        }
      }

      await checkRows(reconciled: false);
      final version = await db.customSelect('PRAGMA user_version').getSingle();
      expect(version.data.values.single, toSchema);
      // Tables the older schema did not have start empty.
      final tables = await db
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table' AND "
            "name NOT LIKE 'sqlite_%' AND name != 'android_metadata'",
          )
          .get();
      for (final name in tables.map((r) => r.data['name'] as String)) {
        if (seeded.containsKey(name)) continue;
        final rows = await db.customSelect('SELECT * FROM $name').get();
        expect(rows, isEmpty, reason: '$name is new and must start empty');
      }
      final settings = await PrefsSettingsStore.open();
      final strings = expected['strings'] as Map<String, dynamic>;
      for (final entry in strings.entries) {
        expect(settings.getString(entry.key), entry.value, reason: entry.key);
      }
      for (final entry
          in (expected['doubles'] as Map<String, dynamic>).entries) {
        expect(settings.getDouble(entry.key), entry.value, reason: entry.key);
      }
      // Upgrading never opts a reader into reminders: unset stays unset.
      expect(
        settings.getString(SettingsKeys.readingReminder),
        strings[SettingsKeys.readingReminder],
      );
      final app = ProviderContainer(
        retry: noAutomaticRetry,
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          settingsStoreProvider.overrideWithValue(settings),
          appRouterProvider.overrideWithValue(
            buildAppRouter(initialLocation: '/saved'),
          ),
        ],
      );
      await tester.pumpWidget(
        UncontrolledProviderScope(container: app, child: const SuhbaApp()),
      );
      await tester.pumpAndSettle();
      await app.read(userDataReconciliationProvider.future);
      await checkRows(reconciled: true);
      expect(app.read(quizBestProvider), {
        QuizMode.mixed: 9,
        QuizMode.companions: 7,
        QuizMode.seerah: 6,
      });
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      app.dispose();
      await tester.pumpAndSettle();
      await tester.runAsync(db.close);
      debugPrintSynchronously(
        'UPGRADE_VERIFIED ${expected['fromVersion']} to ${info.version}, '
        'schema $fromSchema to $toSchema, all saved rows/anchors/scores '
        'preserved',
      );
    },
    skip: !const bool.fromEnvironment('SUHBA_UPGRADE_VERIFY'),
  );
}
