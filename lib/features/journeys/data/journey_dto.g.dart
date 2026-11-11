// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StepRefDto _$StepRefDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StepRefDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['type', 'targetId', 'parentId']);
      final val = _StepRefDto(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$StepRefTypeEnumMap, v),
        ),
        targetId: $checkedConvert('targetId', (v) => v as String),
        parentId: $checkedConvert('parentId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$StepRefDtoToJson(_StepRefDto instance) =>
    <String, dynamic>{
      'type': _$StepRefTypeEnumMap[instance.type]!,
      'targetId': instance.targetId,
      'parentId': ?instance.parentId,
    };

const _$StepRefTypeEnumMap = {
  StepRefType.companionSection: 'companionSection',
  StepRefType.storyChapter: 'storyChapter',
  StepRefType.seerahChapter: 'seerahChapter',
  StepRefType.seerahTopic: 'seerahTopic',
};

_JourneyStepDto _$JourneyStepDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_JourneyStepDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['id', 'title', 'readings', 'framing', 'reflection'],
      );
      final val = _JourneyStepDto(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        readings: $checkedConvert(
          'readings',
          (v) => (v as List<dynamic>)
              .map((e) => StepRefDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        framing: $checkedConvert(
          'framing',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        reflection: $checkedConvert(
          'reflection',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JourneyStepDtoToJson(_JourneyStepDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title.toJson(),
      'readings': instance.readings.map((e) => e.toJson()).toList(),
      'framing': ?instance.framing?.toJson(),
      'reflection': ?instance.reflection?.toJson(),
    };

_JourneyDto _$JourneyDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_JourneyDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'schemaVersion',
          'id',
          'title',
          'description',
          'steps',
          'review',
        ],
      );
      final val = _JourneyDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        description: $checkedConvert(
          'description',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        steps: $checkedConvert(
          'steps',
          (v) => (v as List<dynamic>)
              .map((e) => JourneyStepDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JourneyDtoToJson(_JourneyDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'id': instance.id,
      'title': instance.title.toJson(),
      'description': instance.description.toJson(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
      'review': instance.review.toJson(),
    };
