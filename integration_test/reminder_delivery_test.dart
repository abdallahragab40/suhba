// Schedules a real future alarm and exits. The host observes delivery after the
// process is backgrounded/killed, without relying on a live Flutter driver.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:suhba/features/reminders/data/flutter_reminder_service.dart';
import 'package:suhba/features/reminders/domain/reading_reminder.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    'schedule a future daily reminder for the host delivery observer',
    (tester) async {
      expect(
        (await PackageInfo.fromPlatform()).packageName,
        'com.abdallahragab.suhba.delivery_test',
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(child: Text('Scheduled reminder delivery test')),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final plugin = FlutterLocalNotificationsPlugin();
      final service = FlutterReminderService(plugin: plugin);
      await service.initialize(() {});
      await service.cancel();
      expect(await service.permissionGranted(), isTrue);
      final selected = DateTime.now().add(const Duration(minutes: 2));
      final scheduled = DateTime(
        selected.year,
        selected.month,
        selected.day,
        selected.hour,
        selected.minute,
      );
      const title = 'Suhba scheduled delivery test';
      await service.schedule(
        ReadingReminder(
          enabled: true,
          hour: selected.hour,
          minute: selected.minute,
        ),
        const ReminderCopy(
          title: title,
          body: 'Delivered by the Android alarm receiver',
          channel: 'Reading reminders',
          channelDescription: 'Local reading reminders',
        ),
      );
      expect(
        (await plugin.pendingNotificationRequests()).where(
          (n) => n.id == FlutterReminderService.notificationId,
        ),
        hasLength(1),
      );
      expect(
        (await plugin.getActiveNotifications()).where(
          (n) => n.id == FlutterReminderService.notificationId,
        ),
        isEmpty,
      );
      binding.reportData = {
        'reminderDelivery': {
          'scheduledUtc': scheduled.toUtc().toIso8601String(),
          'notificationId': FlutterReminderService.notificationId,
          'title': title,
        },
      };
      // Deliberately retain the OS alarm; the host owns and removes this fresh
      // .delivery_test sandbox after observing delivery and daily rescheduling.
      service.dispose();
      debugPrintSynchronously('REMINDER_FUTURE_SCHEDULED');
    },
    skip: !const bool.fromEnvironment('SUHBA_REMINDER_DELIVERY'),
  );
}
