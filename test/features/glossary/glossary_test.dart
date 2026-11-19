import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/features/glossary/presentation/glossary_page.dart';
import 'package:suhba/shared/content/domain/glossary.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';
import 'package:suhba/shared/content/presentation/glossary_links.dart';

import '../../helpers/app_harness.dart';

/// E3 (review A3): terms are linked at their first use in a passage and
/// open a short cited definition.
void main() {
  GlossaryTerm term(String id, List<String> forms) => GlossaryTerm(
    id: id,
    term: LocalizedText(ar: forms.first),
    forms: forms,
    definition: const LocalizedText(ar: 'تعريف'),
    reliability: Reliability.established,
    citations: const [],
    review: const ReviewInfo(status: ReviewStatus.draft),
  );

  group('matching', () {
    final matcher = GlossaryMatcher([
      term('ansar', ['الأنصار']),
      term('bayah', ['بيعة']),
      term('ridwan', ['بيعة الرضوان']),
    ]);
    List<String> found(String text, [Set<String>? seen]) => [
      for (final m in matcher.firstMatches(text, seen ?? {}))
        text.substring(m.start, m.end),
    ];

    test('whatever the tashkeel, and after a one-letter prefix', () {
      expect(found('وجاءَ الأنْصارُ'), ['الأنْصارُ']);
      expect(
        found('فقال للأنصار'),
        isEmpty,
        reason: 'ل+ال is a different word',
      );
      expect(found('والأنصار'), ['الأنصار']);
    });

    test('whole words only', () {
      expect(found('الأنصاري'), isEmpty);
    });

    test('the longest form wins, and each term once a passage', () {
      expect(found('بايعوا بيعة الرضوان ثم بيعة أخرى'), [
        'بيعة الرضوان',
        'بيعة',
      ]);
      final seen = <String>{};
      expect(found('الأنصار', seen), ['الأنصار']);
      expect(found('الأنصار مرة أخرى', seen), isEmpty);
    });
  });

  testApp('a linked term opens its definition', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 4000);
    addTearDown(tester.view.reset);
    await AppUnderTest(
      location: '/companions/abu-bakr/sections/abu-bakr.hijrah',
    ).pump(tester);
    final rich = find.byWidgetPredicate(
      (w) =>
          w is RichText &&
          w.text.toPlainText().contains('الهجرة') &&
          _hasLink(w.text),
    );
    expect(rich, findsWidgets);
    // Tap the linked span itself.
    _link(tester.widget<RichText>(rich.first).text, 'الهجرة')!.onTap!();
    await tester.pumpAndSettle();
    expect(find.text('مصطلح'), findsOneWidget);
    expect(
      find.textContaining('خروج النبي ﷺ وأصحابه من مكة إلى المدينة'),
      findsOneWidget,
    );
    await tester.tap(find.text('كل المصطلحات'));
    await tester.pumpAndSettle();
    expect(find.byType(GlossaryPage), findsOneWidget);
  });

  testApp('the glossary lists every term, from Explore', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 4000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: '/explore');
    await app.pump(tester);
    await tester.tap(find.text('المصطلحات'));
    await tester.pumpAndSettle();
    expect(app.location, '/glossary');
    expect(find.byType(ListTile), findsNWidgets(30));
  });
}

bool _hasLink(InlineSpan span) {
  var linked = false;
  span.visitChildren((s) {
    if (s is TextSpan && s.recognizer != null) linked = true;
    return !linked;
  });
  return linked;
}

TapGestureRecognizer? _link(InlineSpan span, String text) {
  TapGestureRecognizer? found;
  span.visitChildren((s) {
    if (s is TextSpan &&
        s.recognizer is TapGestureRecognizer &&
        (s.text ?? '').contains(text)) {
      found = s.recognizer! as TapGestureRecognizer;
    }
    return found == null;
  });
  return found;
}
