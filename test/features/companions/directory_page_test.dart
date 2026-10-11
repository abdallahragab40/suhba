import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/widgets/companion_card.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_banner.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/features/companions/domain/directory_filter.dart';
import 'package:siyar_sahaba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';

List<String> _cardNames(WidgetTester tester) => [
  for (final card in tester.widgetList<CompanionCard>(
    find.byType(CompanionCard),
  ))
    card.name,
];

void main() {
  group('filterCompanions', () {
    CompanionSummary summary(String id, List<String> categories) =>
        CompanionSummary(
          id: id,
          gender: Gender.male,
          name: LocalizedText(ar: id),
          summary: const LocalizedText(ar: ''),
          review: const ReviewInfo(status: ReviewStatus.draft),
          categoryIds: categories,
        );
    final all = [
      summary('a', ['x']),
      summary('b', ['x', 'y']),
      summary('c', ['y']),
    ];

    test('null means everyone, in order', () {
      expect(filterCompanions(all, null).map((c) => c.id), ['a', 'b', 'c']);
    });

    test('filters by category, keeping order', () {
      expect(filterCompanions(all, 'y').map((c) => c.id), ['b', 'c']);
    });
  });

  testApp('lists the Ten first and in order, each labelled', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(800, 6000);
    addTearDown(tester.view.reset);
    await AppUnderTest(
      location: '/companions?category=ashara-mubashshara',
    ).pump(tester);

    expect(_cardNames(tester), [
      'أبو بكر الصديق',
      'عمر بن الخطاب',
      'عثمان بن عفان',
      'علي بن أبي طالب',
      'طلحة بن عبيد الله',
      'الزبير بن العوام',
      'عبد الرحمن بن عوف',
      'سعد بن أبي وقاص',
      'سعيد بن زيد',
      'أبو عبيدة بن الجراح',
    ]);
    expect(find.byType(DraftBanner), findsOneWidget);
    expect(find.byType(DraftBadge), findsNWidgets(10));
    expect(find.text('رضي الله عنه'), findsNWidgets(10));
  });

  testApp('everyone is listed, beyond the Ten', (tester) async {
    await AppUnderTest(location: '/companions').pump(tester);
    expect(_cardNames(tester).first, 'أبو بكر الصديق');
    await tester.scrollUntilVisible(
      find.text('عبد الله بن رواحة'),
      600,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('عبد الله بن رواحة'), findsOneWidget);
  });

  testApp('the category filter narrows the list and updates the URL', (
    tester,
  ) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(800, 6000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: '/companions');
    await app.pump(tester);

    await tester.tap(find.widgetWithText(ChoiceChip, 'الخلفاء الراشدون'));
    await tester.pumpAndSettle();

    expect(app.location, '/companions?category=khulafa-rashidun');
    expect(_cardNames(tester), [
      'أبو بكر الصديق',
      'عمر بن الخطاب',
      'عثمان بن عفان',
      'علي بن أبي طالب',
    ]);

    await tester.tap(find.widgetWithText(ChoiceChip, 'الكل'));
    await tester.pumpAndSettle();
    expect(app.location, '/companions');
  });

  testApp('an unknown category in the URL shows everyone', (tester) async {
    await AppUnderTest(location: '/companions?category=nope').pump(tester);
    final all = tester.widget<ChoiceChip>(
      find.widgetWithText(ChoiceChip, 'الكل'),
    );
    expect(all.selected, isTrue);
  });

  testApp('tapping a card opens the profile; back keeps the filter', (
    tester,
  ) async {
    final app = AppUnderTest(location: '/companions?category=khulafa-rashidun');
    await app.pump(tester);

    await tester.tap(find.text('عمر بن الخطاب'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
    expect(app.location, '/companions/umar');

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(app.location, '/companions?category=khulafa-rashidun');
  });

  testApp('shows an error with retry when the index cannot load', (
    tester,
  ) async {
    final bundle = MemoryAssetBundle.builtContent();
    final index = bundle.files.remove('assets/content/index/companions.json')!;
    await AppUnderTest(location: '/companions', bundle: bundle).pump(tester);
    expect(find.byType(ErrorView), findsOneWidget);

    bundle.files['assets/content/index/companions.json'] = index;
    await tester.tap(find.text('إعادة المحاولة'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionCard), findsWidgets);
  });

  testApp('approved companions carry no draft badge', (tester) async {
    final bundle = MemoryAssetBundle.builtContent()
      ..editJson('assets/content/index/companions.json', (json) {
        ((json['companions'] as List).first as Map)['review'] = {
          'status': 'approved',
        };
      });
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(800, 6000);
    addTearDown(tester.view.reset);
    await AppUnderTest(
      location: '/companions?category=ashara-mubashshara',
      bundle: bundle,
    ).pump(tester);
    expect(find.byType(DraftBadge), findsNWidgets(9));
    expect(
      find.descendant(
        of: find.widgetWithText(CompanionCard, 'أبو بكر الصديق'),
        matching: find.byType(DraftBadge),
      ),
      findsNothing,
    );
  });

  testApp('no overflow at text scale 2.0', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await AppUnderTest(location: '/companions').pump(tester);
    expect(tester.takeException(), isNull);
    expect(find.byType(CompanionCard), findsWidgets);
  });

  testApp('meets tap-target and labelling guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    await AppUnderTest(location: '/companions').pump(tester);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}
