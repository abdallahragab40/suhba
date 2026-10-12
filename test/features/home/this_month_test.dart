import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/features/home/domain/this_month.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

HistoricalEvent _e(String id, HistoricalDate date) => HistoricalEvent(
  id: id,
  name: LocalizedText(ar: id),
  type: EventType.other,
  date: date,
  summary: const LocalizedText(ar: ''),
  reliability: Reliability.established,
  citations: const [],
  review: const ReviewInfo(status: ReviewStatus.draft),
);

void main() {
  test('the events dated to the month, earliest first', () {
    final events = [
      _e(
        'conquest',
        const HistoricalDate(
          precision: DatePrecision.month,
          hijriYear: 8,
          hijriMonth: 9,
        ),
      ),
      _e(
        'badr',
        const HistoricalDate(
          precision: DatePrecision.exact,
          hijriYear: 2,
          hijriMonth: 9,
          hijriDay: 17,
        ),
      ),
      _e(
        'uhud',
        const HistoricalDate(
          precision: DatePrecision.month,
          hijriYear: 3,
          hijriMonth: 10,
        ),
      ),
    ];
    expect(
      [for (final e in eventsInHijriMonth(9, events)) e.id],
      ['badr', 'conquest'],
    );
  });

  test('a year-only date is never placed in a month', () {
    final events = [
      _e(
        'approx',
        const HistoricalDate(
          precision: DatePrecision.approx,
          hijriYear: 1,
          hijriMonth: 3,
        ),
      ),
      _e(
        'year',
        const HistoricalDate(precision: DatePrecision.year, hijriYear: 1),
      ),
    ];
    expect(eventsInHijriMonth(3, events), isEmpty);
  });
}
