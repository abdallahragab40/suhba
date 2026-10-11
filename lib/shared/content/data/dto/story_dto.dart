import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/shared/content/data/dto/block_dto.dart';
import 'package:suhba/shared/content/data/dto/common_dto.dart';

part 'story_dto.freezed.dart';
part 'story_dto.g.dart';

@freezed
abstract class StoryChapterDto with _$StoryChapterDto {
  const factory StoryChapterDto({
    required String id,
    required LocalizedTextDto title,
    required List<ContentBlockDto> blocks,
  }) = _StoryChapterDto;

  factory StoryChapterDto.fromJson(Map<String, dynamic> json) =>
      _$StoryChapterDtoFromJson(json);
}

/// `content/stories/<id>.json` and `assets/content/stories/<id>.json`.
@freezed
abstract class StoryDto with _$StoryDto {
  const factory StoryDto({
    required int schemaVersion,
    required String id,
    required LocalizedTextDto title,
    required LocalizedTextDto synopsis,
    required List<String> companionIds,
    required int readingMinutes,
    required List<StoryChapterDto> chapters,
    required ReviewDto review,
    @Default(<String>[]) List<String> eventIds,
  }) = _StoryDto;

  factory StoryDto.fromJson(Map<String, dynamic> json) =>
      _$StoryDtoFromJson(json);
}

@freezed
abstract class StorySummaryDto with _$StorySummaryDto {
  const factory StorySummaryDto({
    required String id,
    required LocalizedTextDto title,
    required LocalizedTextDto synopsis,
    required List<String> companionIds,
    required int readingMinutes,
    required ReviewDto review,
  }) = _StorySummaryDto;

  factory StorySummaryDto.fromJson(Map<String, dynamic> json) =>
      _$StorySummaryDtoFromJson(json);
}

/// `assets/content/index/stories.json`.
@freezed
abstract class StoryIndexDto with _$StoryIndexDto {
  const factory StoryIndexDto({
    required int schemaVersion,
    required List<StorySummaryDto> stories,
  }) = _StoryIndexDto;

  factory StoryIndexDto.fromJson(Map<String, dynamic> json) =>
      _$StoryIndexDtoFromJson(json);
}
