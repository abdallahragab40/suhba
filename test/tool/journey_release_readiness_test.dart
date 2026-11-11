// Fixture JSON is intentionally edited to model editorial states.
// ignore_for_file: avoid_dynamic_calls
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../../tool/src/content/builder.dart';
import '../../tool/src/content/readiness.dart';
import '../../tool/src/content/schema_set.dart';
import 'content_fixture.dart';
import 'content_readiness_test.dart' show fixtureEdition;

void main() {
  final schemas = SchemaSet.fromFile(SchemaSet.defaultPath);
  late ContentFixture fixture;
  late Map<String, dynamic> journey;

  setUp(() {
    fixture = ContentFixture();
    (fixture.companionA['review'] as Map<String, dynamic>)['coverage'] =
        'complete';
    for (final id in ['quran', 'hadith-a', 'bio-a']) {
      fixture.approve('source', id, fixture.source(id));
    }
    fixture
      ..approve(
        'category',
        'cat-a',
        fixture.list('categories.json', 'categories')[0]
            as Map<String, dynamic>,
      )
      ..approve(
        'event',
        'event-a',
        fixture.list('events.json', 'events')[0] as Map<String, dynamic>,
      )
      ..approve('companion', 'comp-a', fixture.companionA)
      ..approve('story', 'story-a', fixture.files['stories/story-a.json']!);
    journey = {
      'schemaVersion': 1,
      'id': 'journey-a',
      'title': {'ar': 'رحلة'},
      'description': {'ar': 'قراءات قصيرة'},
      'steps': [
        {
          'id': 'journey-a.first',
          'title': {'ar': 'قراءة'},
          'readings': [
            {
              'type': 'companionSection',
              'parentId': 'comp-a',
              'targetId': 'comp-a.early',
            },
          ],
          'reflection': {'ar': 'ماذا تعلمت؟'},
        },
      ],
      'review': {'status': 'draft', 'coverage': 'complete'},
    };
  });

  ReadinessReport report() => contentReadiness(
    fixture.toFiles(),
    schemas,
    edition: fixtureEdition().copyWith(journeyIds: ['journey-a']),
  );

  test('2.0 checklist names all three headline journeys', () {
    final json =
        jsonDecode(File('content/release/edition.json').readAsStringSync())
            as Map;
    expect((json['journeyIds'] as List).toSet(), {
      'seerah-in-thirty-steps',
      'meet-the-companions',
      'moments-and-lessons',
    });
  });

  test('a missing required journey blocks an otherwise approved edition', () {
    final result = report();
    expect(result.publishedBuildErrors, isEmpty);
    expect(result.editionReady, isFalse);
    expect(
      result.editionProblems,
      contains(
        'journey.journey-a: launch journey: required, but it does not exist.',
      ),
    );
  });

  test('a draft journey cannot disappear from the edition through filtering', () {
    fixture.files['journeys/journey-a.json'] = journey;
    final result = report();
    // Ordinary published content can be valid while filtering out this draft.
    expect(result.publishedBuildErrors, isEmpty);
    expect(result.editionReady, isFalse);
    expect(
      result.editionProblems,
      contains(
        'journey.journey-a: launch journey: not approved by a registered reviewer.',
      ),
    );
  });

  test(
    'approved complete reflection-only journeys meet the launch requirement',
    () {
      fixture.files['journeys/journey-a.json'] = journey;
      fixture.approve('journey', 'journey-a', journey);
      expect(report().editionReady, isTrue);
      final built = buildContent(
        fixture.toFiles(),
        schemas,
        channel: ContentChannel.published,
      );
      expect(built.report.hasErrors, isFalse);
      expect(built.outputs, contains('journeys/journey-a.json'));
      expect(built.report.journeyQuestionCounts['journey-a.first'], 0);
    },
  );

  test('stale approvals block required journeys', () {
    fixture.files['journeys/journey-a.json'] = journey;
    fixture.approve('journey', 'journey-a', journey);
    journey['title'] = {'ar': 'عنوان مختلف'};
    expect(
      report().editionProblems,
      contains(
        'journey.journey-a: launch journey: approval is stale; review again.',
      ),
    );
  });

  test('approved sample coverage is not a complete launch journey', () {
    fixture.files['journeys/journey-a.json'] = journey;
    journey['review']['coverage'] = 'sample';
    fixture.approve('journey', 'journey-a', journey);
    expect(
      report().editionProblems,
      contains(
        'journey.journey-a: launch journey: not declared complete by the editor (coverage: sample).',
      ),
    );
  });
}
