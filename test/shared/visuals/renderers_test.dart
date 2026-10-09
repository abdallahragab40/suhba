import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/period_bands.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/resolved_visual.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/schematic_map.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/timeline_chart.dart';

import '../../helpers/pump_app.dart';

TimelineMark mark(String title, HistoricalDate date) => TimelineMark(
  title: LocalizedText(ar: title),
  date: date,
  reliability: Reliability.established,
  citations: const [],
);

HistoricalDate ah(int year) =>
    HistoricalDate(precision: DatePrecision.year, hijriYear: year);

HistoricalPlace place(String id, double lat, double lon) => HistoricalPlace(
  id: id,
  name: LocalizedText(ar: id),
  kind: PlaceKind.city,
  location: GeoPoint(lat: lat, lon: lon, precision: GeoPrecision.identified),
  summary: const LocalizedText(ar: '-'),
  reliability: Reliability.established,
  citations: const [],
  review: const ReviewInfo(status: ReviewStatus.draft),
);

void main() {
  Future<void> pump(WidgetTester tester, Widget child) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(500, 2000);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      testHarness(
        theme: AppTheme.light,
        child: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the timeline places marks by date, not at equal steps', (
    tester,
  ) async {
    await pump(
      tester,
      TimelineChart(
        marks: [
          mark('أ', ah(1)),
          mark('ب', ah(2)),
          mark('ج', ah(40)),
          mark('بلا تاريخ', const HistoricalDate.unknown()),
        ],
        onOpen: (_) {},
      ),
    );
    final a = tester.getCenter(find.text('أ')).dy;
    final b = tester.getCenter(find.text('ب')).dy;
    final c = tester.getCenter(find.text('ج')).dy;
    expect(b, greaterThan(a));
    // One year apart vs. thirty-eight: the gaps say so.
    expect(c - b, greaterThan((b - a) * 5));
    // The undated record is listed after the axis, not placed on it.
    expect(find.text('بلا تاريخ محدد'), findsOneWidget);
    expect(tester.getCenter(find.text('بلا تاريخ')).dy, greaterThan(c));
  });

  testWidgets('the map is never mirrored: north up, east right, in RTL', (
    tester,
  ) async {
    final opened = <String>[];
    await pump(
      tester,
      SchematicMap(
        places: [
          place('makkah', 21.42, 39.83),
          place('madinah', 24.47, 39.61),
          place('taif', 21.27, 40.42),
        ],
        interactive: false,
        onOpenPlace: (p) => opened.add(p.id),
      ),
    );
    Offset at(String id) => tester.getCenter(find.byTooltip(id));
    expect(at('madinah').dy, lessThan(at('makkah').dy), reason: 'north up');
    expect(at('taif').dx, greaterThan(at('makkah').dx), reason: 'east right');
    await tester.tap(find.byTooltip('taif'));
    expect(opened, ['taif']);
  });

  testWidgets('period bands are as long as the periods', (tester) async {
    PeriodBand band(String label, HistoricalDate date) => PeriodBand(
      label: LocalizedText(ar: label),
      date: date,
      reliability: Reliability.established,
      citations: const [],
    );
    await pump(
      tester,
      PeriodBands(
        bands: [
          band(
            'طويلة',
            const HistoricalDate(
              precision: DatePrecision.range,
              era: HijriEra.beforeHijra,
              hijriYear: 53,
              hijriYearEnd: 13,
            ),
          ),
          band(
            'قصيرة',
            const HistoricalDate(
              precision: DatePrecision.range,
              hijriYear: 1,
              hijriYearEnd: 11,
            ),
          ),
        ],
      ),
    );
    final widths = [
      for (final e in tester.widgetList<Expanded>(
        find.descendant(
          of: find.byType(PeriodBands),
          matching: find.byType(Expanded),
        ),
      ))
        e.flex,
    ];
    // 40 years vs 10 years.
    expect(widths.first / widths[1], closeTo(4, 0.1));
  });
}
