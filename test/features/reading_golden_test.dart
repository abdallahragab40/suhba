@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/shared/content/presentation/reading_body.dart';

import '../helpers/app_harness.dart';
import '../helpers/pump_app.dart';
import '../helpers/specimen_blocks.dart';

void main() {
  setUpAll(loadAppFonts);

  void sized(WidgetTester tester, Size size) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = size;
    addTearDown(tester.view.reset);
  }

  for (final (name, theme) in [
    ('light', AppTheme.light),
    ('dark', AppTheme.dark),
  ]) {
    testApp('reading body, every block type, $name', (tester) async {
      sized(tester, const Size(400, 1500));
      await tester.pumpWidget(
        testHarness(
          theme: theme,
          disableAnimations: true,
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.gutter),
              child: ReadingBody(
                blocks: specimenBlocks,
                provisional: true,
                onCitations: (_, _) {},
              ),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('goldens/reading_body_$name.png'),
      );
    });
  }

  final screens = <(String, String, Brightness, double)>[
    (
      'section_reader',
      '/companions/abu-bakr/sections/abu-bakr.hijrah',
      Brightness.light,
      1,
    ),
    (
      'section_reader',
      '/companions/abu-bakr/sections/abu-bakr.hijrah',
      Brightness.dark,
      1,
    ),
    (
      'section_reader',
      '/companions/abu-bakr/sections/abu-bakr.hijrah',
      Brightness.light,
      2,
    ),
    ('timeline', '/companions/abu-bakr/timeline', Brightness.light, 1),
    ('story', '/stories/the-cave', Brightness.light, 1),
    ('chapter', '/stories/the-cave/chapters/the-cave.2', Brightness.dark, 1),
  ];

  for (final (screen, location, brightness, scale) in screens) {
    testApp('$screen, ${brightness.name}, text scale $scale', (tester) async {
      sized(tester, const Size(400, 900));
      tester.platformDispatcher
        ..platformBrightnessTestValue = brightness
        ..textScaleFactorTestValue = scale;
      addTearDown(() {
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
