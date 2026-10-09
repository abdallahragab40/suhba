import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';

part 'block_dto.freezed.dart';
part 'block_dto.g.dart';

@freezed
abstract class OpinionDto with _$OpinionDto {
  const factory OpinionDto({
    required LocalizedTextDto text,
    required List<CitationDto> citations,
  }) = _OpinionDto;

  factory OpinionDto.fromJson(Map<String, dynamic> json) =>
      _$OpinionDtoFromJson(json);
}

/// A content block; `type` selects the variant.
@Freezed(unionKey: 'type')
sealed class ContentBlockDto with _$ContentBlockDto {
  const factory ContentBlockDto.paragraph({
    required LocalizedTextDto text,
    required Reliability reliability,
    required List<CitationDto> citations,
  }) = ParagraphBlockDto;

  const factory ContentBlockDto.lesson({required LocalizedTextDto text}) =
      LessonBlockDto;

  const factory ContentBlockDto.quranQuote({
    required QuranRefDto ref,
    LocalizedTextDto? note,
  }) = QuranQuoteBlockDto;

  const factory ContentBlockDto.hadithQuote({
    required TextStatus textStatus,
    required Reliability reliability,
    required List<CitationDto> citations,
    LocalizedTextDto? text,
    LocalizedTextDto? summary,
  }) = HadithQuoteBlockDto;

  const factory ContentBlockDto.reportQuote({
    required TextStatus textStatus,
    required Reliability reliability,
    required List<CitationDto> citations,
    LocalizedTextDto? text,
    LocalizedTextDto? summary,
  }) = ReportQuoteBlockDto;

  const factory ContentBlockDto.disputeNote({
    required LocalizedTextDto text,
    required List<OpinionDto> opinions,
  }) = DisputeNoteBlockDto;

  const factory ContentBlockDto.heading({required LocalizedTextDto text}) =
      HeadingBlockDto;

  const factory ContentBlockDto.infographic({
    required String visualId,
    LocalizedTextDto? caption,
  }) = InfographicBlockDto;

  factory ContentBlockDto.fromJson(Map<String, dynamic> json) =>
      _$ContentBlockDtoFromJson(json);
}
