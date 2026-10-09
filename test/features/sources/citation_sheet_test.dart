import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/app/provider_retry.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/core/domain/quran_ref.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

import '../../helpers/content_bundle.dart';
import '../../helpers/pump_app.dart';

void main() {
  Future<void> pumpSheet(
    WidgetTester tester,
    List<Citation> citations, {
    bool provisional = false,
    Reliability? reliability,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        retry: noAutomaticRetry,
        overrides: [
          assetBundleProvider.overrideWithValue(
            MemoryAssetBundle.builtContent(),
          ),
        ],
        child: testHarness(
          theme: AppTheme.light,
          child: Scaffold(
            body: CitationSheet(
              citations: citations,
              provisional: provisional,
              reliability: reliability,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a complete locator with grading', (tester) async {
    await pumpSheet(tester, [
      const Citation(
        sourceId: 'bukhari',
        locatorStatus: LocatorStatus.complete,
        chapterTitle: LocalizedText(ar: 'كتاب فضائل أصحاب النبي ﷺ'),
        volume: 5,
        page: '12–13',
        hadithNumber: '3653',
        grading: Grading(
          grade: HadithGrade.sahih,
          gradedBy: LocalizedText(ar: 'البخاري'),
        ),
      ),
    ]);
    expect(find.text('الجامع الصحيح (صحيح البخاري)'), findsOneWidget);
    expect(find.text('محمد بن إسماعيل البخاري (ت ٢٥٦ هـ)'), findsOneWidget);
    expect(
      find.text('كتاب فضائل أصحاب النبي ﷺ · ج ٥ · ص ١٢–١٣ · رقم ٣٦٥٣'),
      findsOneWidget,
    );
    expect(find.text('صحيح — البخاري'), findsOneWidget);
  });

  testWidgets('a pending locator says it awaits verification', (tester) async {
    await pumpSheet(tester, [
      const Citation(sourceId: 'siyar', locatorStatus: LocatorStatus.pending),
    ]);
    expect(find.text('سير أعلام النبلاء'), findsOneWidget);
    expect(find.text('الموضع بانتظار التحقق'), findsOneWidget);
  });

  testWidgets('a Qur\'an reference is shown by surah and ayah', (tester) async {
    await pumpSheet(tester, [
      const Citation(
        sourceId: 'quran',
        locatorStatus: LocatorStatus.complete,
        quranRef: QuranRef(surah: 3, ayahFrom: 123),
      ),
    ]);
    expect(find.text('آل عمران: ١٢٣'), findsOneWidget);
  });

  testWidgets('an unknown source falls back gracefully', (tester) async {
    await pumpSheet(tester, [
      const Citation(sourceId: 'missing', locatorStatus: LocatorStatus.pending),
    ]);
    expect(find.text('مصدر غير معروف'), findsOneWidget);
  });

  testWidgets('reliability is explained; drafts carry the notice', (
    tester,
  ) async {
    await pumpSheet(
      tester,
      const [Citation(sourceId: 'siyar', locatorStatus: LocatorStatus.pending)],
      reliability: Reliability.reported,
      provisional: true,
    );
    expect(
      find.text('وردت في كتب السيرة والتاريخ، ولم يُحكم على إسنادها.'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<ReliabilityBadge>(find.byType(ReliabilityBadge))
          .provisional,
      isTrue,
    );
    expect(find.textContaining('مسودة لم يراجعها مختص'), findsOneWidget);
  });

  testWidgets('approved content has no draft notice', (tester) async {
    await pumpSheet(tester, const [
      Citation(sourceId: 'siyar', locatorStatus: LocatorStatus.pending),
    ]);
    expect(find.textContaining('مسودة'), findsNothing);
  });
}
