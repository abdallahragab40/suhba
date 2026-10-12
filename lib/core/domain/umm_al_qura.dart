import 'package:hijri/hijri_calendar.dart';
import 'package:meta/meta.dart';

/// A day in the Umm al-Qura calendar, the published calendar of Saudi
/// Arabia. It may differ by a day from the start of a month by moon
/// sighting in the reader's country.
@immutable
class UmmAlQuraDate {
  const UmmAlQuraDate(this.year, this.month, this.day);

  /// The Umm al-Qura day of the local calendar [date], or null outside the
  /// calendar's tables (before 1937 or after 2076).
  static UmmAlQuraDate? fromGregorian(DateTime date) {
    if (date.year < _firstYear || date.year > _lastYear) return null;
    final h = HijriCalendar.fromDate(DateTime(date.year, date.month, date.day));
    return UmmAlQuraDate(h.hYear, h.hMonth, h.hDay);
  }

  static const _firstYear = 1937;
  static const _lastYear = 2076;

  final int year;

  /// 1 (al-Muharram) to 12 (Dhu al-Hijjah).
  final int month;
  final int day;

  @override
  bool operator ==(Object other) =>
      other is UmmAlQuraDate &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => 'UmmAlQuraDate($year-$month-$day)';
}
