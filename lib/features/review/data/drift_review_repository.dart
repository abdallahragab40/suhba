import 'package:drift/drift.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/review/domain/leitner_scheduler.dart';
import 'package:suhba/features/review/domain/review_item.dart';

/// Answer recording is transactional, so rapid answers cannot lose history.
class DriftReviewRepository {
  DriftReviewRepository(this._db, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now,
      _scheduler = LeitnerScheduler(clock: clock);

  final AppDatabase _db;
  final DateTime Function() _clock;
  final LeitnerScheduler _scheduler;

  static ReviewItem _map(ReviewItemRow row) => ReviewItem(
    questionKey: row.questionKey,
    box: row.box,
    dueOn: row.dueOn.toUtc(),
    lastAnsweredAt: row.lastAnsweredAt.toUtc(),
    timesRight: row.timesRight,
    timesWrong: row.timesWrong,
  );

  Stream<List<ReviewItem>> watchAll() =>
      _query.watch().map((rows) => rows.map(_map).toList());

  Future<List<ReviewItem>> all() async =>
      (await _query.get()).map(_map).toList();

  SimpleSelectStatement<$ReviewItemsTable, ReviewItemRow> get _query =>
      _db.select(_db.reviewItems)..orderBy([
        (r) => OrderingTerm.asc(r.dueOn),
        (r) => OrderingTerm.asc(r.questionKey),
      ]);

  Future<ReviewItem> recordAnswer(
    String questionKey, {
    required bool correct,
  }) => _db.transaction(() async {
    final row = await (_db.select(
      _db.reviewItems,
    )..where((r) => r.questionKey.equals(questionKey))).getSingleOrNull();
    final next = _scheduler.answer(
      questionKey: questionKey,
      correct: correct,
      previous: row == null ? null : _map(row),
    );
    await save(next);
    return next;
  });

  /// Only a still-due, unchanged snapshot may be answered. Two open review
  /// sessions cannot count the same review twice or overwrite newer history.
  Future<bool> answerDue(ReviewItem expected, {required bool correct}) =>
      _db.transaction(() async {
        final row =
            await (_db.select(_db.reviewItems)
                  ..where((r) => r.questionKey.equals(expected.questionKey)))
                .getSingleOrNull();
        if (row == null) return false;
        final current = _map(row);
        if (!current.isDueOn(_clock()) ||
            current.box != expected.box ||
            current.dueOn != expected.dueOn ||
            current.lastAnsweredAt != expected.lastAnsweredAt ||
            current.timesRight != expected.timesRight ||
            current.timesWrong != expected.timesWrong) {
          return false;
        }
        await save(
          _scheduler.answer(
            questionKey: current.questionKey,
            correct: correct,
            previous: current,
          ),
        );
        return true;
      });

  /// Used by import after deciding which history wins. Unknown question keys
  /// are retained, so a temporary content removal never erases learning data.
  Future<void> save(ReviewItem item) => _db
      .into(_db.reviewItems)
      .insertOnConflictUpdate(
        ReviewItemsCompanion.insert(
          questionKey: item.questionKey,
          box: item.box,
          dueOn: item.dueOn,
          lastAnsweredAt: item.lastAnsweredAt,
          timesRight: item.timesRight,
          timesWrong: item.timesWrong,
        ),
      );
}
