// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CategoryDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'id',
          'name',
          'order',
          'review',
          'description',
          'basis',
        ],
      );
      final val = _CategoryDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert(
          'name',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        order: $checkedConvert('order', (v) => (v as num).toInt()),
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
        description: $checkedConvert(
          'description',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        basis: $checkedConvert(
          'basis',
          (v) => v == null
              ? null
              : ContentBlockDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CategoryDtoToJson(_CategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name.toJson(),
      'order': instance.order,
      'review': instance.review.toJson(),
      'description': ?instance.description?.toJson(),
      'basis': ?instance.basis?.toJson(),
    };

_HistoricalEventDto _$HistoricalEventDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HistoricalEventDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'id',
          'name',
          'type',
          'date',
          'summary',
          'reliability',
          'citations',
          'review',
          'place',
          'participants',
        ],
      );
      final val = _HistoricalEventDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert(
          'name',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$EventTypeEnumMap, v),
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
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
        place: $checkedConvert(
          'place',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        participants: $checkedConvert(
          'participants',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => PersonRefDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <PersonRefDto>[],
        ),
      );
      return val;
    });

Map<String, dynamic> _$HistoricalEventDtoToJson(_HistoricalEventDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name.toJson(),
      'type': _$EventTypeEnumMap[instance.type]!,
      'date': instance.date.toJson(),
      'summary': instance.summary.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'review': instance.review.toJson(),
      'place': ?instance.place?.toJson(),
      'participants': instance.participants.map((e) => e.toJson()).toList(),
    };

const _$EventTypeEnumMap = {
  EventType.hijrah: 'hijrah',
  EventType.battle: 'battle',
  EventType.treaty: 'treaty',
  EventType.pledge: 'pledge',
  EventType.appointment: 'appointment',
  EventType.death: 'death',
  EventType.other: 'other',
};

const _$ReliabilityEnumMap = {
  Reliability.established: 'established',
  Reliability.reported: 'reported',
  Reliability.disputed: 'disputed',
  Reliability.unknown: 'unknown',
};

