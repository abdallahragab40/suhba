@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/gallery/typography_specimen.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);

  for (final (themeName, theme) in [
    ('light', AppTheme.light),
    ('dark', AppTheme.dark),
  ]) {
    for (final (scale, height) in [(1.0, 1600.0), (2.0, 3200.0)]) {
      testWidgets('typography specimen, $themeName, text scale $scale', (
        tester,
      ) async {
        tester.view
          ..devicePixelRatio = 1
          ..physicalSize = Size(400, height);
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          testHarness(
            theme: theme,
            textScale: scale,
            child: const Scaffold(
              body: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacing.gutter),
                child: TypographySpecimen(),
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile(
            'goldens/typography_specimen_${themeName}_x$scale.png',
          ),
        );
      });
    }
  }
}
