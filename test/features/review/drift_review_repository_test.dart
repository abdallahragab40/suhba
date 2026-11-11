import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/review/data/drift_review_repository.dart';

void main() {
  test(
    'answers persist with calendar dates and concurrent answers retain counts',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final repo = DriftReviewRepository(
        db,
        clock: () => DateTime(2026, 11, 9, 21),
      );
      await Future.wait([
        for (var i = 0; i < 5; i++)
          repo.recordAnswer('kunya:ali', correct: true),
      ]);
      final item = (await DriftReviewRepository(db).all()).single;
      expect(item.box, 5);
      expect(item.timesRight, 5);
      expect(item.dueOn, DateTime.utc(2026, 12, 14));
      expect(item.lastAnsweredAt, DateTime(2026, 11, 9, 21).toUtc());
      await repo.recordAnswer('kunya:ali', correct: false);
      final missed = (await repo.all()).single;
      expect(missed.timesRight, 5);
      expect(missed.timesWrong, 1);
      expect(missed.box, 1);
      expect(missed.dueOn, DateTime.utc(2026, 11, 10));
      expect(await repo.watchAll().first, hasLength(1));
    },
  );
}
