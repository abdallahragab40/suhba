import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/design_system/widgets/wordmark.dart';
import 'package:suhba/features/home/presentation/home_page.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';
import '../../helpers/pump_app.dart';

/// How the system text size reaches the design system's text: reading
/// text grows all the way; headings, the wordmark and buttons are held
/// where growing further would break them.
void main() {
  setUpAll(loadAppFonts);

  double scaleOf(WidgetTester tester, Finder text) =>
      tester
          .renderObject<RenderParagraph>(
            find.descendant(of: text, matching: find.byType(RichText)),
          )
          .textScaler
          .scale(10) /
      10;

  Future<void> pump(WidgetTester tester, double scale, Widget child) async {
    await tester.pumpWidget(
      testHarness(
        theme: AppTheme.light,
        textScale: scale,
        disableAnimations: true,
        child: Scaffold(body: child),
      ),
    );
    await tester.pump();
  }

  testWidgets('a section title grows to 1.5× and no further', (tester) async {
    await pump(tester, 1.3, const SectionHeader(title: 'تعرّف على صحابي'));
    expect(scaleOf(tester, find.text('تعرّف على صحابي')), 1.3);

    await pump(tester, 3, const SectionHeader(title: 'تعرّف على صحابي'));
    expect(
      scaleOf(tester, find.text('تعرّف على صحابي')),
      AppTypography.displayMaxScale,
    );
  });

  testWidgets('reading text keeps the full system size', (tester) async {
    await pump(
      tester,
      3,
      Builder(
        builder: (context) =>
            Text('نص للقراءة', style: SuhbaTextStyles.of(context).reading),
      ),
    );
    expect(scaleOf(tester, find.text('نص للقراءة')), 3);
  });

  testWidgets('the wordmark grows to 1.2× and no further', (tester) async {
    await pump(tester, 2, const Wordmark());
    expect(scaleOf(tester, find.byType(Wordmark)), Wordmark.maxScale);
    await pump(tester, 1.1, const Wordmark());
    expect(scaleOf(tester, find.byType(Wordmark)), 1.1);
  });

  testWidgets('a button keeps its height at 1× and grows with the text', (
    tester,
  ) async {
    Widget button() => Center(
      child: FilledButton(onPressed: () {}, child: const Text('التالي')),
    );
    // The pill itself, inside the button's 48 dp tap target.
    final material = find.descendant(
      of: find.byType(FilledButton),
      matching: find.byType(Material),
    );
    await pump(tester, 1, button());
    expect(tester.getSize(material).height, 40);

    await pump(tester, 2, button());
    final pill = tester.getRect(material);
    final label = tester.getRect(find.text('التالي'));
    expect(pill.height, greaterThanOrEqualTo(4 * 14));
    expect(pill.top, lessThanOrEqualTo(label.top));
    expect(pill.bottom, greaterThanOrEqualTo(label.bottom));
  });

  for (final scale in [1.0, 2.0, 3.0]) {
    testApp('on Home at $scale× the wordmark stays in the app bar, below '
        'the status bar', (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(320, 569)
        ..padding = const FakeViewPadding(top: 24);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await AppUnderTest(bundle: MemoryAssetBundle.draftContent()).pump(tester);

      final bar = tester.getRect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.byType(NavigationToolbar),
        ),
      );
      final mark = tester.getRect(find.byType(Wordmark));
      expect(bar.top, 24);
      expect(mark.top, greaterThanOrEqualTo(bar.top));
      expect(mark.bottom, lessThanOrEqualTo(bar.bottom));

      // The ink too: the damma above the ص can stand above the line box.
      final page = await captureImage(tester.element(find.byType(HomePage)));
      final pixels = (await tester.runAsync(page.toByteData))!;
      final ground = pixels.getUint32(0);
      for (var y = 0; y < 24; y++) {
        for (var x = mark.left.floor(); x < mark.right.ceil(); x++) {
          expect(
            pixels.getUint32((y * page.width + x) * 4),
            ground,
            reason: 'ink at ($x, $y), in the status bar',
          );
        }
      }
    });
  }
}
