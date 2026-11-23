import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'only notification and boot permissions: no location, exact alarms or vibration',
    () {
      final manifest = File(
        'android/app/src/main/AndroidManifest.xml',
      ).readAsStringSync();
      final permission = RegExp(r'android:name="([^"]+)"');
      final names = {
        for (final tag in RegExp(
          r'<uses-permission\b[^>]*>',
        ).allMatches(manifest))
          if (!tag.group(0)!.contains('tools:node="remove"'))
            permission.firstMatch(tag.group(0)!)!.group(1),
      };
      // No location: the visit page lets the reader choose the city.
      expect(names, {
        'android.permission.POST_NOTIFICATIONS',
        'android.permission.RECEIVE_BOOT_COMPLETED',
      });
      expect(manifest, isNot(contains('EXACT_ALARM')));
      expect(
        manifest,
        contains(
          'com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver',
        ),
      );
    },
  );

  test('reminders are rescheduled after a reboot or an app update', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();
    final receiver = RegExp(
      r'<receiver\b[^>]*ScheduledNotificationBootReceiver[\s\S]*?</receiver>',
    ).firstMatch(manifest)?.group(0);
    expect(receiver, isNotNull);
    expect(receiver, contains('android:exported="false"'));
    for (final action in [
      'android.intent.action.BOOT_COMPLETED',
      'android.intent.action.MY_PACKAGE_REPLACED',
      'android.intent.action.QUICKBOOT_POWERON',
      'com.htc.intent.action.QUICKBOOT_POWERON',
    ]) {
      expect(receiver, contains('<action android:name="$action" />'));
    }
  });
}
