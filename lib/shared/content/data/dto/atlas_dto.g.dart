// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atlas_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeoPointDto _$GeoPointDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GeoPointDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['lat', 'lon', 'precision']);
      final val = _GeoPointDto(
        lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
        lon: $checkedConvert('lon', (v) => (v as num).toDouble()),
        precision: $checkedConvert(
          'precision',
          (v) => $enumDecode(_$GeoPrecisionEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GeoPointDtoToJson(_GeoPointDto instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'precision': _$GeoPrecisionEnumMap[instance.precision]!,
    };

const _$GeoPrecisionEnumMap = {
  GeoPrecision.identified: 'identified',
  GeoPrecision.approximate: 'approximate',
  GeoPrecision.uncertain: 'uncertain',
};

_PlaceDto _$PlaceDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_PlaceDto',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'id',
        'name',
        'kind',
        'location',
        'summary',
        'reliability',
        'citations',
        'review',
        'modernName',
        'contemporaryNote',
        'companionIds',
      ],
    );
    final val = _PlaceDto(
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert(
        'name',
        (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
      ),
      kind: $checkedConvert('kind', (v) => $enumDecode(_$PlaceKindEnumMap, v)),
      location: $checkedConvert(
        'location',
        (v) => GeoPointDto.fromJson(v as Map<String, dynamic>),
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
      modernName: $checkedConvert(
        'modernName',
        (v) => v == null
            ? null
            : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
      ),
      contemporaryNote: $checkedConvert(
        'contemporaryNote',
        (v) => v == null
            ? null
            : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
      ),
      companionIds: $checkedConvert(
        'companionIds',
        (v) =>
            (v as List<dynamic>?)?.map((e) => e as String).toList() ??
            const <String>[],
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$PlaceDtoToJson(_PlaceDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name.toJson(),
  'kind': _$PlaceKindEnumMap[instance.kind]!,
  'location': instance.location.toJson(),
  'summary': instance.summary.toJson(),
  'reliability': _$ReliabilityEnumMap[instance.reliability]!,
  'citations': instance.citations.map((e) => e.toJson()).toList(),
  'review': instance.review.toJson(),
  'modernName': ?instance.modernName?.toJson(),
  'contemporaryNote': ?instance.contemporaryNote?.toJson(),
  'companionIds': instance.companionIds,
};

const _$PlaceKindEnumMap = {
  PlaceKind.city: 'city',
  PlaceKind.town: 'town',
  PlaceKind.mountain: 'mountain',
  PlaceKind.cave: 'cave',
  PlaceKind.valley: 'valley',
  PlaceKind.well: 'well',
  PlaceKind.mosque: 'mosque',
  PlaceKind.battlefield: 'battlefield',
  PlaceKind.region: 'region',
  PlaceKind.other: 'other',
};

const _$ReliabilityEnumMap = {
  Reliability.established: 'established',
  Reliability.reported: 'reported',
  Reliability.disputed: 'disputed',
  Reliability.unknown: 'unknown',
};

_PlacesFileDto _$PlacesFileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PlacesFileDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'places']);
      final val = _PlacesFileDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        places: $checkedConvert(
          'places',
          (v) => (v as List<dynamic>)
              .map((e) => PlaceDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PlacesFileDtoToJson(_PlacesFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'places': instance.places.map((e) => e.toJson()).toList(),
    };

_RouteLegDto _$RouteLegDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RouteLegDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'from',
          'to',
          'approximate',
          'reliability',
          'citations',
          'note',
        ],
      );
      final val = _RouteLegDto(
        from: $checkedConvert('from', (v) => v as String),
        to: $checkedConvert('to', (v) => v as String),
        approximate: $checkedConvert('approximate', (v) => v as bool),
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
        note: $checkedConvert(
          'note',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RouteLegDtoToJson(_RouteLegDto instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'approximate': instance.approximate,
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'note': ?instance.note?.toJson(),
    };

_RelationEdgeDto _$RelationEdgeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RelationEdgeDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'from',
          'to',
          'type',
          'reliability',
          'citations',
          'note',
        ],
      );
      final val = _RelationEdgeDto(
        from: $checkedConvert(
          'from',
          (v) => PersonRefDto.fromJson(v as Map<String, dynamic>),
        ),
        to: $checkedConvert(
          'to',
          (v) => PersonRefDto.fromJson(v as Map<String, dynamic>),
        ),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$RelationTypeEnumMap, v),
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
        note: $checkedConvert(
          'note',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RelationEdgeDtoToJson(_RelationEdgeDto instance) =>
    <String, dynamic>{
      'from': instance.from.toJson(),
      'to': instance.to.toJson(),
      'type': _$RelationTypeEnumMap[instance.type]!,
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'note': ?instance.note?.toJson(),
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
  RelationType.companion: 'companion',
};

_SequenceStepDto _$SequenceStepDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SequenceStepDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'title',
          'text',
          'reliability',
          'citations',
          'placeId',
          'date',
          'orderUncertain',
        ],
      );
      final val = _SequenceStepDto(
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        text: $checkedConvert(
          'text',
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
        placeId: $checkedConvert('placeId', (v) => v as String?),
        date: $checkedConvert(
          'date',
          (v) => v == null
              ? null
              : HistoricalDateDto.fromJson(v as Map<String, dynamic>),
        ),
        orderUncertain: $checkedConvert(
          'orderUncertain',
          (v) => v as bool? ?? false,
        ),
      );
      return val;
    });

Map<String, dynamic> _$SequenceStepDtoToJson(_SequenceStepDto instance) =>
    <String, dynamic>{
      'title': instance.title.toJson(),
      'text': instance.text.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'placeId': ?instance.placeId,
      'date': ?instance.date?.toJson(),
      'orderUncertain': instance.orderUncertain,
    };

_PeriodBandDto _$PeriodBandDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PeriodBandDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'label',
          'date',
          'reliability',
          'citations',
          'note',
        ],
      );
      final val = _PeriodBandDto(
        label: $checkedConvert(
          'label',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
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

Map<String, dynamic> _$PeriodBandDtoToJson(_PeriodBandDto instance) =>
    <String, dynamic>{
      'label': instance.label.toJson(),
      'date': instance.date.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'note': ?instance.note?.toJson(),
    };

_PlaceCalloutDto _$PlaceCalloutDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PlaceCalloutDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['label', 'text', 'reliability', 'citations'],
      );
      final val = _PlaceCalloutDto(
        label: $checkedConvert(
          'label',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        text: $checkedConvert(
          'text',
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
      );
      return val;
    });

Map<String, dynamic> _$PlaceCalloutDtoToJson(_PlaceCalloutDto instance) =>
    <String, dynamic>{
      'label': instance.label.toJson(),
      'text': instance.text.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
    };

_VisualDto _$VisualDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_VisualDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'schemaVersion',
      'id',
      'type',
      'title',
      'takeaway',
      'review',
      'notes',
      'companionId',
      'eventIds',
      'placeIds',
      'route',
      'edges',
      'steps',
      'bands',
      'placeId',
      'callouts',
    ],
  );
  final val = _VisualDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$InfographicTypeEnumMap, v),
    ),
    title: $checkedConvert(
      'title',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    takeaway: $checkedConvert(
      'takeaway',
      (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
    ),
    review: $checkedConvert(
      'review',
      (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
    ),
    notes: $checkedConvert(
      'notes',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => LocalizedTextDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LocalizedTextDto>[],
    ),
    companionId: $checkedConvert('companionId', (v) => v as String?),
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
    route: $checkedConvert(
      'route',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => RouteLegDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RouteLegDto>[],
    ),
    edges: $checkedConvert(
      'edges',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => RelationEdgeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RelationEdgeDto>[],
    ),
    steps: $checkedConvert(
      'steps',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => SequenceStepDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SequenceStepDto>[],
    ),
    bands: $checkedConvert(
      'bands',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => PeriodBandDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PeriodBandDto>[],
    ),
    placeId: $checkedConvert('placeId', (v) => v as String?),
    callouts: $checkedConvert(
      'callouts',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => PlaceCalloutDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlaceCalloutDto>[],
    ),
  );
  return val;
});

