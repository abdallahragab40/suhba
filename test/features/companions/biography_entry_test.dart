import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/features/biography/presentation/section_reader_page.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';

/// E07: one tap into a biography, progress on the profile, and contents
/// inside the reader.
void main() {
  void tall(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
  }

  Future<void> save(
    AppUnderTest app,
    String sectionId, {
    double fraction = 0.4,
    bool completed = false,
  }) => app.container
      .read(readingProgressRepositoryProvider)
      .save(
        ReadingProgress(
          target: ProgressTarget.section,
          targetId: sectionId,
          parentId: 'abu-bakr',
          fraction: fraction,
          completed: completed,
          contentVersion: '0.1.0',
          updatedAt: DateTime(2026, 10, 9),
        ),
      );

  SectionReaderPage reader(WidgetTester tester) =>
      tester.widget<SectionReaderPage>(find.byType(SectionReaderPage));

  testApp('nothing read: one tap starts the first section', (tester) async {
    tall(tester);
    await AppUnderTest(location: '/companions/abu-bakr').pump(tester);
    expect(find.text('٨ أقسام'), findsOneWidget);
    await tester.tap(find.text('ابدأ قراءة السيرة'));
    await tester.pumpAndSettle();
    expect(reader(tester).sectionId, 'abu-bakr.early-life');
  });

  testApp('part read: one tap continues the last unfinished section', (
    tester,
  ) async {
    tall(tester);
    final app = AppUnderTest(location: '/companions/abu-bakr');
    await save(app, 'abu-bakr.hijrah');
    await app.pump(tester);
    expect(find.text('صاحبه في الهجرة · قُرئ ٤٠٪'), findsOneWidget);
    await tester.tap(find.text('تابع القراءة'));
    await tester.pumpAndSettle();
    expect(reader(tester).sectionId, 'abu-bakr.hijrah');
  });

  testApp('all read: says so and offers the start again', (tester) async {
    tall(tester);
    final app = AppUnderTest(location: '/companions/abu-bakr');
    for (final id in [
      'abu-bakr.early-life',
      'abu-bakr.conversion',
      'abu-bakr.hijrah',
      'abu-bakr.virtues',
      'abu-bakr.character',
      'abu-bakr.caliphate',
      'abu-bakr.death',
      'abu-bakr.lessons',
    ]) {
      await save(app, id, fraction: 1, completed: true);
    }
    await app.pump(tester);
    expect(find.text('أتممتَ قراءة سيرته.'), findsOneWidget);
    await tester.tap(find.text('اقرأها من البداية'));
    await tester.pumpAndSettle();
    expect(reader(tester).sectionId, 'abu-bakr.early-life');
  });

  testApp('a profile without a written biography says so', (tester) async {
    tall(tester);
    await AppUnderTest(
      location: '/companions/talha',
      bundle: MemoryAssetBundle.withSkeleton('talha'),
    ).pump(tester);
    expect(find.textContaining('لم تُكتب سيرته المفصّلة بعد'), findsOneWidget);
    expect(find.text('ابدأ قراءة السيرة'), findsNothing);
  });

  testApp('the section list shows finished and started sections', (
    tester,
  ) async {
    tall(tester);
    final handle = tester.ensureSemantics();
    final app = AppUnderTest(location: '/companions/abu-bakr');
    await save(app, 'abu-bakr.early-life', fraction: 1, completed: true);
    await save(app, 'abu-bakr.hijrah');
    await app.pump(tester);
    // Spoken with the section's title, as part of its row.
    expect(find.bySemanticsLabel(RegExp('النشأة\nمكتمل')), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('صاحبه في الهجرة\nقُرئ ٤٠٪')),
      findsOneWidget,
    );
    handle.dispose();
  });

  group('contents inside the reader', () {
    const hijrah = '/companions/abu-bakr/sections/abu-bakr.hijrah';

    testApp('lists the sections, marks the open one, and switches', (
      tester,
    ) async {
      tall(tester);
      final app = AppUnderTest(location: '/companions/abu-bakr');
      await app.pump(tester);
      await tester.tap(find.text('ابدأ قراءة السيرة'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('فهرس الأقسام'));
      await tester.pumpAndSettle();
      expect(find.text('تقرؤه الآن'), findsOneWidget);
      await tester.tap(find.text('صاحبه في الهجرة').last);
      await tester.pumpAndSettle();
      expect(reader(tester).sectionId, 'abu-bakr.hijrah');

      // It replaced the reader: back returns to the profile.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(SectionReaderPage), findsNothing);
      expect(app.location, '/companions/abu-bakr');
    });

    testApp('switching keeps the position read so far', (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(400, 700);
      addTearDown(tester.view.reset);
      final app = AppUnderTest(location: hijrah);
      await app.pump(tester);
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('فهرس الأقسام'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('فضائله').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('فضائله').last);
      await tester.pumpAndSettle();
      expect(reader(tester).sectionId, 'abu-bakr.virtues');
      final saved = await (app.database.select(
        app.database.readingProgressEntries,
      )..where((p) => p.targetId.equals('abu-bakr.hijrah'))).getSingle();
      expect(saved.fraction, greaterThan(0));
    });

    testApp('the open sheet meets the accessibility guidelines', (
      tester,
    ) async {
      tall(tester);
      final handle = tester.ensureSemantics();
      await AppUnderTest(location: hijrah).pump(tester);
      await tester.tap(find.byTooltip('فهرس الأقسام'));
      await tester.pumpAndSettle();
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
  });
}
