import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/features/biography/presentation/section_reader_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:siyar_sahaba/features/stories/presentation/chapter_page.dart';

import '../../helpers/app_harness.dart';

void main() {
  Future<AppUnderTest> open(WidgetTester tester) async {
    final app = AppUnderTest(location: '/search');
    await app.pump(tester);
    return app;
  }

  /// A result whose title is [title] (not one that only mentions it).
  Finder result(String title) => find.byWidgetPredicate(
    (w) => w is ListTile && w.title is Text && (w.title! as Text).data == title,
  );

  /// A group heading among the results (not the filter chip of that name).
  Finder heading(String text) =>
      find.descendant(of: find.byType(ListView), matching: find.text(text));

  Future<void> type(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(TextField), text);
    await tester.pump(const Duration(milliseconds: 200)); // debounce
    await tester.pumpAndSettle();
  }

  testApp('before typing, a hint', (tester) async {
    await open(tester);
    expect(find.textContaining('ابحث في أسماء الصحابة'), findsOneWidget);
  });

  testApp('finds a companion without hamza or tashkeel', (tester) async {
    await open(tester);
    await type(tester, 'ابو بكر');
    expect(heading('الصحابة'), findsOneWidget);
    expect(result('أبو بكر الصديق'), findsOneWidget);
  });

  testApp('finds by title and opens the profile', (tester) async {
    final app = await open(tester);
    await type(tester, 'الفاروق');
    await tester.tap(result('عمر بن الخطاب'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
    expect(app.location, '/companions/umar');
  });

  testApp('finds biography sections by heading', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(800, 4000);
    addTearDown(tester.view.reset);
    await open(tester);
    await type(tester, 'الهجره');
    expect(heading('أقسام السيرة'), findsOneWidget);
    await tester.tap(result('صاحبه في الهجرة'));
    await tester.pumpAndSettle();
    expect(find.byType(SectionReaderPage), findsOneWidget);
  });

  testApp('finds story chapters', (tester) async {
    await open(tester);
    await type(tester, 'في الغار');
    await tester.tap(result('في الغار'));
    await tester.pumpAndSettle();
    expect(find.byType(ChapterPage), findsOneWidget);
  });

  testApp('says so when nothing matches', (tester) async {
    await open(tester);
    await type(tester, 'خالد بن سعيد');
    expect(find.text('لا نتائج لـ «خالد بن سعيد»'), findsOneWidget);
  });

  testApp('reopening search keeps the last query and its results', (
    tester,
  ) async {
    final app = await open(tester);
    await type(tester, 'الفاروق');
    await tester.tap(result('عمر بن الخطاب'));
    await tester.pumpAndSettle();
    expect(app.location, '/companions/umar');

    // Back goes through the Companions tab, as for any profile.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(app.location, '/companions');

    await tester.tap(find.byTooltip('بحث'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextField, 'الفاروق'), findsOneWidget);
    expect(result('عمر بن الخطاب'), findsOneWidget);
  });

  testApp('remembers queries that led somewhere (in memory)', (tester) async {
    await open(tester);
    await type(tester, 'الفاروق');
    await tester.tap(result('عمر بن الخطاب'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute(); // back to the directory
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('بحث'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('مسح'));
    await tester.pumpAndSettle();
    expect(find.text('عمليات بحث سابقة'), findsOneWidget);
    expect(result('الفاروق'), findsOneWidget);
  });
}
