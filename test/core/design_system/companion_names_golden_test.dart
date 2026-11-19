@Tags(['golden'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/widgets/companion_card.dart';
import 'package:suhba/core/text/honorifics.dart';

import '../../helpers/pump_app.dart';

/// Every companion's name above its honorific, as the directory and the
/// profile set them. Amiri's descenders (ج، ع، ي) must clear the honorific
/// line for all 47 names (review finding F08).
void main() {
  setUpAll(loadAppFonts);

  final index =
      jsonDecode(
            File('assets/content/index/companions.json').readAsStringSync(),
          )
          as Map<String, Object?>;
  final companions = (index['companions']! as List<Object?>)
      .cast<Map<String, Object?>>();

  testWidgets('all companion names clear their honorific', (tester) async {
    expect(companions, hasLength(47));
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(820, 3000);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      testHarness(
        theme: AppTheme.light,
        disableAnimations: true,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final c in companions)
                  SizedBox(
                    width: 390,
                    child: CompanionCard(
                      name: (c['name']! as Map)['ar']! as String,
                      honorific: Honorifics.companion(
                        c['gender'] == 'female'
                            ? HonorificSubject.woman
                            : HonorificSubject.man,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/companion_names.png'),
    );
  });
}
