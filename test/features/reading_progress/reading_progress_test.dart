import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/reading_progress/data/drift_reading_progress_repository.dart';
import 'package:suhba/features/reading_progress/domain/progress_recorder.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/shared/content/domain/passage_position.dart';

PassagePosition _at(double fraction) => PassagePosition(fraction: fraction);

ReadingProgress _progress(
  String id, {
  double fraction = 0.5,
  bool completed = false,
  DateTime? at,
}) => ReadingProgress(
  target: ProgressTarget.section,
  targetId: id,
  parentId: 'umar',
  fraction: fraction,
  completed: completed,
  contentVersion: '0.1.0',
  updatedAt: at ?? DateTime(2026),
);

void main() {
  group('repository', () {
    late AppDatabase db;
    late DriftReadingProgressRepository repo;

    setUp(() {
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      db = AppDatabase(NativeDatabase.memory());
      repo = DriftReadingProgressRepository(db);
    });
    tearDown(() => db.close());

    test('save then watch; saving again updates in place', () async {
      await repo.save(_progress('umar.virtues', fraction: 0.2));
      await repo.save(_progress('umar.virtues', fraction: 0.6));
      final p = await repo.watch(ProgressTarget.section, 'umar.virtues').first;
      expect(p!.fraction, 0.6);
      expect(await repo.watchInProgress().first, hasLength(1));
    });

    test('fractions are clamped to 0–1', () async {
      await repo.save(_progress('a', fraction: 1.7));
      expect(
        (await repo.watch(ProgressTarget.section, 'a').first)!.fraction,
        1,
      );
    });

    test('once completed, an item stays completed', () async {
      await repo.save(_progress('a', fraction: 1, completed: true));
      await repo.save(_progress('a', fraction: 0.3));
      final p = await repo.watch(ProgressTarget.section, 'a').first;
      expect(p!.completed, isTrue);
      expect(p.fraction, 0.3);
    });

    test('in progress: unfinished only, most recent first, limited', () async {
      await repo.save(_progress('old', at: DateTime(2026)));
      await repo.save(_progress('new', at: DateTime(2026, 1, 3)));
      await repo.save(
        _progress('done', completed: true, at: DateTime(2026, 1, 4)),
      );
      final ids = (await repo.watchInProgress().first).map((p) => p.targetId);
      expect(ids, ['new', 'old']);
      expect(await repo.watchInProgress(limit: 1).first, hasLength(1));
    });

    test('remove', () async {
      await repo.save(_progress('a'));
      await repo.remove(ProgressTarget.section, 'a');
      expect(await repo.watch(ProgressTarget.section, 'a').first, isNull);
    });
  });

  group('ProgressRecorder', () {
    test('at most one write per interval, with the latest value', () {
      fakeAsync((async) {
        final writes = <(double, bool)>[];
        final recorder = ProgressRecorder(
          save: (p, c) async => writes.add((p.fraction, c)),
        );
        recorder
          ..report(_at(0.1))
          ..report(_at(0.2))
          ..report(_at(0.3));
        async.elapse(const Duration(milliseconds: 1400));
        expect(writes, isEmpty);
        async.elapse(const Duration(milliseconds: 200));
        expect(writes, [(0.3, false)]);

        recorder.report(_at(0.4));
        async.elapse(const Duration(seconds: 2));
        expect(writes, [(0.3, false), (0.4, false)]);
      });
    });

    test('reaching the end marks the item completed', () {
      fakeAsync((async) {
        final writes = <(double, bool)>[];
        ProgressRecorder(save: (p, c) async => writes.add((p.fraction, c)))
          ..report(_at(0.97))
          ..report(_at(0.5));
        async.elapse(const Duration(seconds: 2));
        expect(writes, [(0.5, true)]);
      });
    });

    test('flush writes immediately and cancels the timer', () {
      fakeAsync((async) {
        final writes = <double>[];
        final recorder = ProgressRecorder(
          save: (p, c) async => writes.add(p.fraction),
        )..report(_at(0.6));
        recorder.flush();
        async.flushMicrotasks();
        expect(writes, [0.6]);
        async.elapse(const Duration(seconds: 2));
        expect(writes, [0.6]);
        expect(async.pendingTimers, isEmpty);
      });
    });

    test('flush with nothing pending writes nothing', () {
      fakeAsync((async) {
        var writes = 0;
        ProgressRecorder(save: (p, c) async => writes++).flush();
        async.flushMicrotasks();
        expect(writes, 0);
      });
    });

    test('a failed write is reported and kept for the next flush', () {
      fakeAsync((async) {
        var fail = true;
        final writes = <double>[];
        final errors = <Object>[];
        final recorder = ProgressRecorder(
          save: (p, c) async {
            if (fail) throw StateError('disk full');
            writes.add(p.fraction);
          },
          onError: (e, _) => errors.add(e),
        )..report(_at(0.4));
        async.elapse(const Duration(seconds: 2));
        expect(errors, hasLength(1));
        expect(writes, isEmpty);

        fail = false;
        recorder.flush();
        async.flushMicrotasks();
        expect(writes, [0.4]);
      });
    });

    test('a newer position wins over a failed one', () {
      fakeAsync((async) {
        var fail = true;
        final writes = <double>[];
        final recorder = ProgressRecorder(
          save: (p, c) async {
            if (fail) throw StateError('disk full');
            writes.add(p.fraction);
          },
          onError: (_, _) {},
        )..report(_at(0.4));
        async.elapse(const Duration(seconds: 2));
        fail = false;
        recorder.report(_at(0.7));
        async.elapse(const Duration(seconds: 2));
        expect(writes, [0.7]);
      });
    });
  });

  group('recorder: finishing and starting again', () {
    test('markCompleted writes the last position as finished, now', () {
      fakeAsync((async) {
        final writes = <(PassagePosition, bool)>[];
        final recorder = ProgressRecorder(
          save: (p, c) async => writes.add((p, c)),
        )..report(const PassagePosition(fraction: 0.3, blockIndex: 2));
        recorder.markCompleted();
        async.flushMicrotasks();
        expect(writes, [
          (const PassagePosition(fraction: 0.3, blockIndex: 2), true),
        ]);
        expect(async.pendingTimers, isEmpty);
      });
    });

    test('reset drops what is pending and forgets completion', () {
      fakeAsync((async) {
        final writes = <(double, bool)>[];
        final recorder = ProgressRecorder(
          save: (p, c) async => writes.add((p.fraction, c)),
        )..report(_at(0.97));
        recorder.reset();
        async.elapse(const Duration(seconds: 2));
        expect(writes, isEmpty);
        recorder.report(_at(0.2));
        async.elapse(const Duration(seconds: 2));
        expect(writes, [(0.2, false)]);
      });
    });

    test('anchors are passed through to storage', () {
      fakeAsync((async) {
        final writes = <PassagePosition>[];
        ProgressRecorder(save: (p, c) async => writes.add(p)).report(
          const PassagePosition(
            fraction: 0.5,
            blockIndex: 3,
            blockOffset: 0.25,
          ),
        );
        async.elapse(const Duration(seconds: 2));
        expect(writes.single.blockIndex, 3);
        expect(writes.single.blockOffset, 0.25);
      });
    });
  });

  group('position fit', () {
    ReadingProgress saved({String? revision, String version = '0.1.0'}) =>
        _progress(
          'a',
        ).copyWith(targetRevision: revision, contentVersion: version);

    test('same revision fits, whatever the build', () {
      expect(
        saved(
          revision: 'r1',
          version: '0.0.9',
        ).fitFor(revision: 'r1', contentVersion: '0.1.0'),
        PositionFit.current,
      );
    });

    test('another revision is outdated', () {
      expect(
        saved(revision: 'r0').fitFor(revision: 'r1', contentVersion: '0.1.0'),
        PositionFit.outdated,
      );
    });

    test('no revision: fits only the same build', () {
      expect(
        saved().fitFor(revision: 'r1', contentVersion: '0.1.0'),
        PositionFit.current,
      );
      expect(
        saved(version: '0.0.9').fitFor(revision: 'r1', contentVersion: '0.1.0'),
        PositionFit.outdated,
      );
      expect(
        saved().fitFor(revision: 'r1', contentVersion: null),
        PositionFit.outdated,
        reason: 'unknown build',
      );
    });
  });
}
