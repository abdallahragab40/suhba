import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/design_system/widgets/reliability_badge.dart';
import 'package:suhba/core/domain/quran_ref.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/domain/content_block.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/quran_verses.dart';
import 'package:suhba/shared/content/presentation/reading_body.dart';
import 'package:suhba/shared/content/providers.dart';

import '../../helpers/content_bundle.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/specimen_blocks.dart';

void main() {
  late List<(List<Citation>, Reliability?)> opened;
  late List<String?> passages;

  Future<void> pump(
    WidgetTester tester, {
    List<ContentBlock>? blocks,
    bool provisional = true,
    double? textSize,
    List<Override> overrides = const [],
  }) async {
    opened = [];
    passages = [];
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(500, 2400);
    addTearDown(tester.view.reset);
    // The real bundled assets: verses come from assets/content/quran.json.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          assetBundleProvider.overrideWithValue(
            MemoryAssetBundle.builtContent(),
          ),
          ...overrides,
        ],
        child: testHarness(
          theme: AppTheme.light,
          child: Scaffold(
            body: SingleChildScrollView(
              // The reader's gutter.
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ReadingBody(
                blocks: blocks ?? specimenBlocks,
                provisional: provisional,
                textSize: textSize,
                onCitations: (c, r, {passage}) {
                  opened.add((c, r));
                  passages.add(passage);
                },
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('paragraphs: a quiet mark, reported explained once at the top', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pump(tester, blocks: specimenBlocks.sublist(0, 2));
    // No pill under established or reported paragraphs (review F10).
    expect(find.byType(ReliabilityBadge), findsNothing);
    final markers = tester
        .widgetList<CitationMarker>(find.byType(CitationMarker))
        .toList();
    expect(markers.map((m) => m.reported), [false, true]);
    // The reported mark has its own shape, not only its own colour.
    expect(find.byIcon(CitationMarker.glyphReported), findsNWidgets(2));
    expect(find.byIcon(CitationMarker.glyphSource), findsOneWidget);
    // The legend, once, at the top of the passage.
    expect(
      find.text(
        'رواية تاريخية: وردت في كتب السيرة والتاريخ، ولم يُحكم على إسنادها.',
      ),
      findsOneWidget,
    );
    // Screen readers hear the label on the mark itself.
    expect(
      find.bySemanticsLabel('رواية تاريخية، عرض المصادر (١)'),
      findsOneWidget,
    );
    // Two sources show their count; one shows the glyph alone.
    expect(find.text('٢'), findsOneWidget);
    expect(find.text('١'), findsNothing);
    handle.dispose();
  });

  testWidgets('the mark follows the last word and costs no row', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    // Below a heading, as in a reader: not against the top of the screen,
    // which would clip the touch area.
    await pump(tester, blocks: [_heading, _short]);
    final text = tester.getRect(find.textContaining('فقرة قصيرة'));
    final marker = tester.getRect(find.byType(CitationMarker));
    // Inside the paragraph's own line box, not on a row below it.
    expect(text.contains(marker.center), isTrue);
    final body = tester.getRect(find.byType(ReadingBody));
    expect(body.bottom, text.bottom + ReadingBody.gapAfter(_short, null));
    // Letter-sized on screen, but a full 48 × 48 target for TalkBack.
    expect(marker.height, lessThan(48));
    final node = tester.getSemantics(find.bySemanticsLabel('عرض المصادر (٢)'));
    expect(node.rect.width, greaterThanOrEqualTo(48));
    expect(node.rect.height, greaterThanOrEqualTo(48));
    expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);
    handle.dispose();
  });

  testWidgets('a tap just beside the small mark still opens the sources', (
    tester,
  ) async {
    await pump(tester, blocks: [_heading, _short]);
    final glyph = tester.getRect(find.byIcon(CitationMarker.glyphSource));
    // Just past the glyph, on the side away from the text: inside the touch
    // area, outside the drawn mark.
    await tester.tapAt(glyph.centerLeft - const Offset(6, 0));
    expect(opened, hasLength(1));
  });

  testWidgets('disputed and unknown paragraphs keep their explicit badge', (
    tester,
  ) async {
    await pump(
      tester,
      blocks: const [
        ContentBlock.paragraph(
          text: LocalizedText(ar: 'فقرة مختلف فيها.'),
          reliability: Reliability.disputed,
          citations: [
            Citation(sourceId: 's', locatorStatus: LocatorStatus.pending),
          ],
        ),
        ContentBlock.paragraph(
          text: LocalizedText(ar: 'فقرة لم تثبت.'),
          reliability: Reliability.unknown,
          citations: [
            Citation(sourceId: 's', locatorStatus: LocatorStatus.pending),
          ],
        ),
      ],
    );
    final badges = tester.widgetList<ReliabilityBadge>(
      find.byType(ReliabilityBadge),
    );
    expect(badges.map((b) => b.reliability), [
      Reliability.disputed,
      Reliability.unknown,
    ]);
    expect(badges.every((b) => b.provisional), isTrue);
  });

  testWidgets('a marker passes its citations and reliability', (tester) async {
    await pump(tester, blocks: specimenBlocks.sublist(0, 1));
    await tester.tap(find.byType(CitationMarker));
    expect(opened.single.$1, hasLength(2));
    expect(opened.single.$2, Reliability.established);
    // The claim's own text goes with it, for sharing.
    expect(passages.single, 'فقرة ثابتة بلا شارة ظاهرة.');
  });

  testWidgets('only complete wording is offered for sharing', (tester) async {
    await pump(tester, blocks: [specimenBlocks[3], specimenBlocks[4]]);
    await tester.tap(find.byType(CitationMarker).first);
    await tester.tap(find.byType(CitationMarker).last);
    // A pending hadith shares nothing, not even its summary.
    expect(passages, [null, 'نص الرواية']);
  });

  testWidgets('a Qur\'an quote is headed by its reference', (tester) async {
    await pump(tester, blocks: [specimenBlocks[2]]);
    expect(find.text('قال الله تعالى — التوبة: ٤٠'), findsOneWidget);
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
    expect(passages.single, 'اختُلف في هذه المسألة.\nالقول الثاني.');
  });

  testWidgets('a lesson is a labelled callout', (tester) async {
    await pump(tester, blocks: [specimenBlocks[6]]);
    expect(find.text('درس وعبرة'), findsOneWidget);
    expect(find.text('درس من القصة.'), findsOneWidget);
  });

  testWidgets('the reading size applies to body text', (tester) async {
    await pump(tester, blocks: specimenBlocks.sublist(0, 1), textSize: 26);
    final text = tester.widget<Text>(find.textContaining('فقرة ثابتة'));
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

  group('Qur\'an quotations', () {
    Future<void> quote(
      WidgetTester tester,
      QuranRef ref, {
      List<Override> overrides = const [],
    }) async {
      await pump(
        tester,
        blocks: [ContentBlock.quranQuote(ref: ref)],
        overrides: overrides,
      );
      await tester.pumpAndSettle();
    }

    // Compared with the bundled text, never with hand-typed Arabic: the
    // order of combining marks matters.
    final bundled =
        jsonDecode(File('assets/content/quran.json').readAsStringSync())
            as Map<String, dynamic>;
    final ayahs = (bundled['ayahs'] as Map).cast<String, String>();
    final basmalas = (bundled['basmalas'] as Map).cast<String, String>();

    String verseText(WidgetTester tester) => tester
        .widgetList<RichText>(find.byType(RichText))
        .map((t) => t.text.toPlainText())
        .join('\n');

    testWidgets('show the verified text, numbered, with its source', (
      tester,
    ) async {
      await quote(tester, const QuranRef(surah: 9, ayahFrom: 40));
      // Exactly the bundled Tanzil text of at-Tawbah 40.
      expect(verseText(tester), contains(ayahs['9:40']));
      expect(verseText(tester), contains('\uFD3F٤٠\uFD3E'));
      expect(find.text('الرسم العثماني من مشروع تنزيل'), findsOneWidget);
      expect(find.text(quranPendingAr), findsNothing);
      // Not a surah opening: no basmala.
      expect(find.text(basmalas['96']!), findsNothing);
    });

    testWidgets('a quotation that opens a surah has the basmala above', (
      tester,
    ) async {
      await quote(tester, const QuranRef(surah: 96, ayahFrom: 1, ayahTo: 5));
      final text = verseText(tester);
      expect(find.text(basmalas['96']!), findsOneWidget);
      expect(text, contains(ayahs['96:1']));
      expect(text, contains(ayahs['96:5']));
      for (final n in ['١', '٢', '٣', '٤', '٥']) {
        expect(text, contains('\uFD3F$n\uFD3E'));
      }
    });

    testWidgets('fall back to the reference if the text cannot load', (
      tester,
    ) async {
      await quote(
        tester,
        const QuranRef(surah: 9, ayahFrom: 40),
        overrides: [
          quranVersesProvider.overrideWith(
            (ref) => Future<QuranVerses>.error(StateError('missing')),
          ),
        ],
      );
      expect(find.text(quranPendingAr), findsOneWidget);
      expect(find.text('الرسم العثماني من مشروع تنزيل'), findsNothing);
    });
  });
}

const quranPendingAr = 'تعذّر عرض نص الآية الآن، والمرجع أعلاه.';

const _heading = ContentBlock.heading(text: LocalizedText(ar: 'عنوان'));

/// Short enough that its mark stays on the line with the test font, whose
/// square glyphs are much wider than Arabic letters.
const _short = ContentBlock.paragraph(
  text: LocalizedText(ar: 'فقرة قصيرة.'),
  reliability: Reliability.established,
  citations: [
    Citation(sourceId: 's', locatorStatus: LocatorStatus.pending),
    Citation(sourceId: 't', locatorStatus: LocatorStatus.pending),
  ],
);
