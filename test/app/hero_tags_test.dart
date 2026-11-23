import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/companions/presentation/directory/directory_page.dart';
import 'package:suhba/features/search/presentation/search_page.dart';

import '../helpers/app_harness.dart';

/// Every destination stays alive behind the others, so two of them may
/// show the same companion at once: Home's companion of the day and the
/// same companion in the directory. Opening a full-screen route above the
/// tabs must not find two heroes with one tag.
void main() {
  testApp('a full-screen route opens over Home and the directory', (
    tester,
  ) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3000);
    addTearDown(tester.view.reset);
    // 1 October 2026 features Abu Bakr, the directory's first companion.
    final app = AppUnderTest(now: DateTime(2026, 10));
    await app.pump(tester);
    expect(find.text('أبو بكر الصديق'), findsWidgets);

    // Build the directory, with Abu Bakr in it, then return Home.
    await tester.tap(find.text('الصحابة').last);
    await tester.pumpAndSettle();
    expect(find.byType(DirectoryPage), findsOneWidget);
    await tester.tap(find.text('الرئيسية').last);
    await tester.pumpAndSettle();

    unawaited(app.router.push<void>('/search'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(SearchPage), findsOneWidget);

    // And back again, which flies in reverse.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
