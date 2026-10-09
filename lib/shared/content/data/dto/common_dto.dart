// JSON shapes of the content files. They mirror content/schema/; enum
// values are the Dart enum names.
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

part 'common_dto.freezed.dart';
part 'common_dto.g.dart';

@freezed
abstract class LocalizedTextDto with _$LocalizedTextDto {
  const factory LocalizedTextDto({required String ar, String? en}) =
      _LocalizedTextDto;

  factory LocalizedTextDto.fromJson(Map<String, dynamic> json) =>
      _$LocalizedTextDtoFromJson(json);
}

@freezed
abstract class HistoricalDateDto with _$HistoricalDateDto {
  const factory HistoricalDateDto({
    required DatePrecision precision,
    @Default(HijriEra.afterHijra) HijriEra era,
    int? hijriYear,
    int? hijriMonth,
    int? hijriDay,
    int? gregorianYear,
    HijriEra? endEra,
    int? hijriYearEnd,
    int? gregorianYearEnd,
  }) = _HistoricalDateDto;

  factory HistoricalDateDto.fromJson(Map<String, dynamic> json) =>
      _$HistoricalDateDtoFromJson(json);
}

@freezed
abstract class QuranRefDto with _$QuranRefDto {
  const factory QuranRefDto({
    required int surah,
    required int ayahFrom,
    int? ayahTo,
  }) = _QuranRefDto;

  factory QuranRefDto.fromJson(Map<String, dynamic> json) =>
      _$QuranRefDtoFromJson(json);
}

@freezed
abstract class GradingDto with _$GradingDto {
  const factory GradingDto({
    required HadithGrade grade,
    required LocalizedTextDto gradedBy,
  }) = _GradingDto;

  factory GradingDto.fromJson(Map<String, dynamic> json) =>
      _$GradingDtoFromJson(json);
}

@freezed
abstract class CitationDto with _$CitationDto {
  const factory CitationDto({
    required String sourceId,
    required LocatorStatus locatorStatus,
    int? volume,
    String? page,
    String? hadithNumber,
    LocalizedTextDto? chapterTitle,
    QuranRefDto? quranRef,
    GradingDto? grading,
    LocalizedTextDto? note,
  }) = _CitationDto;

  factory CitationDto.fromJson(Map<String, dynamic> json) =>
      _$CitationDtoFromJson(json);
}

@freezed
abstract class DatedClaimDto with _$DatedClaimDto {
  const factory DatedClaimDto({
    required HistoricalDateDto date,
    required Reliability reliability,
    @Default(<CitationDto>[]) List<CitationDto> citations,
    LocalizedTextDto? note,
  }) = _DatedClaimDto;

  factory DatedClaimDto.fromJson(Map<String, dynamic> json) =>
      _$DatedClaimDtoFromJson(json);
}

@freezed
abstract class FactDto with _$FactDto {
  const factory FactDto({
    required LocalizedTextDto label,
    required Reliability reliability,
    LocalizedTextDto? text,
    HistoricalDateDto? date,
    @Default(<CitationDto>[]) List<CitationDto> citations,
  }) = _FactDto;

  factory FactDto.fromJson(Map<String, dynamic> json) =>
      _$FactDtoFromJson(json);
}

@freezed
abstract class ReviewDto with _$ReviewDto {
  const factory ReviewDto({
    required ReviewStatus status,
    @Default(<EditorialFlag>[]) List<EditorialFlag> editorialFlags,
    Coverage? coverage,

    /// Who drafted it (team member or "sample-content"); not shipped to UI.
    String? authoredBy,
  }) = _ReviewDto;

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);
}

@freezed
abstract class PersonRefDto with _$PersonRefDto {
  const factory PersonRefDto({
    required LocalizedTextDto displayName,
    String? companionId,
    String? personId,
  }) = _PersonRefDto;

  factory PersonRefDto.fromJson(Map<String, dynamic> json) =>
      _$PersonRefDtoFromJson(json);
}

@freezed
abstract class RelationDto with _$RelationDto {
  const factory RelationDto({
    required RelationType type,
    required PersonRefDto person,
    @Default(<CitationDto>[]) List<CitationDto> citations,
  }) = _RelationDto;

  factory RelationDto.fromJson(Map<String, dynamic> json) =>
      _$RelationDtoFromJson(json);
}

@freezed
abstract class MembershipDto with _$MembershipDto {
  const factory MembershipDto({
    required String categoryId,
    required List<CitationDto> citations,
    LocalizedTextDto? note,
  }) = _MembershipDto;

  factory MembershipDto.fromJson(Map<String, dynamic> json) =>
      _$MembershipDtoFromJson(json);
}
