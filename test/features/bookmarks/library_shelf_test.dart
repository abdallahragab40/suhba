import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/journeys/presentation/journeys_page.dart';
import 'package:suhba/features/reading_progress/presentation/reading_history_page.dart';
import 'package:suhba/features/review/presentation/review_page.dart';

import '../../helpers/app_harness.dart';

/// «مكتبتي» holds the reader's own things: journeys, review and reading
/// history are one tap from the tab (review D6, decision 2).
void main() {
  for (final (label, page) in [
    ('الرحلات', JourneysPage),
    ('مراجعة', ReviewPage),
    ('سجل القراءة', ReadingHistoryPage),
  ]) {
    testApp('$label opens in one tap from مكتبتي', (tester) async {
      await AppUnderTest(location: '/saved').pump(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(OutlinedButton),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(page), findsOneWidget);
    });
  }
}
