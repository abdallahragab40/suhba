import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/features/journeys/presentation/journey_page.dart';

import '../../helpers/pump_app.dart';

/// The stepper's states differ by shape, not only colour, and only the
/// current step has a button (review K4).
void main() {
  testWidgets('done, current, upcoming and skipped look different', (
    tester,
  ) async {
    var opened = 0;
    await tester.pumpWidget(
      testHarness(
        theme: AppTheme.light,
        child: Scaffold(
          body: Column(
            children: [
              for (final (i, state) in JourneyStepState.values.indexed)
                JourneyStepRow(
                  number: '${i + 1}',
                  state: state,
                  first: i == 0,
                  last: i == JourneyStepState.values.length - 1,
                  title: state.name,
                  subtitle: '',
                  continueLabel: 'تابع',
                  onTap: () => opened++,
                ),
            ],
          ),
        ),
      ),
    );
    // Done: a tick. Skipped: its own icon. Current and upcoming: numbers.
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byIcon(Icons.skip_next_outlined), findsOneWidget);
    expect(find.text('2'), findsOneWidget); // current
    expect(find.text('3'), findsOneWidget); // upcoming
    // The current step's ring is thicker than the upcoming one's.
    Border ring(String n) =>
        (tester
                        .widget<Container>(
                          find
                              .ancestor(
                                of: find.text(n),
                                matching: find.byType(Container),
                              )
                              .first,
                        )
                        .decoration!
                    as BoxDecoration)
                .border!
            as Border;
    expect(ring('2').top.width, greaterThan(ring('3').top.width));
    // One button, on the current step.
    expect(find.byType(FilledButton), findsOneWidget);
    await tester.tap(find.text('تابع'));
    expect(opened, 1);
  });
}
