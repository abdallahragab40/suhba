import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/presentation/reading_body.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/specimen_blocks.dart';

void main() {
  late List<(List<Citation>, Reliability?)> opened;

  Future<void> pump(
    WidgetTester tester, {
    List<ContentBlock>? blocks,
    bool provisional = true,
    double? textSize,
  }) async {
    opened = [];
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(500, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      testHarness(
        theme: AppTheme.light,
        child: Scaffold(
          body: SingleChildScrollView(
            child: ReadingBody(
              blocks: blocks ?? specimenBlocks,
              provisional: provisional,
              textSize: textSize,
              onCitations: (c, r) => opened.add((c, r)),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('paragraphs: badge only when not established', (tester) async {
    await pump(tester, blocks: specimenBlocks.sublist(0, 2));
    final badges = tester.widgetList<ReliabilityBadge>(
      find.byType(ReliabilityBadge),
    );
    expect(badges.map((b) => b.reliability), [Reliability.reported]);
    expect(badges.single.provisional, isTrue);
    expect(find.byType(CitationMarker), findsNWidgets(2));
  });

  testWidgets('a marker passes its citations and reliability', (tester) async {
    await pump(tester, blocks: specimenBlocks.sublist(0, 1));
    await tester.tap(find.byType(CitationMarker));
    expect(opened.single.$1, hasLength(2));
    expect(opened.single.$2, Reliability.established);
  });

  testWidgets('a Qur\'an quote shows its reference, never typed text', (
    tester,
  ) async {
    await pump(tester, blocks: [specimenBlocks[2]]);
    expect(find.text('قال الله تعالى — التوبة: ٤٠'), findsOneWidget);
    expect(find.textContaining('مصحف رقمي معتمد'), findsOneWidget);
  });

  testWidgets('a pending hadith shows its description, status and grading', (
    tester,
  ) async {
    await pump(tester, blocks: [specimenBlocks[3]]);
    expect(find.text('حديث'), findsOneWidget);
    expect(find.text('وصف مضمون الحديث.'), findsOneWidget);
    expect(find.text('النص بانتظار نقله من المصدر المعتمد.'), findsOneWidget);
    expect(find.text('صحيح — البخاري'), findsOneWidget);
    expect(find.textContaining('«'), findsNothing);
  });

  testWidgets('a complete report is quoted in guillemets', (tester) async {
    await pump(tester, blocks: [specimenBlocks[4]]);
    expect(find.text('«نص الرواية»'), findsOneWidget);
    expect(find.textContaining('بانتظار نقله'), findsNothing);
  });

  testWidgets('a dispute expands to show each opinion with its sources', (
    tester,
  ) async {
    await pump(tester, blocks: [specimenBlocks[5]]);
    expect(find.text('عرض الأقوال (٢)'), findsOneWidget);
    expect(find.text('القول الأول.'), findsNothing);
    await tester.tap(find.text('عرض الأقوال (٢)'));
    await tester.pumpAndSettle();
    expect(find.text('القول ١'), findsOneWidget);
    expect(find.text('القول الثاني.'), findsOneWidget);
    await tester.tap(find.byType(CitationMarker).last);
    expect(opened.single.$2, Reliability.disputed);
  });

  testWidgets('a lesson is a labelled callout', (tester) async {
    await pump(tester, blocks: [specimenBlocks[6]]);
    expect(find.text('درس وعبرة'), findsOneWidget);
    expect(find.text('درس من القصة.'), findsOneWidget);
  });

  testWidgets('the reading size applies to body text', (tester) async {
    await pump(tester, blocks: specimenBlocks.sublist(0, 1), textSize: 26);
    final text = tester.widget<Text>(find.text('فقرة ثابتة بلا شارة ظاهرة.'));
    expect(text.style!.fontSize, 26);
    expect(text.style!.fontFamily, 'Amiri');
  });

  testWidgets('every block meets tap-target guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    await pump(tester);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    handle.dispose();
  });
}
