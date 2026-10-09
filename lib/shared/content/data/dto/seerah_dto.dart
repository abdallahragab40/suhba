import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/data/dto/block_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/domain/seerah.dart';

part 'seerah_dto.freezed.dart';
part 'seerah_dto.g.dart';

@freezed
abstract class SeerahEraDto with _$SeerahEraDto {
  const factory SeerahEraDto({
    required String id,
    required LocalizedTextDto name,
    required HistoricalDateDto date,
    required LocalizedTextDto summary,
    required Reliability reliability,
    required List<CitationDto> citations,
    required List<String> chapterIds,
  }) = _SeerahEraDto;

  factory SeerahEraDto.fromJson(Map<String, dynamic> json) =>
      _$SeerahEraDtoFromJson(json);
}

/// `content/seerah/seerah.json`: the Seerah section.
@freezed
abstract class SeerahDto with _$SeerahDto {
  const factory SeerahDto({
    required int schemaVersion,
    required LocalizedTextDto title,
    required LocalizedTextDto subtitle,
    required List<ContentBlockDto> introduction,
    required List<SeerahEraDto> eras,
    required List<String> chapterIds,
    required List<String> topicIds,
    required LocalizedTextDto methodology,
    required List<String> references,
    required ReviewDto review,
    @Default(<String>[]) List<String> featuredEventIds,
    @Default(<String>[]) List<String> featuredPlaceIds,
    @Default(<String>[]) List<String> companionIds,
    @Default(<String>[]) List<String> visualIds,
  }) = _SeerahDto;

  factory SeerahDto.fromJson(Map<String, dynamic> json) =>
      _$SeerahDtoFromJson(json);
}

/// `content/seerah/chapters/<id>.json`.
@freezed
abstract class SeerahChapterDto with _$SeerahChapterDto {
  const factory SeerahChapterDto({
    required int schemaVersion,
    required String id,
    required LocalizedTextDto title,
    required LocalizedTextDto abstract,
    required SeerahEra era,
    required HistoricalDateDto date,
    required List<String> references,
    required List<ContentBlockDto> blocks,
    required ReviewDto review,
    @Default(<String>[]) List<String> eventIds,
    @Default(<String>[]) List<String> placeIds,
    @Default(<String>[]) List<String> companionIds,
    @Default(<String>[]) List<String> visualIds,
  }) = _SeerahChapterDto;

  factory SeerahChapterDto.fromJson(Map<String, dynamic> json) =>
      _$SeerahChapterDtoFromJson(json);
}

/// `content/seerah/topics/<id>.json`.
@freezed
abstract class SeerahTopicDto with _$SeerahTopicDto {
  const factory SeerahTopicDto({
    required int schemaVersion,
    required String id,
    required LocalizedTextDto title,
    required LocalizedTextDto abstract,
    required List<String> references,
    required List<ContentBlockDto> blocks,
    required ReviewDto review,
    @Default(<String>[]) List<String> chapterIds,
    @Default(<String>[]) List<String> companionIds,
  }) = _SeerahTopicDto;

  factory SeerahTopicDto.fromJson(Map<String, dynamic> json) =>
      _$SeerahTopicDtoFromJson(json);
}

@freezed
abstract class SeerahChapterSummaryDto with _$SeerahChapterSummaryDto {
  const factory SeerahChapterSummaryDto({
    required String id,
    required LocalizedTextDto title,
    required LocalizedTextDto abstract,
    required SeerahEra era,
    required HistoricalDateDto date,
    required ReviewDto review,
    required int wordCount,
    @Default(<String>[]) List<String> visualIds,
  }) = _SeerahChapterSummaryDto;

  factory SeerahChapterSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$SeerahChapterSummaryDtoFromJson(json);
}

@freezed
abstract class SeerahTopicSummaryDto with _$SeerahTopicSummaryDto {
  const factory SeerahTopicSummaryDto({
    required String id,
    required LocalizedTextDto title,
    required LocalizedTextDto abstract,
    required ReviewDto review,
    required int wordCount,
  }) = _SeerahTopicSummaryDto;

  factory SeerahTopicSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$SeerahTopicSummaryDtoFromJson(json);
}

/// `assets/content/seerah/index.json`: the section with every chapter and
/// topic summary, in reading order.
@freezed
abstract class SeerahIndexDto with _$SeerahIndexDto {
  const factory SeerahIndexDto({
    required int schemaVersion,
    required SeerahDto seerah,
    required List<SeerahChapterSummaryDto> chapters,
    required List<SeerahTopicSummaryDto> topics,
  }) = _SeerahIndexDto;

  factory SeerahIndexDto.fromJson(Map<String, dynamic> json) =>
      _$SeerahIndexDtoFromJson(json);
}
