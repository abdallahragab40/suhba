import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/settings/presentation/reading_settings.dart';
import 'package:suhba/shared/content/presentation/reader_scaffold.dart';

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

  test('the size starts at 20 and is clamped and rounded', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final size = readingTextSizeProvider;
    expect(container.read(size), 20);
    container.read(size.notifier).select(10);
    expect(container.read(size), 16);
    container.read(size.notifier).select(30);
    expect(container.read(size), 28);
    container.read(size.notifier).select(20.6);
    expect(container.read(size), 21);
  });

  testApp('changing the size applies live to the open reader', (tester) async {
    final app = await openReader(tester);
    expect(paragraphSize(tester), 20);

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
    expect(find.text('حجم خط القراءة: ٢٠'), findsOneWidget);

    await tester.tap(find.text('غربية (123)'));
    await tester.pumpAndSettle();
    expect(find.text('حجم خط القراءة: 20'), findsOneWidget);
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
    expect(app.container.read(readingTextSizeProvider), greaterThan(20));
  });

  testApp('warm paper applies to the reader and is remembered', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3000);
    addTearDown(tester.view.reset);
    final store = MemorySettingsStore();
    const location = '/companions/abu-bakr/sections/abu-bakr.death';
    Color page() => Theme.of(
      tester.element(find.byType(ReaderScaffold)),
    ).colorScheme.surface;

    await AppUnderTest(location: location, settings: store).pump(tester);
    expect(page(), Palette.paper);
    await tester.tap(find.byTooltip('إعدادات القراءة'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ورقي دافئ'));
    await tester.pumpAndSettle();
    expect(page(), Palette.warmPaper);
    expect(store.getString(SettingsKeys.readerTone), 'warmPaper');

    // A fresh start reads the saved tone.
    await tester.pumpWidget(const SizedBox());
    await AppUnderTest(location: location, settings: store).pump(tester);
    expect(page(), Palette.warmPaper);
  });

  testApp('the rest of the app keeps its own theme', (tester) async {
    final store = MemorySettingsStore();
    await store.setString(SettingsKeys.readerTone, 'warmPaper');
    await AppUnderTest(location: '/companions', settings: store).pump(tester);
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).colorScheme.surface,
      Palette.paper,
    );
  });
}
