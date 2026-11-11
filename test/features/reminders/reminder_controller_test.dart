import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/personal_data/domain/reading_data_archive.dart';
import 'package:suhba/features/personal_data/presentation/reading_data_transfer.dart';
import 'package:suhba/features/reminders/domain/reading_reminder.dart';
import 'package:suhba/features/reminders/presentation/reminder_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_reminder_service.dart';

class _FailingReminderStore extends MemorySettingsStore {
  @override
  Future<void> setString(String key, String value) {
    if (key == SettingsKeys.readingReminder &&
        ReadingReminder.decode(value).enabled) {
      throw StateError('Cannot save opt-in');
    }
    return super.setString(key, value);
  }
}

void main() {
  testApp('failed opt-in persistence cancels the newly scheduled reminder', (
    tester,
  ) async {
    final service = FakeReminderService();
    final app = AppUnderTest(
      settings: _FailingReminderStore(),
      overrides: [reminderServiceProvider.overrideWithValue(service)],
    );
    await app.container.read(reminderProvider.future);
    await app.container.read(reminderProvider.notifier).setEnabled(true);
    expect(service.scheduled, isNull);
    expect(
      app.container.read(reminderProvider).requireValue.settings.enabled,
      isFalse,
    );
    expect(
      app.container.read(reminderProvider).requireValue.issue,
      ReminderIssue.failed,
    );
    expect(service.requests, 1);
  });
  testApp('reading archives cannot opt another device into reminders', (
    tester,
  ) async {
    final service = FakeReminderService()..granted = true;
    final source = AppUnderTest(
      overrides: [reminderServiceProvider.overrideWithValue(service)],
    );
    await source.container.read(reminderProvider.future);
    await source.container.read(reminderProvider.notifier).setEnabled(true);
    final text = encodeArchive(
      await source.container.read(readingDataTransferProvider).snapshot(),
    );
    expect(text, isNot(contains('permissionRequested')));
    final freshService = FakeReminderService();
    final fresh = AppUnderTest(
      overrides: [reminderServiceProvider.overrideWithValue(freshService)],
    );
    await fresh.container.read(reminderProvider.future);
    final archive = (decodeArchive(text) as ArchiveDecoded).archive;
    await fresh.container
        .read(readingDataTransferProvider)
        .apply(
          planImport(
            localBookmarks: const [],
            localProgress: const [],
            archive: archive,
          ),
        );
    expect(
      fresh.container.read(reminderProvider).requireValue.settings.enabled,
      isFalse,
    );
    expect(freshService.requests, 0);
    expect(freshService.scheduled, isNull);
  });
  test('malformed or unknown preferences never enable reminders', () {
    for (final raw in [
      null,
      '{bad',
      '{}',
      '[]',
      '{"version":2,"enabled":true}',
      '{"version":1,"enabled":true,"hour":25,"minute":0,"permissionRequested":false}',
    ]) {
      final settings = ReadingReminder.decode(raw);
      expect(settings.enabled, isFalse);
      expect((settings.hour, settings.minute), (21, 0));
    }
  });
  testApp(
    'default is off; editing a time does not request permission or schedule',
    (tester) async {
      final service = FakeReminderService();
      final app = AppUnderTest(
        overrides: [reminderServiceProvider.overrideWithValue(service)],
      );
      final state = await app.container.read(reminderProvider.future);
      expect(state.settings.enabled, isFalse);
      expect((state.settings.hour, state.settings.minute), (21, 0));
      await app.container.read(reminderProvider.notifier).setTime(18, 45);
      expect(service.requests, 0);
      expect(service.permissionChecks, 0);
      expect(service.schedules, 0);
      expect(
        app.container.read(reminderProvider).requireValue.settings.hour,
        18,
      );
    },
  );
  testApp(
    'denial persists once; system settings can grant permission without another prompt',
    (tester) async {
      final service = FakeReminderService()..requestGrants = false;
      final store = MemorySettingsStore();
      final app = AppUnderTest(
        settings: store,
        overrides: [reminderServiceProvider.overrideWithValue(service)],
      );
      await app.container.read(reminderProvider.future);
      final controller = app.container.read(reminderProvider.notifier);
      await controller.setEnabled(true);
      await controller.setEnabled(true);
      expect(service.requests, 1);
      expect(service.scheduled, isNull);
      expect(
        app.container.read(reminderProvider).requireValue.issue,
        ReminderIssue.denied,
      );
      expect(
        ReadingReminder.decode(
          store.getString(SettingsKeys.readingReminder),
        ).permissionRequested,
        isTrue,
      );
      await controller.openSettings();
      expect(service.settingsOpened, 1);
      service.granted = true;
      await controller.synchronize();
      expect(
        app.container.read(reminderProvider).requireValue.settings.enabled,
        isFalse,
      );
      await controller.setEnabled(true);
      expect(service.requests, 1);
      expect(service.scheduled?.enabled, isTrue);
      final restoredService = FakeReminderService()..granted = true;
      final restored = AppUnderTest(
        settings: store,
        overrides: [reminderServiceProvider.overrideWithValue(restoredService)],
      );
      final restoredState = await restored.container.read(
        reminderProvider.future,
      );
      expect(restoredState.settings.enabled, isTrue);
      expect(restoredService.schedules, 1);
      expect(restoredService.requests, 0);
      await restored.container
          .read(reminderProvider.notifier)
          .setEnabled(false);
      expect(restoredService.scheduled, isNull);
      expect(
        ReadingReminder.decode(
          store.getString(SettingsKeys.readingReminder),
        ).enabled,
        isFalse,
      );
    },
  );
  testApp(
    'pre-granted permission needs no prompt; resume restores time and permission revocation turns it off',
    (tester) async {
      final service = FakeReminderService()..granted = true;
      final app = AppUnderTest(
        overrides: [reminderServiceProvider.overrideWithValue(service)],
      );
      await app.container.read(reminderProvider.future);
      final controller = app.container.read(reminderProvider.notifier);
      await controller.setEnabled(true);
      await controller.setTime(7, 30);
      await controller.synchronize();
      expect(service.requests, 0);
      expect((service.scheduled!.hour, service.scheduled!.minute), (7, 30));
      service.granted = false;
      await controller.synchronize();
      expect(service.scheduled, isNull);
      expect(
        app.container.read(reminderProvider).requireValue.settings.enabled,
        isFalse,
      );
      expect(
        app.container.read(reminderProvider).requireValue.issue,
        ReminderIssue.denied,
      );
      expect(service.requests, 0);
    },
  );
  testApp(
    'failed changes keep the persisted state and cancellation is required before claiming off',
    (tester) async {
      final service = FakeReminderService()..granted = true;
      final app = AppUnderTest(
        overrides: [reminderServiceProvider.overrideWithValue(service)],
      );
      await app.container.read(reminderProvider.future);
      final controller = app.container.read(reminderProvider.notifier);
      service.scheduleFailures = 1;
      await controller.setEnabled(true);
      expect(
        app.container.read(reminderProvider).requireValue.settings.enabled,
        isFalse,
      );
      expect(
        app.container.read(reminderProvider).requireValue.issue,
        ReminderIssue.failed,
      );
      expect(service.scheduled, isNull);
      await controller.setEnabled(true);
      service.scheduleFailures = 1;
      await controller.setTime(8, 15);
      expect(service.scheduled!.hour, 21);
      expect(
        app.container.read(reminderProvider).requireValue.settings.hour,
        21,
      );
      service.cancelFailures = 1;
      await controller.setEnabled(false);
      expect(
        app.container.read(reminderProvider).requireValue.settings.enabled,
        isTrue,
      );
      await controller.setEnabled(false);
      expect(
        app.container.read(reminderProvider).requireValue.settings.enabled,
        isFalse,
      );
      expect(service.scheduled, isNull);
    },
  );
  testApp(
    'permission-dialog resume is serialized behind opt-in instead of restoring an old off state',
    (tester) async {
      final service = FakeReminderService()
        ..permissionResult = Completer<bool>();
      final app = AppUnderTest(
        overrides: [reminderServiceProvider.overrideWithValue(service)],
      );
      await app.container.read(reminderProvider.future);
      final controller = app.container.read(reminderProvider.notifier);
      final enable = controller.setEnabled(true);
      await tester.pump();
      expect(app.container.read(reminderProvider).requireValue.busy, isTrue);
      final resume = controller.synchronize();
      service.permissionResult!.complete(true);
      await Future.wait([enable, resume]);
      expect(service.requests, 1);
      expect(service.scheduled?.enabled, isTrue);
      expect(app.container.read(reminderProvider).requireValue.busy, isFalse);
    },
  );
}
