@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/gallery/core_widgets_specimen.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);

  for (final (themeName, theme) in [
    ('light', AppTheme.light),
    ('dark', AppTheme.dark),
  ]) {
    for (final (scale, height) in [(1.0, 1500.0), (2.0, 2800.0)]) {
      testWidgets('core widgets, $themeName, text scale $scale', (
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
            disableAnimations: true,
            child: const Scaffold(
              body: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacing.gutter),
                child: CoreWidgetsSpecimen(),
              ),
            ),
          ),
        );
        await tester.pump();

        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile('goldens/core_widgets_${themeName}_x$scale.png'),
        );
      });
    }
  }
}
