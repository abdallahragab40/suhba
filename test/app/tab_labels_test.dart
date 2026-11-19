import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_harness.dart';
import '../helpers/pump_app.dart' show loadAppFonts;

/// Five destination labels share a phone's width. Each must stay on one
/// line on a small phone and with large system text (review finding F01).
void main() {
  // Real Cairo glyphs: the test font's square glyphs are far wider.
  setUpAll(loadAppFonts);

  for (final (width, scale) in [(320.0, 1.0), (393.0, 2.0), (320.0, 2.0)]) {
    testApp('tab labels stay on one line at $width dp and ${scale}x text', (
      tester,
    ) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = Size(width, 720);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await AppUnderTest().pump(tester);
      double height(String label) => tester
          .getSize(
            find.descendant(
              of: find.byType(NavigationBar),
              matching: find.text(label),
            ),
          )
          .height;
      // «السيرة» is short enough never to wrap: every label matches it.
      final oneLine = height('السيرة');
      for (final label in ['الرئيسية', 'الصحابة', 'استكشف', 'مكتبتي']) {
        expect(height(label), oneLine, reason: label);
      }
    });
  }
}
