import 'dart:convert';

/// One shared daily reminder. Stored as one preferences value, independently
/// of reading-data exports; importing progress never opts a device in.
class ReadingReminder {
  const ReadingReminder({
    this.enabled = false,
    this.hour = 21,
    this.minute = 0,
    this.permissionRequested = false,
  });
  final bool enabled;
  final int hour;
  final int minute;
  final bool permissionRequested;

  ReadingReminder copyWith({
    bool? enabled,
    int? hour,
    int? minute,
    bool? permissionRequested,
  }) => ReadingReminder(
    enabled: enabled ?? this.enabled,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    permissionRequested: permissionRequested ?? this.permissionRequested,
  );

  String encode() => jsonEncode({
    'version': 1,
    'enabled': enabled,
    'hour': hour,
    'minute': minute,
    'permissionRequested': permissionRequested,
  });

  static ReadingReminder decode(String? value) {
    if (value == null) return const ReadingReminder();
    try {
      final json = jsonDecode(value);
      if (json case {
        'version': 1,
        'enabled': final bool enabled,
        'hour': final int hour,
        'minute': final int minute,
        'permissionRequested': final bool asked,
      } when hour >= 0 && hour < 24 && minute >= 0 && minute < 60) {
        return ReadingReminder(
          enabled: enabled,
          hour: hour,
          minute: minute,
          permissionRequested: asked,
        );
      }
    } on FormatException {
      /* Invalid preferences never opt the device in. */
    }
    return const ReadingReminder();
  }
}

enum ReminderIssue { denied, failed }

class ReminderState {
  const ReminderState({
    required this.settings,
    required this.supported,
    this.issue,
    this.busy = false,
  });
  final ReadingReminder settings;
  final bool supported;
  final ReminderIssue? issue;
  final bool busy;
}

class ReminderCopy {
  const ReminderCopy({
    required this.title,
    required this.body,
    required this.channel,
    required this.channelDescription,
  });
  final String title;
  final String body;
  final String channel;
  final String channelDescription;
}

abstract interface class ReminderService {
  bool get supported;
  Future<void> initialize(void Function() onTap);
  Future<bool> permissionGranted();
  Future<bool> requestPermission();
  Future<void> openSettings();
  Future<void> schedule(ReadingReminder settings, ReminderCopy copy);
  Future<void> cancel();
  void dispose();
}

/// Tests and non-mobile bootstrap do not create a native notification client.
class UnavailableReminderService implements ReminderService {
  const UnavailableReminderService();
  @override
  bool get supported => false;
  @override
  Future<void> initialize(void Function() onTap) async {}
  @override
  Future<bool> permissionGranted() async => false;
  @override
  Future<bool> requestPermission() async => false;
  @override
  Future<void> openSettings() async {}
  @override
  Future<void> schedule(ReadingReminder settings, ReminderCopy copy) async {}
  @override
  Future<void> cancel() async {}
  @override
  void dispose() {}
}
