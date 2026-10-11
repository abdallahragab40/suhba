import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/database/app_database.dart';

/// Guards the database schema. Changing a table means bumping
/// `schemaVersion`, adding a migration step, and exporting the new schema
/// with `dart run drift_dev make-migrations` (which also generates
/// migration tests from the second version on).
void main() {
  test('the current schema version has an exported schema file', () {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final file = File(
      'drift_schemas/app/drift_schema_v${db.schemaVersion}.json',
    );
    expect(
      file.existsSync(),
      isTrue,
      reason:
          'Run: dart run drift_dev '
          'make-migrations',
    );
    final exported = jsonEncode(jsonDecode(file.readAsStringSync()));
    for (final table in ['bookmarks', 'reading_progress_entries']) {
      expect(exported, contains('"$table"'), reason: table);
    }
  });

  test('a fresh database creates every table', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final tables = await db
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
        .map((row) => row.read<String>('name'))
        .get();
    expect(tables, containsAll(['bookmarks', 'reading_progress_entries']));
  });
}
