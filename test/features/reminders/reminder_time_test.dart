import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/reminders/domain/reminder_time.dart';
import 'package:timezone/data/latest.dart' as data;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(data.initializeTimeZones);
  test(
    'the next local occurrence stays at the chosen hour across midnight',
    () {
      final cairo = tz.getLocation('Africa/Cairo');
      final before = tz.TZDateTime(cairo, 2026, 11, 10, 20, 59);
      expect(
        nextReminderTime(cairo, before.toUtc(), 21, 0),
        tz.TZDateTime(cairo, 2026, 11, 10, 21),
      );
      expect(
        nextReminderTime(cairo, tz.TZDateTime(cairo, 2026, 11, 10, 21), 21, 0),
        tz.TZDateTime(cairo, 2026, 11, 11, 21),
      );
    },
  );
  test(
    'calendar days preserve wall time across daylight saving transitions',
    () {
      final zone = tz.getLocation('America/New_York');
      final before = tz.TZDateTime(zone, 2026, 3, 7, 22);
      final next = nextReminderTime(zone, before, 21, 0);
      expect(next, tz.TZDateTime(zone, 2026, 3, 8, 21));
      expect(next.difference(before).inHours, 22);
      final gap = nextReminderTime(
        zone,
        tz.TZDateTime(zone, 2026, 3, 8),
        2,
        30,
      );
      expect(gap, tz.TZDateTime(zone, 2026, 3, 9, 2, 30));
      expect(
        nextReminderTime(zone, tz.TZDateTime(zone, 2026, 11, 1, 2), 1, 30),
        tz.TZDateTime(zone, 2026, 11, 2, 1, 30),
      );
    },
  );
}
