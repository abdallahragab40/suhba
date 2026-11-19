import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/home/presentation/home_page.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart' show loadAppFonts;

/// Home is the daily entry point: the next step must not be buried under
/// the whole catalog (review findings F04, F05; D7). Measured with the real
/// fonts on a 393 × 852 dp phone, the review's reference device.
void main() {
  setUpAll(loadAppFonts);

  testApp('Home is at most six screens tall at 393 dp', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(393, 852);
    addTearDown(tester.view.reset);
    await AppUnderTest().pump(tester);

    final scroll = find
        .descendant(
          of: find.byType(HomePage),
          matching: find.byType(Scrollable),
        )
        .first;
    final position = tester.state<ScrollableState>(scroll).position;
    final screens =
        (position.maxScrollExtent + position.viewportDimension) /
        position.viewportDimension;
    // Printed so the trend is visible when the page changes.
    // ignore: avoid_print
    print('Home: ${screens.toStringAsFixed(1)} screens at 393 dp');
    expect(screens, lessThanOrEqualTo(6));
  });
}
