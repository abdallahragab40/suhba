// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GlossaryTermDto _$GlossaryTermDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GlossaryTermDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'id',
          'term',
          'forms',
          'definition',
          'reliability',
          'citations',
          'review',
        ],
      );
      final val = _GlossaryTermDto(
        id: $checkedConvert('id', (v) => v as String),
        term: $checkedConvert(
          'term',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        forms: $checkedConvert(
          'forms',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        definition: $checkedConvert(
          'definition',
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
      );
      return val;
    });

Map<String, dynamic> _$GlossaryTermDtoToJson(_GlossaryTermDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'term': instance.term.toJson(),
      'forms': instance.forms,
      'definition': instance.definition.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'review': instance.review.toJson(),
    };

const _$ReliabilityEnumMap = {
  Reliability.established: 'established',
  Reliability.reported: 'reported',
  Reliability.disputed: 'disputed',
  Reliability.unknown: 'unknown',
};

_GlossaryFileDto _$GlossaryFileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GlossaryFileDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'terms']);
      final val = _GlossaryFileDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        terms: $checkedConvert(
          'terms',
          (v) => (v as List<dynamic>)
              .map((e) => GlossaryTermDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GlossaryFileDtoToJson(_GlossaryFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'terms': instance.terms.map((e) => e.toJson()).toList(),
    };
