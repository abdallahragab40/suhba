import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/shared/content/domain/catalog.dart';

/// The events the sources date to Hijri [month] (1–12), earliest first.
///
/// Only dates recorded to the month or the day count: an event known only
/// by its year is never placed in a month by guesswork.
List<HistoricalEvent> eventsInHijriMonth(
  int month,
  Iterable<HistoricalEvent> events,
) => [
  for (final e in events)
    if (e.date.hijriMonth == month &&
        (e.date.precision == DatePrecision.month ||
            e.date.precision == DatePrecision.exact))
      e,
]..sort((a, b) => a.date.compareTo(b.date));
