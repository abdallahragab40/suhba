import 'package:drift/drift.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/reading_plan/domain/reading_plan.dart';

/// The single reading-plan row. Dates are stored as UTC midnight of the
/// local calendar date, as for review due dates.
class DriftReadingPlanRepository {
  DriftReadingPlanRepository(this._db, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _clock;

  static ReadingPlan _map(ReadingPlanRow row) {
    final d = row.startedOn.toUtc();
    return ReadingPlan(
      pace: row.pace,
      startedOn: DateTime(d.year, d.month, d.day),
      baseline: row.baseline,
      catchUp: row.catchUp,
    );
  }

  Stream<ReadingPlan?> watch() =>
      (_db.select(_db.readingPlans)..where((p) => p.id.equals(1)))
          .watchSingleOrNull()
          .map((row) => row == null ? null : _map(row));

  Future<ReadingPlan?> get() async {
    final row = await (_db.select(
      _db.readingPlans,
    )..where((p) => p.id.equals(1))).getSingleOrNull();
    return row == null ? null : _map(row);
  }

  Future<void> save(ReadingPlan plan) => _db
      .into(_db.readingPlans)
      .insertOnConflictUpdate(
        ReadingPlansCompanion.insert(
          id: const Value(1),
          pace: plan.pace,
          startedOn: DateTime.utc(
            plan.startedOn.year,
            plan.startedOn.month,
            plan.startedOn.day,
          ),
          baseline: plan.baseline,
          catchUp: Value(plan.catchUp),
          updatedAt: _clock().toUtc(),
        ),
      );

  Future<void> clear() => _db.delete(_db.readingPlans).go();
}
