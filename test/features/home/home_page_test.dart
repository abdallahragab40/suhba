import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_banner.dart';
import 'package:siyar_sahaba/features/companions/presentation/directory/directory_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:siyar_sahaba/features/search/presentation/search_page.dart';
import 'package:siyar_sahaba/features/stories/presentation/story_page.dart';

import '../../helpers/app_harness.dart';

void main() {
  Future<AppUnderTest> open(WidgetTester tester, {DateTime? now}) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(now: now);
    await app.pump(tester);
    return app;
  }

  testApp('features the companion of the day', (tester) async {
    // 9 October 2026 is day 20735 since 1970; 20735 % 10 = 5 → al-Zubayr.
    await open(tester);
    expect(find.text('صحابي اليوم'), findsOneWidget);
    expect(find.text('الزبير بن العوام'), findsOneWidget);
    expect(find.byType(DraftBanner), findsOneWidget);
  });

  testApp('the next day features someone else', (tester) async {
    await open(tester, now: DateTime(2026, 10, 10));
    expect(find.text('عبد الرحمن بن عوف'), findsOneWidget);
    expect(find.text('الزبير بن العوام'), findsNothing);
  });

  testApp('"read the biography" opens the featured profile', (tester) async {
    await open(tester, now: DateTime(2026, 10, 4)); // Abu Bakr's day
    await tester.tap(find.text('اقرأ السيرة'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
    expect(find.text('أبو بكر الصديق'), findsOneWidget);
  });

  testApp('categories show their sizes and open the directory', (tester) async {
    final app = await open(tester);
    expect(find.text('١٠ صحابة'), findsNWidgets(2)); // the Ten, Muhajirun
    expect(find.text('٤ صحابة'), findsOneWidget); // the caliphs
    await tester.tap(find.text('الخلفاء الراشدون'));
    await tester.pumpAndSettle();
    expect(find.byType(DirectoryPage), findsOneWidget);
    expect(app.location, '/companions?category=khulafa-rashidun');
  });

  testApp('stories open from home', (tester) async {
    await open(tester);
    await tester.tap(find.text('ثاني اثنين'));
    await tester.pumpAndSettle();
    expect(find.byType(StoryPage), findsOneWidget);
  });

  testApp('search opens from the app bar, above the tabs', (tester) async {
    await open(tester);
    await tester.tap(find.byTooltip('بحث'));
    await tester.pumpAndSettle();
    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
