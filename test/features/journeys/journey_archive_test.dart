import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/journeys/domain/journey_import.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/personal_data/domain/reading_data_archive.dart';

void main() {
  final start = DateTime.utc(2026, 11, 9, 21);
  JourneyEnrollment enrollment({int attempt = 0, bool paused = false}) =>
      JourneyEnrollment(
        journeyId: 'journey-a',
        startedAt: start.add(Duration(days: attempt)),
        updatedAt: start.add(Duration(days: attempt, hours: paused ? 1 : 0)),
        paused: paused,
      );
  JourneyStepProgress step({int attempt = 0, bool complete = false}) =>
      JourneyStepProgress(
        journeyId: 'journey-a',
        stepId: 'journey-a.first',
        startedAt: start.add(Duration(days: attempt)),
        updatedAt: start.add(Duration(days: attempt)),
        completedAt: complete ? start.add(Duration(days: attempt)) : null,
        answeredKeys: const {'story:the-cave:abu-bakr'},
      );

  test(
    'new attempts exclude old steps; local ties and completed steps are retained',
    () {
      final newer = mergeJourneys(
        local: [enrollment()],
        localSteps: [step(complete: true)],
        incoming: [enrollment(attempt: 1)],
        incomingSteps: [step(), step(attempt: 1)],
      );
      expect(
        newer.enrollments.single.startedAt,
        enrollment(attempt: 1).startedAt,
      );
      expect(newer.steps.single.startedAt, enrollment(attempt: 1).startedAt);
      final old = mergeJourneys(
        local: [enrollment(attempt: 1)],
        localSteps: [step(attempt: 1)],
        incoming: [enrollment()],
        incomingSteps: [step(complete: true)],
      );
      expect(old.enrollments, isEmpty);
      expect(old.steps, isEmpty);
      final same = mergeJourneys(
        local: [enrollment()],
        localSteps: [step(complete: true)],
        incoming: [enrollment()],
        incomingSteps: [step()],
      );
      expect(same.enrollments, isEmpty);
      expect(same.steps, isEmpty);
    },
  );

  test('answers recorded on either device are combined within an attempt', () {
    JourneyStepProgress answered(Set<String> keys, {int hour = 0}) =>
        JourneyStepProgress(
          journeyId: 'journey-a',
          stepId: 'journey-a.first',
          startedAt: start,
          updatedAt: start.add(Duration(hours: hour)),
          answeredKeys: keys,
        );
    // The incoming snapshot is newer but lacks the local answer.
    final newer = mergeJourneys(
      local: [enrollment()],
      localSteps: [
        answered({'q1'}),
      ],
      incoming: [enrollment()],
      incomingSteps: [
        answered({'q2'}, hour: 1),
      ],
    );
    expect(newer.steps.single.answeredKeys, {'q1', 'q2'});
    expect(newer.steps.single.updatedAt, start.add(const Duration(hours: 1)));
    // The local snapshot is newer, but the incoming one adds an answer.
    final older = mergeJourneys(
      local: [enrollment()],
      localSteps: [
        answered({'q1'}, hour: 1),
      ],
      incoming: [enrollment()],
      incomingSteps: [
        answered({'q2'}),
      ],
    );
    expect(older.steps.single.answeredKeys, {'q1', 'q2'});
    expect(older.steps.single.updatedAt, start.add(const Duration(hours: 1)));
    // Nothing new: nothing to write.
    final same = mergeJourneys(
      local: [enrollment()],
      localSteps: [
        answered({'q1', 'q2'}, hour: 1),
      ],
      incoming: [enrollment()],
      incomingSteps: [
        answered({'q2'}),
      ],
    );
    expect(same.steps, isEmpty);
  });

  test(
    'journey state round-trips and malformed records refuse the archive',
    () {
      final archive = ReadingDataArchive(
        bookmarks: const [],
        progress: const [],
        exportedAt: start,
        journeys: [enrollment(paused: true)],
        journeySteps: [step(complete: true)],
      );
      final encoded = encodeArchive(archive);
      final decoded = (decodeArchive(encoded) as ArchiveDecoded).archive;
      expect(decoded.journeys.single.paused, isTrue);
      expect(decoded.journeySteps.single.answeredKeys, step().answeredKeys);
      for (final (field, value) in <(String, Object)>[
        ('stepId', '../bad'),
        ('skipped', 'true'),
        ('answeredKeys', ['']),
        ('completedAt', 'yesterday'),
        ('startedAt', '2026-11-08T21:00:00Z'),
      ]) {
        final json = jsonDecode(encoded) as Map<String, dynamic>;
        final record =
            (json['journeySteps'] as List<Object?>).single
                as Map<String, dynamic>;
        record[field] = value;
        final rejected = decodeArchive(jsonEncode(json)) as ArchiveRejected;
        expect(rejected.where, 'journeySteps[0].$field');
      }
      for (final version in [1, 2]) {
        final json = jsonDecode(encoded) as Map<String, dynamic>;
        json['version'] = version;
        json.remove('journeys');
        json.remove('journeySteps');
        final legacy =
            (decodeArchive(jsonEncode(json)) as ArchiveDecoded).archive;
        expect(legacy.journeys, isEmpty);
        expect(legacy.journeySteps, isEmpty);
      }
    },
  );
}
