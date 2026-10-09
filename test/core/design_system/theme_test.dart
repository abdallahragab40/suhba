import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/fonts.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';

import '../../helpers/pump_app.dart';

List<(String, TextStyle?)> _roles(TextTheme t) => [
  ('displayLarge', t.displayLarge),
  ('displayMedium', t.displayMedium),
  ('displaySmall', t.displaySmall),
  ('headlineLarge', t.headlineLarge),
  ('headlineMedium', t.headlineMedium),
  ('headlineSmall', t.headlineSmall),
  ('titleLarge', t.titleLarge),
  ('titleMedium', t.titleMedium),
  ('titleSmall', t.titleSmall),
  ('bodyLarge', t.bodyLarge),
  ('bodyMedium', t.bodyMedium),
  ('bodySmall', t.bodySmall),
  ('labelLarge', t.labelLarge),
  ('labelMedium', t.labelMedium),
  ('labelSmall', t.labelSmall),
];

void main() {
  for (final (name, theme) in [
    ('light', AppTheme.light),
    ('dark', AppTheme.dark),
  ]) {
    group('$name theme', () {
      test('is Material 3 with the matching brightness', () {
        expect(theme.useMaterial3, isTrue);
        expect(
          theme.brightness,
          name == 'light' ? Brightness.light : Brightness.dark,
        );
      });

      test('registers both theme extensions', () {
        expect(theme.extension<SahabaColors>(), isNotNull);
        expect(theme.extension<SahabaTextStyles>(), isNotNull);
      });

      test('display roles use Amiri; all other roles use Cairo', () {
        for (final (role, style) in _roles(theme.textTheme)) {
          final expected = role.startsWith('display')
              ? AppFonts.amiri
              : AppFonts.cairo;
          expect(style!.fontFamily, expected, reason: role);
        }
      });

      test('Cairo falls back to Amiri for glyphs it lacks (e.g. ﷺ)', () {
        for (final (role, style) in _roles(theme.textTheme)) {
          if (style!.fontFamily != AppFonts.cairo) continue;
          expect(style.fontFamilyFallback, [AppFonts.amiri], reason: role);
        }
      });

      test('reading text uses Amiri and verses use Amiri Quran', () {
        final styles = theme.extension<SahabaTextStyles>()!;
        expect(styles.reading.fontFamily, AppFonts.amiri);
        expect(styles.readingStrong.fontFamily, AppFonts.amiri);
        expect(styles.quran.fontFamily, AppFonts.amiriQuran);
      });
    });
  }

  // Theme.of() merges script-specific geometry into the text theme. Check
  // that, for Arabic, our sizes survive and no letter spacing is added
  // (tracking would pull connected Arabic letters apart).
  testWidgets('Arabic-localized text theme keeps sizes and zero tracking', (
    tester,
  ) async {
    late TextTheme localized;
    await tester.pumpWidget(
      testHarness(
        theme: AppTheme.light,
        child: Builder(
          builder: (context) {
            localized = Theme.of(context).textTheme;
            return const SizedBox();
          },
        ),
      ),
    );

    for (final (role, style) in _roles(localized)) {
      expect(style!.letterSpacing, 0, reason: role);
    }
    expect(localized.bodyLarge!.fontSize, 16);
    expect(localized.displaySmall!.fontSize, 40);
  });
}
