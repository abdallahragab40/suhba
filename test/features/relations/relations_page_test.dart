import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:suhba/features/relations/presentation/relations_page.dart';
import 'package:suhba/features/sources/presentation/citation_sheet.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';

/// F18: the relationship explorer.
void main() {
  void tall(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 4000);
    addTearDown(tester.view.reset);
  }

  Future<void> reveal(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder.first,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
  }

  testApp('lists each relation under both people, Prophet ﷺ first', (
    tester,
  ) async {
    tall(tester);
    await AppUnderTest(location: '/relations').pump(tester);
    expect(find.byType(RelationsPage), findsOneWidget);
    final firstHeader = tester.widget<Text>(
      find
          .descendant(
            of: find.byWidgetPredicate(
              (w) => w is Semantics && (w.properties.header ?? false),
            ),
            matching: find.byType(Text),
          )
          .first,
    );
    expect(firstHeader.data, 'محمد رسول الله ﷺ');
    // Abu Bakr's daughter, and Aisha's father: one record, both ways.
    await reveal(tester, find.text('أبو بكر الصديق رضي الله عنه'));
    await reveal(tester, find.text('عائشة بنت أبي بكر رضي الله عنها'));
    expect(find.text('الأب'), findsWidgets);
    expect(find.text('من الأبناء'), findsWidgets);
  });

  testApp('the kind filter keeps one group of relations', (tester) async {
    tall(tester);
    await AppUnderTest(location: '/relations').pump(tester);
    await tester.tap(find.widgetWithText(ChoiceChip, 'الزواج'));
    await tester.pumpAndSettle();
    expect(find.text('من الأزواج'), findsWidgets);
    expect(find.text('من الأبناء'), findsNothing);
    expect(find.text('الأب'), findsNothing);

    await tester.tap(find.widgetWithText(ChoiceChip, 'الكل'));
    await tester.pumpAndSettle();
    expect(find.text('من الأبناء'), findsWidgets);
  });

  testApp("one companion's relations, then everyone's", (tester) async {
    tall(tester);
    await AppUnderTest(location: '/relations?companion=zubayr').pump(tester);
    expect(find.text('صلات الزبير بن العوام رضي الله عنه'), findsOneWidget);
    expect(find.text('صفية بنت عبد المطلب رضي الله عنها'), findsOneWidget);
    expect(find.text('الأم'), findsOneWidget);
    expect(find.text('أسماء بنت أبي بكر رضي الله عنها'), findsOneWidget);
    expect(find.text('أبو بكر الصديق رضي الله عنه'), findsNothing);

    await tester.tap(find.text('عرض صلات الجميع'));
    await tester.pumpAndSettle();
    expect(find.textContaining('صلات الزبير'), findsNothing);
    expect(find.text('أبو بكر الصديق رضي الله عنه'), findsWidgets);
  });

  testApp('a person outside the catalog has the reversed relations', (
    tester,
  ) async {
    tall(tester);
    await AppUnderTest(
      location: '/relations?person=safiyyah-bint-abd-al-muttalib',
    ).pump(tester);
    expect(find.text('الزبير بن العوام رضي الله عنه'), findsOneWidget);
    expect(find.text('من الأبناء'), findsOneWidget);
  });

  testApp('a row shows its sources; a companion opens the profile', (
    tester,
  ) async {
    tall(tester);
    final app = AppUnderTest(location: '/relations?companion=zubayr');
    await app.pump(tester);
    final row = find.ancestor(
      of: find.text('صفية بنت عبد المطلب رضي الله عنها'),
      matching: find.byType(Row),
    );
    await tester.tap(
      find.descendant(of: row, matching: find.byType(CitationMarker)),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CitationSheet), findsOneWidget);
    expect(find.textContaining('الإصابة'), findsWidgets);
    Navigator.of(tester.element(find.byType(CitationSheet))).pop();
    await tester.pumpAndSettle();

    // The heading names the companion and opens the profile.
    await tester.tap(find.text('الزبير بن العوام رضي الله عنه'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
    expect(app.location, '/companions/zubayr');
  });

  testApp('Explore and the profile lead to the explorer', (tester) async {
    tall(tester);
    final app = AppUnderTest(location: '/explore');
    await app.pump(tester);
    await reveal(tester, find.text('الصلات والأنساب'));
    await tester.tap(find.text('الصلات والأنساب'));
    await tester.pumpAndSettle();
    expect(find.byType(RelationsPage), findsOneWidget);
    expect(app.location, '/relations');

    app.router.go('/companions/zubayr');
    await tester.pumpAndSettle();
    await reveal(tester, find.text('كل صلاته في مستكشف الصلات'));
    await tester.tap(find.text('كل صلاته في مستكشف الصلات'));
    await tester.pumpAndSettle();
    expect(app.location, '/relations?companion=zubayr');
  });

  testApp('a file that fails to load is reported, not hidden', (tester) async {
    tall(tester);
    final bundle = MemoryAssetBundle.builtContent()
      ..files.remove('assets/content/companions/umar.json');
    await AppUnderTest(location: '/relations', bundle: bundle).pump(tester);
    expect(
      find.text('تعذّر تحميل بعض الملفات، فقد تكون هذه القائمة ناقصة.'),
      findsOneWidget,
    );
    expect(find.text('إعادة المحاولة'), findsOneWidget);
    // Umar's own record is missing, so his daughter is not listed under
    // him, but other relations still are.
    expect(find.text('حفصة أم المؤمنين'), findsNothing);
    expect(find.text('أبو بكر الصديق رضي الله عنه'), findsWidgets);
  });
}
