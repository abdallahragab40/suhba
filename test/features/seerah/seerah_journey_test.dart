import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/features/atlas/presentation/event_page.dart';
import 'package:siyar_sahaba/features/atlas/presentation/place_page.dart';
import 'package:siyar_sahaba/features/atlas/presentation/visual_page.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/saved_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/features/seerah/presentation/seerah_chapter_page.dart';
import 'package:siyar_sahaba/features/seerah/presentation/seerah_hub_page.dart';
import 'package:siyar_sahaba/features/seerah/presentation/seerah_topic_page.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/domain/content_target.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';
import 'package:siyar_sahaba/shared/content/domain/seerah.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/infographic_view.dart';

import '../../helpers/app_harness.dart';

/// Revision 4 (R4.4): the first complete reading journey, and the Seerah
/// section around it.
void main() {
  void tall(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
  }

  Future<void> reveal(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await Scrollable.ensureVisible(
      tester.element(finder.first),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
  }

  const hijrah = '/seerah/chapters/hijrah-to-madinah';

  testApp('the hub: opening, periods, twelve chapters, essays', (tester) async {
    tall(tester);
    await AppUnderTest(location: '/seerah').pump(tester);
    expect(find.byType(SeerahHubPage), findsOneWidget);
    expect(find.text('محمد رسول الله ﷺ'), findsOneWidget);
    expect(find.text('ابدأ السيرة'), findsOneWidget);
    for (final period in ['قبل البعثة', 'العهد المكي', 'العهد المدني']) {
      await reveal(tester, find.text(period));
      expect(find.text(period), findsOneWidget, reason: period);
    }
    expect(find.byType(ChapterJourneyTile), findsNWidgets(12));
    await reveal(tester, find.text('رحمته ﷺ'));
    expect(find.text('رحمته ﷺ'), findsOneWidget);
  });

  testApp('the Prophet ﷺ is not a companion entry', (tester) async {
    final app = AppUnderTest();
    final companions = await app.container.read(companionIndexProvider.future);
    expect(companions.map((c) => c.id), isNot(contains('muhammad')));
    expect(companions, hasLength(10));
    final people = await app.container.read(peopleProvider.future);
    expect(people['muhammad'], isNotNull, reason: 'a referenced person');
  });

  testApp('the journey: Seerah → Hijrah chapter → visual → citation → '
      'Abu Bakr → save → resume', (tester) async {
    tall(tester);
    final app = AppUnderTest(location: '/seerah');
    await app.pump(tester);

    // Into the Hijrah chapter from the journey.
    await reveal(tester, find.text('الهجرة إلى المدينة'));
    await tester.tap(find.text('الهجرة إلى المدينة'));
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage), findsOneWidget);
    expect(app.location, hijrah);
    expect(find.textContaining('الفصل ٨ من ١٢'), findsOneWidget);
    expect(find.text('ثلاث ليال في غار ثور'), findsOneWidget);
    // Both visuals of the chapter are inline, sourced, and labelled draft.
    expect(find.byType(InfographicView), findsNWidgets(2));
    expect(find.text('الهجرة خطوة بخطوة'), findsOneWidget);

    // The route opens in full and has an equivalent list.
    await reveal(tester, find.text('عرض كامل').last);
    await tester.tap(find.text('عرض كامل').last);
    await tester.pumpAndSettle();
    expect(find.byType(VisualPage), findsOneWidget);
    expect(find.text('طريق الهجرة: المحطات المعروفة'), findsOneWidget);
    await tester.tap(find.text('قائمة'));
    await tester.pumpAndSettle();
    expect(find.text('من مكة إلى غار ثور'), findsOneWidget);
    expect(find.text('من غار ثور إلى قباء'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage), findsOneWidget);

    // A claim's sources.
    await reveal(tester, find.text('مصادر هذا القسم'));
    await tester.tap(find.byType(CitationMarker).last);
    await tester.pumpAndSettle();
    expect(find.byType(CitationSheet), findsOneWidget);
    await tester.tapAt(const Offset(300, 40));
    await tester.pumpAndSettle();

    // On to the linked biography, and back.
    await reveal(tester, find.byType(ActionChip).last);
    await tester.tap(find.widgetWithText(ActionChip, 'أبو بكر الصديق'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage), findsOneWidget);

    // Save the chapter: it is listed under the Seerah in Saved.
    await tester.tap(find.byTooltip('حفظ'));
    await tester.pumpAndSettle();
    app.router.go('/saved');
    await tester.pumpAndSettle();
    expect(find.byType(SavedPage), findsOneWidget);
    expect(find.text('من فصول السيرة'), findsOneWidget);
    await tester.tap(find.text('الهجرة إلى المدينة'));
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage), findsOneWidget);
  }, timeout: const Timeout(Duration(minutes: 2)));

  testApp('reading a chapter is resumed from the hub and Home', (tester) async {
    tall(tester);
    final app = AppUnderTest(location: '/seerah');
    await app.container
        .read(readingProgressRepositoryProvider)
        .save(
          ReadingProgress(
            target: ProgressTarget.seerahChapter,
            targetId: 'hijrah-to-madinah',
            parentId: seerahParentId,
            fraction: 0.4,
            completed: false,
            contentVersion: '0.2.0',
            updatedAt: DateTime(2026, 10, 9),
          ),
        );
    await app.pump(tester);
    expect(find.text('تابع: الهجرة إلى المدينة'), findsOneWidget);

    app.router.go('/home');
    await tester.pumpAndSettle();
    expect(find.text('تابع: الهجرة إلى المدينة'), findsOneWidget);
    // Continue reading names the Seerah as its source.
    await reveal(tester, find.text('السيرة النبوية').last);
    expect(find.text('قُرئ ٤٠٪'), findsOneWidget);

    await tester.tap(find.text('تابع: الهجرة إلى المدينة'));
    await tester.pumpAndSettle();
    expect(app.location, hijrah);
  });

  test('where the Seerah resumes', () {
    SeerahChapterSummary chapter(String id) => SeerahChapterSummary(
      id: id,
      number: 1,
      title: LocalizedText(ar: id),
      abstract: const LocalizedText(ar: '-'),
      era: SeerahEra.makkan,
      date: const HistoricalDate.unknown(),
      review: const ReviewInfo(status: ReviewStatus.draft),
      wordCount: 1,
    );
    ReadingProgress p(String id, {bool done = false, int day = 1}) =>
        ReadingProgress(
          target: ProgressTarget.seerahChapter,
          targetId: id,
          parentId: seerahParentId,
          fraction: done ? 1 : 0.5,
          completed: done,
          contentVersion: '1',
          updatedAt: DateTime(2026, 1, day),
        );
    final chapters = [chapter('a'), chapter('b'), chapter('c')];
    expect(seerahResumeChapter(chapters, {}), isNull, reason: 'start');
    expect(
      seerahResumeChapter(chapters, {'a': p('a'), 'c': p('c', day: 3)})?.id,
      'c',
      reason: 'the most recent unfinished',
    );
    expect(
      seerahResumeChapter(chapters, {'a': p('a', done: true)})?.id,
      'b',
      reason: 'the first not yet finished',
    );
    expect(
      seerahResumeChapter(chapters, {
        for (final id in ['a', 'b', 'c']) id: p(id, done: true),
      }),
      isNull,
      reason: 'all finished',
    );
  });

  testApp('essays read in order, with their chapters', (tester) async {
    tall(tester);
    final app = AppUnderTest(location: '/seerah/topics/mercy');
    await app.pump(tester);
    expect(find.byType(SeerahTopicPage), findsOneWidget);
    expect(find.text('موضوع ١ من ٨'), findsOneWidget);
    // The editor says this is a short pilot, not the full essay.
    expect(
      find.text('هذا نص تجريبي مختصر، ولم يُكتب بالتفصيل المقصود بعد.'),
      findsOneWidget,
    );
    await reveal(tester, find.text('الموضوع التالي'));
    await tester.tap(find.text('الموضوع التالي'));
    await tester.pumpAndSettle();
    expect(app.location, '/seerah/topics/trustworthiness');
  });

  testApp('an event: context, outcome, people, places and chapters', (
    tester,
  ) async {
    tall(tester);
    final app = AppUnderTest(location: '/events/hijrah');
    await app.pump(tester);
    expect(find.byType(EventPage), findsOneWidget);
    expect(find.text('الهجرة النبوية'), findsOneWidget);
    expect(find.text('ما قبله'), findsOneWidget);
    expect(find.text('ما بعده'), findsOneWidget);
    // A person outside the catalogue is named, not linked.
    expect(find.text('عامر بن فهيرة'), findsOneWidget);
    await reveal(tester, find.text('الهجرة إلى المدينة'));
    await tester.tap(find.text('الهجرة إلى المدينة'));
    await tester.pumpAndSettle();
    expect(app.location, hijrah);
  });

  testApp('a place: scene, precision, events and visuals', (tester) async {
    tall(tester);
    await AppUnderTest(location: '/places/ghar-thawr').pump(tester);
    expect(find.byType(PlacePage), findsOneWidget);
    expect(find.text('رسم توضيحي'), findsOneWidget);
    expect(find.text('موضع معروف'), findsWidgets);
    await reveal(tester, find.text('طريق الهجرة: المحطات المعروفة'));
    expect(find.text('الهجرة النبوية'), findsOneWidget);
  });

  testApp('Explore filters by kind', (tester) async {
    tall(tester);
    await AppUnderTest(location: '/explore').pump(tester);
    expect(find.text('سجل الأحداث'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'الأماكن'));
    await tester.pumpAndSettle();
    expect(find.text('سجل الأحداث'), findsNothing);
    expect(find.text('غار حراء'), findsOneWidget);
    // An undated event is listed apart, never placed on a guessed date.
    await tester.tap(find.widgetWithText(ChoiceChip, 'الأحداث'));
    await tester.pumpAndSettle();
    await reveal(tester, find.text('الإسراء والمعراج'));
    expect(find.text('بلا تاريخ محدد'), findsOneWidget);
  });

  testApp('search finds Seerah prose, events and places', (tester) async {
    tall(tester);
    final app = AppUnderTest(location: '/search');
    await app.pump(tester);
    await tester.enterText(find.byType(TextField), 'سراقة');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();
    expect(find.text('فصول السيرة النبوية'), findsOneWidget);
    expect(find.text('الهجرة إلى المدينة'), findsWidgets);

    await tester.enterText(find.byType(TextField), 'الحديبية');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();
    expect(find.text('أحداث'), findsOneWidget);
    expect(find.text('أماكن'), findsOneWidget);
    await tester.tap(find.text('صلح الحديبية'));
    await tester.pumpAndSettle();
    expect(find.byType(EventPage), findsOneWidget);
  });

  testApp('a relationship visual reads in both directions as a list', (
    tester,
  ) async {
    tall(tester);
    await AppUnderTest(location: '/visuals/abu-bakr-family').pump(tester);
    await tester.tap(find.text('قائمة'));
    await tester.pumpAndSettle();
    expect(find.text('من الأبناء · أبو بكر الصديق'), findsNWidgets(3));
    expect(find.text('صاحبه · محمد رسول الله ﷺ'), findsOneWidget);
  });

  testApp(
    'every bundled visual renders as chart and as list',
    (tester) async {
      tall(tester);
      final app = AppUnderTest();
      final visuals = await app.container.read(visualsProvider.future);
      expect(visuals.length, greaterThanOrEqualTo(10));
      for (final id in visuals.keys) {
        final a = AppUnderTest(location: '/visuals/$id');
        await a.pump(tester);
        expect(tester.takeException(), isNull, reason: id);
        await tester.tap(find.text('قائمة'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '$id (list)');
        expect(find.byType(ListTile), findsWidgets, reason: id);
      }
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test('a chapter target resolves and describes itself', () {
    expect(const ContentTarget.seerahChapter('x'), isA<SeerahChapterTarget>());
    expect(Reliability.values, isNotEmpty);
  });
}
