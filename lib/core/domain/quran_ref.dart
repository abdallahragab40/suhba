import 'package:meta/meta.dart';
import 'package:suhba/core/domain/quran_surahs.dart';

/// A reference to one ayah or a run of ayahs in one surah. Only the
/// reference is stored; verse text comes from a verified dataset.
@immutable
class QuranRef {
  const QuranRef({required this.surah, required this.ayahFrom, int? ayahTo})
    : ayahTo = ayahTo ?? ayahFrom;

  /// 1–114.
  final int surah;
  final int ayahFrom;
  final int ayahTo;

  bool get isSingleAyah => ayahFrom == ayahTo;

  /// True when the surah exists and the ayahs are within it, in order.
  bool get isValid =>
      surah >= 1 &&
      surah <= quranSurahs.length &&
      ayahFrom >= 1 &&
      ayahTo >= ayahFrom &&
      ayahTo <= quranSurahs[surah - 1].ayahCount;

  @override
  bool operator ==(Object other) =>
      other is QuranRef &&
      other.surah == surah &&
      other.ayahFrom == ayahFrom &&
      other.ayahTo == ayahTo;

  @override
  int get hashCode => Object.hash(surah, ayahFrom, ayahTo);
}
