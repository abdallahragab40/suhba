import 'package:meta/meta.dart';
import 'package:suhba/core/domain/quran_ref.dart';

/// The verified Qur'an text of the ayahs the content quotes.
@immutable
class QuranVerses {
  const QuranVerses({
    required this.sourceName,
    required this.sourceUrl,
    required this.notice,
    required this.basmalas,
    required this.ayahs,
  });

  final String sourceName;
  final String sourceUrl;

  /// The source's copyright notice, shown with the credits.
  final String notice;

  /// The basmala as written at the head of a surah, by surah number, for
  /// the quoted surah openings (al-Fatihah's is its first ayah; at-Tawbah
  /// has none).
  final Map<int, String> basmalas;

  /// Ayah text by `surah:ayah`.
  final Map<String, String> ayahs;

  /// The ayahs of [ref] in order, or null if any is missing.
  List<({int ayah, String text})>? passage(QuranRef ref) {
    final result = <({int ayah, String text})>[];
    for (var a = ref.ayahFrom; a <= ref.ayahTo; a++) {
      final text = ayahs['${ref.surah}:$a'];
      if (text == null) return null;
      result.add((ayah: a, text: text));
    }
    return result;
  }

  /// The basmala to show above [ref], when it opens a surah that has one.
  String? basmalaAbove(QuranRef ref) =>
      ref.ayahFrom == 1 ? basmalas[ref.surah] : null;
}
