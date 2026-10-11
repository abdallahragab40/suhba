import 'package:suhba/core/format/digits.dart';

/// Folds Arabic text to a canonical form for search, so that spelling
/// variants match: أبو بكرٍ, ابو بكر and أبو بَكر all become "ابو بكر".
///
/// - strips tashkeel, Qur'anic annotation marks and tatweel;
/// - unifies alef forms (أ إ آ ٱ → ا), ى → ي, ة → ه, ؤ → و, ئ → ي;
/// - maps Persian/Urdu ک and ی to Arabic ك and ي;
/// - turns Arabic-Indic digits into ASCII, lowercases Latin letters;
/// - treats punctuation as a space and collapses whitespace.
abstract final class ArabicNormalizer {
  static String normalize(String input) => normalizeWithOffsets(input).$1;

  /// Like [normalize], and also where each character of the result came
  /// from: `offsets[i]` is the index in [input] (UTF-16) of the result's
  /// character `i`, so a match found in normalized text can be shown in the
  /// original, with its tashkeel and hamza intact. A space maps to the
  /// character that follows it.
  static (String, List<int>) normalizeWithOffsets(String input) {
    final ascii = Digits.toAscii(input); // same length as input
    final out = StringBuffer();
    final offsets = <int>[];
    var pendingSpace = false;
    var index = 0;
    for (final rune in ascii.runes) {
      final at = index;
      index += rune > 0xFFFF ? 2 : 1;
      if (_isMark(rune)) continue;
      final mapped = _map(rune);
      if (_isWordChar(mapped)) {
        if (pendingSpace && out.isNotEmpty) {
          out.write(' ');
          offsets.add(at);
        }
        pendingSpace = false;
        out.writeCharCode(mapped);
        offsets.add(at);
      } else {
        pendingSpace = true;
      }
    }
    return (out.toString(), offsets);
  }

  /// Whether [rune] is a mark that [normalize] drops (tashkeel, tatweel,
  /// Qur'anic signs): it belongs to the letter before it.
  static bool isMark(int rune) => _isMark(rune);

  static bool _isMark(int r) =>
      r == 0x0640 || // tatweel
      (r >= 0x0610 && r <= 0x061A) || // honorific and Qur'anic signs
      (r >= 0x064B && r <= 0x065F) || // tashkeel
      r == 0x0670 || // superscript alef
      (r >= 0x06D6 && r <= 0x06DC) || // Qur'anic annotation
      (r >= 0x06DF && r <= 0x06E8) ||
      (r >= 0x06EA && r <= 0x06ED);

  static int _map(int r) => switch (r) {
    0x0622 || 0x0623 || 0x0625 || 0x0671 => 0x0627, // آ أ إ ٱ → ا
    0x0649 => 0x064A, // ى → ي
    0x0629 => 0x0647, // ة → ه
    0x0624 => 0x0648, // ؤ → و
    0x0626 => 0x064A, // ئ → ي
    0x06A9 => 0x0643, // ک → ك
    0x06CC => 0x064A, // ی → ي
    >= 0x41 && <= 0x5A => r + 0x20, // A–Z → a–z
    _ => r,
  };

  static bool _isWordChar(int r) =>
      (r >= 0x0621 && r <= 0x064A) || // Arabic letters
      (r >= 0x0671 && r <= 0x06D3) || // extended Arabic letters
      (r >= 0x30 && r <= 0x39) || // 0–9
      (r >= 0x61 && r <= 0x7A); // a–z
}
