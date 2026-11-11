@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/features/reminders/presentation/reminder_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_reminder_service.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);
  for (final brightness in Brightness.values) {
    for (final mode in ['off', 'on', 'denied']) {
      testApp('$mode ${brightness.name}', (tester) async {
        tester.view
          ..devicePixelRatio = 1
          ..physicalSize = const Size(400, 900);
        tester.platformDispatcher.platformBrightnessTestValue = brightness;
        addTearDown(() {
          tester.view.reset();
          tester.platformDispatcher.clearPlatformBrightnessTestValue();
        });
        final service = FakeReminderService()..requestGrants = mode != 'denied';
        final app = AppUnderTest(
          location: AppRoutes.settingsReminder,
          overrides: [reminderServiceProvider.overrideWithValue(service)],
        );
        await app.pump(tester);
        if (mode != 'off') {
          await tester.tap(find.byType(SwitchListTile));
          await tester.pumpAndSettle();
        }
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/${mode}_${brightness.name}.png'),
        );
        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        tester.platformDispatcher.clearTextScaleFactorTestValue();
      });
    }
  }
}
