import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/features/companions/presentation/directory/directory_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/profile/profile_sections.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';

void main() {
  Future<AppUnderTest> open(
    WidgetTester tester,
    String id, {
    AssetBundle? bundle,
  }) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(800, 8000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: '/companions/$id', bundle: bundle);
    await app.pump(tester);
    return app;
  }

  testApp('Abu Bakr: header, draft label and every part of the page', (
    tester,
  ) async {
    await open(tester, 'abu-bakr');

    expect(find.text('أبو بكر الصديق'), findsOneWidget);
    expect(find.text('رضي الله عنه'), findsOneWidget);
    expect(find.text('أبو بكر · الصديق · العتيق'), findsOneWidget);
    expect(
      find.text('المدينة المنورة · جمادى الآخرة ١٣ هـ / ٦٣٤ م'),
      findsWidgets,
    );
    expect(find.byType(DraftBadge), findsWidgets);

    // Sections of the page, numbered in order.
    for (final title in [
      'في سطور',
      'فصول السيرة',
      'محطات من حياته',
      'قصص من السيرة',
      'ذوو صلة',
      'مراجع هذه السيرة',
    ]) {
      expect(find.text(title), findsOneWidget, reason: title);
    }
    expect(find.text('٠٦'), findsWidgets);

    // Facts: birth (approximate) and death.
    expect(find.text('نحو سنة ٥٧٣ م'), findsWidgets);

    // Biography sections listed by title.
    for (final title in ['النشأة', 'إسلامه', 'صاحبه في الهجرة', 'وفاته']) {
      expect(find.text(title), findsOneWidget, reason: title);
    }

    // Stories, with draft badges and Arabic reading time.
    expect(find.text('ثاني اثنين'), findsOneWidget);
    expect(find.text('جمع القرآن في الصحف'), findsOneWidget);
    // Ten stories, three-minute ones among them; in the order of events.
    expect(find.text('٣ دقائق قراءة'), findsNWidgets(7));
    expect(
      tester.getTopLeft(find.text('إسلام أبي ذر')).dy,
      lessThan(tester.getTopLeft(find.text('يوم السقيفة')).dy),
    );

    // Related person from people.json, with her honorific; not a link.
    expect(find.text('عائشة أم المؤمنين رضي الله عنها'), findsOneWidget);

    // References with author death years.
    expect(find.text('الإصابة في تمييز الصحابة'), findsOneWidget);
    expect(find.text('ابن حجر العسقلاني (ت ٨٥٢ هـ)'), findsOneWidget);
  });

  testApp('timeline preview is in date order, birth first', (tester) async {
    await open(tester, 'abu-bakr');
    final preview = find.byType(TimelinePreview);
    final titles = [
      for (final t in tester.widgetList<Text>(
        find.descendant(of: preview, matching: find.byType(Text)),
      ))
        t.data,
    ];
    final order = [
      'مولده بمكة',
      'إسلامه في أول الدعوة',
      'الهجرة مع النبي ﷺ إلى المدينة',
      'شهوده غزوة بدر',
    ];
    final positions = [for (final o in order) titles.indexOf(o)];
    expect(positions.every((p) => p >= 0), isTrue, reason: '$titles');
    expect([...positions]..sort(), positions);
  });

  testApp('every reliability badge is provisional on draft content', (
    tester,
  ) async {
    await open(tester, 'abu-bakr');
    final badges = tester.widgetList<ReliabilityBadge>(
      find.byType(ReliabilityBadge),
    );
    expect(badges, isNotEmpty);
    expect(badges.every((b) => b.provisional), isTrue);
  });

  testApp('a citation marker opens the sheet with the draft notice', (
    tester,
  ) async {
    await open(tester, 'abu-bakr');
    await tester.tap(find.byType(CitationMarker).first);
    await tester.pumpAndSettle();

    expect(find.byType(CitationSheet), findsOneWidget);
    expect(find.text('مصادر هذه المعلومة'), findsOneWidget);
    expect(
      find.textContaining('هذا المحتوى مسودة لم يراجعها مختص'),
      findsOneWidget,
    );
    expect(find.text('الموضع بانتظار التحقق'), findsWidgets);
  });

  testApp('the Qur\'an citation shows its surah and ayah', (tester) async {
    await open(tester, 'abu-bakr');
    final hijrahMarker = find.descendant(
      of: find.ancestor(
        of: find.text('الهجرة مع النبي ﷺ إلى المدينة'),
        matching: find.byType(Row),
      ),
      matching: find.byType(CitationMarker),
    );
    await tester.tap(hijrahMarker.first);
    await tester.pumpAndSettle();
    expect(find.text('التوبة: ٤٠'), findsOneWidget);
    expect(find.text('القرآن الكريم'), findsOneWidget);
  });

  testApp('a skeleton profile (Talha) renders without sections', (
    tester,
  ) async {
    // Every one of the Ten now has a written biography; strip one to test
    // the state a newly added companion starts in.
    await open(
      tester,
      'talha',
      bundle: MemoryAssetBundle.withSkeleton('talha'),
    );
    expect(find.text('طلحة بن عبيد الله'), findsOneWidget);
    expect(find.text('فصول السيرة'), findsNothing);
    expect(find.text('طلحة الخير'), findsNothing); // only in the subtitle
    expect(find.text('أبو محمد · طلحة الخير'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testApp('a category chip goes to the filtered directory', (tester) async {
    final app = await open(tester, 'umar');
    await tester.tap(find.widgetWithText(ActionChip, 'الخلفاء الراشدون'));
    await tester.pumpAndSettle();
    expect(find.byType(DirectoryPage), findsOneWidget);
    expect(app.location, '/companions?category=khulafa-rashidun');
  });

  testApp('an unknown companion shows a friendly message', (tester) async {
    await AppUnderTest(location: '/companions/nobody').pump(tester);
    expect(find.text('لم نجد هذا الصحابي.'), findsOneWidget);
    await tester.tap(find.text('العودة إلى الصحابة'));
    await tester.pumpAndSettle();
    expect(find.byType(DirectoryPage), findsOneWidget);
  });

  testApp('no overflow at text scale 2.0', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await open(tester, 'abu-bakr');
    expect(tester.takeException(), isNull);
  });

  testApp('meets tap-target and labelling guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    await AppUnderTest(location: '/companions/abu-bakr').pump(tester);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    handle.dispose();
  });
}
