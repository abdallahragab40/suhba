// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpinionDto _$OpinionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OpinionDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['text', 'citations']);
      final val = _OpinionDto(
        text: $checkedConvert(
          'text',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$OpinionDtoToJson(_OpinionDto instance) =>
    <String, dynamic>{
      'text': instance.text.toJson(),
      'citations': instance.citations.map((e) => e.toJson()).toList(),
    };

ParagraphBlockDto _$ParagraphBlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ParagraphBlockDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['text', 'reliability', 'citations', 'type'],
      );
      final val = ParagraphBlockDto(
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
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$ParagraphBlockDtoToJson(ParagraphBlockDto instance) =>
    <String, dynamic>{
      'text': instance.text.toJson(),
      'reliability': _$ReliabilityEnumMap[instance.reliability]!,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

const _$ReliabilityEnumMap = {
  Reliability.established: 'established',
  Reliability.reported: 'reported',
  Reliability.disputed: 'disputed',
  Reliability.unknown: 'unknown',
};

LessonBlockDto _$LessonBlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LessonBlockDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['text', 'type']);
      final val = LessonBlockDto(
        text: $checkedConvert(
          'text',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$LessonBlockDtoToJson(LessonBlockDto instance) =>
    <String, dynamic>{'text': instance.text.toJson(), 'type': instance.$type};

QuranQuoteBlockDto _$QuranQuoteBlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('QuranQuoteBlockDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['ref', 'note', 'type']);
      final val = QuranQuoteBlockDto(
        ref: $checkedConvert(
          'ref',
          (v) => QuranRefDto.fromJson(v as Map<String, dynamic>),
        ),
        note: $checkedConvert(
          'note',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$QuranQuoteBlockDtoToJson(QuranQuoteBlockDto instance) =>
    <String, dynamic>{
      'ref': instance.ref.toJson(),
      'note': ?instance.note?.toJson(),
      'type': instance.$type,
    };

HadithQuoteBlockDto _$HadithQuoteBlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HadithQuoteBlockDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'textStatus',
          'reliability',
          'citations',
          'text',
          'summary',
          'type',
        ],
      );
      final val = HadithQuoteBlockDto(
        textStatus: $checkedConvert(
          'textStatus',
          (v) => $enumDecode(_$TextStatusEnumMap, v),
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
        text: $checkedConvert(
          'text',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        summary: $checkedConvert(
          'summary',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$HadithQuoteBlockDtoToJson(
  HadithQuoteBlockDto instance,
) => <String, dynamic>{
  'textStatus': _$TextStatusEnumMap[instance.textStatus]!,
  'reliability': _$ReliabilityEnumMap[instance.reliability]!,
  'citations': instance.citations.map((e) => e.toJson()).toList(),
  'text': ?instance.text?.toJson(),
  'summary': ?instance.summary?.toJson(),
  'type': instance.$type,
};

const _$TextStatusEnumMap = {
  TextStatus.complete: 'complete',
  TextStatus.pendingFromSource: 'pendingFromSource',
};

ReportQuoteBlockDto _$ReportQuoteBlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportQuoteBlockDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'textStatus',
          'reliability',
          'citations',
          'text',
          'summary',
          'type',
        ],
      );
      final val = ReportQuoteBlockDto(
        textStatus: $checkedConvert(
          'textStatus',
          (v) => $enumDecode(_$TextStatusEnumMap, v),
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
        text: $checkedConvert(
          'text',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        summary: $checkedConvert(
          'summary',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$ReportQuoteBlockDtoToJson(
  ReportQuoteBlockDto instance,
) => <String, dynamic>{
  'textStatus': _$TextStatusEnumMap[instance.textStatus]!,
  'reliability': _$ReliabilityEnumMap[instance.reliability]!,
  'citations': instance.citations.map((e) => e.toJson()).toList(),
  'text': ?instance.text?.toJson(),
  'summary': ?instance.summary?.toJson(),
  'type': instance.$type,
};

DisputeNoteBlockDto _$DisputeNoteBlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DisputeNoteBlockDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['text', 'opinions', 'type']);
      final val = DisputeNoteBlockDto(
        text: $checkedConvert(
          'text',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        opinions: $checkedConvert(
          'opinions',
          (v) => (v as List<dynamic>)
              .map((e) => OpinionDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$DisputeNoteBlockDtoToJson(
  DisputeNoteBlockDto instance,
) => <String, dynamic>{
  'text': instance.text.toJson(),
  'opinions': instance.opinions.map((e) => e.toJson()).toList(),
  'type': instance.$type,
};

HeadingBlockDto _$HeadingBlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HeadingBlockDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['text', 'type']);
      final val = HeadingBlockDto(
        text: $checkedConvert(
          'text',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$HeadingBlockDtoToJson(HeadingBlockDto instance) =>
    <String, dynamic>{'text': instance.text.toJson(), 'type': instance.$type};

InfographicBlockDto _$InfographicBlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InfographicBlockDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['visualId', 'caption', 'type']);
      final val = InfographicBlockDto(
        visualId: $checkedConvert('visualId', (v) => v as String),
        caption: $checkedConvert(
          'caption',
          (v) => v == null
              ? null
              : LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$InfographicBlockDtoToJson(
  InfographicBlockDto instance,
) => <String, dynamic>{
  'visualId': instance.visualId,
  'caption': ?instance.caption?.toJson(),
  'type': instance.$type,
};
