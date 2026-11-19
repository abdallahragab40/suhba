import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/biography/presentation/section_reader_page.dart';

import '../../helpers/app_harness.dart';

/// E7 (review C3): a lesson points back to the passage it is drawn from.
void main() {
  testApp('a lesson opens the passage it rests on', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 6000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(
      location: '/companions/abu-bakr/sections/abu-bakr.lessons',
    );
    await app.pump(tester);
    final link = find.text('مبنيّ على: خلافته');
    expect(link, findsWidgets);
    expect(find.semantics.byLabel('مبنيّ على: خلافته'), findsWidgets);
    await tester.ensureVisible(link.first);
    await tester.tap(link.first);
    await tester.pumpAndSettle();
    expect(app.location, '/companions/abu-bakr/sections/abu-bakr.caliphate');
    expect(find.byType(SectionReaderPage), findsOneWidget);
  });
}
