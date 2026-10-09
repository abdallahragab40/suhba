import 'package:drift/drift.dart';
import 'package:siyar_sahaba/core/database/app_database.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';

class DriftReadingProgressRepository implements ReadingProgressRepository {
  DriftReadingProgressRepository(this._db);

  final AppDatabase _db;

  static ReadingProgress _toDomain(ProgressRow row) => ReadingProgress(
    target: ProgressTarget.values.byName(row.targetType),
    targetId: row.targetId,
    parentId: row.parentId,
    fraction: row.fraction,
    completed: row.completed,
    contentVersion: row.contentVersion,
    updatedAt: row.updatedAt,
    targetRevision: row.targetRevision,
    blockIndex: row.blockIndex,
    blockOffset: row.blockOffset,
  );

  SimpleSelectStatement<$ReadingProgressEntriesTable, ProgressRow> _select(
    ProgressTarget target,
    String targetId,
  ) => _db.select(_db.readingProgressEntries)
    ..where(
      (p) => p.targetType.equals(target.name) & p.targetId.equals(targetId),
    );

  @override
  Stream<ReadingProgress?> watch(ProgressTarget target, String targetId) =>
      _select(
        target,
        targetId,
      ).watchSingleOrNull().map((row) => row == null ? null : _toDomain(row));

  @override
  Stream<List<ReadingProgress>> watchInProgress({int limit = 10}) {
    final query = _db.select(_db.readingProgressEntries)
      ..where((p) => p.completed.equals(false))
      ..orderBy([(p) => OrderingTerm.desc(p.updatedAt)])
      ..limit(limit);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Stream<List<ReadingProgress>> watchForParent(
    ProgressTarget target,
    String parentId,
  ) {
    final query = _db.select(_db.readingProgressEntries)
      ..where(
        (p) => p.targetType.equals(target.name) & p.parentId.equals(parentId),
      );
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<List<ReadingProgress>> all() async {
    final rows = await (_db.select(
      _db.readingProgressEntries,
    )..orderBy([(p) => OrderingTerm.desc(p.updatedAt)])).get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<void> save(ReadingProgress progress) => _db.transaction(() async {
    final existing = await _select(
      progress.target,
      progress.targetId,
    ).getSingleOrNull();
    await _db
        .into(_db.readingProgressEntries)
        .insertOnConflictUpdate(
          ReadingProgressEntriesCompanion.insert(
            targetType: progress.target.name,
            targetId: progress.targetId,
            parentId: progress.parentId,
            fraction: progress.fraction.clamp(0, 1),
            // Finishing an item is remembered even if the reader scrolls up.
            completed: Value(
              progress.completed || (existing?.completed ?? false),
            ),
            contentVersion: progress.contentVersion,
            updatedAt: progress.updatedAt,
            targetRevision: Value(progress.targetRevision),
            blockIndex: Value(progress.blockIndex),
            blockOffset: Value(progress.blockOffset?.clamp(0, 1)),
          ),
        );
  });

  @override
  Future<void> remove(ProgressTarget target, String targetId) =>
      (_db.delete(_db.readingProgressEntries)..where(
            (p) =>
                p.targetType.equals(target.name) & p.targetId.equals(targetId),
          ))
          .go();

  @override
  Future<void> confirmRevision(
    ProgressTarget target,
    String targetId, {
    required String revision,
    required String contentVersion,
  }) =>
      (_db.update(_db.readingProgressEntries)..where(
            (p) =>
                p.targetType.equals(target.name) & p.targetId.equals(targetId),
          ))
          .write(
            ReadingProgressEntriesCompanion(
              targetRevision: Value(revision),
              contentVersion: Value(contentVersion),
            ),
          );

  @override
  Stream<List<ReadingProgress>> watchCompleted() {
    final query = _db.select(_db.readingProgressEntries)
      ..where((p) => p.completed.equals(true))
      ..orderBy([(p) => OrderingTerm.desc(p.updatedAt)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Stream<List<ReadingProgress>> watchAll() => _db
      .select(_db.readingProgressEntries)
      .watch()
      .map((rows) => rows.map(_toDomain).toList());

  @override
  Future<void> restore(ReadingProgress progress) => _db
      .into(_db.readingProgressEntries)
      .insert(
        ReadingProgressEntriesCompanion.insert(
          targetType: progress.target.name,
          targetId: progress.targetId,
          parentId: progress.parentId,
          fraction: progress.fraction,
          completed: Value(progress.completed),
          contentVersion: progress.contentVersion,
          updatedAt: progress.updatedAt,
          targetRevision: Value(progress.targetRevision),
          blockIndex: Value(progress.blockIndex),
          blockOffset: Value(progress.blockOffset),
        ),
        mode: InsertMode.insertOrIgnore,
      );

  @override
  Future<int> clearAll() => _db.delete(_db.readingProgressEntries).go();
}
