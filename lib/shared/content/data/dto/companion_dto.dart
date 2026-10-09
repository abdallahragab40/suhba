import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/data/dto/block_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';

part 'companion_dto.freezed.dart';
part 'companion_dto.g.dart';

@freezed
abstract class BiographySectionDto with _$BiographySectionDto {
  const factory BiographySectionDto({
    required String id,
    required SectionKind kind,
    required LocalizedTextDto title,
    required List<ContentBlockDto> blocks,
  }) = _BiographySectionDto;

  factory BiographySectionDto.fromJson(Map<String, dynamic> json) =>
      _$BiographySectionDtoFromJson(json);
}

@freezed
abstract class TimelineEventDto with _$TimelineEventDto {
  const factory TimelineEventDto({
    required String id,
    required TimelineEra era,
    required HistoricalDateDto date,
    required LocalizedTextDto title,
    required Reliability reliability,
    required List<CitationDto> citations,
    LocalizedTextDto? summary,
    String? eventId,
    String? sectionId,
  }) = _TimelineEventDto;

  factory TimelineEventDto.fromJson(Map<String, dynamic> json) =>
      _$TimelineEventDtoFromJson(json);
}

/// `content/companions/<id>.json` and `assets/content/companions/<id>.json`.
@freezed
abstract class CompanionDto with _$CompanionDto {
  const factory CompanionDto({
    required int schemaVersion,
    required String id,
    required Gender gender,
    required LocalizedTextDto name,
    required LocalizedTextDto fullName,
    required LocalizedTextDto summary,
    required ReviewDto review,
    required List<String> references,
    int? order,
    LocalizedTextDto? lineage,
    LocalizedTextDto? kunya,
    @Default(<LocalizedTextDto>[]) List<LocalizedTextDto> titles,
    @Default(<String>[]) List<String> aliases,
    DatedClaimDto? birth,
    DatedClaimDto? death,
    LocalizedTextDto? deathPlace,
    @Default(<FactDto>[]) List<FactDto> atAGlance,
    @Default(<MembershipDto>[]) List<MembershipDto> memberships,
    @Default(<RelationDto>[]) List<RelationDto> relations,
    @Default(<BiographySectionDto>[]) List<BiographySectionDto> sections,
    @Default(<String>[]) List<String> storyIds,
    @Default(<TimelineEventDto>[]) List<TimelineEventDto> timeline,
  }) = _CompanionDto;

  factory CompanionDto.fromJson(Map<String, dynamic> json) =>
      _$CompanionDtoFromJson(json);
}

@freezed
abstract class CompanionSummaryDto with _$CompanionSummaryDto {
  const factory CompanionSummaryDto({
    required String id,
    required Gender gender,
    required LocalizedTextDto name,
    required LocalizedTextDto summary,
    required ReviewDto review,
    int? order,
    LocalizedTextDto? kunya,
    @Default(<LocalizedTextDto>[]) List<LocalizedTextDto> titles,
    @Default(<String>[]) List<String> aliases,
    @Default(<String>[]) List<String> categoryIds,
    HistoricalDateDto? death,
  }) = _CompanionSummaryDto;

  factory CompanionSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$CompanionSummaryDtoFromJson(json);
}

/// `assets/content/index/companions.json`.
@freezed
abstract class CompanionIndexDto with _$CompanionIndexDto {
  const factory CompanionIndexDto({
    required int schemaVersion,
    required List<CompanionSummaryDto> companions,
  }) = _CompanionIndexDto;

  factory CompanionIndexDto.fromJson(Map<String, dynamic> json) =>
      _$CompanionIndexDtoFromJson(json);
}
