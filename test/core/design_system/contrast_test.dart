import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';

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
    ('feature', AppTheme.feature),
    ('feature dark', AppTheme.featureDark),
    ('warm paper', AppTheme.warmPaper),
    ('warm night', AppTheme.warmNight),
  ]) {
    group('$name theme', () {
      final s = theme.colorScheme;
      final c = theme.extension<SuhbaColors>()!;

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
        'onSurface / verseSurface': (s.onSurface, c.verseSurface),
        'onSurfaceDim / verseSurface': (c.onSurfaceDim, c.verseSurface),
        'accentText / verseSurface': (c.accentText, c.verseSurface),
        'mark / surface': (c.mark, s.surface),
        'mark / surfaceAlt': (c.mark, c.surfaceAlt),
        'link / surface': (c.link, s.surface),
        'link / surfaceAlt': (c.link, c.surfaceAlt),
        'error / surface': (s.error, s.surface),
        'error / errorContainer': (s.error, s.errorContainer),
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

      test('selected tab icon / its pill ≥ 3:1 (graphical object)', () {
        final pill = theme.navigationBarTheme.indicatorColor!;
        expect(contrast(s.onSecondaryContainer, pill), greaterThanOrEqualTo(3));
      });

      test('outline / surface ≥ 3:1 (UI component boundary)', () {
        expect(contrast(s.outline, s.surface), greaterThanOrEqualTo(3));
      });
    });
  }

  // Dark mode: soft, not harsh. Every text role on every surface it is set
  // on, the controls' boundaries, and a ceiling on body text contrast.
  for (final (name, theme) in [
    ('dark', AppTheme.dark),
    ('feature dark', AppTheme.featureDark),
    ('warm night', AppTheme.warmNight),
  ]) {
    group('$name: night comfort', () {
      final s = theme.colorScheme;
      final c = theme.extension<SuhbaColors>()!;
      final navBar = theme.navigationBarTheme.backgroundColor!;
      final dialog = theme.dialogTheme.backgroundColor!;
      final surfaces = <String, Color>{
        'page': s.surface,
        'low (nav, sheets)': s.surfaceContainerLow,
        'card': c.surfaceAlt,
        'dialog': dialog,
        'nav bar': navBar,
      };
      final roles = <String, Color>{
        'onSurface': s.onSurface,
        'onSurfaceVariant': s.onSurfaceVariant,
        'onSurfaceDim': c.onSurfaceDim,
        'accentText': c.accentText,
        'link': c.link,
        'mark': c.mark,
        'established': c.established,
        'disputed': c.disputed,
        'draft': c.draft,
        'error': s.error,
        'primary (text buttons, labels)': s.primary,
      };
      for (final MapEntry(key: role, value: fg) in roles.entries) {
        for (final MapEntry(key: where, value: bg) in surfaces.entries) {
          test('$role on $where ≥ 4.5:1', () {
            expect(contrast(fg, bg), greaterThanOrEqualTo(4.5));
          });
        }
      }

      test('tooltips and chips: text on the highest step ≥ 4.5:1', () {
        expect(
          contrast(s.onSurface, s.surfaceContainerHighest),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          contrast(s.onSurfaceVariant, s.surfaceContainerHighest),
          greaterThanOrEqualTo(4.5),
        );
      });

      test('body text is comfortable: AAA, but not harsh (≤ 15:1)', () {
        for (final bg in [s.surface, c.surfaceAlt]) {
          final ratio = contrast(s.onSurface, bg);
          expect(ratio, greaterThanOrEqualTo(7));
          expect(ratio, lessThanOrEqualTo(15));
        }
      });

      test('filled button label on its gold ≥ 7:1', () {
        expect(contrast(s.onPrimary, s.primary), greaterThanOrEqualTo(7));
      });

      test('snack bar action ≥ 4.5:1', () {
        expect(
          contrast(s.inversePrimary, s.inverseSurface),
          greaterThanOrEqualTo(4.5),
        );
      });

      test('disabled text stays legible (≥ 3:1) on page and dialog', () {
        final disabled = s.onSurface.withValues(alpha: 0.5);
        for (final bg in [s.surface, dialog]) {
          expect(
            contrast(Color.alphaBlend(disabled, bg), bg),
            greaterThanOrEqualTo(3),
          );
        }
      });

      test('non-text UI ≥ 3:1: outlines, focus line, switch, slider', () {
        for (final bg in [s.surface, c.surfaceAlt, dialog]) {
          // Text field and outlined button edges.
          expect(contrast(s.outline, bg), greaterThanOrEqualTo(3));
          // The focused field's underline, the slider and progress fill.
          expect(contrast(s.primary, bg), greaterThanOrEqualTo(3));
        }
        final sw = theme.switchTheme;
        const on = {WidgetState.selected};
        final thumbOn = sw.thumbColor!.resolve(on)!;
        final trackOn = sw.trackColor!.resolve(on)!;
        expect(contrast(thumbOn, trackOn), greaterThanOrEqualTo(3));
        expect(contrast(thumbOn, s.surface), greaterThanOrEqualTo(3));
        final outlineOff = sw.trackOutlineColor!.resolve({})!;
        expect(contrast(outlineOff, s.surface), greaterThanOrEqualTo(3));
      });

      test('a glossary term is marked faintly and still reads', () {
        for (final bg in [s.surface, c.surfaceAlt]) {
          final wash = Color.alphaBlend(
            c.link.withValues(alpha: c.linkWash),
            bg,
          );
          expect(contrast(c.link, wash), greaterThanOrEqualTo(4.5));
          expect(contrast(wash, bg), lessThan(1.25));
        }
      });

      test('no shadows at night', () {
        expect(s.shadow.a, 0);
        expect(theme.shadowColor.a, 0);
        expect(theme.dialogTheme.shadowColor!.a, 0);
        expect(theme.cardTheme.shadowColor!.a, 0);
      });

      test('cards and lines step gently off the page', () {
        // A card is visibly lifted, but no slab: tone plus a hairline.
        expect(contrast(c.surfaceAlt, s.surface), inInclusiveRange(1.05, 1.3));
        expect(contrast(c.line, s.surface), inInclusiveRange(1.2, 1.8));
      });
    });
  }

  test('the night page is not black, and stays in the green family', () {
    final page = AppTheme.dark.colorScheme.surface;
    expect(page.computeLuminance(), greaterThan(0.008));
    final hsl = HSLColor.fromColor(page);
    expect(hsl.hue, inInclusiveRange(120, 180));
  });

  test('feature sections are deeper and quieter at night', () {
    final day = HSLColor.fromColor(AppTheme.feature.colorScheme.surface);
    final night = HSLColor.fromColor(AppTheme.featureDark.colorScheme.surface);
    expect(night.lightness, lessThan(day.lightness));
    expect(night.saturation, lessThan(day.saturation));
  });

  test('decorative gold is only text-safe on ink', () {
    final light = AppTheme.light;
    final dark = AppTheme.dark;
    final lightGold = light.extension<SuhbaColors>()!.accent;
    final darkGold = dark.extension<SuhbaColors>()!.accent;
    // Documents why accentText exists: gold fails on paper...
    expect(contrast(lightGold, light.colorScheme.surface), lessThan(3));
    // ...and passes on ink.
    expect(
      contrast(darkGold, dark.colorScheme.surface),
      greaterThanOrEqualTo(4.5),
    );
  });

  test('gold is not used for links, status or errors on paper', () {
    final light = AppTheme.light;
    final c = light.extension<SuhbaColors>()!;
    final s = light.colorScheme;
    for (final (role, color) in [
      ('link', c.link),
      ('draft', c.draft),
      ('error', s.error),
    ]) {
      expect(color, isNot(c.accentText), reason: role);
      expect(color, isNot(c.accent), reason: role);
    }
  });
}
