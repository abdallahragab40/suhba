import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/widgets/draft_banner.dart';
import 'package:suhba/features/atlas/presentation/event_page.dart';
import 'package:suhba/features/companions/presentation/directory/directory_page.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:suhba/features/search/presentation/search_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_chapter_page.dart';
import 'package:suhba/features/stories/presentation/story_page.dart';

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

  /// Scrolls Home until [finder] is built and on screen.
  Future<void> reveal(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    // Mid-screen, clear of the navigation bar.
    await Scrollable.ensureVisible(
      tester.element(finder.first),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
  }

  testApp('opens on the Seerah, with a way to begin it', (tester) async {
    await open(tester);
    expect(find.text('محمد رسول الله ﷺ'), findsOneWidget);
    expect(find.byType(DraftBanner), findsOneWidget);
    await tester.tap(find.text('ابدأ السيرة'));
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage), findsOneWidget);
    expect(find.text('مكة والنسب والمولد'), findsWidgets);
  });

  testApp('the Prophet ﷺ is never the companion of the day', (tester) async {
    // Every day of a year: the companion section only ever names a
    // Companion from the catalogue.
    for (var day = 0; day < 10; day++) {
      await open(tester, now: DateTime(2026, 10, 9 + day));
      await reveal(tester, find.text('صحابي اليوم'));
      expect(find.text('اقرأ السيرة'), findsOneWidget);
    }
  });

  testApp('in Ramadan, shows what the sources date to Ramadan', (tester) async {
    // 20 February 2026 is 3 Ramadan 1447 by Umm al-Qura.
    await open(tester, now: DateTime(2026, 2, 20));
    await reveal(tester, find.text('في رمضان من السيرة'));
    expect(
      find.textContaining('٣ رمضان ١٤٤٧ هـ بتقويم أم القرى'),
      findsOneWidget,
    );
    // Earliest first.
    final badr = tester.getTopLeft(find.text('غزوة بدر').first).dy;
    final conquest = tester.getTopLeft(find.text('فتح مكة').first).dy;
    expect(badr, lessThan(conquest));
    await tester.tap(find.text('غزوة بدر').first);
    await tester.pumpAndSettle();
    expect(find.byType(EventPage), findsOneWidget);
  });

  testApp('a month the sources date nothing to has no such section', (
    tester,
  ) async {
    // 9 October 2026 is in Rabi al-Akhir, when no event is dated.
    await open(tester);
    await reveal(tester, find.text('صحابي اليوم'));
    expect(find.text('هذا الشهر'), findsNothing);
  });

  testApp('features the companion of the day', (tester) async {
    // 9 October 2026 is day 20735 since 1970; 20735 % 47 = 8 → Sa'id ibn
    // Zayd.
    await open(tester);
    await reveal(tester, find.text('صحابي اليوم'));
    expect(find.text('صحابي اليوم'), findsOneWidget);
    expect(find.text('سعيد بن زيد'), findsOneWidget);
  });

  testApp('the next day features someone else', (tester) async {
    await open(tester, now: DateTime(2026, 10, 10));
    await reveal(tester, find.text('صحابي اليوم'));
    expect(find.text('أبو عبيدة بن الجراح'), findsOneWidget);
    expect(find.text('سعيد بن زيد'), findsNothing);
  });

  testApp('"read the biography" opens the featured profile', (tester) async {
    await open(tester, now: DateTime(2026, 10)); // Abu Bakr's day
    await reveal(tester, find.text('اقرأ السيرة'));
    // A real passage from his biography, not only a label.
    expect(find.textContaining('عبد الله بن عثمان بن عامر'), findsWidgets);
    await tester.tap(find.text('اقرأ السيرة'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
    expect(find.text('أبو بكر الصديق'), findsOneWidget);
  });

  testApp('categories show their sizes and open the directory', (tester) async {
    final app = await open(tester);
    await reveal(tester, find.text('الخلفاء الراشدون'));
    expect(find.text('١٠ صحابة'), findsOneWidget); // the Ten
    expect(find.text('٤ صحابة'), findsWidgets); // the caliphs
    await tester.tap(find.text('الخلفاء الراشدون'));
    await tester.pumpAndSettle();
    expect(find.byType(DirectoryPage), findsOneWidget);
    expect(app.location, '/companions?category=khulafa-rashidun');
  });

  testApp('stories open from home', (tester) async {
    await open(tester);
    await reveal(tester, find.text('ثاني اثنين'));
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
