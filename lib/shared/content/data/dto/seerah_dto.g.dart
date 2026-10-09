// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerah_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeerahEraDto _$SeerahEraDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SeerahEraDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'id',
          'name',
          'date',
          'summary',
          'reliability',
          'citations',
          'chapterIds',
        ],
      );
      final val = _SeerahEraDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert(
          'name',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        date: $checkedConvert(
          'date',
          (v) => HistoricalDateDto.fromJson(v as Map<String, dynamic>),
        ),
        summary: $checkedConvert(
          'summary',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        reliability: $checkedConvert(
          'reliability',
          (v) => $enumDecode(_$ReliabilityEnumMap, v),
        ),
        citations: $checkedConvert(
          'citations',
          (v) => (v as List<dynamic>)
              .map((e) => CitationDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        chapterIds: $checkedConvert(
          'chapterIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SeerahEraDtoToJson(_SeerahEraDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name.toJson(),
      'date': instance.date.toJson(),
      'summary': instance.summary.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'chapterIds': instance.chapterIds,
    };

const _$ReliabilityEnumMap = {
  Reliability.established: 'established',
  Reliability.reported: 'reported',
  Reliability.disputed: 'disputed',
  Reliability.unknown: 'unknown',
};

_SeerahDto _$SeerahDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SeerahDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'schemaVersion',
          'title',
          'subtitle',
          'introduction',
          'eras',
          'chapterIds',
          'topicIds',
          'methodology',
          'references',
          'review',
          'featuredEventIds',
          'featuredPlaceIds',
          'companionIds',
          'visualIds',
        ],
      );
      final val = _SeerahDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        subtitle: $checkedConvert(
          'subtitle',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        introduction: $checkedConvert(
          'introduction',
          (v) => (v as List<dynamic>)
              .map((e) => ContentBlockDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        eras: $checkedConvert(
          'eras',
          (v) => (v as List<dynamic>)
              .map((e) => SeerahEraDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        chapterIds: $checkedConvert(
          'chapterIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        topicIds: $checkedConvert(
          'topicIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        methodology: $checkedConvert(
          'methodology',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        references: $checkedConvert(
          'references',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
        featuredEventIds: $checkedConvert(
          'featuredEventIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
        featuredPlaceIds: $checkedConvert(
          'featuredPlaceIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
        companionIds: $checkedConvert(
          'companionIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
        visualIds: $checkedConvert(
          'visualIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
      );
      return val;
    });

Map<String, dynamic> _$SeerahDtoToJson(_SeerahDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'title': instance.title.toJson(),
      'subtitle': instance.subtitle.toJson(),
      'introduction': instance.introduction.map((e) => e.toJson()).toList(),
      'eras': instance.eras.map((e) => e.toJson()).toList(),
      'chapterIds': instance.chapterIds,
      'topicIds': instance.topicIds,
      'methodology': instance.methodology.toJson(),
      'references': instance.references,
      'review': instance.review.toJson(),
      'featuredEventIds': instance.featuredEventIds,
      'featuredPlaceIds': instance.featuredPlaceIds,
      'companionIds': instance.companionIds,
      'visualIds': instance.visualIds,
    };

_SeerahChapterDto _$SeerahChapterDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SeerahChapterDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'schemaVersion',
          'id',
          'title',
          'abstract',
          'era',
          'date',
          'references',
          'blocks',
          'review',
          'eventIds',
          'placeIds',
          'companionIds',
          'visualIds',
        ],
      );
      final val = _SeerahChapterDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        abstract: $checkedConvert(
          'abstract',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        era: $checkedConvert('era', (v) => $enumDecode(_$SeerahEraEnumMap, v)),
        date: $checkedConvert(
          'date',
          (v) => HistoricalDateDto.fromJson(v as Map<String, dynamic>),
        ),
        references: $checkedConvert(
          'references',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        blocks: $checkedConvert(
          'blocks',
          (v) => (v as List<dynamic>)
              .map((e) => ContentBlockDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
        eventIds: $checkedConvert(
          'eventIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
        placeIds: $checkedConvert(
          'placeIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
        companionIds: $checkedConvert(
          'companionIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
        visualIds: $checkedConvert(
          'visualIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
      );
      return val;
    });

Map<String, dynamic> _$SeerahChapterDtoToJson(_SeerahChapterDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'id': instance.id,
      'title': instance.title.toJson(),
      'abstract': instance.abstract.toJson(),
      'era': _$SeerahEraEnumMap[instance.era]!,
      'date': instance.date.toJson(),
      'references': instance.references,
      'blocks': instance.blocks.map((e) => e.toJson()).toList(),
      'review': instance.review.toJson(),
      'eventIds': instance.eventIds,
      'placeIds': instance.placeIds,
      'companionIds': instance.companionIds,
      'visualIds': instance.visualIds,
    };

const _$SeerahEraEnumMap = {
  SeerahEra.preIslam: 'preIslam',
  SeerahEra.makkan: 'makkan',
  SeerahEra.madinan: 'madinan',
};

_SeerahTopicDto _$SeerahTopicDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SeerahTopicDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'schemaVersion',
          'id',
          'title',
          'abstract',
          'references',
          'blocks',
          'review',
          'chapterIds',
          'companionIds',
        ],
      );
      final val = _SeerahTopicDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        abstract: $checkedConvert(
          'abstract',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        references: $checkedConvert(
          'references',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        blocks: $checkedConvert(
          'blocks',
          (v) => (v as List<dynamic>)
              .map((e) => ContentBlockDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
        chapterIds: $checkedConvert(
          'chapterIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
        companionIds: $checkedConvert(
          'companionIds',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
      );
      return val;
    });

Map<String, dynamic> _$SeerahTopicDtoToJson(_SeerahTopicDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'id': instance.id,
      'title': instance.title.toJson(),
      'abstract': instance.abstract.toJson(),
      'references': instance.references,
      'blocks': instance.blocks.map((e) => e.toJson()).toList(),
      'review': instance.review.toJson(),
      'chapterIds': instance.chapterIds,
      'companionIds': instance.companionIds,
    };

_SeerahChapterSummaryDto _$SeerahChapterSummaryDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SeerahChapterSummaryDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'id',
      'title',
      'abstract',
      'era',
      'date',
      'review',
      'wordCount',
      'visualIds',
    ],
  );
  final val = _SeerahChapterSummaryDto(
    id: $checkedConvert('id', (v) => v as String),
    title: $checkedConvert(
      'title',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    abstract: $checkedConvert(
      'abstract',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    era: $checkedConvert('era', (v) => $enumDecode(_$SeerahEraEnumMap, v)),
    date: $checkedConvert(
      'date',
      (v) => HistoricalDateDto.fromJson(v as Map<String, dynamic>),
    ),
    review: $checkedConvert(
      'review',
      (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
    ),
    wordCount: $checkedConvert('wordCount', (v) => (v as num).toInt()),
    visualIds: $checkedConvert(
      'visualIds',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    ),
  );
  return val;
});

Map<String, dynamic> _$SeerahChapterSummaryDtoToJson(
  _SeerahChapterSummaryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title.toJson(),
  'abstract': instance.abstract.toJson(),
  'era': _$SeerahEraEnumMap[instance.era]!,
  'date': instance.date.toJson(),
  'review': instance.review.toJson(),
  'wordCount': instance.wordCount,
  'visualIds': instance.visualIds,
};

_SeerahTopicSummaryDto _$SeerahTopicSummaryDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SeerahTopicSummaryDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['id', 'title', 'abstract', 'review', 'wordCount'],
  );
  final val = _SeerahTopicSummaryDto(
    id: $checkedConvert('id', (v) => v as String),
    title: $checkedConvert(
      'title',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    abstract: $checkedConvert(
      'abstract',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    review: $checkedConvert(
      'review',
      (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
    ),
    wordCount: $checkedConvert('wordCount', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$SeerahTopicSummaryDtoToJson(
  _SeerahTopicSummaryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title.toJson(),
  'abstract': instance.abstract.toJson(),
  'review': instance.review.toJson(),
  'wordCount': instance.wordCount,
};

_SeerahIndexDto _$SeerahIndexDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SeerahIndexDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['schemaVersion', 'seerah', 'chapters', 'topics'],
  );
  final val = _SeerahIndexDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    seerah: $checkedConvert(
      'seerah',
      (v) => SeerahDto.fromJson(v as Map<String, dynamic>),
    ),
    chapters: $checkedConvert(
      'chapters',
      (v) => (v as List<dynamic>)
          .map(
            (e) => SeerahChapterSummaryDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    topics: $checkedConvert(
      'topics',
      (v) => (v as List<dynamic>)
          .map((e) => SeerahTopicSummaryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$SeerahIndexDtoToJson(_SeerahIndexDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'seerah': instance.seerah.toJson(),
      'chapters': instance.chapters.map((e) => e.toJson()).toList(),
      'topics': instance.topics.map((e) => e.toJson()).toList(),
    };
