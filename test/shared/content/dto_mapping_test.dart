import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/quran_ref.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/data/dto/block_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/companion_dto.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/content_mappers.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

Map<String, dynamic> _readJson(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  group('sample content', () {
    test('every companion file maps to a domain Companion', () {
      final files = Directory(
        'content/companions',
      ).listSync().whereType<File>().where((f) => f.path.endsWith('.json'));
      expect(files, hasLength(10));
      for (final file in files) {
        final companion = CompanionDto.fromJson(
          _readJson(file.path),
        ).toDomain();
        expect(companion.review.status, ReviewStatus.draft, reason: file.path);
        expect(companion.memberships, isNotEmpty, reason: file.path);
      }
    });

    test('Abu Bakr maps field by field', () {
      final c = CompanionDto.fromJson(
        _readJson('content/companions/abu-bakr.json'),
      ).toDomain();
      expect(c.id, 'abu-bakr');
      expect(c.order, 1);
      expect(c.gender, Gender.male);
      expect(c.name.ar, 'أبو بكر الصديق');
      expect(c.titles.map((t) => t.ar), ['الصديق', 'العتيق']);
      expect(
        c.death!.date,
        const HistoricalDate(
          precision: DatePrecision.month,
          hijriYear: 13,
          hijriMonth: 6,
          gregorianYear: 634,
        ),
      );
      expect(c.death!.reliability, Reliability.established);
      expect(
        c.death!.citations.every(
          (x) => x.locatorStatus == LocatorStatus.pending,
        ),
        isTrue,
      );
      expect(c.memberships.map((m) => m.categoryId), [
        'ashara-mubashshara',
        'khulafa-rashidun',
        'muhajirun',
      ]);
      expect(c.sections.map((x) => x.kind), [
        SectionKind.earlyLife,
        SectionKind.conversion,
        SectionKind.withProphet,
        SectionKind.virtues,
        SectionKind.character,
        SectionKind.contributions,
        SectionKind.death,
        SectionKind.lessons,
      ]);
      expect(c.timeline, hasLength(13));
      expect(c.review.coverage, Coverage.complete);
      final hijrah = c.timeline.firstWhere((t) => t.id == 'abu-bakr.t.hijrah');
      expect(
        hijrah.citations.first.quranRef,
        const QuranRef(surah: 9, ayahFrom: 40),
      );
      expect(hijrah.eventId, 'hijrah');
      expect(hijrah.sectionId, 'abu-bakr.hijrah');
      // In the order of events, not the order of writing.
      expect(c.storyIds, [
        'islam-of-abu-dharr',
        'protection-of-ibn-al-daghinah',
        'the-cave',
        'day-of-badr',
        'treaty-of-hudaybiyah',
        'hunayn-and-the-ansar',
        'army-of-hardship',
        'the-farewell-pilgrimage',
        'the-day-of-saqifah',
        'jam-al-quran',
      ]);
      expect(c.review.editorialFlags, {
        EditorialFlag.needsLocators,
        EditorialFlag.needsSourceText,
      });
      // Hadith appear by description only until copied from the edition.
      final quotes = c.sections
          .expand((x) => x.blocks)
          .whereType<HadithQuoteBlock>();
      expect(quotes, isNotEmpty);
      expect(quotes.every((q) => q.text == null), isTrue);
    });

    test('fitna-adjacent companions are flagged', () {
      for (final id in ['uthman', 'ali', 'talha', 'zubayr']) {
        final c = CompanionDto.fromJson(
          _readJson('content/companions/$id.json'),
        ).toDomain();
        expect(
          c.review.editorialFlags,
          contains(EditorialFlag.fitnaAdjacent),
          reason: id,
        );
      }
    });
  });

  group('content blocks', () {
    final cases = <String, Map<String, dynamic>>{
      'paragraph': {
        'type': 'paragraph',
        'text': {'ar': 'نص'},
        'reliability': 'established',
        'citations': [
          {'sourceId': 's', 'locatorStatus': 'pending'},
        ],
      },
      'lesson': {
        'type': 'lesson',
        'text': {'ar': 'درس'},
      },
      'quranQuote': {
        'type': 'quranQuote',
        'ref': {'surah': 2, 'ayahFrom': 255, 'ayahTo': 257},
      },
      'hadithQuote': {
        'type': 'hadithQuote',
        'textStatus': 'pendingFromSource',
        'reliability': 'established',
        'citations': [
          {
            'sourceId': 'bukhari',
            'locatorStatus': 'complete',
            'hadithNumber': '1',
            'grading': {
              'grade': 'sahih',
              'gradedBy': {'ar': 'البخاري'},
            },
          },
        ],
        'summary': {'ar': 'ملخص'},
      },
      'reportQuote': {
        'type': 'reportQuote',
        'textStatus': 'complete',
        'reliability': 'reported',
        'text': {'ar': 'نص'},
        'citations': [
          {'sourceId': 's', 'locatorStatus': 'pending'},
        ],
      },
      'disputeNote': {
        'type': 'disputeNote',
        'text': {'ar': 'اختُلف'},
        'opinions': [
          {
            'text': {'ar': 'قول'},
            'citations': [
              {'sourceId': 's', 'locatorStatus': 'pending'},
            ],
          },
        ],
      },
    };

    for (final MapEntry(key: type, value: json) in cases.entries) {
      test('$type round-trips through the DTO', () {
        final dto = ContentBlockDto.fromJson(json);
        expect(jsonDecode(jsonEncode(dto.toJson())), json);
      });
    }

    test('each type maps to its domain variant', () {
      final mapped = [
        for (final json in cases.values)
          ContentBlockDto.fromJson(json).toDomain(),
      ];
      expect(mapped[0], isA<ParagraphBlock>());
      expect(mapped[1], isA<LessonBlock>());
      expect(
        (mapped[2] as QuranQuoteBlock).ref,
        const QuranRef(surah: 2, ayahFrom: 255, ayahTo: 257),
      );
      final hadith = mapped[3] as HadithQuoteBlock;
      expect(hadith.textStatus, TextStatus.pendingFromSource);
      expect(hadith.text, isNull);
      expect(hadith.citations.single.grading!.grade, HadithGrade.sahih);
      expect(mapped[4], isA<ReportQuoteBlock>());
      expect((mapped[5] as DisputeNoteBlock).opinions, hasLength(1));
    });
  });

  group('strict parsing', () {
    test('unknown keys are rejected', () {
      expect(
        () => LocalizedTextDto.fromJson({'ar': 'نص', 'fr': 'x'}),
        throwsA(
          isA<CheckedFromJsonException>().having(
            (e) => e.innerError,
            'innerError',
            isA<UnrecognizedKeysException>(),
          ),
        ),
      );
    });

    test('unknown enum values are rejected', () {
      expect(
        () => DatedClaimDto.fromJson({
          'date': {'precision': 'sometime'},
          'reliability': 'established',
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('an unknown block type is rejected', () {
      expect(
        () => ContentBlockDto.fromJson({'type': 'poem'}),
        throwsA(anything),
      );
    });
  });
}
