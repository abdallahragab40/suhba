import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';

class DriftJourneyRepository {
  DriftJourneyRepository(this.db);
  final AppDatabase db;

  static JourneyEnrollment _enrollment(JourneyEnrollmentRow r) =>
      JourneyEnrollment(
        journeyId: r.journeyId,
        startedAt: r.startedAt.toUtc(),
        updatedAt: r.updatedAt.toUtc(),
        paused: r.paused,
      );
  static JourneyStepProgress _step(JourneyStepProgressRow r) =>
      JourneyStepProgress(
        journeyId: r.journeyId,
        stepId: r.stepId,
        startedAt: r.startedAt.toUtc(),
        updatedAt: r.updatedAt.toUtc(),
        completedAt: r.completedAt?.toUtc(),
        skipped: r.skipped,
        answeredKeys: (jsonDecode(r.answeredKeys) as List)
            .cast<String>()
            .toSet(),
      );

  Future<List<JourneyEnrollment>> enrollments() async =>
      (await db.select(db.journeyEnrollments).get()).map(_enrollment).toList();
  Stream<List<JourneyEnrollment>> watchEnrollments() => db
      .select(db.journeyEnrollments)
      .watch()
      .map((rows) => rows.map(_enrollment).toList());
  Future<List<JourneyStepProgress>> steps() async =>
      (await db.select(db.journeyProgressEntries).get()).map(_step).toList();
  Stream<List<JourneyStepProgress>> watchSteps() => db
      .select(db.journeyProgressEntries)
      .watch()
      .map((rows) => rows.map(_step).toList());

  Future<void> saveEnrollment(JourneyEnrollment item) => db
      .into(db.journeyEnrollments)
      .insertOnConflictUpdate(
        JourneyEnrollmentsCompanion.insert(
          journeyId: item.journeyId,
          startedAt: item.startedAt,
          updatedAt: item.updatedAt,
          paused: Value(item.paused),
        ),
      );
  Future<void> saveStep(JourneyStepProgress item) => db
      .into(db.journeyProgressEntries)
      .insertOnConflictUpdate(
        JourneyProgressEntriesCompanion.insert(
          journeyId: item.journeyId,
          stepId: item.stepId,
          startedAt: item.startedAt,
          updatedAt: item.updatedAt,
          completedAt: Value(item.completedAt),
          skipped: Value(item.skipped),
          answeredKeys: Value(jsonEncode(item.answeredKeys.toList()..sort())),
        ),
      );
  Future<int> clearSteps(String journeyId) => (db.delete(
    db.journeyProgressEntries,
  )..where((s) => s.journeyId.equals(journeyId))).go();
}
