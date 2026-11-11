import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/features/reminders/presentation/reminder_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_reminder_service.dart';

void main() {
  testApp('the editable 21:00 suggestion stays off until explicit opt-in', (
    tester,
  ) async {
    final service = FakeReminderService();
    final app = AppUnderTest(
      location: AppRoutes.settingsReminder,
      overrides: [reminderServiceProvider.overrideWithValue(service)],
    );
    await app.pump(tester);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isFalse,
    );
    expect(find.text('٢١:٠٠'), findsOneWidget);
    await tester.tap(find.text('وقت التذكير'));
    await tester.pumpAndSettle();
    final dialog = tester.widget<TimePickerDialog>(
      find.byType(TimePickerDialog),
    );
    expect(dialog.initialTime, const TimeOfDay(hour: 21, minute: 0));
    final context = tester.element(find.byType(TimePickerDialog));
    Navigator.of(context).pop(const TimeOfDay(hour: 18, minute: 5));
    await tester.pumpAndSettle();
    expect(find.text('١٨:٠٥'), findsOneWidget);
    expect(service.requests, 0);
    expect(service.scheduled, isNull);
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(service.requests, 1);
    expect((service.scheduled!.hour, service.scheduled!.minute), (18, 5));
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(service.scheduled, isNull);
  });
  testApp('notification taps open journeys without a permission prompt', (
    tester,
  ) async {
    final service = FakeReminderService()..launchTap = true;
    final app = AppUnderTest(
      overrides: [reminderServiceProvider.overrideWithValue(service)],
    );
    await app.pump(tester);
    expect(app.location, AppRoutes.journeys);
    expect(service.requests, 0);
    app.router.go(AppRoutes.settings);
    await tester.pumpAndSettle();
    service.onTap!();
    await tester.pumpAndSettle();
    expect(app.location, AppRoutes.journeys);
    expect(service.requests, 0);
  });
}
