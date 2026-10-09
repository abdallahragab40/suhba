import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/features/biography/presentation/section_reader_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/presentation/reader_scaffold.dart';

import '../../helpers/app_harness.dart';

void main() {
  Future<AppUnderTest> open(WidgetTester tester, String path) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 4000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: path);
    await app.pump(tester);
    return app;
  }

  testApp('the Hijrah section: title, blocks, draft label, sources', (
    tester,
  ) async {
    await open(tester, '/companions/abu-bakr/sections/abu-bakr.hijrah');
    expect(find.text('صاحبه في الهجرة'), findsOneWidget);
    expect(find.text('٠٣'), findsOneWidget); // third section
    expect(find.byType(DraftBadge), findsOneWidget);
    expect(find.text('قال الله تعالى — التوبة: ٤٠'), findsOneWidget);
    expect(find.text('النص بانتظار نقله من المصدر المعتمد.'), findsOneWidget);
    expect(find.text('مصادر هذا القسم'), findsOneWidget);
    expect(find.textContaining('الجامع الصحيح (صحيح البخاري)'), findsOneWidget);
    expect(find.byType(ReadingProgressBar), findsOneWidget);
  });

  testApp('next and previous replace the page', (tester) async {
    final app = await open(
      tester,
      '/companions/abu-bakr/sections/abu-bakr.hijrah',
    );
    await tester.tap(find.text('فضائله'));
    await tester.pumpAndSettle();
    expect(app.location, '/companions/abu-bakr/sections/abu-bakr.virtues');

    await tester.tap(find.text('صاحبه في الهجرة'));
    await tester.pumpAndSettle();
    expect(app.location, '/companions/abu-bakr/sections/abu-bakr.hijrah');

    // Replacing (not pushing) keeps back pointing at the profile.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
  });

  testApp('the first section has no previous; the last no next', (
    tester,
  ) async {
    await open(tester, '/companions/abu-bakr/sections/abu-bakr.early-life');
    expect(find.text('القسم السابق'), findsNothing);
    expect(find.text('القسم التالي'), findsOneWidget);
  });

  testApp('the passage marker opens all of its sources', (tester) async {
    await open(tester, '/companions/abu-bakr/sections/abu-bakr.death');
    await tester.tap(find.byType(CitationMarker).last);
    await tester.pumpAndSettle();
    expect(find.byType(CitationSheet), findsOneWidget);
    expect(find.text('الإصابة في تمييز الصحابة'), findsWidgets);
  });

  testApp('the profile opens sections from its index', (tester) async {
    final app = await open(tester, '/companions/umar');
    await tester.tap(find.text('خلافته'));
    await tester.pumpAndSettle();
    expect(find.byType(SectionReaderPage), findsOneWidget);
    expect(app.location, '/companions/umar/sections/umar.caliphate');
  });

  testApp('an unknown section is reported, not crashed on', (tester) async {
    await open(tester, '/companions/abu-bakr/sections/abu-bakr.nope');
    expect(find.text('لم نجد هذا القسم.'), findsOneWidget);
  });

  testApp('no overflow at text scale 2.0', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await open(tester, '/companions/abu-bakr/sections/abu-bakr.virtues');
    expect(tester.takeException(), isNull);
  });
}
