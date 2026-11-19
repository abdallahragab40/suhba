import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/shared/content/presentation/reading_body.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart' show loadAppFonts;

/// How much of a passage fits on one screen (review findings F03, F10).
/// The same text in less height is more words per screen. Measured with the
/// real fonts at 393 dp, the review's reference width.
///
/// Baselines are the heights before the D1 change (2026-11-19, content
/// 0.3.0). The review's target was 30% more words per screen; D1 reaches
/// 22% (Seerah chapter 1) and 25% (Abu Bakr's Hijrah). The rest is not
/// chrome: about a third of chapter 1 is framed blocks (a Qur'an quote, a
/// hadith, a dispute, a lesson), and an inline source mark sometimes takes
/// a line of its own, the price of attaching it to its paragraph. The gains
/// are pinned so they cannot regress.
void main() {
  setUpAll(loadAppFonts);

  for (final (route, baseline, gain) in [
    ('/seerah/chapters/makkah-lineage-birth', 4366.0, 1.22),
    ('/companions/abu-bakr/sections/abu-bakr.hijrah', 2653.0, 1.25),
  ]) {
    testApp('reading density: $route', (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(393, 852);
      addTearDown(tester.view.reset);
      await AppUnderTest(location: route).pump(tester);
      final height = tester.getSize(find.byType(ReadingBody).first).height;
      // ignore: avoid_print
      print('DENSITY $route ${height.toStringAsFixed(0)}');
      expect(height, lessThanOrEqualTo(baseline / gain));
    });
  }
}
