// Fixture JSON is intentionally edited in place to test authoring errors.
// ignore_for_file: avoid_dynamic_calls
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/journeys/data/journey_dto.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../../tool/src/content/builder.dart';
import '../../tool/src/content/schema_set.dart';
import '../../tool/src/content/validator.dart';
import 'content_fixture.dart';

void main() {
  final schemas = SchemaSet.fromFile(SchemaSet.defaultPath);
  late ContentFixture fx;
  late Map<String, dynamic> journey;
  late Map<String, dynamic> step;
  late Map<String, dynamic> reading;

  setUp(() {
    fx = ContentFixture();
    reading = {
      'type': 'companionSection',
      'parentId': 'comp-a',
      'targetId': 'comp-a.early',
    };
    step = {
      'id': 'journey-a.first',
      'title': {'ar': 'قراءة'},
      'readings': [reading],
    };
    journey = {
      'schemaVersion': 1,
      'id': 'journey-a',
      'title': {'ar': 'رحلة'},
      'description': {'ar': 'قراءات قصيرة'},
      'steps': [step],
      'review': {'status': 'draft', 'authoredBy': 'editor'},
    };
    fx.files['journeys/journey-a.json'] = journey;
  });

  ValidationReport validate() =>
      validateContent(fx.toFiles(), schemas, channel: ContentChannel.draft);

  test('journeys map references without copying or authoring questions', () {
    expect(validate().hasErrors, isFalse);
    expect(validate().journeyQuestionCounts, {'journey-a.first': 0});
    final domain = JourneyDto.fromJson(journey).toDomain();
    expect(
      domain.steps.single.readings.single.target,
      const ContentTarget.section('comp-a', 'comp-a.early'),
    );
    step['questions'] = <Object>[];
    expect(validate().issues.any((i) => i.rule == 'V1'), isTrue);
  });

  test('every supported passage type resolves against the content', () {
    fx.addSeerah();
    for (final r in [
      reading,
      {'type': 'storyChapter', 'parentId': 'story-a', 'targetId': 'story-a.1'},
      {'type': 'seerahChapter', 'targetId': 'chapter-a'},
      {'type': 'seerahTopic', 'targetId': 'topic-a'},
    ]) {
      step['readings'] = [r];
      expect(validate().hasErrors, isFalse, reason: '$r');
      step['readings'] = [
        {...r, 'targetId': 'missing'},
      ];
      expect(validate().issues.any((i) => i.rule == 'V2'), isTrue);
    }
  });

  test(
    'schema rejects absent parents, empty readings and unexpected parents',
    () {
      reading.remove('parentId');
      expect(validate().issues.any((i) => i.rule == 'V1'), isTrue);
      reading['type'] = 'seerahChapter';
      reading['parentId'] = 'comp-a';
      expect(validate().issues.any((i) => i.rule == 'V1'), isTrue);
      step['readings'] = <Object>[];
      expect(validate().issues.any((i) => i.rule == 'V1'), isTrue);
    },
  );

  test('duplicate step ids and duplicate readings are rejected', () {
    journey['steps'] = [step, step];
    expect(validate().issues.any((i) => i.rule == 'V2'), isTrue);
    journey['steps'] = [step];
    step['readings'] = [reading, reading];
    expect(
      validate().issues.any((i) => i.message.contains('Duplicate reading')),
      isTrue,
    );
  });

  test(
    'build includes journeys in the manifest and strips editorial authorship',
    () {
      final result = buildContent(
        fx.toFiles(),
        schemas,
        channel: ContentChannel.draft,
      );
      expect(result.report.hasErrors, isFalse);
      final shipped =
          jsonDecode(result.outputs['journeys/journey-a.json']!) as Map;
      expect(shipped['review'], {
        'status': 'draft',
        'editorialFlags': <Object>[],
      });
      expect(result.outputs['index/journeys.json'], contains('journey-a'));
      expect(
        result.outputs['manifest.json'],
        contains('journeys/journey-a.json'),
      );
    },
  );

  test('an approved journey cannot publish a draft passage', () {
    fx.approve('journey', 'journey-a', journey);
    final result = validateContent(
      fx.toFiles(),
      schemas,
      channel: ContentChannel.published,
    );
    expect(
      result.issues.any(
        (i) => i.rule == 'V11' && i.message.contains('journey passage'),
      ),
      isTrue,
    );
    expect(result.tree.journeys.single.isApproved, isTrue);
    // Editing its framing invalidates the approval hash too.
    step['framing'] = {'ar': 'اقرأ وتأمل'};
    expect(validate().issues.any((i) => i.rule == 'V7'), isTrue);
  });
}
