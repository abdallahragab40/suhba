// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalizedTextDto _$LocalizedTextDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LocalizedTextDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['ar', 'en']);
      final val = _LocalizedTextDto(
        ar: $checkedConvert('ar', (v) => v as String),
        en: $checkedConvert('en', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$LocalizedTextDtoToJson(_LocalizedTextDto instance) =>
    <String, dynamic>{'ar': instance.ar, 'en': ?instance.en};

_HistoricalDateDto _$HistoricalDateDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HistoricalDateDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'precision',
          'era',
          'hijriYear',
          'hijriMonth',
          'hijriDay',
          'gregorianYear',
          'endEra',
          'hijriYearEnd',
          'gregorianYearEnd',
        ],
      );
      final val = _HistoricalDateDto(
        precision: $checkedConvert(
          'precision',
          (v) => $enumDecode(_$DatePrecisionEnumMap, v),
        ),
        era: $checkedConvert(
          'era',
          (v) =>
              $enumDecodeNullable(_$HijriEraEnumMap, v) ?? HijriEra.afterHijra,
        ),
        hijriYear: $checkedConvert('hijriYear', (v) => (v as num?)?.toInt()),
        hijriMonth: $checkedConvert('hijriMonth', (v) => (v as num?)?.toInt()),
        hijriDay: $checkedConvert('hijriDay', (v) => (v as num?)?.toInt()),
        gregorianYear: $checkedConvert(
          'gregorianYear',
          (v) => (v as num?)?.toInt(),
        ),
        endEra: $checkedConvert(
          'endEra',
          (v) => $enumDecodeNullable(_$HijriEraEnumMap, v),
        ),
        hijriYearEnd: $checkedConvert(
          'hijriYearEnd',
          (v) => (v as num?)?.toInt(),
        ),
        gregorianYearEnd: $checkedConvert(
          'gregorianYearEnd',
          (v) => (v as num?)?.toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$HistoricalDateDtoToJson(_HistoricalDateDto instance) =>
    <String, dynamic>{
      'precision': _$DatePrecisionEnumMap[instance.precision]!,
      'era': _$HijriEraEnumMap[instance.era]!,
      'hijriYear': ?instance.hijriYear,
      'hijriMonth': ?instance.hijriMonth,
      'hijriDay': ?instance.hijriDay,
      'gregorianYear': ?instance.gregorianYear,
      'endEra': ?_$HijriEraEnumMap[instance.endEra],
      'hijriYearEnd': ?instance.hijriYearEnd,
      'gregorianYearEnd': ?instance.gregorianYearEnd,
    };

const _$DatePrecisionEnumMap = {
  DatePrecision.exact: 'exact',
  DatePrecision.month: 'month',
  DatePrecision.year: 'year',
  DatePrecision.approx: 'approx',
  DatePrecision.range: 'range',
  DatePrecision.unknown: 'unknown',
};

const _$HijriEraEnumMap = {
  HijriEra.beforeHijra: 'beforeHijra',
  HijriEra.afterHijra: 'afterHijra',
};

_QuranRefDto _$QuranRefDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_QuranRefDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['surah', 'ayahFrom', 'ayahTo']);
      final val = _QuranRefDto(
        surah: $checkedConvert('surah', (v) => (v as num).toInt()),
        ayahFrom: $checkedConvert('ayahFrom', (v) => (v as num).toInt()),
        ayahTo: $checkedConvert('ayahTo', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$QuranRefDtoToJson(_QuranRefDto instance) =>
    <String, dynamic>{
      'surah': instance.surah,
      'ayahFrom': instance.ayahFrom,
      'ayahTo': ?instance.ayahTo,
    };

_GradingDto _$GradingDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GradingDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['grade', 'gradedBy']);
      final val = _GradingDto(
        grade: $checkedConvert(
          'grade',
          (v) => $enumDecode(_$HadithGradeEnumMap, v),
        ),
        gradedBy: $checkedConvert(
          'gradedBy',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GradingDtoToJson(_GradingDto instance) =>
    <String, dynamic>{
      'grade': _$HadithGradeEnumMap[instance.grade]!,
      'gradedBy': instance.gradedBy.toJson(),
    };

const _$HadithGradeEnumMap = {
  HadithGrade.sahih: 'sahih',
  HadithGrade.hasan: 'hasan',
  HadithGrade.daif: 'daif',
};

_CitationDto _$CitationDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_CitationDto',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'sourceId',
        'locatorStatus',
        'volume',
        'page',
        'hadithNumber',
        'chapterTitle',
        'quranRef',
        'grading',
        'note',
      ],
    );
    final val = _CitationDto(
      sourceId: $checkedConvert('sourceId', (v) => v as String),
      locatorStatus: $checkedConvert(
        'locatorStatus',
        (v) => $enumDecode(_$LocatorStatusEnumMap, v),
      ),
      volume: $checkedConvert('volume', (v) => (v as num?)?.toInt()),
      page: $checkedConvert('page', (v) => v as String?),
      hadithNumber: $checkedConvert('hadithNumber', (v) => v as String?),
      chapterTitle: $checkedConvert(
        'chapterTitle',
        (v) => v == null
            ? null
            : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
      ),
      quranRef: $checkedConvert(
        'quranRef',
        (v) =>
            v == null ? null : QuranRefDto.fromJson(v as Map<String, dynamic>),
      ),
      grading: $checkedConvert(
        'grading',
        (v) =>
            v == null ? null : GradingDto.fromJson(v as Map<String, dynamic>),
      ),
      note: $checkedConvert(
        'note',
        (v) => v == null
            ? null
            : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$CitationDtoToJson(_CitationDto instance) =>
    <String, dynamic>{
      'sourceId': instance.sourceId,
      'locatorStatus': _$LocatorStatusEnumMap[instance.locatorStatus]!,
      'volume': ?instance.volume,
      'page': ?instance.page,
      'hadithNumber': ?instance.hadithNumber,
      'chapterTitle': ?instance.chapterTitle?.toJson(),
      'quranRef': ?instance.quranRef?.toJson(),
      'grading': ?instance.grading?.toJson(),
      'note': ?instance.note?.toJson(),
    };

const _$LocatorStatusEnumMap = {
  LocatorStatus.complete: 'complete',
  LocatorStatus.pending: 'pending',
};

_DatedClaimDto _$DatedClaimDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DatedClaimDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['date', 'reliability', 'citations', 'note'],
      );
      final val = _DatedClaimDto(
        date: $checkedConvert(
          'date',
          (v) => HistoricalDateDto.fromJson(v as Map<String, dynamic>),
        ),
        reliability: $checkedConvert(
          'reliability',
          (v) => $enumDecode(_$ReliabilityEnumMap, v),
        ),
        citations: $checkedConvert(
          'citations',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => CitationDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <CitationDto>[],
        ),
        note: $checkedConvert(
          'note',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DatedClaimDtoToJson(_DatedClaimDto instance) =>
    <String, dynamic>{
      'date': instance.date.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'note': ?instance.note?.toJson(),
    };

const _$ReliabilityEnumMap = {
  Reliability.established: 'established',
  Reliability.reported: 'reported',
  Reliability.disputed: 'disputed',
  Reliability.unknown: 'unknown',
};

_FactDto _$FactDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_FactDto',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const ['label', 'reliability', 'text', 'date', 'citations'],
    );
    final val = _FactDto(
      label: $checkedConvert(
        'label',
        (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
      ),
      reliability: $checkedConvert(
        'reliability',
        (v) => $enumDecode(_$ReliabilityEnumMap, v),
      ),
      text: $checkedConvert(
        'text',
        (v) => v == null
            ? null
            : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
      ),
      date: $checkedConvert(
        'date',
        (v) => v == null
            ? null
            : HistoricalDateDto.fromJson(v as Map<String, dynamic>),
      ),
      citations: $checkedConvert(
        'citations',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => CitationDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const <CitationDto>[],
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$FactDtoToJson(_FactDto instance) => <String, dynamic>{
  'label': instance.label.toJson(),
  'reliability': _$ReliabilityEnumMap[instance.reliability]!,
  'text': ?instance.text?.toJson(),
  'date': ?instance.date?.toJson(),
  'citations': instance.citations.map((e) => e.toJson()).toList(),
};

_ReviewDto _$ReviewDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ReviewDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['status', 'editorialFlags', 'authoredBy'],
      );
      final val = _ReviewDto(
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$ReviewStatusEnumMap, v),
        ),
        editorialFlags: $checkedConvert(
          'editorialFlags',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$EditorialFlagEnumMap, e))
                  .toList() ??
              const <EditorialFlag>[],
        ),
        authoredBy: $checkedConvert('authoredBy', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ReviewDtoToJson(_ReviewDto instance) =>
    <String, dynamic>{
      'status': _$ReviewStatusEnumMap[instance.status]!,
      'editorialFlags': instance.editorialFlags
          .map((e) => _$EditorialFlagEnumMap[e]!)
          .toList(),
      'authoredBy': ?instance.authoredBy,
    };

const _$ReviewStatusEnumMap = {
  ReviewStatus.draft: 'draft',
  ReviewStatus.sourced: 'sourced',
  ReviewStatus.inReview: 'inReview',
  ReviewStatus.approved: 'approved',
  ReviewStatus.rejected: 'rejected',
};

const _$EditorialFlagEnumMap = {
  EditorialFlag.fitnaAdjacent: 'fitnaAdjacent',
  EditorialFlag.needsLocators: 'needsLocators',
  EditorialFlag.needsSourceText: 'needsSourceText',
};

_PersonRefDto _$PersonRefDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PersonRefDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['displayName', 'companionId', 'personId'],
      );
      final val = _PersonRefDto(
        displayName: $checkedConvert(
          'displayName',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        companionId: $checkedConvert('companionId', (v) => v as String?),
        personId: $checkedConvert('personId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$PersonRefDtoToJson(_PersonRefDto instance) =>
    <String, dynamic>{
      'displayName': instance.displayName.toJson(),
      'companionId': ?instance.companionId,
      'personId': ?instance.personId,
    };

_RelationDto _$RelationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RelationDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['type', 'person', 'citations']);
      final val = _RelationDto(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$RelationTypeEnumMap, v),
        ),
        person: $checkedConvert(
          'person',
          (v) => PersonRefDto.fromJson(v as Map<String, dynamic>),
        ),
        citations: $checkedConvert(
          'citations',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => CitationDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <CitationDto>[],
        ),
      );
      return val;
    });

Map<String, dynamic> _$RelationDtoToJson(_RelationDto instance) =>
    <String, dynamic>{
      'type': _$RelationTypeEnumMap[instance.type]!,
      'person': instance.person.toJson(),
      'citations': instance.citations.map((e) => e.toJson()).toList(),
    };

const _$RelationTypeEnumMap = {
  RelationType.father: 'father',
  RelationType.mother: 'mother',
  RelationType.child: 'child',
  RelationType.spouse: 'spouse',
  RelationType.sibling: 'sibling',
  RelationType.relative: 'relative',
  RelationType.teacher: 'teacher',
  RelationType.student: 'student',
  RelationType.brotherhood: 'brotherhood',
};

_MembershipDto _$MembershipDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MembershipDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['categoryId', 'citations', 'note']);
      final val = _MembershipDto(
        categoryId: $checkedConvert('categoryId', (v) => v as String),
        citations: $checkedConvert(
          'citations',
          (v) => (v as List<dynamic>)
              .map((e) => CitationDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        note: $checkedConvert(
          'note',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MembershipDtoToJson(_MembershipDto instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'note': ?instance.note?.toJson(),
    };
