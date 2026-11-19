import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/companions/presentation/directory/directory_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_hub_page.dart';

import '../helpers/app_harness.dart';

/// Every empty state offers one useful next step (review F20, D10).
void main() {
  Future<void> type(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(TextField), text);
    await tester.pump(const Duration(milliseconds: 200)); // debounce
    await tester.pumpAndSettle();
  }

  testApp('an empty library starts the Seerah', (tester) async {
    final app = AppUnderTest(location: '/saved');
    await app.pump(tester);
    await tester.tap(find.text('ابدأ السيرة'));
    await tester.pumpAndSettle();
    expect(find.byType(SeerahHubPage), findsOneWidget);
  });

  testApp('search suggests queries, and each one finds something', (
    tester,
  ) async {
    await AppUnderTest(location: '/search').pump(tester);
    final chips = tester
        .widgetList<ActionChip>(find.byType(ActionChip))
        .map((c) => (c.label as Text).data!)
        .toList();
    expect(chips, hasLength(4));
    for (final q in chips) {
      await type(tester, q);
      expect(find.byIcon(Icons.search_off), findsNothing, reason: q);
      await type(tester, '');
    }
    await tester.tap(find.widgetWithText(ActionChip, chips.first));
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      chips.first,
    );
  });

  testApp('no results: a tip and a way to the directory', (tester) async {
    await AppUnderTest(location: '/search').pump(tester);
    await type(tester, 'زززز');
    expect(
      find.text('جرّب كلمة واحدة، أو الاسم دون لقب أو كنية.'),
      findsOneWidget,
    );
    await tester.tap(find.text('تصفّح الصحابة'));
    await tester.pumpAndSettle();
    expect(find.byType(DirectoryPage), findsOneWidget);
  });
}
