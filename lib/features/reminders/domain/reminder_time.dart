import 'package:timezone/timezone.dart' as tz;

/// Keeps the requested wall-clock hour across day boundaries and DST. If
/// today's chosen time does not exist, start on the next valid calendar day
/// rather than storing its normalized later hour as the repeating time.
tz.TZDateTime nextReminderTime(
  tz.Location location,
  DateTime now,
  int hour,
  int minute,
) {
  RangeError.checkValueInInterval(hour, 0, 23, 'hour');
  RangeError.checkValueInInterval(minute, 0, 59, 'minute');
  final local = tz.TZDateTime.from(now, location);
  for (var day = 0; day < 4; day++) {
    final candidate = tz.TZDateTime(
      location,
      local.year,
      local.month,
      local.day + day,
      hour,
      minute,
    );
    if (candidate.hour == hour &&
        candidate.minute == minute &&
        candidate.isAfter(local)) {
      return candidate;
    }
  }
  throw StateError('No future occurrence of the chosen local time');
}
