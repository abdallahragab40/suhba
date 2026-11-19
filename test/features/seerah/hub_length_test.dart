import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/seerah/presentation/seerah_hub_page.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart' show loadAppFonts;

/// The Seerah hub keeps each block once (review F05, D7): the featured
/// episode is Home's, the map opens full screen, and only the next chapter
/// shows its abstract. Measured with the real fonts on a 393 × 852 dp
/// phone, the review's reference device.
void main() {
  setUpAll(loadAppFonts);

  testApp('the hub is at most eight screens tall at 393 dp', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(393, 852);
    addTearDown(tester.view.reset);
    await AppUnderTest(location: '/seerah').pump(tester);

    final scroll = find
        .descendant(
          of: find.byType(SeerahHubPage),
          matching: find.byType(Scrollable),
        )
        .first;
    final position = tester.state<ScrollableState>(scroll).position;
    final screens =
        (position.maxScrollExtent + position.viewportDimension) /
        position.viewportDimension;
    // Printed so the trend is visible when the page changes.
    // ignore: avoid_print
    print('Seerah hub: ${screens.toStringAsFixed(1)} screens at 393 dp');
    expect(screens, lessThanOrEqualTo(8));
  });
}
