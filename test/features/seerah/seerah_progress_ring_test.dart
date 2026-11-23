import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/widgets/progress_ring.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/providers.dart';

import '../../helpers/app_harness.dart';

/// K2: the Seerah's progress ring, on the hub and on Home, in words for
/// screen readers.
void main() {
  Future<AppUnderTest> open(
    WidgetTester tester, {
    String location = '/seerah',
    int finished = 0,
    double partFirst = 0,
  }) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 2400);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: location);
    final index = await app.container.read(seerahIndexProvider.future);
    for (final c in index.chapters.take(finished)) {
      await app.container
          .read(readingProgressRepositoryProvider)
          .save(
            ReadingProgress(
              target: ProgressTarget.seerahChapter,
              targetId: c.id,
              parentId: seerahParentId,
              fraction: 1,
              completed: true,
              contentVersion: '1',
              updatedAt: DateTime(2026, 10, 9),
            ),
          );
    }
    if (partFirst > 0) {
      await app.container
          .read(readingProgressRepositoryProvider)
          .save(
            ReadingProgress(
              target: ProgressTarget.seerahChapter,
              targetId: index.chapters.first.id,
              parentId: seerahParentId,
              fraction: partFirst,
              completed: false,
              contentVersion: '1',
              updatedAt: DateTime(2026, 10, 9),
            ),
          );
    }
    await app.pump(tester);
    return app;
  }

  double ringValue(WidgetTester tester) =>
      tester.widget<ProgressRing>(find.byType(ProgressRing)).value;

  testApp('before any chapter: not started yet (Q4)', (tester) async {
    await open(tester);
    expect(ringValue(tester), 0);
    expect(find.semantics.byLabel('لم تبدأ بعد'), findsOne);
    expect(find.text('ابدأ السيرة'), findsOneWidget);
  });

  // A chapter part-read is a start: never «لم تبدأ بعد» above «تابع: …».
  for (final location in ['/seerah', '/home']) {
    testApp('a chapter part-read reads as started ($location)', (tester) async {
      await open(tester, location: location, partFirst: 0.61);
      expect(ringValue(tester), 0);
      expect(find.semantics.byLabel('بدأتَ القراءة'), findsOne);
      expect(find.semantics.byLabel('لم تبدأ بعد'), findsNothing);
      expect(find.text('تابع: مكة والنسب والمولد'), findsOneWidget);
    });
  }

  testApp('chapters read out of all, in words', (tester) async {
    await open(tester, finished: 3);
    expect(ringValue(tester), closeTo(3 / 12, 1e-9));
    expect(find.semantics.byLabel('قرأتَ ٣ من ١٢ فصلًا'), findsOne);
  });

  testApp('the same ring on Home', (tester) async {
    await open(tester, location: '/home', finished: 3);
    expect(find.semantics.byLabel('قرأتَ ٣ من ١٢ فصلًا'), findsOne);
  });

  testApp('finished: a calm close, and a way to read it again', (tester) async {
    final app = await open(tester, finished: 12);
    expect(ringValue(tester), 1);
    expect(find.semantics.byLabel('أتممتَ السيرة'), findsOne);
    await tester.tap(find.text('اقرأها من جديد'));
    await tester.pumpAndSettle();
    expect(app.location, '/seerah/chapters/makkah-lineage-birth');
    // Reading again resets nothing.
    final progress = await app.container
        .read(readingProgressRepositoryProvider)
        .all();
    expect(progress.where((p) => p.completed), hasLength(12));
  });
}
