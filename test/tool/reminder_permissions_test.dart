import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'reminders add notification permission without exact alarms, boot or vibration access',
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
      expect(names, {
        'android.permission.ACCESS_COARSE_LOCATION',
        'android.permission.POST_NOTIFICATIONS',
      });
      expect(
        manifest,
        contains(
          'com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver',
        ),
      );
      expect(manifest, isNot(contains('ScheduledNotificationBootReceiver')));
    },
  );
}
