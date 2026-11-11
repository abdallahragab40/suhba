// Android native scheduling, permission and tap smoke test. Uses a distinct
// application ID when run with SUHBA_REMINDER_TEST=true; never replace an
// installed reader build. The OS permission dialog and notification tap are
// exercised from the emulator UI while this test waits.
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suhba/features/reminders/data/flutter_reminder_service.dart';
import 'package:suhba/features/reminders/domain/reading_reminder.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    'Android reminder schedules once, replaces, posts, opens and cancels',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Center(child: Text('Reminder smoke test'))),
        ),
      );
      final plugin = FlutterLocalNotificationsPlugin();
      final service = FlutterReminderService(plugin: plugin);
      var tapped = false;
      await service.initialize(() => tapped = true);
      try {
        if (!await service.permissionGranted()) {
          debugPrint('REMINDER_SMOKE_REQUEST_PERMISSION');
          expect(await service.requestPermission(), isTrue);
        }
        expect(await service.permissionGranted(), isTrue);
        const copy = ReminderCopy(
          title: 'Suhba reminder test',
          body: 'Local reminder smoke test',
          channel: 'Reading reminders',
          channelDescription: 'Local reminder smoke test',
        );
        final time = DateTime.now().add(const Duration(minutes: 5));
        final settings = ReadingReminder(
          enabled: true,
          hour: time.hour,
          minute: time.minute,
        );
        await service.schedule(settings, copy);
        expect(
          (await plugin.pendingNotificationRequests()).where(
            (r) => r.id == FlutterReminderService.notificationId,
          ),
          hasLength(1),
        );
        await service.schedule(
          settings.copyWith(minute: (time.minute + 1) % 60),
          copy,
        );
        expect(
          (await plugin.pendingNotificationRequests()).where(
            (r) => r.id == FlutterReminderService.notificationId,
          ),
          hasLength(1),
        );
        await service.cancel();
        expect(
          (await plugin.pendingNotificationRequests()).where(
            (r) => r.id == FlutterReminderService.notificationId,
          ),
          isEmpty,
        );
        // Render/tap an immediate notification separately from inexact alarm
        // delivery, whose OS-controlled delay cannot be asserted in a short test.
        await plugin.show(
          id: FlutterReminderService.notificationId,
          title: copy.title,
          body: copy.body,
          payload: FlutterReminderService.payload,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              FlutterReminderService.channelId,
              'Reading reminders',
              icon: 'ic_stat_suhba',
              enableVibration: false,
            ),
          ),
        );
        expect(
          (await plugin.getActiveNotifications()).where(
            (r) => r.id == FlutterReminderService.notificationId,
          ),
          hasLength(1),
        );
        debugPrint('REMINDER_SMOKE_NOTIFICATION_POSTED');
        final end = DateTime.now().add(const Duration(seconds: 60));
        while (!tapped && DateTime.now().isBefore(end)) {
          await Future<void>.delayed(const Duration(milliseconds: 250));
          await tester.pump();
        }
        expect(
          tapped,
          isTrue,
          reason:
              'Tap the emulator notification to exercise the native callback',
        );
        await service.cancel();
        expect(
          (await plugin.getActiveNotifications()).where(
            (r) => r.id == FlutterReminderService.notificationId,
          ),
          isEmpty,
        );
        debugPrint('REMINDER_SMOKE_PASSED');
      } finally {
        await service.cancel();
        service.dispose();
      }
    },
  );
}
