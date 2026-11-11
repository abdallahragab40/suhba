import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/reminders/domain/reading_reminder.dart';

/// Bootstrap supplies the native implementation. Host tests have no platform
/// calls unless they explicitly override this with a fake service.
final reminderServiceProvider = Provider<ReminderService>(
  (ref) => const UnavailableReminderService(),
);

final reminderTapProvider = NotifierProvider<ReminderTapController, int>(
  ReminderTapController.new,
);

class ReminderTapController extends Notifier<int> {
  @override
  int build() => 0;
  void received() => state++;
}

final reminderCopyProvider = Provider<ReminderCopy>((ref) {
  final l10n = lookupAppLocalizations(const Locale('ar'));
  return ReminderCopy(
    title: l10n.reminderNotificationTitle,
    body: l10n.reminderNotificationBody,
    channel: l10n.reminderChannel,
    channelDescription: l10n.reminderChannelDescription,
  );
});

final reminderProvider =
    AsyncNotifierProvider<ReminderController, ReminderState>(
      ReminderController.new,
    );

class ReminderController extends AsyncNotifier<ReminderState>
    with WidgetsBindingObserver {
  late SettingsStore _store;
  late ReminderService _service;
  late ReminderCopy _copy;
  bool _alive = false;
  bool _ready = false;
  Future<void> _tail = Future.value();

  ReadingReminder _read() =>
      ReadingReminder.decode(_store.getString(SettingsKeys.readingReminder));
  Future<void> _save(ReadingReminder config) =>
      _store.setString(SettingsKeys.readingReminder, config.encode());
  ReminderState _view(ReadingReminder config, [ReminderIssue? issue]) =>
      ReminderState(
        settings: config,
        supported: _service.supported,
        issue: issue,
      );

  @override
  Future<ReminderState> build() async {
    _store = ref.watch(settingsStoreProvider);
    _service = ref.watch(reminderServiceProvider);
    _copy = ref.watch(reminderCopyProvider);
    _alive = true;
    ref.onDispose(() {
      _alive = false;
      _ready = false;
      WidgetsBinding.instance.removeObserver(this);
      _service.dispose();
    });
    try {
      await _service.initialize(() {
        scheduleMicrotask(() {
          if (_alive) ref.read(reminderTapProvider.notifier).received();
        });
      });
      final restored = await _restore();
      if (_alive) {
        _ready = true;
        WidgetsBinding.instance.addObserver(this);
      }
      return restored;
    } on Object {
      return _view(_read(), ReminderIssue.failed);
    }
  }

  Future<ReminderState> _restore() async {
    final config = _read();
    if (!_service.supported) return _view(config);
    final allowed = config.enabled || config.permissionRequested
        ? await _service.permissionGranted()
        : true;
    if (config.enabled && allowed) {
      try {
        await _service.schedule(config, _copy);
      } on Object {
        await _service.cancel();
        final off = config.copyWith(enabled: false);
        await _save(off);
        return _view(off, ReminderIssue.failed);
      }
      return _view(config);
    }
    await _service.cancel();
    final off = config.copyWith(enabled: false);
    if (config.enabled) await _save(off);
    return _view(off, !allowed ? ReminderIssue.denied : null);
  }

  /// Serialize resume/permission-dialog callbacks with user changes. Resuming
  /// while permission is being requested cannot restore an older off state.
  Future<void> _perform(Future<ReminderState> Function() action) {
    final job = _tail.then((_) async {
      if (!_alive || !state.hasValue) return;
      final current = state.requireValue;
      state = AsyncData(
        ReminderState(
          settings: current.settings,
          supported: current.supported,
          issue: current.issue,
          busy: true,
        ),
      );
      try {
        final next = await action();
        if (_alive) state = AsyncData(next);
      } on Object {
        if (_alive) state = AsyncData(_view(_read(), ReminderIssue.failed));
      }
    });
    _tail = job;
    return job;
  }

  Future<void> setEnabled(bool enabled) => _perform(() async {
    var config = _read();
    if (!_service.supported) return _view(config);
    if (!enabled) {
      // Do not claim off if cancellation fails.
      await _service.cancel();
      config = config.copyWith(enabled: false);
      await _save(config);
      return _view(config);
    }
    var allowed = await _service.permissionGranted();
    if (!allowed && !config.permissionRequested) {
      config = config.copyWith(permissionRequested: true);
      // Persist before opening the OS dialog, even if the app is then killed.
      await _save(config);
      allowed = await _service.requestPermission();
    }
    if (!allowed) {
      await _service.cancel();
      config = config.copyWith(enabled: false);
      await _save(config);
      return _view(config, ReminderIssue.denied);
    }
    return _scheduleAndSave(config.copyWith(enabled: true));
  });

  Future<ReminderState> _scheduleAndSave(ReadingReminder next) async {
    final previous = _read();
    try {
      await _service.schedule(next, _copy);
      await _save(next);
      return _view(next);
    } on Object {
      // Restore the old alarm when possible. A failed preference write must
      // not leave a newly enabled reminder that the app still describes as off.
      if (previous.enabled) {
        await _service.schedule(previous, _copy);
      } else {
        await _service.cancel();
      }
      rethrow;
    }
  }

  Future<void> setTime(int hour, int minute) => _perform(() async {
    RangeError.checkValueInInterval(hour, 0, 23, 'hour');
    RangeError.checkValueInInterval(minute, 0, 59, 'minute');
    final next = _read().copyWith(hour: hour, minute: minute);
    if (next.enabled) return _scheduleAndSave(next);
    await _save(next);
    return _view(next);
  });

  Future<void> synchronize() => _perform(_restore);
  Future<void> openSettings() => _perform(() async {
    await _service.openSettings();
    return _view(_read(), state.value?.issue);
  });
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_ready && _service.supported && state == AppLifecycleState.resumed) {
      synchronize();
    }
  }
}
