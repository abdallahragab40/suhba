import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/quran_ref.dart';
import 'package:siyar_sahaba/core/domain/quran_surahs.dart';

void main() {
  group('quranSurahs', () {
    test('has 114 surahs totalling 6,236 ayahs (Hafs)', () {
      expect(quranSurahs, hasLength(114));
      expect(quranSurahs.fold<int>(0, (sum, s) => sum + s.ayahCount), 6236);
    });

    test('names are unique and non-empty', () {
      final names = quranSurahs.map((s) => s.nameAr).toList();
      expect(names.every((n) => n.isNotEmpty), isTrue);
      expect(names.toSet(), hasLength(114));
    });

    test('spot checks', () {
      expect(quranSurahs[0].nameAr, 'الفاتحة');
      expect(quranSurahs[1].ayahCount, 286);
      expect(quranSurahs[8].nameAr, 'التوبة');
      expect(quranSurahs[113].nameAr, 'الناس');
    });
  });

  group('QuranRef.isValid', () {
    final cases = <(QuranRef, bool)>[
      (const QuranRef(surah: 1, ayahFrom: 7), true),
      (const QuranRef(surah: 114, ayahFrom: 6), true),
      (const QuranRef(surah: 2, ayahFrom: 255, ayahTo: 257), true),
      (const QuranRef(surah: 0, ayahFrom: 1), false),
      (const QuranRef(surah: 115, ayahFrom: 1), false),
      (const QuranRef(surah: 1, ayahFrom: 8), false),
      (const QuranRef(surah: 1, ayahFrom: 0), false),
      (const QuranRef(surah: 2, ayahFrom: 5, ayahTo: 3), false),
    ];
    for (final (ref, valid) in cases) {
      test('${ref.surah}:${ref.ayahFrom}-${ref.ayahTo} → $valid', () {
        expect(ref.isValid, valid);
      });
    }
  });

  group('HistoricalDate ordering', () {
    const bh1 = HistoricalDate(
      precision: DatePrecision.year,
      era: HijriEra.beforeHijra,
      hijriYear: 1,
    );
    const bh13 = HistoricalDate(
      precision: DatePrecision.year,
      era: HijriEra.beforeHijra,
      hijriYear: 13,
    );
    const ah1 = HistoricalDate(precision: DatePrecision.year, hijriYear: 1);
    const ah13 = HistoricalDate(precision: DatePrecision.year, hijriYear: 13);
    const ah13m6 = HistoricalDate(
      precision: DatePrecision.month,
      hijriYear: 13,
      hijriMonth: 6,
    );
    const gregorianOnly = HistoricalDate(
      precision: DatePrecision.approx,
      gregorianYear: 573,
    );

    test('sorts BH before AH, and by month within a year', () {
      final sorted = [ah13m6, ah1, bh1, ah13, bh13]..sort();
      expect(sorted, [bh13, bh1, ah1, ah13, ah13m6]);
    });

    test(
      'Gregorian-only dates are placed approximately; no-year dates last',
      () {
        const unknown = HistoricalDate.unknown();
        const greg640 = HistoricalDate(
          precision: DatePrecision.year,
          gregorianYear: 640,
        );
        final sorted = [unknown, ah13, greg640, gregorianOnly, bh1]..sort();
        // 573 CE is ~50 years before the Hijrah; 640 CE falls in 19 AH.
        expect(sorted, [gregorianOnly, bh1, ah13, greg640, unknown]);
      },
    );

    test('value equality', () {
      expect(
        ah13,
        const HistoricalDate(precision: DatePrecision.year, hijriYear: 13),
      );
      expect(ah13 == ah13m6, isFalse);
      expect(ah13.hashCode, ah13.hashCode);
    });

    test('isUnknown', () {
      expect(const HistoricalDate.unknown().isUnknown, isTrue);
      expect(
        const HistoricalDate(precision: DatePrecision.year).isUnknown,
        isTrue,
      );
      expect(ah13.isUnknown, isFalse);
      expect(gregorianOnly.isUnknown, isFalse);
    });
  });
}
