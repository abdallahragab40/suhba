import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/data/dto/common_dto.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/companion.dart';

part 'atlas_dto.freezed.dart';
part 'atlas_dto.g.dart';

@freezed
abstract class GeoPointDto with _$GeoPointDto {
  const factory GeoPointDto({
    required double lat,
    required double lon,
    required GeoPrecision precision,
  }) = _GeoPointDto;

  factory GeoPointDto.fromJson(Map<String, dynamic> json) =>
      _$GeoPointDtoFromJson(json);
}

@freezed
abstract class PlaceDto with _$PlaceDto {
  const factory PlaceDto({
    required String id,
    required LocalizedTextDto name,
    required PlaceKind kind,
    required GeoPointDto location,
    required LocalizedTextDto summary,
    required Reliability reliability,
    required List<CitationDto> citations,
    required ReviewDto review,
    LocalizedTextDto? modernName,
    LocalizedTextDto? contemporaryNote,
    @Default(<String>[]) List<String> companionIds,
  }) = _PlaceDto;

  factory PlaceDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDtoFromJson(json);
}

/// `places.json`.
@freezed
abstract class PlacesFileDto with _$PlacesFileDto {
  const factory PlacesFileDto({
    required int schemaVersion,
    required List<PlaceDto> places,
  }) = _PlacesFileDto;

  factory PlacesFileDto.fromJson(Map<String, dynamic> json) =>
      _$PlacesFileDtoFromJson(json);
}

@freezed
abstract class RouteLegDto with _$RouteLegDto {
  const factory RouteLegDto({
    required String from,
    required String to,
    required bool approximate,
    required Reliability reliability,
    required List<CitationDto> citations,
    LocalizedTextDto? note,
  }) = _RouteLegDto;

  factory RouteLegDto.fromJson(Map<String, dynamic> json) =>
      _$RouteLegDtoFromJson(json);
}

@freezed
abstract class RelationEdgeDto with _$RelationEdgeDto {
  const factory RelationEdgeDto({
    required PersonRefDto from,
    required PersonRefDto to,
    required RelationType type,
    required Reliability reliability,
    required List<CitationDto> citations,
    LocalizedTextDto? note,
  }) = _RelationEdgeDto;

  factory RelationEdgeDto.fromJson(Map<String, dynamic> json) =>
      _$RelationEdgeDtoFromJson(json);
}

@freezed
abstract class SequenceStepDto with _$SequenceStepDto {
  const factory SequenceStepDto({
    required LocalizedTextDto title,
    required LocalizedTextDto text,
    required Reliability reliability,
    required List<CitationDto> citations,
    String? placeId,
    HistoricalDateDto? date,
    @Default(false) bool orderUncertain,
  }) = _SequenceStepDto;

  factory SequenceStepDto.fromJson(Map<String, dynamic> json) =>
      _$SequenceStepDtoFromJson(json);
}

@freezed
abstract class PeriodBandDto with _$PeriodBandDto {
  const factory PeriodBandDto({
    required LocalizedTextDto label,
    required HistoricalDateDto date,
    required Reliability reliability,
    required List<CitationDto> citations,
    LocalizedTextDto? note,
  }) = _PeriodBandDto;

  factory PeriodBandDto.fromJson(Map<String, dynamic> json) =>
      _$PeriodBandDtoFromJson(json);
}

@freezed
abstract class PlaceCalloutDto with _$PlaceCalloutDto {
  const factory PlaceCalloutDto({
    required LocalizedTextDto label,
    required LocalizedTextDto text,
    required Reliability reliability,
    required List<CitationDto> citations,
  }) = _PlaceCalloutDto;

  factory PlaceCalloutDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceCalloutDtoFromJson(json);
}

/// `content/visuals/<id>.json`. Which data fields apply depends on [type]
/// (enforced by the schema).
@freezed
abstract class VisualDto with _$VisualDto {
  const factory VisualDto({
    required int schemaVersion,
    required String id,
    required InfographicType type,
    required LocalizedTextDto title,
    required LocalizedTextDto takeaway,
    required ReviewDto review,
    @Default(<LocalizedTextDto>[]) List<LocalizedTextDto> notes,
    String? companionId,
    @Default(<String>[]) List<String> eventIds,
    @Default(<String>[]) List<String> placeIds,
    @Default(<RouteLegDto>[]) List<RouteLegDto> route,
    @Default(<RelationEdgeDto>[]) List<RelationEdgeDto> edges,
    @Default(<SequenceStepDto>[]) List<SequenceStepDto> steps,
    @Default(<PeriodBandDto>[]) List<PeriodBandDto> bands,
    String? placeId,
    @Default(<PlaceCalloutDto>[]) List<PlaceCalloutDto> callouts,
  }) = _VisualDto;

  factory VisualDto.fromJson(Map<String, dynamic> json) =>
      _$VisualDtoFromJson(json);
}

/// `assets/content/visuals.json`.
@freezed
abstract class VisualsFileDto with _$VisualsFileDto {
  const factory VisualsFileDto({
    required int schemaVersion,
    required List<VisualDto> visuals,
  }) = _VisualsFileDto;

  factory VisualsFileDto.fromJson(Map<String, dynamic> json) =>
      _$VisualsFileDtoFromJson(json);
}
