import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/data/dto/block_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

part 'catalog_dto.freezed.dart';
part 'catalog_dto.g.dart';

@freezed
abstract class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required String id,
    required LocalizedTextDto name,
    required int order,
    required ReviewDto review,
    LocalizedTextDto? description,
    ContentBlockDto? basis,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);
}

@freezed
abstract class HistoricalEventDto with _$HistoricalEventDto {
  const factory HistoricalEventDto({
    required String id,
    required LocalizedTextDto name,
    required EventType type,
    required HistoricalDateDto date,
    required LocalizedTextDto summary,
    required Reliability reliability,
    required List<CitationDto> citations,
    required ReviewDto review,
    LocalizedTextDto? place,
    @Default(<PersonRefDto>[]) List<PersonRefDto> participants,
  }) = _HistoricalEventDto;

  factory HistoricalEventDto.fromJson(Map<String, dynamic> json) =>
      _$HistoricalEventDtoFromJson(json);
}

@freezed
abstract class SourceReferenceDto with _$SourceReferenceDto {
  const factory SourceReferenceDto({
    required String id,
    required SourceType type,
    required LocalizedTextDto title,
    required ReviewDto review,
    LocalizedTextDto? author,
    int? authorDeathAH,
    LocalizedTextDto? edition,
    LocalizedTextDto? publisher,
    LocalizedTextDto? numberingScheme,
  }) = _SourceReferenceDto;

  factory SourceReferenceDto.fromJson(Map<String, dynamic> json) =>
      _$SourceReferenceDtoFromJson(json);
}

@freezed
abstract class PersonDto with _$PersonDto {
  const factory PersonDto({
    required String id,
    required LocalizedTextDto name,
    required PersonHonorific honorific,
    required ReviewDto review,
    Gender? gender,
  }) = _PersonDto;

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);
}

/// `categories.json`.
@freezed
abstract class CategoriesFileDto with _$CategoriesFileDto {
  const factory CategoriesFileDto({
    required int schemaVersion,
    required List<CategoryDto> categories,
  }) = _CategoriesFileDto;

  factory CategoriesFileDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFileDtoFromJson(json);
}

/// `events.json`.
@freezed
abstract class EventsFileDto with _$EventsFileDto {
  const factory EventsFileDto({
    required int schemaVersion,
    required List<HistoricalEventDto> events,
  }) = _EventsFileDto;

  factory EventsFileDto.fromJson(Map<String, dynamic> json) =>
      _$EventsFileDtoFromJson(json);
}

/// `sources.json`.
@freezed
abstract class SourcesFileDto with _$SourcesFileDto {
  const factory SourcesFileDto({
    required int schemaVersion,
    required List<SourceReferenceDto> sources,
  }) = _SourcesFileDto;

  factory SourcesFileDto.fromJson(Map<String, dynamic> json) =>
      _$SourcesFileDtoFromJson(json);
}

/// `people.json`.
@freezed
abstract class PeopleFileDto with _$PeopleFileDto {
  const factory PeopleFileDto({
    required int schemaVersion,
    required List<PersonDto> people,
  }) = _PeopleFileDto;

  factory PeopleFileDto.fromJson(Map<String, dynamic> json) =>
      _$PeopleFileDtoFromJson(json);
}

/// `content/meta.json`: the content version stamped into builds.
@freezed
abstract class ContentMetaDto with _$ContentMetaDto {
  const factory ContentMetaDto({
    required int schemaVersion,
    required String contentVersion,
  }) = _ContentMetaDto;

  factory ContentMetaDto.fromJson(Map<String, dynamic> json) =>
      _$ContentMetaDtoFromJson(json);
}

/// `assets/content/manifest.json`.
@freezed
abstract class ManifestDto with _$ManifestDto {
  const factory ManifestDto({
    required int schemaVersion,
    required String contentVersion,
    required ContentChannel channel,
    required int companionCount,
    required int storyCount,
    required int approvedCount,
    required int unapprovedCount,

    /// Published path → SHA-256 of its bytes.
    required Map<String, String> files,
  }) = _ManifestDto;

  factory ManifestDto.fromJson(Map<String, dynamic> json) =>
      _$ManifestDtoFromJson(json);
}

/// `content/reviewers.json` (tooling only; never shipped).
@freezed
abstract class ReviewerDto with _$ReviewerDto {
  const factory ReviewerDto({
    required String id,
    required String name,
    required String qualification,
    required String addedAt,
  }) = _ReviewerDto;

  factory ReviewerDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewerDtoFromJson(json);
}

@freezed
abstract class ReviewersFileDto with _$ReviewersFileDto {
  const factory ReviewersFileDto({
    required int schemaVersion,
    required List<ReviewerDto> reviewers,
  }) = _ReviewersFileDto;

  factory ReviewersFileDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewersFileDtoFromJson(json);
}

/// The kinds of reviewable content items.
enum ContentKind { companion, story, event, category, source, person }

@freezed
abstract class ApprovalChecklistDto with _$ApprovalChecklistDto {
  const factory ApprovalChecklistDto({
    required bool sourcesMatch,
    required bool gradingsCorrect,
    required bool noEmbellishment,
    required bool reliabilityCorrect,
    required bool honorificsCorrect,

    /// Required for items flagged fitnaAdjacent.
    @Default(false) bool fitnaSignOff,
  }) = _ApprovalChecklistDto;

  factory ApprovalChecklistDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovalChecklistDtoFromJson(json);
}

/// `content/reviews/<kind>.<id>.json` (tooling only; never shipped).
@freezed
abstract class ApprovalDto with _$ApprovalDto {
  const factory ApprovalDto({
    required int schemaVersion,
    required ContentKind kind,
    required String id,
    required String reviewerId,
    required String approvedAt,

    /// SHA-256 of the reviewed item (see `tool/content_hash.dart`).
    required String contentHash,
    required ApprovalChecklistDto checklist,
    String? notes,
  }) = _ApprovalDto;

  factory ApprovalDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovalDtoFromJson(json);
}
