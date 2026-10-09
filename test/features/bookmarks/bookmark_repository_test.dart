import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/database/app_database.dart';
import 'package:siyar_sahaba/features/bookmarks/data/drift_bookmark_repository.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';

void main() {
  late AppDatabase db;
  late DriftBookmarkRepository repo;
  late DateTime now;

  setUp(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    db = AppDatabase(NativeDatabase.memory());
    now = DateTime(2026);
    repo = DriftBookmarkRepository(db, clock: () => now);
  });
  tearDown(() => db.close());

  test('toggle saves, toggle again removes', () async {
    expect(await repo.toggle(BookmarkTarget.companion, 'umar'), isTrue);
    expect(await repo.watchAll().first, hasLength(1));
    expect(await repo.toggle(BookmarkTarget.companion, 'umar'), isFalse);
    expect(await repo.watchAll().first, isEmpty);
  });

  test('the same id under different targets is separate', () async {
    await repo.toggle(BookmarkTarget.story, 'x');
    await repo.toggle(BookmarkTarget.chapter, 'x', parentId: 's');
    final all = await repo.watchAll().first;
    expect(all.map((b) => b.target).toSet(), {
      BookmarkTarget.story,
      BookmarkTarget.chapter,
    });
    expect(
      all.firstWhere((b) => b.target == BookmarkTarget.chapter).parentId,
      's',
    );
  });

  test('newest first', () async {
    await repo.toggle(BookmarkTarget.companion, 'a');
    now = now.add(const Duration(minutes: 1));
    await repo.toggle(BookmarkTarget.companion, 'b');
    final ids = (await repo.watchAll().first).map((b) => b.targetId);
    expect(ids, ['b', 'a']);
  });

  test('watchIsSaved follows changes', () async {
    final states = <bool>[];
    final sub = repo
        .watchIsSaved(BookmarkTarget.section, 'umar.virtues')
        .listen(states.add);
    await pumpEventQueue();
    await repo.toggle(BookmarkTarget.section, 'umar.virtues', parentId: 'umar');
    await pumpEventQueue();
    await repo.remove(BookmarkTarget.section, 'umar.virtues');
    await pumpEventQueue();
    await sub.cancel();
    expect(states, [false, true, false]);
  });

  test('the database refuses a duplicate row', () async {
    Future<int> insert() => db
        .into(db.bookmarks)
        .insert(
          BookmarksCompanion.insert(
            targetType: 'companion',
            targetId: 'umar',
            createdAt: now,
          ),
        );
    await insert();
    expect(insert, throwsA(isA<SqliteException>()));
  });
}
