import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/quran_ref.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';

part 'citation.freezed.dart';

/// Whether a citation's locator (volume, page, hadith number) has been
/// checked against the edition.
enum LocatorStatus { complete, pending }

enum HadithGrade { sahih, hasan, daif }

/// A hadith grading and who made it.
@freezed
abstract class Grading with _$Grading {
  const factory Grading({
    required HadithGrade grade,
    required LocalizedText gradedBy,
  }) = _Grading;
}

/// A pointer into one source.
@freezed
abstract class Citation with _$Citation {
  const factory Citation({
    required String sourceId,
    required LocatorStatus locatorStatus,
    int? volume,
    String? page,
    String? hadithNumber,
    LocalizedText? chapterTitle,
    QuranRef? quranRef,
    Grading? grading,
    LocalizedText? note,
  }) = _Citation;

  const Citation._();

  bool get hasLocator =>
      volume != null ||
      page != null ||
      hadithNumber != null ||
      quranRef != null;
}

/// A date together with how well it is established and where it comes from.
@freezed
abstract class DatedClaim with _$DatedClaim {
  const factory DatedClaim({
    required HistoricalDate date,
    required Reliability reliability,
    @Default(<Citation>[]) List<Citation> citations,
    LocalizedText? note,
  }) = _DatedClaim;
}

/// One "at a glance" fact: a label with either a text or a date value.
@freezed
abstract class Fact with _$Fact {
  const factory Fact({
    required LocalizedText label,
    required Reliability reliability,
    LocalizedText? text,
    HistoricalDate? date,
    @Default(<Citation>[]) List<Citation> citations,
  }) = _Fact;
}
