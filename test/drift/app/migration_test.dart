// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/database/app_database.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // Saved items and reading positions must survive the upgrade unchanged;
  // positions recorded before v2 have no passage revision.
  test('migration from v1 to v2 keeps bookmarks and progress', () async {
    final oldBookmarksData = <v1.BookmarksData>[
      const v1.BookmarksData(
        id: 1,
        targetType: 'companion',
        targetId: 'abu-bakr',
        createdAt: 1760000000,
      ),
      const v1.BookmarksData(
        id: 2,
        targetType: 'section',
        targetId: 'umar.virtues',
        parentId: 'umar',
        createdAt: 1760000100,
      ),
    ];
    final expectedNewBookmarksData = <v2.BookmarksData>[
      const v2.BookmarksData(
        id: 1,
        targetType: 'companion',
        targetId: 'abu-bakr',
        createdAt: 1760000000,
      ),
      const v2.BookmarksData(
        id: 2,
        targetType: 'section',
        targetId: 'umar.virtues',
        parentId: 'umar',
        createdAt: 1760000100,
      ),
    ];

    final oldReadingProgressEntriesData = <v1.ReadingProgressEntriesData>[
      const v1.ReadingProgressEntriesData(
        targetType: 'section',
        targetId: 'abu-bakr.hijrah',
        parentId: 'abu-bakr',
        fraction: 0.4,
        completed: 0,
        contentVersion: '0.1.0',
        updatedAt: 1760000200,
      ),
    ];
    final expectedNewReadingProgressEntriesData =
        <v2.ReadingProgressEntriesData>[
          const v2.ReadingProgressEntriesData(
            targetType: 'section',
            targetId: 'abu-bakr.hijrah',
            parentId: 'abu-bakr',
            fraction: 0.4,
            completed: 0,
            contentVersion: '0.1.0',
            updatedAt: 1760000200,
          ),
        ];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.bookmarks, oldBookmarksData);
        batch.insertAll(
          oldDb.readingProgressEntries,
          oldReadingProgressEntriesData,
        );
      },
      validateItems: (newDb) async {
        expect(
          expectedNewBookmarksData,
          await newDb.select(newDb.bookmarks).get(),
        );
        expect(
          expectedNewReadingProgressEntriesData,
          await newDb.select(newDb.readingProgressEntries).get(),
        );
      },
    );
  });

  // Positions from v2 keep their revision; block anchors start empty, so
  // they restore by fraction until the reader saves again.
  test('migration from v2 to v3 keeps positions and revisions', () async {
    final old = <v2.ReadingProgressEntriesData>[
      const v2.ReadingProgressEntriesData(
        targetType: 'chapter',
        targetId: 'the-cave.2',
        parentId: 'the-cave',
        fraction: 0.7,
        completed: 1,
        contentVersion: '0.1.0',
        updatedAt: 1760000300,
        targetRevision: '0123456789abcdef',
      ),
    ];
    final expected = <v3.ReadingProgressEntriesData>[
      const v3.ReadingProgressEntriesData(
        targetType: 'chapter',
        targetId: 'the-cave.2',
        parentId: 'the-cave',
        fraction: 0.7,
        completed: 1,
        contentVersion: '0.1.0',
        updatedAt: 1760000300,
        targetRevision: '0123456789abcdef',
      ),
    ];
    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) =>
          batch.insertAll(oldDb.readingProgressEntries, old),
      validateItems: (newDb) async => expect(
        expected,
        await newDb.select(newDb.readingProgressEntries).get(),
      ),
    );
  });
}