_SourceReferenceDto _$SourceReferenceDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SourceReferenceDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'id',
          'type',
          'title',
          'review',
          'author',
          'authorDeathAH',
          'edition',
          'publisher',
          'numberingScheme',
        ],
      );
      final val = _SourceReferenceDto(
        id: $checkedConvert('id', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$SourceTypeEnumMap, v),
        ),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
        author: $checkedConvert(
          'author',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        authorDeathAH: $checkedConvert(
          'authorDeathAH',
          (v) => (v as num?)?.toInt(),
        ),
        edition: $checkedConvert(
          'edition',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        publisher: $checkedConvert(
          'publisher',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        numberingScheme: $checkedConvert(
          'numberingScheme',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SourceReferenceDtoToJson(_SourceReferenceDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SourceTypeEnumMap[instance.type]!,
      'title': instance.title.toJson(),
      'review': instance.review.toJson(),
      'author': ?instance.author?.toJson(),
      'authorDeathAH': ?instance.authorDeathAH,
      'edition': ?instance.edition?.toJson(),
      'publisher': ?instance.publisher?.toJson(),
      'numberingScheme': ?instance.numberingScheme?.toJson(),
    };

const _$SourceTypeEnumMap = {
  SourceType.quran: 'quran',
  SourceType.hadithCollection: 'hadithCollection',
  SourceType.biographical: 'biographical',
  SourceType.history: 'history',
  SourceType.sira: 'sira',
  SourceType.tafsir: 'tafsir',
  SourceType.other: 'other',
};

_PersonDto _$PersonDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PersonDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['id', 'name', 'honorific', 'review', 'gender'],
      );
      final val = _PersonDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert(
          'name',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        honorific: $checkedConvert(
          'honorific',
          (v) => $enumDecode(_$PersonHonorificEnumMap, v),
        ),
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
        gender: $checkedConvert(
          'gender',
          (v) => $enumDecodeNullable(_$GenderEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PersonDtoToJson(_PersonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name.toJson(),
      'honorific': _$PersonHonorificEnumMap[instance.honorific]!,
      'review': instance.review.toJson(),
      'gender': ?_$GenderEnumMap[instance.gender],
    };

const _$PersonHonorificEnumMap = {
  PersonHonorific.sahabi: 'sahabi',
  PersonHonorific.prophet: 'prophet',
  PersonHonorific.alayhiSalam: 'alayhiSalam',
  PersonHonorific.none: 'none',
};

const _$GenderEnumMap = {Gender.male: 'male', Gender.female: 'female'};

_CategoriesFileDto _$CategoriesFileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CategoriesFileDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'categories']);
      final val = _CategoriesFileDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        categories: $checkedConvert(
          'categories',
          (v) => (v as List<dynamic>)
              .map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CategoriesFileDtoToJson(_CategoriesFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'categories': instance.categories.map((e) => e.toJson()).toList(),
    };

_EventsFileDto _$EventsFileDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EventsFileDto', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['schemaVersion', 'events']);
  final val = _EventsFileDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    events: $checkedConvert(
      'events',
      (v) => (v as List<dynamic>)
          .map((e) => HistoricalEventDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EventsFileDtoToJson(_EventsFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };

_SourcesFileDto _$SourcesFileDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SourcesFileDto', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['schemaVersion', 'sources']);
  final val = _SourcesFileDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    sources: $checkedConvert(
      'sources',
      (v) => (v as List<dynamic>)
          .map((e) => SourceReferenceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$SourcesFileDtoToJson(_SourcesFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'sources': instance.sources.map((e) => e.toJson()).toList(),
    };

_PeopleFileDto _$PeopleFileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PeopleFileDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'people']);
      final val = _PeopleFileDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        people: $checkedConvert(
          'people',
          (v) => (v as List<dynamic>)
              .map((e) => PersonDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PeopleFileDtoToJson(_PeopleFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'people': instance.people.map((e) => e.toJson()).toList(),
    };

_ContentMetaDto _$ContentMetaDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ContentMetaDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'contentVersion']);
      final val = _ContentMetaDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        contentVersion: $checkedConvert('contentVersion', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ContentMetaDtoToJson(_ContentMetaDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'contentVersion': instance.contentVersion,
    };

_ManifestDto _$ManifestDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ManifestDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'schemaVersion',
      'contentVersion',
      'channel',
      'companionCount',
      'storyCount',
      'approvedCount',
      'unapprovedCount',
      'files',
    ],
  );
  final val = _ManifestDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    contentVersion: $checkedConvert('contentVersion', (v) => v as String),
    channel: $checkedConvert(
      'channel',
      (v) => $enumDecode(_$ContentChannelEnumMap, v),
    ),
    companionCount: $checkedConvert(
      'companionCount',
      (v) => (v as num).toInt(),
    ),
    storyCount: $checkedConvert('storyCount', (v) => (v as num).toInt()),
    approvedCount: $checkedConvert('approvedCount', (v) => (v as num).toInt()),
    unapprovedCount: $checkedConvert(
      'unapprovedCount',
      (v) => (v as num).toInt(),
    ),
    files: $checkedConvert('files', (v) => Map<String, String>.from(v as Map)),
  );
  return val;
});

Map<String, dynamic> _$ManifestDtoToJson(_ManifestDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'contentVersion': instance.contentVersion,
      'channel': _$ContentChannelEnumMap[instance.channel]!,
      'companionCount': instance.companionCount,
      'storyCount': instance.storyCount,
      'approvedCount': instance.approvedCount,
      'unapprovedCount': instance.unapprovedCount,
      'files': instance.files,
    };

const _$ContentChannelEnumMap = {
  ContentChannel.draft: 'draft',
  ContentChannel.published: 'published',
};

_ReviewerDto _$ReviewerDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ReviewerDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['id', 'name', 'qualification', 'addedAt'],
      );
      final val = _ReviewerDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        qualification: $checkedConvert('qualification', (v) => v as String),
        addedAt: $checkedConvert('addedAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ReviewerDtoToJson(_ReviewerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'qualification': instance.qualification,
      'addedAt': instance.addedAt,
    };

_ReviewersFileDto _$ReviewersFileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ReviewersFileDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'reviewers']);
      final val = _ReviewersFileDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        reviewers: $checkedConvert(
          'reviewers',
          (v) => (v as List<dynamic>)
              .map((e) => ReviewerDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ReviewersFileDtoToJson(_ReviewersFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'reviewers': instance.reviewers.map((e) => e.toJson()).toList(),
    };

_ApprovalChecklistDto _$ApprovalChecklistDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ApprovalChecklistDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'sourcesMatch',
      'gradingsCorrect',
      'noEmbellishment',
      'reliabilityCorrect',
      'honorificsCorrect',
      'fitnaSignOff',
    ],
  );
  final val = _ApprovalChecklistDto(
    sourcesMatch: $checkedConvert('sourcesMatch', (v) => v as bool),
    gradingsCorrect: $checkedConvert('gradingsCorrect', (v) => v as bool),
    noEmbellishment: $checkedConvert('noEmbellishment', (v) => v as bool),
    reliabilityCorrect: $checkedConvert('reliabilityCorrect', (v) => v as bool),
    honorificsCorrect: $checkedConvert('honorificsCorrect', (v) => v as bool),
    fitnaSignOff: $checkedConvert('fitnaSignOff', (v) => v as bool? ?? false),
  );
  return val;
});

Map<String, dynamic> _$ApprovalChecklistDtoToJson(
  _ApprovalChecklistDto instance,
) => <String, dynamic>{
  'sourcesMatch': instance.sourcesMatch,
  'gradingsCorrect': instance.gradingsCorrect,
  'noEmbellishment': instance.noEmbellishment,
  'reliabilityCorrect': instance.reliabilityCorrect,
  'honorificsCorrect': instance.honorificsCorrect,
  'fitnaSignOff': instance.fitnaSignOff,
};

_ApprovalDto _$ApprovalDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ApprovalDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'schemaVersion',
      'kind',
      'id',
      'reviewerId',
      'approvedAt',
      'contentHash',
      'checklist',
      'notes',
    ],
  );
  final val = _ApprovalDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    kind: $checkedConvert('kind', (v) => $enumDecode(_$ContentKindEnumMap, v)),
    id: $checkedConvert('id', (v) => v as String),
    reviewerId: $checkedConvert('reviewerId', (v) => v as String),
    approvedAt: $checkedConvert('approvedAt', (v) => v as String),
    contentHash: $checkedConvert('contentHash', (v) => v as String),
    checklist: $checkedConvert(
      'checklist',
      (v) => ApprovalChecklistDto.fromJson(v as Map<String, dynamic>),
    ),
    notes: $checkedConvert('notes', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ApprovalDtoToJson(_ApprovalDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'kind': _$ContentKindEnumMap[instance.kind]!,
      'id': instance.id,
      'reviewerId': instance.reviewerId,
      'approvedAt': instance.approvedAt,
      'contentHash': instance.contentHash,
      'checklist': instance.checklist.toJson(),
      'notes': ?instance.notes,
    };

const _$ContentKindEnumMap = {
  ContentKind.companion: 'companion',
  ContentKind.story: 'story',
  ContentKind.event: 'event',
  ContentKind.category: 'category',
  ContentKind.source: 'source',
  ContentKind.person: 'person',
};
