import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_chapter_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_hub_page.dart';

import '../helpers/app_harness.dart';

/// Readers open above the destination bar, so the text has the whole
/// screen (review F16, D6). Their links still open visibly, and Back still
/// returns to where the reader was opened from.
void main() {
  testApp('a reader has no destination bar; its tab page has one', (
    tester,
  ) async {
    final app = AppUnderTest(location: '/seerah');
    await app.pump(tester);
    expect(find.byType(NavigationBar), findsOneWidget);

    unawaited(app.router.push<void>('/seerah/chapters/hijrah-to-madinah'));
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage), findsOneWidget);
    expect(find.byType(NavigationBar).hitTestable(), findsNothing);
    expect(app.location, '/seerah/chapters/hijrah-to-madinah');

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(SeerahHubPage).hitTestable(), findsOneWidget);
    expect(find.byType(NavigationBar).hitTestable(), findsOneWidget);
  });

  testApp('a companion link in a reader opens on top, and Back returns', (
    tester,
  ) async {
    final app = AppUnderTest(location: '/seerah');
    await app.pump(tester);
    unawaited(app.router.push<void>('/seerah/chapters/hijrah-to-madinah'));
    await tester.pumpAndSettle();

    final chip = find.widgetWithText(ActionChip, 'أبو بكر الصديق');
    await tester.scrollUntilVisible(
      chip,
      400,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(chip);
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage).hitTestable(), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(SeerahChapterPage).hitTestable(), findsOneWidget);
  });
}
