@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);

  final cases = <(String, String, Brightness, double)>[
    ('directory', '/companions', Brightness.light, 1),
    ('directory', '/companions', Brightness.dark, 1),
    ('profile', '/companions/abu-bakr', Brightness.light, 1),
    ('profile', '/companions/abu-bakr', Brightness.dark, 1),
    ('profile', '/companions/abu-bakr', Brightness.light, 2),
  ];

  for (final (screen, location, brightness, scale) in cases) {
    testApp('$screen, ${brightness.name}, text scale $scale', (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(400, 900);
      tester.platformDispatcher
        ..platformBrightnessTestValue = brightness
        ..textScaleFactorTestValue = scale;
      addTearDown(() {
        tester.view.reset();
        tester.platformDispatcher
          ..clearPlatformBrightnessTestValue()
          ..clearTextScaleFactorTestValue();
      });

      await AppUnderTest(location: location).pump(tester);

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile(
          'goldens/${screen}_${brightness.name}_x${scale.toStringAsFixed(1)}.png',
        ),
      );
    });
  }
}
