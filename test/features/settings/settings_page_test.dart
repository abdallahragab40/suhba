import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/home/presentation/home_page.dart';
import 'package:suhba/features/reading_progress/presentation/reading_history_page.dart';
import 'package:suhba/features/settings/presentation/feedback_tile.dart';
import 'package:suhba/features/settings/presentation/settings_page.dart';
import 'package:suhba/features/sources/presentation/about_page.dart';
import 'package:suhba/features/sources/presentation/sources_page.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';

void main() {
  void tall(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(800, 2400);
    addTearDown(tester.view.reset);
  }

  testApp('choices persist across a restart', (tester) async {
    tall(tester);
    final store = MemorySettingsStore();
    final first = AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      location: '/settings',
      settings: store,
    );
    await first.pump(tester);

    await tester.tap(find.text('داكن'));
    await tester.tap(find.text('غربية (123)'));
    await tester.pumpAndSettle();
    expect(find.text('حجم خط القراءة: 20'), findsOneWidget);

    expect(store.getString(SettingsKeys.themeMode), 'dark');
    expect(store.getString(SettingsKeys.digitStyle), 'western');

    // A second app on the same store starts with the saved choices.
    final second = AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      settings: store,
    );
    await second.pump(tester);
    final background = Theme.of(
      tester.element(find.byType(HomePage)),
    ).scaffoldBackgroundColor;
    expect(background, Palette.night);
  });

  testApp('back from a Settings page returns to Settings, then home', (
    tester,
  ) async {
    tall(tester);
    final app = AppUnderTest(bundle: MemoryAssetBundle.draftContent());
    await app.pump(tester);
    await tester.tap(find.byTooltip('الإعدادات'));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);

    for (final (label, page) in [
      ('سجل القراءة', ReadingHistoryPage),
      ('عن التطبيق والمنهج', AboutPage),
      ('المصادر المعتمدة', SourcesPage),
    ]) {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      expect(find.byType(page), findsOneWidget, reason: label);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(app.location, '/settings', reason: label);
      expect(find.byType(SettingsPage), findsOneWidget, reason: label);
    }

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(app.location, '/home');
  });

  test('the feedback link is addressed and encoded for mail apps', () {
    final uri = FeedbackTile.mailto(
      subject: 'ملاحظات على صُحبة',
      body: 'سطر\nثانٍ',
    );
    expect(uri.scheme, 'mailto');
    expect(uri.path, feedbackEmail);
    expect(uri.toString(), isNot(contains('+')));
    expect(uri.queryParameters['subject'], 'ملاحظات على صُحبة');
    expect(uri.queryParameters['body'], 'سطر\nثانٍ');
  });

  Future<List<Object?>> mockClipboard(WidgetTester tester) async {
    final copied = <Object?>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') copied.add(call.arguments);
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    return copied;
  }

  Future<void> writeFeedback(WidgetTester tester, String message) async {
    await tester.tap(find.text('أرسل ملاحظاتك'));
    await tester.pumpAndSettle();
    expect(find.byType(FeedbackSheet), findsOneWidget);
    // Nothing to send until something is written.
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'اكتب الرسالة في البريد'),
          )
          .onPressed,
      isNull,
    );
    await tester.tap(find.text('مشكلة في التطبيق'));
    await tester.enterText(find.byType(TextField), message);
    await tester.pump();
    await tester.tap(find.text('اكتب الرسالة في البريد'));
    await tester.pumpAndSettle();
  }

  testApp('feedback opens the mail app with kind, message and details', (
    tester,
  ) async {
    tall(tester);
    final opened = <Uri>[];
    await AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      location: '/settings',
      overrides: [
        mailLauncherProvider.overrideWithValue((uri) async {
          opened.add(uri);
          return true;
        }),
      ],
    ).pump(tester);
    await writeFeedback(tester, 'الشاشة لا تتحرك');

    final uri = opened.single;
    expect(uri.path, feedbackEmail);
    expect(
      uri.queryParameters['subject'],
      'مشكلة في التطبيق — ملاحظات على تطبيق صُحبة',
    );
    final body = uri.queryParameters['body']!;
    expect(body, startsWith('الشاشة لا تتحرك'));
    expect(body, contains('معلومات التطبيق'));
    expect(body, contains('المحتوى: '));
    expect(find.byType(FeedbackSheet), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
  });

  testApp('without a mail app the whole message is copied', (tester) async {
    tall(tester);
    final copied = await mockClipboard(tester);
    await AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      location: '/settings',
      overrides: [mailLauncherProvider.overrideWithValue((uri) async => false)],
    ).pump(tester);
    await writeFeedback(tester, 'رسالة');

    final text = (copied.single! as Map)['text'] as String;
    expect(text, startsWith(feedbackEmail));
    expect(text, contains('رسالة'));
    expect(find.textContaining(feedbackEmail), findsOneWidget);
  });

  testApp('the address can be copied from the sheet', (tester) async {
    tall(tester);
    final copied = await mockClipboard(tester);
    await AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      location: '/settings',
    ).pump(tester);
    await tester.tap(find.text('أرسل ملاحظاتك'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('نسخ العنوان'));
    await tester.pumpAndSettle();
    expect(copied, [
      {'text': feedbackEmail},
    ]);
  });

  testApp('app details can be left out', (tester) async {
    tall(tester);
    final opened = <Uri>[];
    await AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      location: '/settings',
      overrides: [
        mailLauncherProvider.overrideWithValue((uri) async {
          opened.add(uri);
          return true;
        }),
      ],
    ).pump(tester);
    await tester.tap(find.text('أرسل ملاحظاتك'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(FeedbackSheet),
        matching: find.byType(Switch),
      ),
    );
    await tester.enterText(find.byType(TextField), 'شكرًا');
    await tester.pump();
    await tester.tap(find.text('اكتب الرسالة في البريد'));
    await tester.pumpAndSettle();
    expect(opened.single.queryParameters['body'], 'شكرًا');
  });

  testApp('the content version and channel are shown', (tester) async {
    tall(tester);
    await AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      location: '/settings',
    ).pump(tester);
    expect(find.text('إصدار المحتوى: 0.3.0'), findsOneWidget);
    expect(find.text('محتوى تجريبي (مسودة)'), findsOneWidget);
  });

  testApp('about explains method, reliability, review, images and privacy', (
    tester,
  ) async {
    tall(tester);
    await AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      location: '/settings',
    ).pump(tester);
    await tester.tap(find.text('عن التطبيق والمنهج'));
    await tester.pumpAndSettle();
    expect(find.byType(AboutPage), findsOneWidget);
    expect(find.textContaining('أهل السنة والجماعة'), findsOneWidget);
    expect(find.textContaining('ولا تتناول تفاصيل الفتنة'), findsOneWidget);
    expect(
      find.textContaining('لم يعتمد المحتوى مختص مؤهل بعد'),
      findsOneWidget,
    );
    expect(find.textContaining('لا يتضمن التطبيق صورًا'), findsOneWidget);
    expect(find.text('الخصوصية'), findsOneWidget);
    expect(
      find.textContaining('لا يجمع التطبيق أي بيانات عنك'),
      findsOneWidget,
    );
    expect(find.textContaining('لا يُقرأ موقعك إلا حين تطلب'), findsOneWidget);
    for (final level in ['ثابت', 'رواية تاريخية', 'مختلف فيه', 'غير معروف']) {
      expect(find.text(level), findsOneWidget, reason: level);
    }
  });

  testApp('the sources directory groups works by kind', (tester) async {
    tall(tester);
    await AppUnderTest(
      bundle: MemoryAssetBundle.draftContent(),
      location: '/settings/sources',
    ).pump(tester);
    expect(find.byType(SourcesPage), findsOneWidget);
    for (final group in [
      'القرآن الكريم',
      'كتب الحديث',
      'كتب التراجم',
      'كتب التاريخ',
      'كتب السيرة',
    ]) {
      expect(find.text(group), findsWidgets, reason: group);
    }
    expect(find.text('سير أعلام النبلاء'), findsOneWidget);
    expect(find.text('شمس الدين الذهبي (ت ٧٤٨ هـ)'), findsOneWidget);

    // The verse text's source, licence and notice (O3).
    await tester.scrollUntilVisible(
      find.text('نص الترخيص'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Tanzil Quran Text (Uthmani, Version 1.1)'),
      findsOneWidget,
    );
    expect(find.textContaining('tanzil.net'), findsOneWidget);
    await tester.tap(find.text('نص الترخيص'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CHANGING IT IS NOT ALLOWED'), findsOneWidget);
  });
}