Map<String, dynamic> _$VisualDtoToJson(_VisualDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'id': instance.id,
      'type': _$InfographicTypeEnumMap[instance.type]!,
      'title': instance.title.toJson(),
      'takeaway': instance.takeaway.toJson(),
      'review': instance.review.toJson(),
      'notes': instance.notes.map((e) => e.toJson()).toList(),
      'companionId': ?instance.companionId,
      'eventIds': instance.eventIds,
      'placeIds': instance.placeIds,
      'route': instance.route.map((e) => e.toJson()).toList(),
      'edges': instance.edges.map((e) => e.toJson()).toList(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
      'bands': instance.bands.map((e) => e.toJson()).toList(),
      'placeId': ?instance.placeId,
      'callouts': instance.callouts.map((e) => e.toJson()).toList(),
    };

const _$InfographicTypeEnumMap = {
  InfographicType.timeline: 'timeline',
  InfographicType.map: 'map',
  InfographicType.relationships: 'relationships',
  InfographicType.sequence: 'sequence',
  InfographicType.periods: 'periods',
  InfographicType.placePanel: 'placePanel',
};

_VisualsFileDto _$VisualsFileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_VisualsFileDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'visuals']);
      final val = _VisualsFileDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        visuals: $checkedConvert(
          'visuals',
          (v) => (v as List<dynamic>)
              .map((e) => VisualDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$VisualsFileDtoToJson(_VisualsFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'visuals': instance.visuals.map((e) => e.toJson()).toList(),
    };
