import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/data/dto/common_dto.dart';

part 'glossary_dto.freezed.dart';
part 'glossary_dto.g.dart';

/// One glossary entry (review E3): a term, the word forms it is found
/// under in the text, and a short cited definition.
@freezed
abstract class GlossaryTermDto with _$GlossaryTermDto {
  const factory GlossaryTermDto({
    required String id,
    required LocalizedTextDto term,

    /// The spellings linked in passages (without tashkeel), the term
    /// itself included.
    required List<String> forms,
    required LocalizedTextDto definition,
    required Reliability reliability,
    required List<CitationDto> citations,
    required ReviewDto review,
  }) = _GlossaryTermDto;

  factory GlossaryTermDto.fromJson(Map<String, dynamic> json) =>
      _$GlossaryTermDtoFromJson(json);
}

/// `glossary.json`.
@freezed
abstract class GlossaryFileDto with _$GlossaryFileDto {
  const factory GlossaryFileDto({
    required int schemaVersion,
    required List<GlossaryTermDto> terms,
  }) = _GlossaryFileDto;

  factory GlossaryFileDto.fromJson(Map<String, dynamic> json) =>
      _$GlossaryFileDtoFromJson(json);
}
