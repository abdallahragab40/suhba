import 'dart:convert';

import '../../tool/src/content/content_files.dart';
import '../../tool/src/content/content_hash.dart';

/// A minimal, valid content tree as editable JSON maps. Tests mutate it to
/// trigger one rule at a time. Texts are neutral placeholders.
class ContentFixture {
  ContentFixture() {
    files = {
      'meta.json': {'schemaVersion': 1, 'contentVersion': '1.0.0'},
      'reviewers.json': {'schemaVersion': 1, 'reviewers': <Object>[]},
      'sources.json': {
        'schemaVersion': 1,
        'sources': [
          _source('quran', 'quran'),
          _source('hadith-a', 'hadithCollection'),
          _source('bio-a', 'biographical'),
        ],
      },
      'categories.json': {
        'schemaVersion': 1,
        'categories': [
          {
            'id': 'cat-a',
            'name': _t('فئة'),
            'order': 1,
            'review': _draft(),
            'basis': {
              'type': 'paragraph',
              'text': _t('نص'),
              'reliability': 'established',
              'citations': [_pending('bio-a')],
            },
          },
        ],
      },
      'people.json': {
        'schemaVersion': 1,
        'people': [
          {
            'id': 'person-a',
            'name': _t('شخص'),
            'honorific': 'none',
            'review': _draft(),
          },
        ],
      },
      'events.json': {
        'schemaVersion': 1,
        'events': [
          {
            'id': 'event-a',
            'name': _t('حدث'),
            'type': 'hijrah',
            'date': {'precision': 'year', 'hijriYear': 1, 'gregorianYear': 622},
            'summary': _t('نص'),
            'reliability': 'established',
            'citations': [_pending('bio-a')],
            'review': _draft(),
            'participants': [
              {'displayName': _t('صاحب'), 'companionId': 'comp-a'},
            ],
          },
        ],
      },
      'companions/comp-a.json': {
        'schemaVersion': 1,
        'id': 'comp-a',
        'order': 2,
        'gender': 'male',
        'name': _t('صاحب'),
        'fullName': _t('صاحب بن فلان'),
        'summary': _t('نص'),
        'review': _draft(),
        'references': ['bio-a'],
        'death': {
          'date': {
            'precision': 'month',
            'hijriYear': 13,
            'hijriMonth': 6,
            'gregorianYear': 634,
          },
          'reliability': 'established',
          'citations': [_pending('bio-a')],
        },
        'memberships': [
          {
            'categoryId': 'cat-a',
            'citations': [_pending('bio-a')],
          },
        ],
        'relations': [
          {
            'type': 'relative',
            'person': {'displayName': _t('شخص'), 'personId': 'person-a'},
          },
        ],
        'sections': [
          {
            'id': 'comp-a.early',
            'kind': 'earlyLife',
            'title': _t('النشأة'),
            'blocks': [
              {
                'type': 'paragraph',
                'text': _t('نص'),
                'reliability': 'established',
                'citations': [_pending('bio-a')],
              },
              {'type': 'lesson', 'text': _t('درس')},
              {
                'type': 'quranQuote',
                'ref': {'surah': 9, 'ayahFrom': 40},
              },
              {
                'type': 'hadithQuote',
                'textStatus': 'pendingFromSource',
                'reliability': 'established',
                'citations': [_pending('hadith-a')],
                'summary': _t('ملخص'),
              },
              {
                'type': 'reportQuote',
                'textStatus': 'complete',
                'reliability': 'reported',
                'text': _t('نص'),
                'citations': [_pending('bio-a')],
              },
              {
                'type': 'disputeNote',
                'text': _t('اختُلف'),
                'opinions': [
                  {
                    'text': _t('قول'),
                    'citations': [_pending('bio-a')],
                  },
                  {
                    'text': _t('قول آخر'),
                    'citations': [_pending('bio-a')],
                  },
                ],
              },
            ],
          },
        ],
        'storyIds': ['story-a'],
        'timeline': [
          {
            'id': 'comp-a.t.hijrah',
            'era': 'madinan',
            'date': {'precision': 'year', 'hijriYear': 1},
            'title': _t('الهجرة'),
            'reliability': 'established',
            'citations': [
              {
                'sourceId': 'quran',
                'locatorStatus': 'complete',
                'quranRef': {'surah': 9, 'ayahFrom': 40},
              },
            ],
            'eventId': 'event-a',
            'sectionId': 'comp-a.early',
          },
        ],
      },
      'companions/comp-b.json': {
        'schemaVersion': 1,
        'id': 'comp-b',
        'order': 1,
        'gender': 'female',
        'name': _t('صاحبة'),
        'fullName': _t('صاحبة بنت فلان'),
        'summary': _t('نص'),
        'review': _draft(),
        'references': ['bio-a'],
      },
      'stories/story-a.json': {
        'schemaVersion': 1,
        'id': 'story-a',
        'title': _t('قصة'),
        'synopsis': _t('نص'),
        'companionIds': ['comp-a'],
        'readingMinutes': 3,
        'review': _draft(),
        'chapters': [
          {
            'id': 'story-a.1',
            'title': _t('الفصل الأول'),
            'blocks': [
              {
                'type': 'paragraph',
                'text': _t('نص'),
                'reliability': 'established',
                'citations': [_pending('bio-a')],
              },
            ],
          },
        ],
      },
    };
  }

