// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiographySectionDto _$BiographySectionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BiographySectionDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['id', 'kind', 'title', 'blocks']);
      final val = _BiographySectionDto(
        id: $checkedConvert('id', (v) => v as String),
        kind: $checkedConvert(
          'kind',
          (v) => $enumDecode(_$SectionKindEnumMap, v),
        ),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        blocks: $checkedConvert(
          'blocks',
          (v) => (v as List<dynamic>)
              .map((e) => ContentBlockDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BiographySectionDtoToJson(
  _BiographySectionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'kind': _$SectionKindEnumMap[instance.kind]!,
  'title': instance.title.toJson(),
  'blocks': instance.blocks.map((e) => e.toJson()).toList(),
};

const _$SectionKindEnumMap = {
  SectionKind.earlyLife: 'earlyLife',
  SectionKind.conversion: 'conversion',
  SectionKind.withProphet: 'withProphet',
  SectionKind.virtues: 'virtues',
  SectionKind.contributions: 'contributions',
  SectionKind.character: 'character',
  SectionKind.lessons: 'lessons',
  SectionKind.death: 'death',
  SectionKind.custom: 'custom',
};

_TimelineEventDto _$TimelineEventDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TimelineEventDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'id',
          'era',
          'date',
          'title',
          'reliability',
          'citations',
          'summary',
          'eventId',
          'sectionId',
        ],
      );
      final val = _TimelineEventDto(
        id: $checkedConvert('id', (v) => v as String),
        era: $checkedConvert(
          'era',
          (v) => $enumDecode(_$TimelineEraEnumMap, v),
        ),
        date: $checkedConvert(
          'date',
          (v) => HistoricalDateDto.fromJson(v as Map<String, dynamic>),
        ),
        title: $checkedConvert(
          'title',
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
        summary: $checkedConvert(
          'summary',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        eventId: $checkedConvert('eventId', (v) => v as String?),
        sectionId: $checkedConvert('sectionId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TimelineEventDtoToJson(_TimelineEventDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'era': _$TimelineEraEnumMap[instance.era]!,
      'date': instance.date.toJson(),
      'title': instance.title.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'summary': ?instance.summary?.toJson(),
      'eventId': ?instance.eventId,
      'sectionId': ?instance.sectionId,
    };

const _$TimelineEraEnumMap = {
  TimelineEra.preIslam: 'preIslam',
  TimelineEra.makkan: 'makkan',
  TimelineEra.madinan: 'madinan',
  TimelineEra.afterProphet: 'afterProphet',
};

const _$ReliabilityEnumMap = {
  Reliability.established: 'established',
  Reliability.reported: 'reported',
  Reliability.disputed: 'disputed',
  Reliability.unknown: 'unknown',
};

_CompanionDto _$CompanionDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CompanionDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'schemaVersion',
      'id',
      'gender',
      'name',
      'fullName',
      'summary',
      'review',
      'references',
      'order',
      'lineage',
      'kunya',
      'titles',
      'aliases',
      'birth',
      'death',
      'deathPlace',
      'atAGlance',
      'memberships',
      'relations',
      'sections',
      'storyIds',
      'timeline',
    ],
  );
  final val = _CompanionDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    id: $checkedConvert('id', (v) => v as String),
    gender: $checkedConvert('gender', (v) => $enumDecode(_$GenderEnumMap, v)),
    name: $checkedConvert(
      'name',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    fullName: $checkedConvert(
      'fullName',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    summary: $checkedConvert(
      'summary',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    review: $checkedConvert(
      'review',
      (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
    ),
    references: $checkedConvert(
      'references',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    order: $checkedConvert('order', (v) => (v as num?)?.toInt()),
    lineage: $checkedConvert(
      'lineage',
      (v) => v == null
          ? null
          : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    kunya: $checkedConvert(
      'kunya',
      (v) => v == null
          ? null
          : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    titles: $checkedConvert(
      'titles',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => LocalizedTextDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LocalizedTextDto>[],
    ),
    aliases: $checkedConvert(
      'aliases',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    ),
    birth: $checkedConvert(
      'birth',
      (v) =>
          v == null ? null : DatedClaimDto.fromJson(v as Map<String, dynamic>),
    ),
    death: $checkedConvert(
      'death',
      (v) =>
          v == null ? null : DatedClaimDto.fromJson(v as Map<String, dynamic>),
    ),
    deathPlace: $checkedConvert(
      'deathPlace',
      (v) => v == null
          ? null
          : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    atAGlance: $checkedConvert(
      'atAGlance',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => FactDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FactDto>[],
    ),
    memberships: $checkedConvert(
      'memberships',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => MembershipDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MembershipDto>[],
    ),
    relations: $checkedConvert(
      'relations',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => RelationDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RelationDto>[],
    ),
    sections: $checkedConvert(
      'sections',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => BiographySectionDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <BiographySectionDto>[],
    ),
    storyIds: $checkedConvert(
      'storyIds',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    ),
    timeline: $checkedConvert(
      'timeline',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => TimelineEventDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TimelineEventDto>[],
    ),
  );
  return val;
});

Map<String, dynamic> _$CompanionDtoToJson(_CompanionDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'id': instance.id,
      'gender': _$GenderEnumMap[instance.gender]!,
      'name': instance.name.toJson(),
      'fullName': instance.fullName.toJson(),
      'summary': instance.summary.toJson(),
      'review': instance.review.toJson(),
      'references': instance.references,
      'order': ?instance.order,
      'lineage': ?instance.lineage?.toJson(),
      'kunya': ?instance.kunya?.toJson(),
      'titles': instance.titles.map((e) => e.toJson()).toList(),
      'aliases': instance.aliases,
      'birth': ?instance.birth?.toJson(),
      'death': ?instance.death?.toJson(),
      'deathPlace': ?instance.deathPlace?.toJson(),
      'atAGlance': instance.atAGlance.map((e) => e.toJson()).toList(),
      'memberships': instance.memberships.map((e) => e.toJson()).toList(),
      'relations': instance.relations.map((e) => e.toJson()).toList(),
      'sections': instance.sections.map((e) => e.toJson()).toList(),
      'storyIds': instance.storyIds,
      'timeline': instance.timeline.map((e) => e.toJson()).toList(),
    };

const _$GenderEnumMap = {Gender.male: 'male', Gender.female: 'female'};

_CompanionSummaryDto _$CompanionSummaryDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CompanionSummaryDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'id',
      'gender',
      'name',
      'summary',
      'review',
      'order',
      'kunya',
      'titles',
      'aliases',
      'categoryIds',
      'death',
    ],
  );
  final val = _CompanionSummaryDto(
    id: $checkedConvert('id', (v) => v as String),
    gender: $checkedConvert('gender', (v) => $enumDecode(_$GenderEnumMap, v)),
    name: $checkedConvert(
      'name',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    summary: $checkedConvert(
      'summary',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    review: $checkedConvert(
      'review',
      (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
    ),
    order: $checkedConvert('order', (v) => (v as num?)?.toInt()),
    kunya: $checkedConvert(
      'kunya',
      (v) => v == null
          ? null
          : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    titles: $checkedConvert(
      'titles',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => LocalizedTextDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LocalizedTextDto>[],
    ),
    aliases: $checkedConvert(
      'aliases',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    ),
    categoryIds: $checkedConvert(
      'categoryIds',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    ),
    death: $checkedConvert(
      'death',
      (v) => v == null
          ? null
          : HistoricalDateDto.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$CompanionSummaryDtoToJson(
  _CompanionSummaryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'gender': _$GenderEnumMap[instance.gender]!,
  'name': instance.name.toJson(),
  'summary': instance.summary.toJson(),
  'review': instance.review.toJson(),
  'order': ?instance.order,
  'kunya': ?instance.kunya?.toJson(),
  'titles': instance.titles.map((e) => e.toJson()).toList(),
  'aliases': instance.aliases,
  'categoryIds': instance.categoryIds,
  'death': ?instance.death?.toJson(),
};

_CompanionIndexDto _$CompanionIndexDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CompanionIndexDto', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['schemaVersion', 'companions']);
  final val = _CompanionIndexDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    companions: $checkedConvert(
      'companions',
      (v) => (v as List<dynamic>)
          .map((e) => CompanionSummaryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$CompanionIndexDtoToJson(_CompanionIndexDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'companions': instance.companions.map((e) => e.toJson()).toList(),
    };
