/// How digits are shown in the UI. Stored data always uses ASCII digits.
enum DigitStyle {
  /// ٠١٢٣٤٥٦٧٨٩ (default in the Arabic UI).
  arabicIndic,

  /// 0123456789.
  western,
}

/// Deterministic digit mapping. Deliberately independent of `intl` locale
/// data, whose default numbering system differs between `ar` and its
/// regional variants.
abstract final class Digits {
  static const _ascii0 = 0x30;
  static const _arabicIndic0 = 0x0660; // ٠
  static const _easternArabicIndic0 = 0x06F0; // ۰ (Persian/Urdu forms)

  /// Rewrites the ASCII digits in [text] in [style]. Other characters are
  /// left untouched.
  static String apply(String text, DigitStyle style) {
    if (style == DigitStyle.western) return text;
    final out = StringBuffer();
    for (final unit in text.codeUnits) {
      final isDigit = unit >= _ascii0 && unit <= _ascii0 + 9;
      out.writeCharCode(isDigit ? unit - _ascii0 + _arabicIndic0 : unit);
    }
    return out.toString();
  }

  /// Rewrites Arabic-Indic and Eastern Arabic-Indic digits in [text] as
  /// ASCII. Used to normalize user input (e.g. search queries).
  static String toAscii(String text) {
    final out = StringBuffer();
    for (final unit in text.codeUnits) {
      if (unit >= _arabicIndic0 && unit <= _arabicIndic0 + 9) {
        out.writeCharCode(unit - _arabicIndic0 + _ascii0);
      } else if (unit >= _easternArabicIndic0 &&
          unit <= _easternArabicIndic0 + 9) {
        out.writeCharCode(unit - _easternArabicIndic0 + _ascii0);
      } else {
        out.writeCharCode(unit);
      }
    }
    return out.toString();
  }
}
