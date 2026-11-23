import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/quran_ref.dart';
import 'package:suhba/core/format/digits.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

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
      // A leading ٠ reads as a dot, so Arabic-Indic indices are not padded.
      ('index single digit', f.index(1), '١'),
      ('index two digits', f.index(12), '١٢'),
      ('index width 3', f.index(5, width: 3), '٥'),
      ('index western', western.index(7), '07'),
      ('index western width 3', western.index(5, width: 3), '005'),
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
        '١٣\u00a0هـ',
      ),
      (
        'year AH with Gregorian',
        const HistoricalDate(
          precision: DatePrecision.year,
          hijriYear: 13,
          gregorianYear: 634,
        ),
        '١٣\u00a0هـ / ٦٣٤\u00a0م',
      ),
      (
        'year BH',
        const HistoricalDate(
          precision: DatePrecision.year,
          era: bh,
          hijriYear: 13,
        ),
        '١٣\u00a0قبل الهجرة',
      ),
      (
        'month and year',
        const HistoricalDate(
          precision: DatePrecision.month,
          hijriYear: 13,
          hijriMonth: 6,
        ),
        'جمادى الآخرة ١٣\u00a0هـ',
      ),
      (
        'month and year with Gregorian',
        const HistoricalDate(
          precision: DatePrecision.month,
          hijriYear: 13,
          hijriMonth: 6,
          gregorianYear: 634,
        ),
        'جمادى الآخرة ١٣\u00a0هـ / ٦٣٤\u00a0م',
      ),
      (
        'exact day',
        const HistoricalDate(
          precision: DatePrecision.exact,
          hijriYear: 2,
          hijriMonth: 9,
          hijriDay: 17,
        ),
        '١٧ رمضان ٢\u00a0هـ',
      ),
      (
        'exact without a day falls back to month',
        const HistoricalDate(
          precision: DatePrecision.exact,
          hijriYear: 2,
          hijriMonth: 9,
        ),
        'رمضان ٢\u00a0هـ',
      ),
      (
        'year precision hides a recorded month',
        const HistoricalDate(
          precision: DatePrecision.year,
          hijriYear: 2,
          hijriMonth: 9,
        ),
        '٢\u00a0هـ',
      ),
      (
        'approximate Hijri year',
        const HistoricalDate(precision: DatePrecision.approx, hijriYear: 13),
        'نحو سنة ١٣\u00a0هـ',
      ),
      (
        'approximate Gregorian year only',
        const HistoricalDate(
          precision: DatePrecision.approx,
          gregorianYear: 573,
        ),
        'نحو سنة ٥٧٣\u00a0م',
      ),
      (
        'Gregorian year only',
        const HistoricalDate(precision: DatePrecision.year, gregorianYear: 573),
        '٥٧٣\u00a0م',
      ),
      (
        'range AH',
        const HistoricalDate(
          precision: DatePrecision.range,
          hijriYear: 11,
          hijriYearEnd: 13,
        ),
        '١١ – ١٣\u00a0هـ',
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
        '١١ – ١٣\u00a0هـ / ٦٣٢ – ٦٣٤\u00a0م',
      ),
      (
        'range BH',
        const HistoricalDate(
          precision: DatePrecision.range,
          era: bh,
          hijriYear: 13,
          hijriYearEnd: 10,
        ),
        '١٣ – ١٠\u00a0قبل الهجرة',
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
        '١\u00a0قبل الهجرة – ١\u00a0هـ',
      ),
      (
        'range without an end shows the start',
        const HistoricalDate(precision: DatePrecision.range, hijriYear: 11),
        '١١\u00a0هـ',
      ),
      (
        'Gregorian range only',
        const HistoricalDate(
          precision: DatePrecision.range,
          gregorianYear: 610,
          gregorianYearEnd: 622,
        ),
        '٦١٠ – ٦٢٢\u00a0م',
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
        '١٣\u00a0هـ',
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
        '٥٧٣\u00a0م',
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
        '13\u00a0هـ / 634\u00a0م',
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
        'Jumada al-Akhirah 13\u00a0AH / 634\u00a0CE',
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
          '${months[m - 1]} ١\u00a0هـ',
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

  group('timeOfDay', () {
    final cases = <(String, String, String)>[
      ('evening on the hour', f.timeOfDay(21, 0), '٩ مساءً'),
      ('morning with minutes', f.timeOfDay(7, 30), '٧:٣٠ صباحًا'),
      ('minutes are padded', f.timeOfDay(9, 5), '٩:٠٥ صباحًا'),
      ('midnight', f.timeOfDay(0, 0), '١٢ صباحًا'),
      ('noon', f.timeOfDay(12, 0), '١٢ مساءً'),
      ('western', western.timeOfDay(21, 15), '9:15 مساءً'),
    ];
    for (final (name, actual, expected) in cases) {
      test(name, () => expect(actual, expected));
    }
    test('on the hour shows no minutes, so no "٠٠"', () {
      for (var h = 0; h < 24; h++) {
        expect(f.timeOfDay(h, 0), isNot(contains(':')), reason: '$h:00');
      }
    });
  });

  group('join', () {
    test('uses the Arabic comma and skips empty parts', () {
      expect(
        DisplayFormatter.join(['الفصل ٣', null, '', '٢\u00a0هـ']),
        'الفصل ٣، ٢\u00a0هـ',
      );
    });
    test('never uses the middle dot', () {
      expect(DisplayFormatter.separator, isNot(contains('·')));
    });
  });
}
