import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';

/// Timeline entries grouped by era (in historical order), each group sorted
/// by date. Entries with equal dates keep their authored order.
List<(TimelineEra, List<TimelineEvent>)> groupTimeline(
  List<TimelineEvent> entries,
) {
  final indexed = [for (var i = 0; i < entries.length; i++) (i, entries[i])]
    ..sort((a, b) {
      final byDate = a.$2.date.compareTo(b.$2.date);
      return byDate != 0 ? byDate : a.$1.compareTo(b.$1);
    });
  return [
    for (final era in TimelineEra.values)
      if (indexed.where((e) => e.$2.era == era).toList() case final group
          when group.isNotEmpty)
        (era, [for (final (_, entry) in group) entry]),
  ];
}

/// True when the date is not recorded to the year (approximate, a range, or
/// unknown); the era strip draws these with a dashed marker.
bool isImpreciseDate(HistoricalDate date) => switch (date.precision) {
  DatePrecision.approx || DatePrecision.range || DatePrecision.unknown => true,
  _ => false,
};
