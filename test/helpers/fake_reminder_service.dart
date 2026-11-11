import 'dart:async';

import 'package:suhba/features/reminders/domain/reading_reminder.dart';

class FakeReminderService implements ReminderService {
  bool granted = false;
  bool requestGrants = true;
  bool launchTap = false;
  int requests = 0;
  int permissionChecks = 0;
  int schedules = 0;
  int cancellations = 0;
  int settingsOpened = 0;
  int scheduleFailures = 0;
  int cancelFailures = 0;
  Completer<bool>? permissionResult;
  ReadingReminder? scheduled;
  void Function()? onTap;
  @override
  bool get supported => true;
  @override
  Future<void> initialize(void Function() callback) async {
    onTap = callback;
    if (launchTap) {
      launchTap = false;
      callback();
    }
  }

  @override
  Future<bool> permissionGranted() async {
    permissionChecks++;
    return granted;
  }

  @override
  Future<bool> requestPermission() async {
    requests++;
    granted = permissionResult == null
        ? requestGrants
        : await permissionResult!.future;
    return granted;
  }

  @override
  Future<void> openSettings() async {
    settingsOpened++;
  }

  @override
  Future<void> schedule(ReadingReminder settings, ReminderCopy copy) async {
    schedules++;
    if (scheduleFailures > 0) {
      scheduleFailures--;
      throw StateError('schedule failed');
    }
    scheduled = settings;
  }

  @override
  Future<void> cancel() async {
    cancellations++;
    if (cancelFailures > 0) {
      cancelFailures--;
      throw StateError('cancel failed');
    }
    scheduled = null;
  }

  @override
  void dispose() {
    onTap = null;
  }
}
