import 'package:drift/drift.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';

class DriftBookmarkRepository implements BookmarkRepository {
  DriftBookmarkRepository(this._db, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _clock;

  static Bookmark _toDomain(BookmarkRow row) => Bookmark(
    target: BookmarkTarget.values.byName(row.targetType),
    targetId: row.targetId,
    parentId: row.parentId,
    createdAt: row.createdAt,
  );

  SimpleSelectStatement<$BookmarksTable, BookmarkRow> _select(
    BookmarkTarget target,
    String targetId,
  ) => _db.select(_db.bookmarks)
    ..where(
      (b) => b.targetType.equals(target.name) & b.targetId.equals(targetId),
    );

  SimpleSelectStatement<$BookmarksTable, BookmarkRow> get _newestFirst =>
      _db.select(_db.bookmarks)..orderBy([
        (b) => OrderingTerm.desc(b.createdAt),
        (b) => OrderingTerm.desc(b.id),
      ]);

  @override
  Stream<List<Bookmark>> watchAll() =>
      _newestFirst.watch().map((rows) => rows.map(_toDomain).toList());

  @override
  Future<List<Bookmark>> all() async =>
      (await _newestFirst.get()).map(_toDomain).toList();

  @override
  Stream<bool> watchIsSaved(BookmarkTarget target, String targetId) =>
      _select(target, targetId).watch().map((rows) => rows.isNotEmpty);

  @override
  Future<bool> toggle(
    BookmarkTarget target,
    String targetId, {
    String? parentId,
  }) => _db.transaction(() async {
    final existing = await _select(target, targetId).getSingleOrNull();
    if (existing != null) {
      await (_db.delete(
        _db.bookmarks,
      )..where((b) => b.id.equals(existing.id))).go();
      return false;
    }
    await _db
        .into(_db.bookmarks)
        .insert(
          BookmarksCompanion.insert(
            targetType: target.name,
            targetId: targetId,
            parentId: Value(parentId),
            createdAt: _clock(),
          ),
          mode: InsertMode.insertOrIgnore,
        );
    return true;
  });

  @override
  Future<void> remove(BookmarkTarget target, String targetId) =>
      (_db.delete(_db.bookmarks)..where(
            (b) =>
                b.targetType.equals(target.name) & b.targetId.equals(targetId),
          ))
          .go();

  @override
  Future<void> restore(Bookmark bookmark) => _db
      .into(_db.bookmarks)
      .insert(
        BookmarksCompanion.insert(
          targetType: bookmark.target.name,
          targetId: bookmark.targetId,
          parentId: Value(bookmark.parentId),
          createdAt: bookmark.createdAt,
        ),
        mode: InsertMode.insertOrIgnore,
      );

  @override
  Future<int> clearAll() => _db.delete(_db.bookmarks).go();
}
