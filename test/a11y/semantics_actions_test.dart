import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/features/timeline/presentation/timeline_page.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/visuals/presentation/resolved_visual.dart';
import 'package:suhba/shared/visuals/presentation/timeline_chart.dart';

import '../helpers/pump_app.dart';

/// Controls that merge their child's semantics into one labelled node must
/// still expose the tap. Without it TalkBack announces a button that does
/// nothing (review finding F02).
void main() {
  Future<void> pump(WidgetTester tester, Widget child) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(500, 1200);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      testHarness(
        theme: AppTheme.light,
        child: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> expectTappable(
    WidgetTester tester,
    Finder node,
    FinderBase<SemanticsNode> semanticNode,
    int Function() taps,
  ) async {
    expect(
      tester.getSemantics(node),
      isSemantics(isButton: true, hasTapAction: true),
    );
    final before = taps();
    tester.semantics.tap(semanticNode);
    await tester.pumpAndSettle();
    expect(taps(), before + 1, reason: 'the semantic tap runs the action');
  }

  const date = HistoricalDate(precision: DatePrecision.year, hijriYear: 2);

  testWidgets('a source marker can be activated by a screen reader', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    var taps = 0;
    await pump(tester, CitationMarker(count: 3, onPressed: () => taps++));
    await expectTappable(
      tester,
      find.bySemanticsLabel('عرض المصادر (٣)'),
      find.semantics.byLabel('عرض المصادر (٣)'),
      () => taps,
    );
    handle.dispose();
  });

  testWidgets('a timeline chart label can be activated by a screen reader', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    var taps = 0;
    await pump(
      tester,
      TimelineChart(
        marks: [
          const TimelineMark(
            title: LocalizedText(ar: 'غزوة بدر'),
            date: date,
            reliability: Reliability.established,
            citations: [],
          ),
        ],
        onOpen: (_) => taps++,
      ),
    );
    await expectTappable(
      tester,
      find.bySemanticsLabel(RegExp('غزوة بدر')),
      find.semantics.byLabel(RegExp('غزوة بدر')),
      () => taps,
    );
    handle.dispose();
  });

  testWidgets('an era-strip marker can be activated by a screen reader', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    var taps = 0;
    await pump(
      tester,
      EraStrip(
        entries: [
          const TimelineEvent(
            id: 'badr',
            era: TimelineEra.madinan,
            date: date,
            title: LocalizedText(ar: 'شهد بدرًا'),
            reliability: Reliability.established,
            citations: [],
          ),
        ],
        onSelected: (_) => taps++,
      ),
    );
    await expectTappable(
      tester,
      find.bySemanticsLabel(RegExp('شهد بدرًا')),
      find.semantics.byLabel(RegExp('شهد بدرًا')),
      () => taps,
    );
    handle.dispose();
  });
}
