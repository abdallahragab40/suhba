import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/widgets/companion_row.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart' show loadAppFonts;

/// The directory is for scanning (review F07): compact rows, grouped by
/// category, each saying how deep its biography goes. Real fonts, 393 dp.
void main() {
  setUpAll(loadAppFonts);

  Future<void> open(WidgetTester tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(393, 852);
    addTearDown(tester.view.reset);
    await AppUnderTest(location: '/companions').pump(tester);
  }

  testApp('at least five companions on the first screen', (tester) async {
    await open(tester);
    final viewport = tester.getRect(find.byType(Scrollable).first);
    final visible = [
      for (final e in find.byType(CompanionRow).evaluate())
        if (tester.getRect(find.byWidget(e.widget)).bottom <= viewport.bottom)
          e,
    ].length;
    expect(visible, greaterThanOrEqualTo(5));
  });

  testApp('every row states its depth; the Ten are full', (tester) async {
    await open(tester);
    final scrollable = find.byType(Scrollable).first;
    final seen = <String, String?>{};
    for (var i = 0; i < 40; i++) {
      for (final e in find.byType(CompanionRow).evaluate()) {
        final row = e.widget as CompanionRow;
        seen[row.name] = row.depth;
      }
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pumpAndSettle();
    }
    expect(seen, hasLength(47));
    expect(seen.values.where((d) => d == 'سيرة كاملة'), hasLength(10));
    expect(seen.values.where((d) => d == 'تعريف موجز'), hasLength(37));
    expect(seen['أبو بكر الصديق'], 'سيرة كاملة');
  });

  testApp('one status note for the list, a compact mark per row', (
    tester,
  ) async {
    await open(tester);
    expect(find.byType(ListStatusNote), findsOneWidget);
    // No full pill in the list: rows carry the icon-only mark.
    final badges = tester.widgetList<DraftBadge>(find.byType(DraftBadge));
    expect(badges, isNotEmpty);
    expect(badges.where((b) => !b.isMark), isEmpty);
  });
}
