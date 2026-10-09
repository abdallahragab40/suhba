import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';

/// WCAG 2.1 contrast ratio.
double contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

void main() {
  for (final (name, theme) in [
    ('light', AppTheme.light),
    ('dark', AppTheme.dark),
  ]) {
    group('$name theme', () {
      final s = theme.colorScheme;
      final c = theme.extension<SahabaColors>()!;

      // Text on its background: WCAG AA for normal text.
      final textPairs = <String, (Color, Color)>{
        'onSurface / surface': (s.onSurface, s.surface),
        'onSurface / surfaceAlt': (s.onSurface, c.surfaceAlt),
        'onSurface / containerHighest': (
          s.onSurface,
          s.surfaceContainerHighest,
        ),
        'onSurfaceDim / surface': (c.onSurfaceDim, s.surface),
        'onSurfaceDim / surfaceAlt': (c.onSurfaceDim, c.surfaceAlt),
        'onSurfaceDim / containerHigh': (
          c.onSurfaceDim,
          s.surfaceContainerHigh,
        ),
        'onSurfaceVariant / surface': (s.onSurfaceVariant, s.surface),
        'accentText / surface': (c.accentText, s.surface),
        'accentText / surfaceAlt': (c.accentText, c.surfaceAlt),
        'established / surface': (c.established, s.surface),
        'established / surfaceAlt': (c.established, c.surfaceAlt),
        'disputed / surface': (c.disputed, s.surface),
        'disputed / surfaceAlt': (c.disputed, c.surfaceAlt),
        'draft / draftSurface': (c.draft, c.draftSurface),
        'draft / surface': (c.draft, s.surface),
        'onPrimary / primary': (s.onPrimary, s.primary),
        'onSecondary / secondary': (s.onSecondary, s.secondary),
        'onSecondaryContainer / secondaryContainer': (
          s.onSecondaryContainer,
          s.secondaryContainer,
        ),
        'onTertiary / tertiary': (s.onTertiary, s.tertiary),
        'onError / error': (s.onError, s.error),
        'onErrorContainer / errorContainer': (
          s.onErrorContainer,
          s.errorContainer,
        ),
        'onInverseSurface / inverseSurface': (
          s.onInverseSurface,
          s.inverseSurface,
        ),
      };

      for (final MapEntry(key: label, value: (fg, bg)) in textPairs.entries) {
        test('$label ≥ 4.5:1', () {
          expect(contrast(fg, bg), greaterThanOrEqualTo(4.5));
        });
      }

      test('outline / surface ≥ 3:1 (UI component boundary)', () {
        expect(contrast(s.outline, s.surface), greaterThanOrEqualTo(3));
      });
    });
  }

  test('decorative gold is only text-safe on ink', () {
    final light = AppTheme.light;
    final dark = AppTheme.dark;
    final lightGold = light.extension<SahabaColors>()!.accent;
    final darkGold = dark.extension<SahabaColors>()!.accent;
    // Documents why accentText exists: gold fails on paper...
    expect(contrast(lightGold, light.colorScheme.surface), lessThan(3));
    // ...and passes on ink.
    expect(
      contrast(darkGold, dark.colorScheme.surface),
      greaterThanOrEqualTo(4.5),
    );
  });
}
