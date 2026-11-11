import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:suhba/features/reminders/domain/reading_reminder.dart';
import 'package:suhba/features/reminders/domain/reminder_time.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Android only while the iOS release is on hold. Initialization never asks for
/// permission. One stable ID replaces a previous time instead of adding alarms.
class FlutterReminderService implements ReminderService {
  FlutterReminderService({
    FlutterLocalNotificationsPlugin? plugin,
    DateTime Function()? clock,
    Future<String> Function()? timezone,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
       _clock = clock ?? DateTime.now,
       _timezone =
           timezone ??
           (() async => (await FlutterTimezone.getLocalTimezone()).identifier);

  static const notificationId = 7201;
  static const channelId = 'daily_reading_v1';
  static const payload = 'reading-reminder';
  final FlutterLocalNotificationsPlugin _plugin;
  final DateTime Function() _clock;
  final Future<String> Function() _timezone;
  void Function()? _onTap;
  bool _initialized = false;
  bool _zonesReady = false;

  @override
  bool get supported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  AndroidFlutterLocalNotificationsPlugin get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()!;

  @override
  Future<void> initialize(void Function() onTap) async {
    _onTap = onTap;
    if (!supported || _initialized) return;
    final initialized = await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_suhba'),
      ),
      onDidReceiveNotificationResponse: (response) {
        if (response.payload == payload) _onTap?.call();
      },
    );
    if (initialized != true) {
      throw StateError('Could not initialize notifications');
    }
    _initialized = true;
    final launch = await _plugin.getNotificationAppLaunchDetails();
    if ((launch?.didNotificationLaunchApp ?? false) &&
        launch?.notificationResponse?.payload == payload) {
      _onTap?.call();
    }
  }

  @override
  Future<bool> permissionGranted() async {
    if (!supported || await _android.areNotificationsEnabled() != true) {
      return false;
    }
    final channels = await _android.getNotificationChannels();
    final channel = channels?.where((c) => c.id == channelId).firstOrNull;
    return channel == null || channel.importance != Importance.none;
  }

  @override
  Future<bool> requestPermission() async {
    if (!supported) return false;
    await _android.requestNotificationsPermission();
    return permissionGranted();
  }

  @override
  Future<void> openSettings() async {
    if (await _android.openAppNotificationSettings() != true) {
      throw StateError('Could not open notification settings');
    }
  }

  @override
  Future<void> schedule(ReadingReminder settings, ReminderCopy copy) async {
    if (!supported || !_initialized) {
      throw StateError('Notifications are unavailable');
    }
    if (!_zonesReady) {
      tz_data.initializeTimeZones();
      _zonesReady = true;
    }
    final location = tz.getLocation(await _timezone());
    await _plugin.zonedSchedule(
      id: notificationId,
      scheduledDate: nextReminderTime(
        location,
        _clock(),
        settings.hour,
        settings.minute,
      ),
      title: copy.title,
      body: copy.body,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          copy.channel,
          channelDescription: copy.channelDescription,
          icon: 'ic_stat_suhba',
          enableVibration: false,
          category: AndroidNotificationCategory.reminder,
        ),
      ),
    );
  }

  @override
  Future<void> cancel() async {
    if (supported && _initialized) await _plugin.cancel(id: notificationId);
  }

  @override
  void dispose() {
    _onTap = null;
  }
}
