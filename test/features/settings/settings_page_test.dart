import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';
import 'package:siyar_sahaba/features/home/presentation/home_page.dart';
import 'package:siyar_sahaba/features/sources/presentation/about_page.dart';
import 'package:siyar_sahaba/features/sources/presentation/sources_page.dart';

import '../../helpers/app_harness.dart';

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
    final first = AppUnderTest(location: '/settings', settings: store);
    await first.pump(tester);

    await tester.tap(find.text('داكن'));
    await tester.tap(find.text('غربية (123)'));
    await tester.pumpAndSettle();
    expect(find.text('حجم خط القراءة: 19'), findsOneWidget);

    expect(store.getString(SettingsKeys.themeMode), 'dark');
    expect(store.getString(SettingsKeys.digitStyle), 'western');

    // A second app on the same store starts with the saved choices.
    final second = AppUnderTest(settings: store);
    await second.pump(tester);
    final background = Theme.of(
      tester.element(find.byType(HomePage)),
    ).scaffoldBackgroundColor;
    expect(background, Palette.ink);
  });

  testApp('the content version and channel are shown', (tester) async {
    tall(tester);
    await AppUnderTest(location: '/settings').pump(tester);
    expect(find.text('إصدار المحتوى: 0.2.0'), findsOneWidget);
    expect(find.text('محتوى تجريبي (مسودة)'), findsOneWidget);
  });

  testApp('about explains method, reliability, review and images', (
    tester,
  ) async {
    tall(tester);
    await AppUnderTest(location: '/settings').pump(tester);
    await tester.tap(find.text('عن التطبيق والمنهج'));
    await tester.pumpAndSettle();
    expect(find.byType(AboutPage), findsOneWidget);
    expect(find.textContaining('أهل السنة والجماعة'), findsOneWidget);
    expect(find.textContaining('ولا تتناول تفاصيل الفتنة'), findsOneWidget);
    expect(find.textContaining('لم يُراجَع المحتوى بعد'), findsOneWidget);
    expect(find.textContaining('لا يتضمن التطبيق صورًا'), findsOneWidget);
    for (final level in ['ثابت', 'رواية تاريخية', 'مختلف فيه', 'غير معروف']) {
      expect(find.text(level), findsOneWidget, reason: level);
    }
  });

  testApp('the sources directory groups works by kind', (tester) async {
    tall(tester);
    await AppUnderTest(location: '/settings/sources').pump(tester);
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
