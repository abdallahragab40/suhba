import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/database/app_database.dart';

/// The local database, opened once and closed with the app. Tests override
/// it with an in-memory database.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});

/// The current time; overridden in tests.
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);
