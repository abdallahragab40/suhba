// Never seeds or resets data: a missing 1.0 snapshot must fail the upgrade.
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
    '2.0 upgrade preserves 1.0 data before and after reconciliation',
    (tester) async {
      final info = await PackageInfo.fromPlatform();
      expect(info.packageName, 'com.abdallahragab.suhba.integration_test');
      expect(info.version, '2.0.0');
      final snapshot = File(
        '${(await getApplicationDocumentsDirectory()).path}/v1-upgrade-snapshot.json',
      );
      expect(
        await snapshot.exists(),
        isTrue,
        reason: 'The 1.0 install must not be uninstalled or reset.',
      );
      final expected =
          jsonDecode(await snapshot.readAsString()) as Map<String, dynamic>;
      expect(expected['schema'], 3);
      final db = AppDatabase.open();
      Future<void> checkRows({required bool reconciled}) async {
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
        expect(bookmarks.map((r) => r.data).toList(), expected['bookmarks']);
        final actual = positions
            .map((r) => Map<String, dynamic>.from(r.data))
            .toList();
        final prior = (expected['positions'] as List)
            .map((r) => Map<String, dynamic>.from(r as Map))
            .toList();
        if (reconciled) {
          // Reconciliation may attach a current revision to legacy null anchors.
          for (final row in actual) {
            row.remove('target_revision');
          }
          for (final row in prior) {
            row.remove('target_revision');
          }
        }
        expect(actual, prior);
      }

      await checkRows(reconciled: false);
      final version = await db.customSelect('PRAGMA user_version').getSingle();
      expect(version.data.values.single, 5);
      expect(await db.select(db.reviewItems).get(), isEmpty);
      expect(await db.select(db.journeyEnrollments).get(), isEmpty);
      expect(await db.select(db.journeyProgressEntries).get(), isEmpty);
      final settings = await PrefsSettingsStore.open();
      for (final entry
          in (expected['strings'] as Map<String, dynamic>).entries) {
        expect(settings.getString(entry.key), entry.value);
      }
      for (final entry
          in (expected['doubles'] as Map<String, dynamic>).entries) {
        expect(settings.getDouble(entry.key), entry.value);
      }
      expect(settings.getString(SettingsKeys.readingReminder), isNull);
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
        'UPGRADE_V2_VERIFIED schema 3 to 5, all saved rows/anchors/scores preserved',
      );
    },
    skip: !const bool.fromEnvironment('SUHBA_UPGRADE_VERIFY'),
  );
}
