// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoryChapterDto _$StoryChapterDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StoryChapterDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['id', 'title', 'blocks']);
      final val = _StoryChapterDto(
        id: $checkedConvert('id', (v) => v as String),
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

Map<String, dynamic> _$StoryChapterDtoToJson(_StoryChapterDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title.toJson(),
      'blocks': instance.blocks.map((e) => e.toJson()).toList(),
    };

_StoryDto _$StoryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StoryDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'schemaVersion',
          'id',
          'title',
          'synopsis',
          'companionIds',
          'readingMinutes',
          'chapters',
          'review',
          'eventIds',
        ],
      );
      final val = _StoryDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        synopsis: $checkedConvert(
          'synopsis',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        companionIds: $checkedConvert(
          'companionIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        readingMinutes: $checkedConvert(
          'readingMinutes',
          (v) => (v as num).toInt(),
        ),
        chapters: $checkedConvert(
          'chapters',
          (v) => (v as List<dynamic>)
              .map((e) => StoryChapterDto.fromJson(e as Map<String, dynamic>))
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
      );
      return val;
    });

Map<String, dynamic> _$StoryDtoToJson(_StoryDto instance) => <String, dynamic>{
  'schemaVersion': instance.schemaVersion,
  'id': instance.id,
  'title': instance.title.toJson(),
  'synopsis': instance.synopsis.toJson(),
  'companionIds': instance.companionIds,
  'readingMinutes': instance.readingMinutes,
  'chapters': instance.chapters.map((e) => e.toJson()).toList(),
  'review': instance.review.toJson(),
  'eventIds': instance.eventIds,
};

_StorySummaryDto _$StorySummaryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StorySummaryDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'id',
          'title',
          'synopsis',
          'companionIds',
          'readingMinutes',
          'review',
        ],
      );
      final val = _StorySummaryDto(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert(
          'title',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        synopsis: $checkedConvert(
          'synopsis',
          (v) => LocalizedTextDto.fromJson(v as Map<String, dynamic>),
        ),
        companionIds: $checkedConvert(
          'companionIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        readingMinutes: $checkedConvert(
          'readingMinutes',
          (v) => (v as num).toInt(),
        ),
        review: $checkedConvert(
          'review',
          (v) => ReviewDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StorySummaryDtoToJson(_StorySummaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title.toJson(),
      'synopsis': instance.synopsis.toJson(),
      'companionIds': instance.companionIds,
      'readingMinutes': instance.readingMinutes,
      'review': instance.review.toJson(),
    };

_StoryIndexDto _$StoryIndexDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StoryIndexDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'stories']);
      final val = _StoryIndexDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        stories: $checkedConvert(
          'stories',
          (v) => (v as List<dynamic>)
              .map((e) => StorySummaryDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StoryIndexDtoToJson(_StoryIndexDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'stories': instance.stories.map((e) => e.toJson()).toList(),
    };
