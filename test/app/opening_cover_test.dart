import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/opening/opening_cover.dart';
import 'package:suhba/core/design_system/widgets/brand_loader.dart';
import 'package:suhba/core/design_system/widgets/brand_mark.dart';
import 'package:suhba/features/home/presentation/home_page.dart';
import 'package:suhba/shared/content/domain/content_manifest.dart';
import 'package:suhba/shared/content/providers.dart';

import '../helpers/app_harness.dart';
import '../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);

  AppUnderTest app() => AppUnderTest(openingCover: true);

  testApp('the opening screen shows the mark until Home has loaded', (
    tester,
  ) async {
    await tester.pumpWidget(app().widget);
    expect(find.byType(BrandMark), findsOneWidget);
    final mark = tester.getRect(find.byType(BrandMark));
    // Where Android 12+ draws its launch icon: 160 dp, in the centre.
    expect(mark.size, const Size.square(openingMarkSize));
    expect(mark.center, tester.getRect(find.byType(OpeningCover)).center);

    await tester.pumpAndSettle();
    expect(find.byType(BrandMark), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testApp('a slow start shows the gold line, then lifts anyway', (
    tester,
  ) async {
    final never = Completer<ContentManifest>();
    await tester.pumpWidget(
      AppUnderTest(
        openingCover: true,
        overrides: [
          contentManifestProvider.overrideWith((ref) => never.future),
        ],
      ).widget,
    );
    expect(find.byType(BrandLoader), findsNothing);
    await tester.pump(OpeningCover.lineDelay);
    await tester.pump();
    expect(find.byType(BrandLoader), findsOneWidget);
    // Still loading at the limit: the cover lifts onto Home's placeholders.
    await tester.pump(OpeningCover.maximum);
    for (var i = 0; i < 3; i++) {
      await tester.pump(OpeningCover.fade);
    }
    expect(find.byType(BrandMark), findsNothing);
  });

  testApp('with less motion the cover lifts at once and shows no line', (
    tester,
  ) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(app().widget);
    await tester.pump(OpeningCover.lineDelay);
    expect(find.byType(BrandLoader), findsNothing);
    await tester.pumpAndSettle();
    expect(find.byType(BrandMark), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testApp('Home keeps its state when the cover lifts', (tester) async {
    await tester.pumpWidget(app().widget);
    final before = tester.state(find.byType(Navigator).first);
    await tester.pumpAndSettle();
    expect(tester.state(find.byType(Navigator).first), same(before));
  });
}