  late Map<String, Map<String, dynamic>> files;

  ContentFiles toFiles() => ContentFiles({
    for (final MapEntry(:key, :value) in files.entries) key: jsonEncode(value),
  });

  Map<String, dynamic> get companionA => files['companions/comp-a.json']!;

  List<dynamic> list(String file, String key) => files[file]![key] as List;

  Map<String, dynamic> source(String id) => list(
    'sources.json',
    'sources',
  ).cast<Map<String, dynamic>>().firstWhere((s) => s['id'] == id);

  /// Registers a reviewer and approves [item] (with a correct hash) and
  /// fills in every locator, so it can be published.
  void approve(String kind, String id, Map<String, dynamic> item) {
    _completeLocators(item);
    final coverage = (item['review'] as Map?)?['coverage'];
    item['review'] = {'status': 'approved', 'coverage': ?coverage};
    final reviewers = list('reviewers.json', 'reviewers');
    if (reviewers.isEmpty) {
      reviewers.add({
        'id': 'reviewer-a',
        'name': 'مراجع',
        'qualification': 'test',
        'addedAt': '2026-01-01',
      });
    }
    files['reviews/$kind.$id.json'] = approvalFor(kind, id, item);
  }

  Map<String, dynamic> approvalFor(
    String kind,
    String id,
    Map<String, dynamic> item, {
    String reviewerId = 'reviewer-a',
    bool fitnaSignOff = false,
  }) => {
    'schemaVersion': 1,
    'kind': kind,
    'id': id,
    'reviewerId': reviewerId,
    'approvedAt': '2026-01-02',
    'contentHash': contentHash(item),
    'checklist': {
      'sourcesMatch': true,
      'gradingsCorrect': true,
      'noEmbellishment': true,
      'reliabilityCorrect': true,
      'honorificsCorrect': true,
      'fitnaSignOff': fitnaSignOff,
    },
  };

