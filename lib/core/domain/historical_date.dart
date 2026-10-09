import 'package:meta/meta.dart';

/// Before or after the Hijrah.
enum HijriEra {
  /// قبل الهجرة: `hijriYear` counts back from the Hijrah (1 = the year before).
  beforeHijra,

  /// بعد الهجرة (هـ).
  afterHijra,
}

/// How much of a [HistoricalDate] is actually known.
enum DatePrecision {
  /// Day, month and year.
  exact,

  /// Month and year.
  month,

  /// Year only.
  year,

  /// An approximate year ("نحو سنة …").
  approx,

  /// A span of years (start → end).
  range,

  /// Not reliably documented.
  unknown,
}

/// A date as the sources record it: Hijri first, with an optional Gregorian
/// year, and only as precise as the sources are.
///
/// Values are stored as authored and never converted computationally:
/// converting would invent precision the sources do not have.
@immutable
class HistoricalDate implements Comparable<HistoricalDate> {
  const HistoricalDate({
    required this.precision,
    this.era = HijriEra.afterHijra,
    this.hijriYear,
    this.hijriMonth,
    this.hijriDay,
    this.gregorianYear,
    this.endEra,
    this.hijriYearEnd,
    this.gregorianYearEnd,
  }) : assert(hijriYear == null || hijriYear > 0, 'hijriYear must be > 0'),
       assert(
         hijriMonth == null || (hijriMonth >= 1 && hijriMonth <= 12),
         'hijriMonth must be 1–12',
       ),
       assert(
         hijriDay == null || (hijriDay >= 1 && hijriDay <= 30),
         'hijriDay must be 1–30',
       ),
       assert(hijriDay == null || hijriMonth != null, 'a day needs a month');

  const HistoricalDate.unknown() : this(precision: DatePrecision.unknown);

  final DatePrecision precision;
  final HijriEra era;
  final int? hijriYear;
  final int? hijriMonth;
  final int? hijriDay;
  final int? gregorianYear;

  /// End of a [DatePrecision.range]; defaults to [era] when null.
  final HijriEra? endEra;
  final int? hijriYearEnd;
  final int? gregorianYearEnd;

  /// True when there is nothing to show.
  bool get isUnknown =>
      precision == DatePrecision.unknown ||
      (hijriYear == null && gregorianYear == null);

  /// A single number on the Hijri time line, for sorting only: year 1 before
  /// the Hijrah is -1, year 1 after it is 0. A date with only a Gregorian
  /// year is placed approximately (a Hijri year is ~0.97 Gregorian years);
  /// this never affects how the date is displayed. Null when no year is
  /// recorded at all.
  double? get sortKey {
    final year = hijriYear;
    if (year == null) {
      final g = gregorianYear;
      return g == null ? null : (g - 622) / 0.970224;
    }
    final base = era == HijriEra.beforeHijra ? -year : year - 1;
    final month = (hijriMonth ?? 1) - 1;
    final day = (hijriDay ?? 1) - 1;
    return base + month / 12 + day / 360;
  }

  /// Orders by [sortKey]; dates with no year at all sort last.
  @override
  int compareTo(HistoricalDate other) {
    final a = sortKey;
    final b = other.sortKey;
    if (a == null && b == null) return 0;
    if (a == null) return 1;
    if (b == null) return -1;
    return a.compareTo(b);
  }

  @override
  bool operator ==(Object other) =>
      other is HistoricalDate &&
      other.precision == precision &&
      other.era == era &&
      other.hijriYear == hijriYear &&
      other.hijriMonth == hijriMonth &&
      other.hijriDay == hijriDay &&
      other.gregorianYear == gregorianYear &&
      other.endEra == endEra &&
      other.hijriYearEnd == hijriYearEnd &&
      other.gregorianYearEnd == gregorianYearEnd;

  @override
  int get hashCode => Object.hash(
    precision,
    era,
    hijriYear,
    hijriMonth,
    hijriDay,
    gregorianYear,
    endEra,
    hijriYearEnd,
    gregorianYearEnd,
  );
}
