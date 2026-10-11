import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/format/digits.dart';

void main() {
  group('Digits.apply', () {
    final cases = <(String, DigitStyle, String)>[
      ('0123456789', DigitStyle.arabicIndic, '٠١٢٣٤٥٦٧٨٩'),
      ('0123456789', DigitStyle.western, '0123456789'),
      ('a1-2 b', DigitStyle.arabicIndic, 'a١-٢ b'),
      ('سنة 13', DigitStyle.arabicIndic, 'سنة ١٣'),
      ('', DigitStyle.arabicIndic, ''),
    ];
    for (final (input, style, expected) in cases) {
      test('"$input" in ${style.name}', () {
        expect(Digits.apply(input, style), expected);
      });
    }
  });

  group('Digits.toAscii', () {
    final cases = <(String, String)>[
      ('٠١٢٣٤٥٦٧٨٩', '0123456789'),
      ('۰۱۲۳۴۵۶۷۸۹', '0123456789'),
      ('سنة ١٣ هـ', 'سنة 13 هـ'),
      ('13', '13'),
      ('mixed ١۲3', 'mixed 123'),
    ];
    for (final (input, expected) in cases) {
      test('"$input"', () => expect(Digits.toAscii(input), expected));
    }

    test('round-trips with apply', () {
      const text = 'الآية 255 من 286';
      expect(Digits.toAscii(Digits.apply(text, DigitStyle.arabicIndic)), text);
    });
  });
}
