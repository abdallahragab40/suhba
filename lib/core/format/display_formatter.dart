import 'package:flutter/widgets.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/quran_ref.dart';
import 'package:suhba/core/domain/quran_surahs.dart';
import 'package:suhba/core/format/digits.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Turns raw values into display strings: numbers in the chosen digit
/// style, Hijri dates at their recorded precision, and Qur'an references.
///
/// Presentation-only. Domain and data code keep ints and ASCII IDs and never
/// see these strings. Read with `DisplayFormatter.of(context)`.
class DisplayFormatter {
  const DisplayFormatter(this._l10n, this.digitStyle);

  final AppLocalizations _l10n;
  final DigitStyle digitStyle;

  static DisplayFormatter of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<DisplayFormatterScope>();
    assert(scope != null, 'No DisplayFormatterScope above this context.');
    return scope!.formatter;
  }

  /// [value] in the current digit style.
  String integer(int value) => Digits.apply('$value', digitStyle);

  /// [text] (e.g. a page range "12–13") with its ASCII digits in the
  /// current digit style.
  String digits(String text) => Digits.apply(text, digitStyle);

  /// [value] zero-padded to [width] digits, e.g. ٠١ for section indices.
  String padded(int value, {int width = 2}) =>
      Digits.apply('$value'.padLeft(width, '0'), digitStyle);

  /// [value] as a percentage, e.g. ٤٢٪.
  String percent(int value) => _l10n.percent(integer(value));

  /// [date] as precisely as it is recorded, Hijri first. With
  /// [withGregorian], the Gregorian year (when recorded) follows.
  String historicalDate(HistoricalDate date, {bool withGregorian = true}) {
    if (date.isUnknown) return _l10n.dateUnknown;

    final hijri = _hijriPart(date);
    final gregorian = withGregorian || hijri == null
        ? _gregorianPart(date)
        : null;

    final String text;
    if (hijri != null && gregorian != null) {
      text = _l10n.dateWithGregorian(hijri, gregorian);
    } else {
      // isUnknown is false, so at least one part is present.
      text = (hijri ?? gregorian)!;
    }
    return date.precision == DatePrecision.approx
        ? _l10n.dateApprox(text)
        : text;
  }

  /// [ref] as "التوبة: ٤٠" or "البقرة: ٢٥٥–٢٥٧".
  String quranRef(QuranRef ref) {
    assert(ref.isValid, 'Invalid Qur\'an reference');
    final surah = quranSurahs[ref.surah - 1].nameAr;
    if (ref.isSingleAyah) return _l10n.quranRef(surah, integer(ref.ayahFrom));
    return _l10n.quranRefRange(
      surah,
      integer(ref.ayahFrom),
      integer(ref.ayahTo),
    );
  }

  String? _hijriPart(HistoricalDate date) {
    final year = date.hijriYear;
    if (year == null) return null;

    if (date.precision == DatePrecision.range && date.hijriYearEnd != null) {
      final endEra = date.endEra ?? date.era;
      if (endEra == date.era) {
        final start = integer(year);
        final end = integer(date.hijriYearEnd!);
        return date.era == HijriEra.afterHijra
            ? _l10n.dateHijriRange(start, end)
            : _l10n.dateBeforeHijraRange(start, end);
      }
      // Across the Hijrah: write both ends out in full.
      return _l10n.dateSpan(
        _hijriYear(year, date.era),
        _hijriYear(date.hijriYearEnd!, endEra),
      );
    }

    final yearText = _hijriYear(year, date.era);
    final month = date.hijriMonth;
    final showMonth =
        month != null &&
        (date.precision == DatePrecision.exact ||
            date.precision == DatePrecision.month);
    if (!showMonth) return yearText;

    final monthName = _l10n.hijriMonthName('$month');
    final day = date.hijriDay;
    if (date.precision == DatePrecision.exact && day != null) {
      return _l10n.dateDayMonthYear(integer(day), monthName, yearText);
    }
    return _l10n.dateMonthYear(monthName, yearText);
  }

  String? _gregorianPart(HistoricalDate date) {
    final year = date.gregorianYear;
    if (year == null) return null;
    final end = date.gregorianYearEnd;
    if (date.precision == DatePrecision.range && end != null) {
      return _l10n.dateGregorianRange(integer(year), integer(end));
    }
    return _l10n.dateGregorianYear(integer(year));
  }

  String _hijriYear(int year, HijriEra era) => era == HijriEra.afterHijra
      ? _l10n.dateHijriYear(integer(year))
      : _l10n.dateBeforeHijraYear(integer(year));
}

/// Provides the [DisplayFormatter] to the widget tree.
class DisplayFormatterScope extends InheritedWidget {
  const DisplayFormatterScope({
    required this.formatter,
    required super.child,
    super.key,
  });

  final DisplayFormatter formatter;

  @override
  bool updateShouldNotify(DisplayFormatterScope oldWidget) =>
      formatter.digitStyle != oldWidget.formatter.digitStyle ||
      !identical(formatter._l10n, oldWidget.formatter._l10n);
}
