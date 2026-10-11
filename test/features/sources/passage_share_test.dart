import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/share/share_service.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/features/sources/presentation/passage_share.dart';

import '../../helpers/app_harness.dart';

class _RecordingShare implements ShareService {
  final shared = <(String, String?)>[];

  @override
  Future<void> shareText(String text, {String? subject, Rect? origin}) async {
    shared.add((text, subject));
  }
}

/// F19: sharing a passage with its sources.
void main() {
  group('formatPassageShare', () {
    const passage = PassageShare(
      text: ' نص الفقرة. ',
      origin: 'أبو بكر — الهجرة',
    );

    test('quotes the passage, names its origin and lists each source', () {
      final text = formatPassageShare(
        passage: passage,
        sources: [
          (title: 'صحيح البخاري', locator: 'رقم ٣٩٠٥', grading: null),
          (title: 'الإصابة', locator: 'ج ٤ · ص ١٧٤', grading: 'صحيح — البخاري'),
        ],
        sourcesHeading: 'المصادر:',
        reliabilityLine: 'درجة الخبر: ثابت',
        draftLine: 'تنبيه: مسودة.',
        appLine: 'من التطبيق',
      );
      expect(text.split('\n'), [
        '«نص الفقرة.»',
        '— أبو بكر — الهجرة',
        '',
        'المصادر:',
        '• صحيح البخاري، رقم ٣٩٠٥',
        '• الإصابة، ج ٤ · ص ١٧٤ (صحيح — البخاري)',
        '',
        'درجة الخبر: ثابت',
        'تنبيه: مسودة.',
        '',
        'من التطبيق',
      ]);
    });

    test('reviewed text without a grade has no notes section', () {
      final text = formatPassageShare(
        passage: passage,
        sources: const [],
        sourcesHeading: 'المصادر:',
        appLine: 'من التطبيق',
      );
      expect(text, '«نص الفقرة.»\n— أبو بكر — الهجرة\n\nمن التطبيق');
    });
  });

  testApp('a reader shares a passage with its sources and draft status', (
    tester,
  ) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
    final share = _RecordingShare();
    await AppUnderTest(
      location: '/companions/abu-bakr/sections/abu-bakr.hijrah',
      overrides: [shareServiceProvider.overrideWithValue(share)],
    ).pump(tester);

    await tester.tap(find.byType(CitationMarker).first);
    await tester.pumpAndSettle();
    expect(find.byType(CitationSheet), findsOneWidget);
    await tester.tap(find.text('مشاركة المقطع مع مصادره'));
    await tester.pumpAndSettle();

    final (text, subject) = share.shared.single;
    expect(subject, 'أبو بكر الصديق — صاحبه في الهجرة');
    final lines = text.split('\n');
    expect(lines.first, startsWith('«صحب النبيَّ ﷺ في هجرته'));
    expect(lines[1], '— أبو بكر الصديق — صاحبه في الهجرة');
    expect(lines, contains('المصادر:'));
    expect(lines, contains('• الجامع الصحيح (صحيح البخاري)، رقم ٣٩٠٥'));
    expect(lines, contains('درجة الخبر: ثابت'));
    // Draft content never leaves the app without saying so.
    expect(
      lines,
      contains(
        'تنبيه: نص تجريبي لم يراجعه مختص بعد، والمصادر ومواضعها مبدئية.',
      ),
    );
    expect(lines.last, 'من تطبيق سِيَر الصحابة');
  });

  testApp('sources without a passage offer no sharing', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
    await AppUnderTest(location: '/companions/abu-bakr/timeline').pump(tester);
    await tester.tap(find.byType(CitationMarker).first);
    await tester.pumpAndSettle();
    expect(find.byType(CitationSheet), findsOneWidget);
    expect(find.text('مشاركة المقطع مع مصادره'), findsNothing);
  });
}
