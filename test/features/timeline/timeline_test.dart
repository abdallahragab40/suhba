import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/features/biography/presentation/section_reader_page.dart';
import 'package:siyar_sahaba/features/timeline/domain/timeline_grouping.dart';
import 'package:siyar_sahaba/features/timeline/presentation/timeline_page.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';

import '../../helpers/app_harness.dart';

TimelineEvent _entry(String id, TimelineEra era, HistoricalDate date) =>
    TimelineEvent(
      id: id,
      era: era,
      date: date,
      title: LocalizedText(ar: id),
      reliability: Reliability.established,
      citations: const [],
    );

void main() {
  group('groupTimeline', () {
    const ah = HijriEra.afterHijra;
    HistoricalDate year(int y, {HijriEra era = ah}) =>
        HistoricalDate(precision: DatePrecision.year, era: era, hijriYear: y);

    test('eras in historical order, dates sorted within each', () {
      final groups = groupTimeline([
        _entry('death', TimelineEra.afterProphet, year(13)),
        _entry('badr', TimelineEra.madinan, year(2)),
        _entry(
          'islam',
          TimelineEra.makkan,
          year(13, era: HijriEra.beforeHijra),
        ),
        _entry('hijrah', TimelineEra.madinan, year(1)),
        _entry(
          'birth',
          TimelineEra.preIslam,
          const HistoricalDate(
            precision: DatePrecision.approx,
            gregorianYear: 573,
          ),
        ),
      ]);
      expect(groups.map((g) => g.$1), TimelineEra.values);
      expect(
        [for (final (_, entries) in groups) ...entries.map((e) => e.id)],
        ['birth', 'islam', 'hijrah', 'badr', 'death'],
      );
    });

    test('empty eras are left out; equal dates keep authored order', () {
      final groups = groupTimeline([
        _entry('b', TimelineEra.madinan, year(5)),
        _entry('a', TimelineEra.madinan, year(5)),
      ]);
      expect(groups, hasLength(1));
      expect(groups.single.$2.map((e) => e.id), ['b', 'a']);
    });

    test('imprecise dates are flagged for dashed markers', () {
      expect(isImpreciseDate(year(1)), isFalse);
      expect(
        isImpreciseDate(
          const HistoricalDate(precision: DatePrecision.approx, hijriYear: 12),
        ),
        isTrue,
      );
      expect(isImpreciseDate(const HistoricalDate.unknown()), isTrue);
    });
  });

  group('timeline page', () {
    Future<AppUnderTest> open(WidgetTester tester, String id) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(600, 4000);
      addTearDown(tester.view.reset);
      final app = AppUnderTest(location: '/companions/$id/timeline');
      await app.pump(tester);
      return app;
    }

    testApp('Abu Bakr: four eras, thirteen entries, events named', (
      tester,
    ) async {
      await open(tester, 'abu-bakr');
      for (final era in [
        'قبل الإسلام',
        'العهد المكي',
        'العهد المدني',
        'بعد وفاة النبي ﷺ',
      ]) {
        expect(find.text(era), findsOneWidget, reason: era);
      }
      expect(find.byType(TimelineEntryTile), findsNWidgets(13));
      expect(find.text('الحدث: غزوة بدر'), findsOneWidget);
      expect(find.text('الحدث: الهجرة النبوية'), findsOneWidget);
      // The disputed calendar date range is Umar's; Abu Bakr has a range too.
      expect(find.text('١١ – ١٢ هـ'), findsWidgets);
    });

    testApp('"read in the biography" opens the linked section', (tester) async {
      final app = await open(tester, 'abu-bakr');
      await tester.tap(find.text('اقرأ في السيرة').first);
      await tester.pumpAndSettle();
      expect(find.byType(SectionReaderPage), findsOneWidget);
      expect(app.location, '/companions/abu-bakr/sections/abu-bakr.early-life');
    });

    testApp('the era strip has a marker per entry and scrolls to it', (
      tester,
    ) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(600, 700);
      addTearDown(tester.view.reset);
      await AppUnderTest(
        location: '/companions/abu-bakr/timeline',
      ).pump(tester);
      final strip = find.byType(EraStrip);
      final markers = find.descendant(
        of: strip,
        matching: find.byType(InkWell),
      );
      expect(markers, findsNWidgets(13));

      final death = find.text('وفاته بالمدينة');
      final before = tester.getTopLeft(death).dy;
      await tester.ensureVisible(markers.last); // the strip scrolls sideways
      await tester.pumpAndSettle();
      await tester.tap(markers.last);
      await tester.pumpAndSettle();
      expect(tester.getTopLeft(death).dy, lessThan(before));
    });
  });
}
