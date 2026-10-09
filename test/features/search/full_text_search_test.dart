import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/app/provider_retry.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/core/text/arabic_normalizer.dart';
import 'package:siyar_sahaba/features/search/domain/search_documents.dart';
import 'package:siyar_sahaba/features/search/domain/search_index.dart';
import 'package:siyar_sahaba/features/search/presentation/search_providers.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';

/// E08: body text is searchable, with excerpts, filters, and honest
/// handling of an incomplete index.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  SearchDocument doc(
    String id,
    List<SearchField> fields, {
    SearchKind kind = SearchKind.section,
    String? parentId = 'p',
  }) => SearchDocument(
    kind: kind,
    id: id,
    parentId: kind == SearchKind.companion ? null : parentId,
    title: id,
    fields: fields,
  );

  group('excerpts', () {
    test('mark the original words, tashkeel and hamza intact', () {
      const text = 'وقد رأى النبيُّ ﷺ ذلك في سنة ١٣ هـ بالمدينة.';
      final e = SearchExcerpt.around(
        text,
        ArabicNormalizer.normalize('راي النبي'),
      )!;
      expect(e.text.substring(e.matchStart, e.matchEnd), 'رأى النبيُّ');
    });

    test('the mark includes trailing tashkeel but not punctuation', () {
      const text = 'قبل الهجرةِ، وكان';
      final e = SearchExcerpt.around(text, 'الهجره')!;
      expect(e.text.substring(e.matchStart, e.matchEnd), 'الهجرةِ');
    });

    test('digits match across scripts', () {
      const text = 'في سنة ١٣ هـ';
      final e = SearchExcerpt.around(text, ArabicNormalizer.normalize('13'))!;
      expect(e.text.substring(e.matchStart, e.matchEnd), '١٣');
    });

    test('long text is cut at word boundaries, with ellipses', () {
      final words = [for (var i = 0; i < 60; i++) 'كلمة$i'].join(' ');
      final text = '$words الهدف $words';
      final e = SearchExcerpt.around(text, 'الهدف', context: 20)!;
      expect(e.text, startsWith('… '));
      expect(e.text, endsWith(' …'));
      expect(e.text.substring(e.matchStart, e.matchEnd), 'الهدف');
      expect(e.text.length, lessThan(80));
    });
  });

  group('index', () {
    test('a body-only phrase finds its passage, with an excerpt', () {
      final index = SearchIndex([
        doc('a', [
          const SearchField('عنوان', SearchField.headingWeight),
          const SearchField.body('خرجا ليلًا إلى غار ثور فمكثا فيه ثلاثًا.'),
        ]),
        doc('b', [const SearchField('آخر', SearchField.headingWeight)]),
      ]);
      final hits = index.search('غار ثور');
      expect(hits.single.document.id, 'a');
      final e = hits.single.excerpt!;
      expect(e.text.substring(e.matchStart, e.matchEnd), 'غار ثور');
    });

    test('a name outranks a body mention', () {
      final index = SearchIndex([
        doc('passage', [
          const SearchField.body('وكان الصديق أول من أسلم من الرجال.'),
        ]),
        doc('companion', kind: SearchKind.companion, [
          const SearchField('الصديق', SearchField.aliasWeight),
        ]),
      ]);
      final hits = index.search('الصديق');
      expect(hits.map((h) => h.document.id), ['companion', 'passage']);
      expect(hits.first.excerpt, isNull, reason: 'matched by name');
    });

    test('the whole phrase ranks above scattered words', () {
      final index = SearchIndex([
        doc('scattered', [
          const SearchField.body('غار في الجبل، وثور اسم الجبل.'),
        ]),
        doc('phrase', [const SearchField.body('دخلا غار ثور.')]),
      ]);
      expect(index.search('غار ثور').first.document.id, 'phrase');
    });

    test('filters narrow by kind and by companion or story', () {
      final index = SearchIndex([
        doc('c', kind: SearchKind.companion, [
          const SearchField('صاحب', SearchField.nameWeight),
          const SearchField.body('نص مشترك'),
        ]),
        doc('s1', parentId: 'c', [const SearchField.body('نص مشترك')]),
        doc('s2', parentId: 'other', [const SearchField.body('نص مشترك')]),
      ]);
      expect(
        index
            .search(
              'مشترك',
              filter: const SearchFilter(kinds: {SearchKind.companion}),
            )
            .map((h) => h.document.id),
        ['c'],
      );
      expect(
        index
            .search('مشترك', filter: const SearchFilter(parentId: 'c'))
            .map((h) => h.document.id)
            .toSet(),
        {'c', 's1'},
      );
    });
  });

  group('what is indexed', () {
    LocalizedText ar(String text) => LocalizedText(ar: text);

    test('prose, lessons, disputes and complete quotes', () {
      final text = searchableText([
        ContentBlock.paragraph(
          text: ar('فقرة'),
          reliability: Reliability.established,
          citations: const [],
        ),
        ContentBlock.lesson(text: ar('درس')),
        ContentBlock.reportQuote(
          textStatus: TextStatus.complete,
          reliability: Reliability.reported,
          citations: const [],
          text: ar('أثر منقول'),
        ),
        ContentBlock.disputeNote(
          text: ar('اختُلف'),
          opinions: [Opinion(text: ar('قول'), citations: const [])],
        ),
      ]);
      expect(text, ['فقرة', 'درس', 'أثر منقول', 'اختُلف', 'قول']);
    });

    test('never a quote still pending from its source, nor its summary', () {
      final text = searchableText([
        ContentBlock.hadithQuote(
          textStatus: TextStatus.pendingFromSource,
          reliability: Reliability.established,
          citations: const [],
          summary: ar('ملخص محايد بانتظار النص'),
        ),
        ContentBlock.reportQuote(
          textStatus: TextStatus.pendingFromSource,
          reliability: Reliability.reported,
          citations: const [],
          text: ar('نص مؤقت'),
        ),
      ]);
      expect(text, isEmpty);
    });
  });

  group('the real catalog', () {
    test('a phrase from a section body finds that section', () async {
      final container = ProviderContainer(
        retry: noAutomaticRetry,
        overrides: [
          assetBundleProvider.overrideWithValue(
            MemoryAssetBundle.builtContent(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final index = await container.read(searchIndexProvider.future);
      expect(index.isComplete, isTrue);
      final hit = index
          .search('بني تيم')
          .firstWhere((h) => h.document.kind == SearchKind.section);
      expect(hit.document.id, 'abu-bakr.early-life');
      expect(hit.excerpt, isNotNull);
    });
  });

  group('an incomplete index', () {
    MemoryAssetBundle broken() {
      final bundle = MemoryAssetBundle.builtContent();
      bundle.files['assets/content/companions/umar.json'] = '{}';
      return bundle;
    }

    test('counts what could not be loaded', () async {
      final container = ProviderContainer(
        retry: noAutomaticRetry,
        overrides: [assetBundleProvider.overrideWithValue(broken())],
      );
      addTearDown(container.dispose);
      final index = await container.read(searchIndexProvider.future);
      expect(index.unavailable, 1);
      expect(index.isComplete, isFalse);
    });

    testApp('says results may be missing, even when there are none', (
      tester,
    ) async {
      final bundle = broken();
      final good = MemoryAssetBundle.builtContent()
          .files['assets/content/companions/umar.json']!;
      final app = AppUnderTest(location: '/search', bundle: bundle);
      await app.pump(tester);
      await tester.enterText(find.byType(TextField), 'كلمة لا توجد');
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
      expect(
        find.text('تعذّر تحميل بعض المحتوى، فقد تكون النتائج ناقصة.'),
        findsOneWidget,
      );
      expect(find.textContaining('فيما أمكن تحميله'), findsOneWidget);

      bundle.files['assets/content/companions/umar.json'] = good;
      await tester.tap(find.text('إعادة المحاولة'));
      await tester.pumpAndSettle();
      expect(find.textContaining('تعذّر تحميل بعض المحتوى'), findsNothing);
      expect(find.text('لا نتائج لـ «كلمة لا توجد»'), findsOneWidget);
    });
  });

  testApp('filter chips narrow the results', (tester) async {
    final app = AppUnderTest(location: '/search');
    await app.pump(tester);
    await tester.enterText(find.byType(TextField), 'الغار');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();
    Finder heading(String text) =>
        find.descendant(of: find.byType(ListView), matching: find.text(text));
    expect(heading('فصول القصص'), findsOneWidget);
    expect(heading('أقسام السيرة'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'السِّيَر'));
    await tester.pumpAndSettle();
    expect(heading('فصول القصص'), findsNothing);
    expect(heading('أقسام السيرة'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'القصص'));
    await tester.pumpAndSettle();
    expect(heading('فصول القصص'), findsOneWidget);
    expect(heading('أقسام السيرة'), findsNothing);
  });
}
