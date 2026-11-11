import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/features/journeys/data/drift_journey_repository.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';

void main() {
  test(
    'journey attempt, pause, answers and completion survive closing the database',
    () async {
      final folder = await Directory.systemTemp.createTemp('suhba-journey-');
      addTearDown(() => folder.delete(recursive: true));
      final file = File('${folder.path}/reader.sqlite');
      final original = AppDatabase(NativeDatabase(file));
      final repo = DriftJourneyRepository(original);
      final started = DateTime.utc(2026, 11, 9, 21);
      await repo.saveEnrollment(
        JourneyEnrollment(
          journeyId: 'journey-a',
          startedAt: started,
          updatedAt: started,
          paused: true,
        ),
      );
      await repo.saveStep(
        JourneyStepProgress(
          journeyId: 'journey-a',
          stepId: 'journey-a.first',
          startedAt: started,
          updatedAt: started,
          completedAt: started,
          answeredKeys: const {'story:the-cave:abu-bakr'},
        ),
      );
      await original.close();
      final reopened = AppDatabase(NativeDatabase(file));
      addTearDown(reopened.close);
      final restored = DriftJourneyRepository(reopened);
      expect((await restored.enrollments()).single.paused, isTrue);
      expect((await restored.enrollments()).single.startedAt, started);
      expect((await restored.steps()).single.completedAt, started);
      expect((await restored.steps()).single.answeredKeys, {
        'story:the-cave:abu-bakr',
      });
    },
  );
}