  /// Adds a minimal Seerah: the section with one period, one chapter (with
  /// a heading and a visual), one essay, two places, and a map visual.
  void addSeerah() {
    files['places.json'] = {
      'schemaVersion': 1,
      'places': [_place('place-a', 21.4, 39.8), _place('place-b', 24.4, 39.6)],
    };
    files['seerah/seerah.json'] = {
      'schemaVersion': 1,
      'title': _t('السيرة'),
      'subtitle': _t('السيرة النبوية'),
      'introduction': [_paragraph()],
      'eras': [
        {
          'id': 'era-a',
          'name': _t('مرحلة'),
          'date': {'precision': 'year', 'hijriYear': 1, 'gregorianYear': 622},
          'summary': _t('نص'),
          'reliability': 'established',
          'citations': [_pending('bio-a')],
          'chapterIds': ['chapter-a'],
        },
      ],
      'chapterIds': ['chapter-a'],
      'topicIds': ['topic-a'],
      'featuredEventIds': ['event-a'],
      'featuredPlaceIds': ['place-a'],
      'companionIds': ['comp-a'],
      'visualIds': ['visual-a'],
      'methodology': _t('منهج'),
      'references': ['bio-a'],
      'review': _draft(),
    };
    files['seerah/chapters/chapter-a.json'] = {
      'schemaVersion': 1,
      'id': 'chapter-a',
      'title': _t('فصل'),
      'abstract': _t('ملخص'),
      'era': 'madinan',
      'date': {'precision': 'year', 'hijriYear': 1, 'gregorianYear': 622},
      'references': ['bio-a'],
      'eventIds': ['event-a'],
      'placeIds': ['place-a'],
      'companionIds': ['comp-a'],
      'visualIds': ['visual-a'],
      'blocks': [
        {'type': 'heading', 'text': _t('عنوان')},
        _paragraph(),
        {'type': 'infographic', 'visualId': 'visual-a'},
      ],
      'review': {'status': 'draft', 'coverage': 'complete'},
    };
    files['seerah/topics/topic-a.json'] = {
      'schemaVersion': 1,
      'id': 'topic-a',
      'title': _t('موضوع'),
      'abstract': _t('ملخص'),
      'references': ['bio-a'],
      'chapterIds': ['chapter-a'],
      'blocks': [_paragraph()],
      'review': {'status': 'draft', 'coverage': 'complete'},
    };
    files['visuals/visual-a.json'] = {
      'schemaVersion': 1,
      'id': 'visual-a',
      'type': 'map',
      'title': _t('خريطة'),
      'takeaway': _t('خلاصة'),
      'review': _draft(),
      'placeIds': ['place-a', 'place-b'],
      'route': [
        {
          'from': 'place-a',
          'to': 'place-b',
          'approximate': true,
          'reliability': 'established',
          'citations': [_pending('bio-a')],
        },
      ],
    };
  }

  /// Approves everything [addSeerah] added.
  void approveSeerah() {
    for (final p in list('places.json', 'places')) {
      final place = p as Map<String, dynamic>;
      approve('place', place['id'] as String, place);
    }
    approve(
      'seerahChapter',
      'chapter-a',
      files['seerah/chapters/chapter-a.json']!,
    );
    approve('seerahTopic', 'topic-a', files['seerah/topics/topic-a.json']!);
    approve('visual', 'visual-a', files['visuals/visual-a.json']!);
    approve('seerah', 'seerah', files['seerah/seerah.json']!);
  }

  /// Gives every pending citation a page and every pending quote a text, so
  /// the item has no pending work.
  static void _completeLocators(Object? node) {
    if (node is Map<String, dynamic>) {
      if (node['locatorStatus'] == 'pending') {
        node['locatorStatus'] = 'complete';
        node['page'] = '1';
      }
      if (node['textStatus'] == 'pendingFromSource') {
        node['textStatus'] = 'complete';
        node['text'] = _t('نص');
      }
      if (node['type'] == 'hadithQuote') {
        for (final c
            in (node['citations'] as List).cast<Map<String, dynamic>>()) {
          c['grading'] = {'grade': 'sahih', 'gradedBy': _t('البخاري')};
        }
      }
      node.values.forEach(_completeLocators);
    } else if (node is List) {
      node.forEach(_completeLocators);
    }
  }

  static Map<String, dynamic> _t(String ar) => {'ar': ar};
  static Map<String, dynamic> _paragraph() => {
    'type': 'paragraph',
    'text': _t('نص'),
    'reliability': 'established',
    'citations': [_pending('bio-a')],
  };
  static Map<String, dynamic> _place(String id, double lat, double lon) => {
    'id': id,
    'name': _t('مكان'),
    'kind': 'city',
    'location': {'lat': lat, 'lon': lon, 'precision': 'identified'},
    'summary': _t('نص'),
    'reliability': 'established',
    'citations': [_pending('bio-a')],
    'review': _draft(),
  };
  static Map<String, dynamic> _draft() => {'status': 'draft'};
  static Map<String, dynamic> _pending(String sourceId) => {
    'sourceId': sourceId,
    'locatorStatus': 'pending',
  };
  static Map<String, dynamic> _source(String id, String type) => {
    'id': id,
    'type': type,
    'title': _t('كتاب $id'),
    'review': _draft(),
  };
}
