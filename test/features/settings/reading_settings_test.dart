import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/settings/presentation/reading_settings.dart';

import '../../helpers/app_harness.dart';

void main() {
  Future<AppUnderTest> openReader(WidgetTester tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(
      location: '/companions/abu-bakr/sections/abu-bakr.death',
    );
    await app.pump(tester);
    return app;
  }

  double paragraphSize(WidgetTester tester) => tester
      .widget<Text>(find.textContaining('توفي بالمدينة'))
      .style!
      .fontSize!;

  test('the size starts at 19 and is clamped and rounded', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final size = readingTextSizeProvider;
    expect(container.read(size), 19);
    container.read(size.notifier).select(10);
    expect(container.read(size), 16);
    container.read(size.notifier).select(30);
    expect(container.read(size), 28);
    container.read(size.notifier).select(20.6);
    expect(container.read(size), 21);
  });

  testApp('changing the size applies live to the open reader', (tester) async {
    final app = await openReader(tester);
    expect(paragraphSize(tester), 19);

    app.container.read(readingTextSizeProvider.notifier).select(24.4);
    await tester.pumpAndSettle();
    expect(paragraphSize(tester), 24);

    app.container.read(readingTextSizeProvider.notifier).select(99);
    await tester.pumpAndSettle();
    expect(paragraphSize(tester), 28);
  });

  testApp('the sheet opens from the reader and switches digits', (
    tester,
  ) async {
    await openReader(tester);
    await tester.tap(find.byTooltip('إعدادات القراءة'));
    await tester.pumpAndSettle();
    expect(find.byType(ReadingSettingsSheet), findsOneWidget);
    expect(find.text('حجم خط القراءة: ١٩'), findsOneWidget);

    await tester.tap(find.text('غربية (123)'));
    await tester.pumpAndSettle();
    expect(find.text('حجم خط القراءة: 19'), findsOneWidget);
    // The page behind the sheet follows too.
    expect(find.text('07'), findsOneWidget);
  });

  testApp('dragging the slider changes the size', (tester) async {
    final app = await openReader(tester);
    await tester.tap(find.byTooltip('إعدادات القراءة'));
    await tester.pumpAndSettle();
    final slider = find.byType(Slider);
    // RTL: the slider's maximum is on the left.
    await tester.tapAt(tester.getTopLeft(slider) + const Offset(30, 24));
    await tester.pumpAndSettle();
    expect(app.container.read(readingTextSizeProvider), greaterThan(19));
  });
}
