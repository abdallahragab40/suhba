import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:suhba/core/database/app_database.steps.dart';

part 'app_database.g.dart';

/// Saved items. One row per target: saving twice is a no-op.
@DataClassName('BookmarkRow')
class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// companion | section | story | chapter
  TextColumn get targetType => text()();
  TextColumn get targetId => text()();

  /// The companion of a section, or the story of a chapter.
  TextColumn get parentId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {targetType, targetId},
  ];
}

/// How far the reader got in each section or chapter.
@DataClassName('ProgressRow')
class ReadingProgressEntries extends Table {
  /// section | chapter
  TextColumn get targetType => text()();
  TextColumn get targetId => text()();
  TextColumn get parentId => text()();

  /// 0–1, the share of the text scrolled through.
  RealColumn get fraction => real()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  /// The content build the position was recorded against.
  TextColumn get contentVersion => text()();
  DateTimeColumn get updatedAt => dateTime()();

  /// The passage's content revision when the position was recorded; null
  /// for positions saved before schema 2.
  TextColumn get targetRevision => text().nullable()();

  /// The block at the top of the screen and how far into it (0–1); null
  /// for positions saved before schema 3, which fall back to [fraction].
  IntColumn get blockIndex => integer().nullable()();
  RealColumn get blockOffset => real().nullable()();

  @override
  Set<Column> get primaryKey => {targetType, targetId};
}

/// Spaced review history, keyed independently of shuffled answer choices.
@DataClassName('ReviewItemRow')
class ReviewItems extends Table {
  TextColumn get questionKey => text()();
  // Drift resolves column references inside check expressions at generation.
  // ignore: recursive_getters
  IntColumn get box => integer().check(box.isBetweenValues(1, 5))();

  /// UTC midnight encoding a local calendar date, rather than an instant.
  DateTimeColumn get dueOn => dateTime()();
  DateTimeColumn get lastAnsweredAt => dateTime()();
  IntColumn get timesRight =>
      // ignore: recursive_getters
      integer().check(timesRight.isBiggerOrEqualValue(0))();
  IntColumn get timesWrong =>
      // ignore: recursive_getters
      integer().check(timesWrong.isBiggerOrEqualValue(0))();

  @override
  Set<Column> get primaryKey => {questionKey};
}

/// One enrollment per journey; multiple journeys may be followed at once.
@DataClassName('JourneyEnrollmentRow')
class JourneyEnrollments extends Table {
  TextColumn get journeyId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get paused => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {journeyId};
}

@DataClassName('JourneyStepProgressRow')
class JourneyProgressEntries extends Table {
  TextColumn get journeyId => text()();
  TextColumn get stepId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  BoolColumn get skipped => boolean().withDefault(const Constant(false))();
  TextColumn get answeredKeys => text().withDefault(const Constant('[]'))();
  @override
  Set<Column> get primaryKey => {journeyId, stepId};
}

/// User data only; exported solely at the reader's request.
@DriftDatabase(
  tables: [
    Bookmarks,
    ReadingProgressEntries,
    ReviewItems,
    JourneyEnrollments,
    JourneyProgressEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// The on-device database file.
  factory AppDatabase.open() => AppDatabase(driftDatabase(name: 'suhba'));

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    // One step per version (see drift_schemas/ and the migration tests
    // generated from it).
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.addColumn(
          schema.readingProgressEntries,
          schema.readingProgressEntries.targetRevision,
        );
      },
      from2To3: (m, schema) async {
        await m.addColumn(
          schema.readingProgressEntries,
          schema.readingProgressEntries.blockIndex,
        );
        await m.addColumn(
          schema.readingProgressEntries,
          schema.readingProgressEntries.blockOffset,
        );
      },
      from3To4: (m, schema) => m.createTable(schema.reviewItems),
      from4To5: (m, schema) async {
        await m.createTable(schema.journeyEnrollments);
        await m.createTable(schema.journeyProgressEntries);
      },
    ),
  );
}
