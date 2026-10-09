import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/quran_ref.dart';
import 'package:siyar_sahaba/core/format/digits.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';

void main() {
  final ar = lookupAppLocalizations(const Locale('ar'));
  final f = DisplayFormatter(ar, DigitStyle.arabicIndic);
  final western = DisplayFormatter(ar, DigitStyle.western);

  const ah = HijriEra.afterHijra;
  const bh = HijriEra.beforeHijra;

  group('numbers', () {
    final cases = <(String, String, String)>[
      ('integer', f.integer(13), '١٣'),
      ('integer zero', f.integer(0), '٠'),
      ('integer western', western.integer(13), '13'),
      ('padded single digit', f.padded(1), '٠١'),
      ('padded two digits', f.padded(12), '١٢'),
      ('padded width 3', f.padded(5, width: 3), '٠٠٥'),
      ('padded western', western.padded(7), '07'),
      ('percent', f.percent(42), '٤٢٪'),
      ('percent western', western.percent(42), '42٪'),
    ];
    for (final (name, actual, expected) in cases) {
      test(name, () => expect(actual, expected));
    }
  });

  group('historicalDate', () {
    final cases = <(String, HistoricalDate, String)>[
      (
        'year AH',
        const HistoricalDate(precision: DatePrecision.year, hijriYear: 13),
        '١٣ هـ',
      ),
      (
        'year AH with Gregorian',
        const HistoricalDate(
          precision: DatePrecision.year,
          hijriYear: 13,
          gregorianYear: 634,
        ),
        '١٣ هـ / ٦٣٤ م',
      ),
      (
        'year BH',
        const HistoricalDate(
          precision: DatePrecision.year,
          era: bh,
          hijriYear: 13,
        ),
        '١٣ قبل الهجرة',
      ),
      (
        'month and year',
        const HistoricalDate(
          precision: DatePrecision.month,
          hijriYear: 13,
          hijriMonth: 6,
        ),
        'جمادى الآخرة ١٣ هـ',
      ),
      (
        'month and year with Gregorian',
        const HistoricalDate(
          precision: DatePrecision.month,
          hijriYear: 13,
          hijriMonth: 6,
          gregorianYear: 634,
        ),
        'جمادى الآخرة ١٣ هـ / ٦٣٤ م',
      ),
      (
        'exact day',
        const HistoricalDate(
          precision: DatePrecision.exact,
          hijriYear: 2,
          hijriMonth: 9,
          hijriDay: 17,
        ),
        '١٧ رمضان ٢ هـ',
      ),
      (
        'exact without a day falls back to month',
        const HistoricalDate(
          precision: DatePrecision.exact,
          hijriYear: 2,
          hijriMonth: 9,
        ),
        'رمضان ٢ هـ',
      ),
      (
        'year precision hides a recorded month',
        const HistoricalDate(
          precision: DatePrecision.year,
          hijriYear: 2,
          hijriMonth: 9,
        ),
        '٢ هـ',
      ),
      (
        'approximate Hijri year',
        const HistoricalDate(precision: DatePrecision.approx, hijriYear: 13),
        'نحو سنة ١٣ هـ',
      ),
      (
        'approximate Gregorian year only',
        const HistoricalDate(
          precision: DatePrecision.approx,
          gregorianYear: 573,
        ),
        'نحو سنة ٥٧٣ م',
      ),
      (
        'Gregorian year only',
        const HistoricalDate(precision: DatePrecision.year, gregorianYear: 573),
        '٥٧٣ م',
      ),
      (
        'range AH',
        const HistoricalDate(
          precision: DatePrecision.range,
          hijriYear: 11,
          hijriYearEnd: 13,
        ),
        '١١ – ١٣ هـ',
      ),
      (
        'range AH with Gregorian range',
        const HistoricalDate(
          precision: DatePrecision.range,
          hijriYear: 11,
          hijriYearEnd: 13,
          gregorianYear: 632,
          gregorianYearEnd: 634,
        ),
        '١١ – ١٣ هـ / ٦٣٢ – ٦٣٤ م',
      ),
      (
        'range BH',
        const HistoricalDate(
          precision: DatePrecision.range,
          era: bh,
          hijriYear: 13,
          hijriYearEnd: 10,
        ),
        '١٣ – ١٠ قبل الهجرة',
      ),
      (
        'range across the Hijrah',
        const HistoricalDate(
          precision: DatePrecision.range,
          era: bh,
          hijriYear: 1,
          endEra: ah,
          hijriYearEnd: 1,
        ),
        '١ قبل الهجرة – ١ هـ',
      ),
      (
        'range without an end shows the start',
        const HistoricalDate(precision: DatePrecision.range, hijriYear: 11),
        '١١ هـ',
      ),
      (
        'Gregorian range only',
        const HistoricalDate(
          precision: DatePrecision.range,
          gregorianYear: 610,
          gregorianYearEnd: 622,
        ),
        '٦١٠ – ٦٢٢ م',
      ),
      ('unknown', const HistoricalDate.unknown(), 'غير معروف على وجه التحقيق'),
      (
        'unknown even when a year is present',
        const HistoricalDate(precision: DatePrecision.unknown, hijriYear: 13),
        'غير معروف على وجه التحقيق',
      ),
      (
        'no years at all is unknown',
        const HistoricalDate(precision: DatePrecision.year),
        'غير معروف على وجه التحقيق',
      ),
    ];
    for (final (name, date, expected) in cases) {
      test(name, () => expect(f.historicalDate(date), expected));
    }

    test('withGregorian: false drops the Gregorian year', () {
      expect(
        f.historicalDate(
          const HistoricalDate(
            precision: DatePrecision.year,
            hijriYear: 13,
            gregorianYear: 634,
          ),
          withGregorian: false,
        ),
        '١٣ هـ',
      );
    });

    test('withGregorian: false still shows a Gregorian-only date', () {
      expect(
        f.historicalDate(
          const HistoricalDate(
            precision: DatePrecision.year,
            gregorianYear: 573,
          ),
          withGregorian: false,
        ),
        '٥٧٣ م',
      );
    });

    test('western digits', () {
      expect(
        western.historicalDate(
          const HistoricalDate(
            precision: DatePrecision.year,
            hijriYear: 13,
            gregorianYear: 634,
          ),
        ),
        '13 هـ / 634 م',
      );
    });

    test('English strings are wired up', () {
      final en = DisplayFormatter(
        lookupAppLocalizations(const Locale('en')),
        DigitStyle.western,
      );
      expect(
        en.historicalDate(
          const HistoricalDate(
            precision: DatePrecision.month,
            hijriYear: 13,
            hijriMonth: 6,
            gregorianYear: 634,
          ),
        ),
        'Jumada al-Akhirah 13 AH / 634 CE',
      );
    });

    const months = [
      'المحرّم',
      'صفر',
      'ربيع الأول',
      'ربيع الآخر',
      'جمادى الأولى',
      'جمادى الآخرة',
      'رجب',
      'شعبان',
      'رمضان',
      'شوّال',
      'ذو القعدة',
      'ذو الحجة',
    ];
    for (var m = 1; m <= 12; m++) {
      test('month $m name', () {
        expect(
          f.historicalDate(
            HistoricalDate(
              precision: DatePrecision.month,
              hijriYear: 1,
              hijriMonth: m,
            ),
          ),
          '${months[m - 1]} ١ هـ',
        );
      });
    }
  });

  group('quranRef', () {
    final cases = <(String, QuranRef, DisplayFormatter, String)>[
      ('single ayah', const QuranRef(surah: 9, ayahFrom: 40), f, 'التوبة: ٤٠'),
      (
        'ayah range',
        const QuranRef(surah: 2, ayahFrom: 255, ayahTo: 257),
        f,
        'البقرة: ٢٥٥–٢٥٧',
      ),
      ('first surah', const QuranRef(surah: 1, ayahFrom: 1), f, 'الفاتحة: ١'),
      ('last surah', const QuranRef(surah: 114, ayahFrom: 6), f, 'الناس: ٦'),
      (
        'western digits',
        const QuranRef(surah: 9, ayahFrom: 40),
        western,
        'التوبة: 40',
      ),
    ];
    for (final (name, ref, formatter, expected) in cases) {
      test(name, () => expect(formatter.quranRef(ref), expected));
    }
  });
}
