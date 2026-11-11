import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/share/share_service.dart';
import 'package:suhba/features/sources/domain/share_card_policy.dart';
import 'package:suhba/features/sources/presentation/citation_sheet.dart';
import 'package:suhba/features/sources/presentation/passage_share.dart';
import 'package:suhba/features/sources/presentation/share_card_sheet.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/recording_share.dart';

/// F19: sharing a passage with its sources.
void main() {
  setUpAll(loadAppFonts);
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
    final share = RecordingShare();
    await AppUnderTest(
      location: '/companions/abu-bakr/sections/abu-bakr.hijrah',
      overrides: [shareServiceProvider.overrideWithValue(share)],
    ).pump(tester);

    await tester.tap(find.byType(CitationMarker).first);
    await tester.pumpAndSettle();
    expect(find.byType(CitationSheet), findsOneWidget);
    expect(find.text('بطاقة'), findsNothing);
    await tester.tap(find.text('مشاركة المقطع مع مصادره'));
    await tester.pumpAndSettle();

    final (text, subject) = share.texts.single;
    expect(subject, 'أبو بكر الصديق — صاحبه في الهجرة');
    final lines = text.split('\n');
    expect(lines.first, startsWith('«صحب النبيَّ ﷺ في هجرته'));
    expect(lines[1], '— أبو بكر الصديق — صاحبه في الهجرة');
    expect(lines, contains('المصادر:'));
    expect(lines, contains('• الجامع الصحيح (صحيح البخاري)، رقم ٣٩٠٥'));
    expect(lines, contains('درجة الخبر: ثابت'));
    // Draft content never leaves the app without saying so.
    expect(lines, contains('المحتوى قيد المراجعة ولم يكتمل اعتماده العلمي.'));
    expect(lines.last, 'من تطبيق صُحبة');
  });

  testApp('debug preview shares a PNG only after explicit share', (
    tester,
  ) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
    final share = _ImageShare();
    await AppUnderTest(
      location: '/companions/abu-bakr/sections/abu-bakr.hijrah',
      overrides: [
        shareServiceProvider.overrideWithValue(share),
        shareCardPreviewProvider.overrideWithValue(true),
      ],
    ).pump(tester);
    await tester.tap(find.byType(CitationMarker).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('بطاقة'));
    await tester.pumpAndSettle();
    expect(find.byType(ShareCardSheet), findsOneWidget);
    final semantics = tester.ensureSemantics();
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    semantics.dispose();
    expect(share.image, isNull);
    expect(
      find.text('المحتوى قيد المراجعة ولم يكتمل اعتماده العلمي.'),
      findsWidgets,
    );
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    tester.platformDispatcher.clearTextScaleFactorTestValue();
    await tester.tap(find.text('قصة'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('مشاركة البطاقة'));
    await tester.pump();
    await tester.runAsync(() async {
      for (var i = 0; i < 30 && share.image == null; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
    });
    await tester.pumpAndSettle();
    expect(share.image, isNotNull);
    expect(share.image!.take(8), [137, 80, 78, 71, 13, 10, 26, 10]);
    expect(share.fileName, 'suhba-story.png');
    expect(share.mimeType, 'image/png');
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

class _ImageShare extends RecordingShare {
  Uint8List? image;
  String? fileName, mimeType;
  @override
  Future<void> shareFile(
    Uint8List bytes, {
    required String fileName,
    required String mimeType,
    String? subject,
    Rect? origin,
  }) async {
    image = bytes;
    this.fileName = fileName;
    this.mimeType = mimeType;
  }
}
