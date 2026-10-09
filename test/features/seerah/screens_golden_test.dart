@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart';

/// The Revision 4 design gate (plan §14.6): full-page captures of Home,
/// the Seerah hub, the Hijrah chapter, a full profile and a visual, on a
/// 390 dp phone and a tablet, in both themes. Pages are captured whole
/// (a tall surface), not only their first screen.
void main() {
  setUpAll(loadAppFonts);

  const screens = <String, (String, double)>{
    'home': ('/home', 4200),
    'seerah_hub': ('/seerah', 5200),
    'seerah_chapter': ('/seerah/chapters/hijrah-to-madinah', 7600),
    'profile': ('/companions/abu-bakr', 3600),
    'visual_route': ('/visuals/hijrah-route', 1500),
  };
  const widths = {'phone': 390.0, 'tablet': 900.0};

  for (final MapEntry(key: screen, value: (location, height))
      in screens.entries) {
    for (final MapEntry(key: device, value: width) in widths.entries) {
      for (final brightness in Brightness.values) {
        // Tablets: one theme is enough to check the layout.
        if (device == 'tablet' && brightness == Brightness.dark) continue;
        testApp('$screen, $device, ${brightness.name}', (tester) async {
          tester.view
            ..devicePixelRatio = 1
            ..physicalSize = Size(width, height);
          tester.platformDispatcher.platformBrightnessTestValue = brightness;
          addTearDown(() {
            tester.view.reset();
            tester.platformDispatcher.clearPlatformBrightnessTestValue();
          });

          await AppUnderTest(location: location).pump(tester);
          expect(tester.takeException(), isNull);

          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile(
              'goldens/${screen}_${device}_${brightness.name}.png',
            ),
          );
        });
      }
    }
  }
}
