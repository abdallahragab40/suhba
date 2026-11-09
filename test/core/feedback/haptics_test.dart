import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/storage/settings_store.dart';

import '../../helpers/app_harness.dart';

void main() {
  /// Records every haptic the app asks the platform for.
  List<String> recordHaptics(WidgetTester tester) {
    final calls = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'HapticFeedback.vibrate') {
          calls.add(call.arguments as String);
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    return calls;
  }

  testApp('choices give feedback until it is turned off', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(800, 2400);
    addTearDown(tester.view.reset);
    final calls = recordHaptics(tester);
    final store = MemorySettingsStore();
    await AppUnderTest(location: '/settings', settings: store).pump(tester);

    await tester.tap(find.text('داكن'));
    await tester.pumpAndSettle();
    expect(calls, ['HapticFeedbackType.selectionClick']);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(store.getString(SettingsKeys.haptics), 'off');

    calls.clear();
    await tester.tap(find.text('فاتح'));
    await tester.pumpAndSettle();
    expect(calls, isEmpty);

    // Turning it back on answers with a tap.
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(calls, ['HapticFeedbackType.lightImpact']);
    expect(store.getString(SettingsKeys.haptics), 'on');
  });

  testApp('the off setting survives a restart', (tester) async {
    final store = MemorySettingsStore();
    await store.setString(SettingsKeys.haptics, 'off');
    final calls = recordHaptics(tester);
    await AppUnderTest(location: '/settings', settings: store).pump(tester);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
    await tester.tap(find.text('داكن'));
    await tester.pumpAndSettle();
    expect(calls, isEmpty);
  });
}
