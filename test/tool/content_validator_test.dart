// These tests edit raw content JSON in place, which is dynamically typed.
// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../../tool/src/content/builder.dart';
import '../../tool/src/content/content_files.dart';
import '../../tool/src/content/issues.dart';
import '../../tool/src/content/schema_set.dart';
import '../../tool/src/content/validator.dart';
import 'content_fixture.dart';

void main() {
  final schemas = SchemaSet.fromFile(SchemaSet.defaultPath);
  late ContentFixture fx;

  setUp(() => fx = ContentFixture());

  ValidationReport validate({
    ContentChannel channel = ContentChannel.draft,
    ContentFiles? files,
  }) => validateContent(files ?? fx.toFiles(), schemas, channel: channel);

  /// The rule codes of all errors (or warnings).
  Set<String> codes(ValidationReport r, [Severity s = Severity.error]) => {
    for (final i in r.issues.where((i) => i.severity == s)) i.rule,
  };

  void expectOnly(String rule, {ContentChannel? channel}) {
    final report = validate(channel: channel ?? ContentChannel.draft);
    expect(codes(report), {rule}, reason: report.issues.join('\n'));
  }

  Map<String, dynamic> block(int i) =>
      ((fx.companionA['sections'] as List)[0] as Map)['blocks'][i]
          as Map<String, dynamic>;

  group('the fixture', () {
    test('is valid on the draft channel, with pending work counted', () {
      final report = validate();
      expect(report.issues, isEmpty, reason: report.issues.join('\n'));
      expect(report.pendingByItem, isNotEmpty);
    });

    test('cannot be published: nothing is approved', () {
      final report = validate(channel: ContentChannel.published);
      expect(codes(report), {'V11'});
    });
  });

  group('V1 schema', () {
    test('unknown key', () {
      fx.companionA['nickname'] = {'ar': 'x'};
      expectOnly('V1');
    });

    test('unknown enum value', () {
      fx.companionA['gender'] = 'other';
      expectOnly('V1');
    });

    test('missing required field', () {
      fx.companionA.remove('fullName');
      expectOnly('V1');
    });

    test('exact date without a day', () {
      (fx.companionA['death'] as Map)['date'] = {
        'precision': 'exact',
        'hijriYear': 13,
        'hijriMonth': 6,
      };
      expectOnly('V1');
    });

    test('invalid JSON', () {
      final files = fx.toFiles();
      files.files['people.json'] = '{"schemaVersion": 1,';
      final report = validate(files: files);
      expect(codes(report), contains('V1'));
    });

    test('ids must be slugs', () {
      fx.source('bio-a')['id'] = 'Bio A';
      expect(codes(validate()), contains('V1'));
    });
  });

  group('V2 IDs and references', () {
    test('file name must match the id', () {
      fx.files['companions/other.json'] = fx.files.remove(
        'companions/comp-b.json',
      )!;
      expectOnly('V2');
    });

    test('duplicate ids', () {
      fx
          .list('sources.json', 'sources')
          .add(Map<String, dynamic>.of(fx.source('bio-a')));
      expectOnly('V2');
    });

    test('section ids must be prefixed with the companion id', () {
      ((fx.companionA['sections'] as List)[0] as Map)['id'] = 'early';
      (fx.companionA['timeline'] as List)[0]['sectionId'] = 'early';
      expectOnly('V2');
    });

    test('unknown source', () {
      block(0)['citations'] = [
        {'sourceId': 'nowhere', 'locatorStatus': 'pending'},
      ];
      expectOnly('V2');
    });

    test('unknown category, event, section and person', () {
      fx.companionA['memberships'][0]['categoryId'] = 'cat-x';
      (fx.companionA['timeline'] as List)[0]['eventId'] = 'event-x';
      (fx.companionA['timeline'] as List)[0]['sectionId'] = 'comp-a.x';
      fx.companionA['relations'][0]['person']['personId'] = 'person-x';
      final errors = validate().issues.where(
        (i) => i.severity == Severity.error,
      );
      expect(errors.map((e) => e.rule).toSet(), {'V2'});
      expect(errors, hasLength(4));
    });

    test('quranRef only on Qur\'an citations, and required there', () {
      block(0)['citations'] = [
        {
          'sourceId': 'bio-a',
          'locatorStatus': 'complete',
          'quranRef': {'surah': 1, 'ayahFrom': 1},
        },
        {'sourceId': 'quran', 'locatorStatus': 'pending'},
      ];
      final report = validate();
      expect(codes(report), {'V2'});
      expect(report.issues.where((i) => i.rule == 'V2'), hasLength(2));
    });

    test('an approval for a missing item', () {
      fx.files['reviews/companion.ghost.json'] = fx.approvalFor(
        'companion',
        'ghost',
        {},
      );
      expect(codes(validate()), contains('V2'));
    });

    test('unexpected files are warned about', () {
      fx.files['notes.json'] = {'a': 1};
      expect(codes(validate(), Severity.warning), {'V2'});
    });
  });

  group('V3 citations', () {
    test('a biography needs references', () {
      fx.companionA['references'] = <String>[];
      expectOnly('V3');
    });

    test('a claim needs a citation unless its reliability is unknown', () {
      block(0)['citations'] = <Object>[];
      expectOnly('V3');
      block(0)['reliability'] = 'unknown';
      expect(validate().issues, isEmpty);
    });

    test('an event needs a citation', () {
      fx.list('events.json', 'events')[0]['citations'] = <Object>[];
      expectOnly('V3');
    });

    test('a hadith must cite a hadith collection', () {
      block(3)['citations'] = [
        {'sourceId': 'bio-a', 'locatorStatus': 'pending'},
      ];
      expectOnly('V3');
    });

    test('complete quoted text must have text', () {
      block(4).remove('text');
      expectOnly('V3');
    });
  });

  group('V4 disputes', () {
    test('a dispute needs two opinions', () {
      (block(5)['opinions'] as List).removeLast();
      expectOnly('V4');
    });

    test('each opinion needs a source', () {
      block(5)['opinions'][0]['citations'] = <Object>[];
      expectOnly('V3');
    });

    test('a disputed paragraph should be a disputeNote', () {
      block(0)['reliability'] = 'disputed';
      expect(codes(validate(), Severity.warning), {'V4'});
    });
  });

  group('V5 wording', () {
    test('no Companion honorific inside a name field', () {
      fx.companionA['name'] = {'ar': 'صاحب رضي الله عنه'};
      expectOnly('V5');
    });

    test('ﷺ is allowed in a title', () {
      fx.companionA['titles'] = [
        {'ar': 'حواري رسول الله ﷺ'},
      ];
      expect(validate().issues, isEmpty);
    });

    test('no abbreviated honorifics anywhere', () {
      block(0)['text'] = {'ar': 'قال النبي (ص)'};
      expectOnly('V5');
    });
  });

  group('V6–V8 approvals', () {
    test('approved status needs an approval record', () {
      fx.companionA['review'] = {'status': 'approved'};
      expectOnly('V6');
    });

    test('the reviewer must be registered', () {
      fx.companionA['review'] = {'status': 'approved'};
      fx.files['reviews/companion.comp-a.json'] = fx.approvalFor(
        'companion',
        'comp-a',
        fx.companionA,
        reviewerId: 'someone',
      );
      expectOnly('V6');
    });

    test('every checklist item must pass', () {
      fx.approve('companion', 'comp-a', fx.companionA);
      (fx.files['reviews/companion.comp-a.json']!['checklist']
              as Map)['noEmbellishment'] =
          false;
      expectOnly('V6');
    });

    test('a correct approval is accepted', () {
      fx.approve('companion', 'comp-a', fx.companionA);
      expect(validate().issues, isEmpty);
    });

    test('editing after approval invalidates it', () {
      fx.approve('companion', 'comp-a', fx.companionA);
      fx.companionA['summary'] = {'ar': 'نص معدّل'};
      expectOnly('V7');
    });

    test('changing only the review block keeps the approval', () {
      fx.approve('companion', 'comp-a', fx.companionA);
      fx.companionA['review'] = {
        'status': 'approved',
        'authoredBy': 'someone else',
      };
      expect(validate().issues, isEmpty);
    });

    test('fitna-adjacent items need explicit sign-off', () {
      fx.approve('companion', 'comp-a', fx.companionA);
      fx.companionA['review'] = {
        'status': 'approved',
        'editorialFlags': ['fitnaAdjacent'],
      };
      expectOnly('V8');
      fx.files['reviews/companion.comp-a.json'] = fx.approvalFor(
        'companion',
        'comp-a',
        fx.companionA,
        fitnaSignOff: true,
      );
      expect(validate().issues, isEmpty);
    });

    test('an approval for an unapproved item is warned about', () {
      fx.files['reviews/companion.comp-b.json'] = fx.approvalFor(
        'companion',
        'comp-b',
        fx.files['companions/comp-b.json']!,
      );
      expect(codes(validate(), Severity.warning), {'V6'});
    });
  });

  group('V9 pending work', () {
    test('"complete" needs an actual locator', () {
      block(0)['citations'] = [
        {'sourceId': 'bio-a', 'locatorStatus': 'complete'},
      ];
      expectOnly('V9');
    });

    test('pending work blocks publication of an approved item', () {
      fx.approve('companion', 'comp-a', fx.companionA);
      block(0)['citations'] = [
        {'sourceId': 'bio-a', 'locatorStatus': 'pending'},
      ];
      // Re-approve the edited content so only the pending locator remains.
      fx.files['reviews/companion.comp-a.json'] = fx.approvalFor(
        'companion',
        'comp-a',
        fx.companionA,
      );
      final report = validate(channel: ContentChannel.published);
      expect(codes(report), containsAll(['V9']));
    });
  });

  test('V10 the ayah must exist', () {
    block(2)['ref'] = {'surah': 1, 'ayahFrom': 8};
    expectOnly('V10');
  });

  group('V12 dates', () {
    test('a range must not end before it starts', () {
      (fx.companionA['death'] as Map)['date'] = {
        'precision': 'range',
        'hijriYear': 51,
        'hijriYearEnd': 50,
      };
      expectOnly('V12');
    });

    test('a Gregorian year far from the Hijri year is warned about', () {
      ((fx.companionA['death'] as Map)['date'] as Map)['gregorianYear'] = 700;
      expect(codes(validate(), Severity.warning), {'V12'});
    });
  });

  group('Revision 4: the Seerah, places and visuals', () {
    setUp(() => fx.addSeerah());

    Map<String, dynamic> chapter() =>
        fx.files['seerah/chapters/chapter-a.json']!;
    Map<String, dynamic> visual() => fx.files['visuals/visual-a.json']!;

    test('the Seerah fixture is valid, with pending work counted', () {
      final report = validate();
      expect(report.issues, isEmpty, reason: report.issues.join('\n'));
      expect(report.pendingByItem.keys, contains('seerahChapter.chapter-a'));
    });

    test('a passage cannot show a visual that does not exist', () {
      (chapter()['blocks'] as List).add({
        'type': 'infographic',
        'visualId': 'no-such-visual',
      });
      expectOnly('V2');
    });

    test('a chapter outside the reading order is unreachable', () {
      fx.files['seerah/chapters/chapter-b.json'] =
          (jsonDecode(jsonEncode(chapter())) as Map<String, dynamic>)
            ..['id'] = 'chapter-b';
      expectOnly('V2');
    });

    test('a chapter needs work-level references', () {
      chapter()['references'] = <String>[];
      expectOnly('V3');
    });

    test('unknown events, places and companions are reported', () {
      chapter()['eventIds'] = ['no-event'];
      chapter()['placeIds'] = ['no-place'];
      chapter()['companionIds'] = ['no-companion'];
      final report = validate();
      expect(codes(report), {'V2'});
      expect(report.issues.where((i) => i.rule == 'V2'), hasLength(3));
    });

    test('a place can only name known companions', () {
      (fx.list('places.json', 'places').first as Map)['companionIds'] = [
        'comp-a',
        'no-companion',
      ];
      final report = validate();
      expect(codes(report), {'V2'});
      expect(report.issues.where((i) => i.rule == 'V2'), hasLength(1));
    });

    test('a visual only carries the data of its own type', () {
      visual()['bands'] = [
        {
          'label': {'ar': 'مرحلة'},
          'date': {'precision': 'year', 'hijriYear': 1},
          'reliability': 'established',
          'citations': [
            {'sourceId': 'bio-a', 'locatorStatus': 'pending'},
          ],
        },
      ];
      expectOnly('V13');
    });

    test('a journey can only join places on its map', () {
      ((visual()['route'] as List)[0] as Map)['to'] = 'place-c';
      expectOnly('V13');
    });

    test('each journey leg is a sourced claim', () {
      ((visual()['route'] as List)[0] as Map)['citations'] = <Object>[];
      expectOnly('V3');
    });

    test('a companion timeline visual needs timeline entries', () {
      fx.files['visuals/visual-b.json'] = {
        'schemaVersion': 1,
        'id': 'visual-b',
        'type': 'timeline',
        'title': {'ar': 'خط'},
        'takeaway': {'ar': 'خلاصة'},
        'review': {'status': 'draft'},
        'companionId': 'comp-b',
      };
      expectOnly('V13');
    });

    test('a timeline visual names a companion or events (schema)', () {
      fx.files['visuals/visual-b.json'] = {
        'schemaVersion': 1,
        'id': 'visual-b',
        'type': 'timeline',
        'title': {'ar': 'خط'},
        'takeaway': {'ar': 'خلاصة'},
        'review': {'status': 'draft'},
      };
      expectOnly('V1');
    });

    test('a place needs a citation', () {
      ((fx.files['places.json']!['places'] as List)[0] as Map)['citations'] =
          <Object>[];
      expectOnly('V3');
    });

    test('an approved chapter may only show approved visuals and places', () {
      fx.approve('seerahChapter', 'chapter-a', chapter());
      final report = validate(channel: ContentChannel.published);
      final v11 = [
        for (final i in report.issues)
          if (i.rule == 'V11') i.message,
      ];
      expect(v11.join('\n'), contains('visual "visual-a"'));
      expect(v11.join('\n'), contains('place "place-a"'));
    });

    test('the draft build writes the Seerah index, chapters and visuals', () {
      final result = buildContent(
        fx.toFiles(),
        schemas,
        channel: ContentChannel.draft,
      );
      expect(
        result.outputs.keys,
        containsAll([
          'seerah/index.json',
          'seerah/chapters/chapter-a.json',
          'seerah/topics/topic-a.json',
          'places.json',
          'visuals.json',
        ]),
      );
      final index =
          jsonDecode(result.outputs['seerah/index.json']!)
              as Map<String, dynamic>;
      final summary = (index['chapters'] as List).single as Map;
      expect(summary['id'], 'chapter-a');
      expect(summary['wordCount'], 1);
      final manifest =
          jsonDecode(result.outputs['manifest.json']!) as Map<String, dynamic>;
      expect(manifest['seerahChapterCount'], 1);
      expect(manifest['visualCount'], 1);
    });

    test('the published build leaves out unapproved chapters and links', () {
      for (final id in ['quran', 'hadith-a', 'bio-a']) {
        fx.approve('source', id, fx.source(id));
      }
      fx
        ..approve(
          'category',
          'cat-a',
          fx.list('categories.json', 'categories')[0] as Map<String, dynamic>,
        )
        ..approve(
          'event',
          'event-a',
          fx.list('events.json', 'events')[0] as Map<String, dynamic>,
        )
        ..approve('companion', 'comp-a', fx.companionA)
        ..approveSeerah();
      // The essay goes back to draft: it must vanish, links and all.
      fx.files['seerah/topics/topic-a.json']!['review'] = {'status': 'draft'};
      fx.files.remove('reviews/seerahTopic.topic-a.json');
      final result = buildContent(
        fx.toFiles(),
        schemas,
        channel: ContentChannel.published,
      );
      expect(
        result.report.hasErrors,
        isFalse,
        reason: result.report.issues.join('\n'),
      );
      expect(result.outputs.keys, contains('seerah/chapters/chapter-a.json'));
      expect(
        result.outputs.keys,
        isNot(contains('seerah/topics/topic-a.json')),
      );
      final index =
          jsonDecode(result.outputs['seerah/index.json']!)
              as Map<String, dynamic>;
      expect((index['seerah'] as Map)['topicIds'], isEmpty);
      expect(index['topics'], isEmpty);
    });
  });

  group('publication', () {
    void approveAll() {
      for (final id in ['quran', 'hadith-a', 'bio-a']) {
        fx.approve('source', id, fx.source(id));
      }
      fx.approve(
        'category',
        'cat-a',
        fx.list('categories.json', 'categories')[0] as Map<String, dynamic>,
      );
      fx.approve(
        'event',
        'event-a',
        fx.list('events.json', 'events')[0] as Map<String, dynamic>,
      );
      fx.approve('companion', 'comp-a', fx.companionA);
    }

    test('V11 an approved item may only use approved items', () {
      fx.approve('companion', 'comp-a', fx.companionA);
      final report = validate(channel: ContentChannel.published);
      expect(codes(report), {'V11'});
    });

    test('a fully approved companion can be published', () {
      approveAll();
      final report = validate(channel: ContentChannel.published);
      expect(report.issues, isEmpty, reason: report.issues.join('\n'));
    });

    test('the published build contains approved items only', () {
      approveAll();
      final result = buildContent(
        fx.toFiles(),
        schemas,
        channel: ContentChannel.published,
      );
      expect(result.outputs.keys, contains('companions/comp-a.json'));
      expect(result.outputs.keys, isNot(contains('companions/comp-b.json')));
      expect(result.outputs.keys, isNot(contains('stories/story-a.json')));
      final manifest =
          jsonDecode(result.outputs['manifest.json']!) as Map<String, dynamic>;
      expect(manifest['channel'], 'published');
      expect(manifest['unapprovedCount'], 0);
      expect(manifest['companionCount'], 1);
    });
  });

  group('build', () {
    test('fails with no outputs when there are errors', () {
      fx.companionA['references'] = <String>[];
      final result = buildContent(
        fx.toFiles(),
        schemas,
        channel: ContentChannel.draft,
      );
      expect(result.report.hasErrors, isTrue);
      expect(result.outputs, isEmpty);
    });

    test('draft includes everything, ordered, without authorship', () {
      fx.companionA['review'] = {'status': 'draft', 'authoredBy': 'someone'};
      final result = buildContent(
        fx.toFiles(),
        schemas,
        channel: ContentChannel.draft,
      );
      expect(
        result.outputs.keys,
        containsAll([
          'companions/comp-a.json',
          'companions/comp-b.json',
          'stories/story-a.json',
        ]),
      );
      final index =
          jsonDecode(result.outputs['index/companions.json']!)
              as Map<String, dynamic>;
      expect(
        [for (final c in index['companions'] as List) (c as Map)['id']],
        ['comp-b', 'comp-a'], // by order
      );
      expect(
        result.outputs['companions/comp-a.json'],
        isNot(contains('authoredBy')),
      );
      final manifest =
          jsonDecode(result.outputs['manifest.json']!) as Map<String, dynamic>;
      expect(manifest['channel'], 'draft');
      expect((manifest['files'] as Map).keys, isNot(contains('manifest.json')));
    });

    test('is deterministic', () {
      String build() => jsonEncode(
        buildContent(
          fx.toFiles(),
          schemas,
          channel: ContentChannel.draft,
        ).outputs,
      );
      expect(build(), build());
    });
  });
}
