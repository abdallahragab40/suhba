@Tags(['golden'])
library;

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/features/sources/domain/share_card_policy.dart';
import 'package:suhba/features/sources/presentation/passage_card.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../../core/design_system/contrast_test.dart' show contrast;
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(loadAppFonts);
  test('only approved published cards are enabled without a debug preview', () {
    for (final channel in [null, ...ContentChannel.values]) {
      for (final provisional in [true, false]) {
        expect(
          canShareCard(
            channel: channel,
            provisional: provisional,
            preview: false,
          ),
          channel == ContentChannel.published && !provisional,
        );
      }
    }
    expect(
      canShareCard(
        channel: ContentChannel.draft,
        provisional: true,
        preview: true,
      ),
      isTrue,
    );
  });
  test('excerpt preserves wording and cuts only at sentence boundaries', () {
    expect(cardExcerpt('  نص موجز.  '), 'نص موجز.');
    expect(
      cardExcerpt('الجملة الأولى. ${List.filled(65, 'كلمة').join(' ')}'),
      'الجملة الأولى. …',
    );
    expect(cardExcerpt(List.filled(65, 'كلمة').join(' ')), isNull);
    expect(cardExcerpt('  '), isNull);
  });
  test('oversized sources cannot reduce an excerpt below readable size', () {
    expect(
      passageCardFits(
        excerpt: 'نص قصير.',
        origin: 'الموضع',
        sources: 'المصدر: كتاب',
        footer: 'صُحبة',
      ),
      isTrue,
    );
    expect(
      passageCardFits(
        excerpt: 'نص قصير.',
        origin: 'الموضع',
        sources: List.filled(80, 'مصدر كامل مع موضعه').join('\n'),
        footer: 'صُحبة',
      ),
      isFalse,
    );
  });
  test('every template and accent stays legible (K6)', () {
    for (final t in PassageCardTemplate.values) {
      // Body text, sources and footer: normal-size text.
      expect(contrast(t.text, t.background), greaterThanOrEqualTo(4.5));
      for (final a in PassageCardAccent.values) {
        // The wordmark (26 px) and the rule: large text and graphics.
        expect(
          contrast(a.on(t), t.background),
          greaterThanOrEqualTo(3),
          reason: '${a.name} on ${t.name}',
        );
      }
    }
  });
  // One golden per template; the story size and the accents on top.
  for (final (size, template, accent) in [
    (PassageCardSize.square, PassageCardTemplate.paper, PassageCardAccent.gold),
    (PassageCardSize.square, PassageCardTemplate.green, PassageCardAccent.gold),
    (PassageCardSize.square, PassageCardTemplate.night, PassageCardAccent.gold),
    (PassageCardSize.story, PassageCardTemplate.paper, PassageCardAccent.green),
    (PassageCardSize.story, PassageCardTemplate.night, PassageCardAccent.plain),
  ]) {
    final name = '${size.name}_${template.name}_${accent.name}';
    testWidgets('$name export and golden', (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(400, 800);
      addTearDown(tester.view.reset);
      final key = GlobalKey();
      await tester.pumpWidget(
        testHarness(
          theme: AppTheme.light,
          child: Center(
            child: RepaintBoundary(
              key: key,
              child: PassageCard(
                excerpt:
                    'قراءة السيرة تعين على فهم المواقف في سياقها، والعودة إلى مصادرها تفتح باب التعلّم والتأمّل.',
                origin: 'نموذج تصميم — ليست رواية تاريخية',
                sources: 'المصادر:\nنص تجريبي لا ينسب إلى مصدر تاريخي.',
                footer: 'تطبيق صُحبة • السيرة والصحابة',
                size: size,
                template: template,
                accent: accent,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byKey(key),
        matchesGoldenFile('goldens/card_$name.png'),
      );
      final capture = capturePassageCard(key);
      await tester.pump();
      final bytes = await tester.runAsync(() => capture);
      expect(bytes, isNotNull);
      await tester.runAsync(() async {
        final codec = await ui.instantiateImageCodec(bytes!);
        final frame = await codec.getNextFrame();
        expect(frame.image.width, 1080);
        expect(
          frame.image.height,
          size == PassageCardSize.square ? 1080 : 1920,
        );
        frame.image.dispose();
        codec.dispose();
      });
    });
  }
}
