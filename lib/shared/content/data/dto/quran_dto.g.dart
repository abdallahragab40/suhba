// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuranFileDto _$QuranFileDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_QuranFileDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['schemaVersion', 'source', 'basmalas', 'ayahs'],
  );
  final val = _QuranFileDto(
    schemaVersion: $checkedConvert('schemaVersion', (v) => (v as num).toInt()),
    source: $checkedConvert(
      'source',
      (v) => QuranSourceDto.fromJson(v as Map<String, dynamic>),
    ),
    basmalas: $checkedConvert(
      'basmalas',
      (v) => Map<String, String>.from(v as Map),
    ),
    ayahs: $checkedConvert('ayahs', (v) => Map<String, String>.from(v as Map)),
  );
  return val;
});

Map<String, dynamic> _$QuranFileDtoToJson(_QuranFileDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'source': instance.source.toJson(),
      'basmalas': instance.basmalas,
      'ayahs': instance.ayahs,
    };

_QuranSourceDto _$QuranSourceDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_QuranSourceDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['name', 'url', 'notice']);
      final val = _QuranSourceDto(
        name: $checkedConvert('name', (v) => v as String),
        url: $checkedConvert('url', (v) => v as String),
        notice: $checkedConvert('notice', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$QuranSourceDtoToJson(_QuranSourceDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'notice': instance.notice,
    };
