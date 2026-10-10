import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/shared/content/domain/quran_verses.dart';

part 'quran_dto.freezed.dart';
part 'quran_dto.g.dart';

/// `quran.json`: the quoted ayahs, verbatim from the pinned Tanzil text,
/// with its source and copyright notice.
@freezed
abstract class QuranFileDto with _$QuranFileDto {
  const factory QuranFileDto({
    required int schemaVersion,
    required QuranSourceDto source,

    /// The basmala as written at the head of each quoted surah opening, by
    /// surah number.
    required Map<String, String> basmalas,

    /// Ayah text by `surah:ayah`.
    required Map<String, String> ayahs,
  }) = _QuranFileDto;

  factory QuranFileDto.fromJson(Map<String, dynamic> json) =>
      _$QuranFileDtoFromJson(json);
}

@freezed
abstract class QuranSourceDto with _$QuranSourceDto {
  const factory QuranSourceDto({
    required String name,
    required String url,
    required String notice,
  }) = _QuranSourceDto;

  factory QuranSourceDto.fromJson(Map<String, dynamic> json) =>
      _$QuranSourceDtoFromJson(json);
}

extension QuranFileDtoMapper on QuranFileDto {
  QuranVerses toDomain() => QuranVerses(
    sourceName: source.name,
    sourceUrl: source.url,
    notice: source.notice,
    basmalas: {
      for (final MapEntry(:key, :value) in basmalas.entries)
        int.parse(key): value,
    },
    ayahs: ayahs,
  );
}
