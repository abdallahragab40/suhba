import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';

/// Light (paper) and dark (ink) Material 3 themes, and the feature theme:
/// the dark roles on Madinah green, for the app's showcase sections.
abstract final class AppTheme {
  static final ThemeData light = _build(_lightScheme, SuhbaColors.light);
  static final ThemeData dark = _build(_darkScheme, SuhbaColors.dark);
  static final ThemeData feature = _build(
    _darkScheme.copyWith(
      surface: Palette.green,
      onSurface: Palette.paper,
      surfaceContainerLowest: Palette.greenLowest,
      surfaceContainerLow: Palette.greenLow,
      surfaceContainer: Palette.greenAlt,
      surfaceContainerHigh: Palette.greenHigh,
      surfaceContainerHighest: Palette.greenHighest,
      onSurfaceVariant: Palette.paperDimOnGreen,
      onPrimary: Palette.green,
      secondaryContainer: Palette.greenHighest,
      outline: Palette.outlineOnGreen,
      outlineVariant: Palette.lineOnGreen,
    ),
    SuhbaColors.feature,
  );

  /// The reader's warm paper tone (review K5): the light theme on a sepia
  /// page, a clear step warmer than the app's ivory. Readers only; the
  /// rest of the app keeps its theme.
  static final ThemeData warmPaper = _build(
    _lightScheme.copyWith(
      surface: Palette.warmPaper,
      onSurface: Palette.inkTextOnWarmPaper,
      surfaceContainerLowest: Palette.warmPaperAlt,
      surfaceContainerLow: Palette.warmPaper,
      surfaceContainer: Palette.warmPaper,
      outlineVariant: Palette.lineOnWarmPaper,
    ),
    SuhbaColors.light.copyWith(
      surfaceAlt: Palette.warmPaperAlt,
      line: Palette.lineOnWarmPaper,
      verseSurface: Palette.verseWashOnWarmPaper,
      draftSurface: Palette.warmPaperAlt,
    ),
  );

  /// The warm tone at night: [warmPaper]'s counterpart in the dark theme,
  /// a warm near-black page with cream text (K5).
  static final ThemeData warmNight = _build(
    _darkScheme.copyWith(
      surface: Palette.warmNight,
      surfaceContainerLowest: Palette.warmNight,
      surfaceContainerLow: Palette.warmNight,
      surfaceContainer: Palette.warmNightAlt,
      onSurface: Palette.textOnWarmNight,
      onSurfaceVariant: Palette.dimOnWarmNight,
      outlineVariant: Palette.lineOnWarmNight,
    ),
    SuhbaColors.dark.copyWith(
      surfaceAlt: Palette.warmNightAlt,
      onSurfaceDim: Palette.dimOnWarmNight,
      line: Palette.lineOnWarmNight,
      verseSurface: Palette.verseWashOnWarmNight,
      draft: Palette.dimOnWarmNight,
      draftSurface: Palette.warmNightAlt,
    ),
  );

  static const _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Palette.green,
    onPrimary: Palette.paper,
    primaryContainer: Palette.greenWash,
    onPrimaryContainer: Palette.green,
    secondary: Palette.goldText,
    onSecondary: Palette.paper,
    secondaryContainer: Palette.greenWash,
    onSecondaryContainer: Palette.green,
    tertiary: Palette.establishedOnPaper,
    onTertiary: Palette.paper,
    error: Palette.clay,
    onError: Palette.paper,
    errorContainer: Palette.clayWash,
    onErrorContainer: Palette.clay,
    surface: Palette.paper,
    onSurface: Palette.inkText,
    onSurfaceVariant: Palette.inkDim,
    surfaceContainerLowest: Palette.paperLowest,
    surfaceContainerLow: Palette.paperLow,
    surfaceContainer: Palette.paperAlt,
    surfaceContainerHigh: Palette.paperHigh,
    surfaceContainerHighest: Palette.paperHighest,
    outline: Palette.outlineOnPaper,
    outlineVariant: Palette.lineOnPaper,
    // Snack bars: paper text and a gold action on Madinah green.
    inverseSurface: Palette.green,
    onInverseSurface: Palette.paper,
    inversePrimary: Palette.goldOnInk,
    shadow: Palette.ink,
    scrim: Palette.ink,
    surfaceTint: Colors.transparent,
  );

  static const _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    // Gold is the dark-mode accent: it belongs with the green-black and
    // stays distinct from the green of the "established" label.
    primary: Palette.goldOnInk,
    onPrimary: Palette.ink,
    primaryContainer: Palette.nightHighest,
    onPrimaryContainer: Palette.textOnNight,
    secondary: Palette.goldOnInk,
    onSecondary: Palette.ink,
    secondaryContainer: Palette.greenWashOnInk,
    onSecondaryContainer: Palette.greenWash,
    tertiary: Palette.establishedOnInk,
    onTertiary: Palette.ink,
    error: Palette.clayOnInk,
    onError: Palette.clayWashOnInk,
    errorContainer: Palette.clayWashOnInk,
    onErrorContainer: Palette.clayOnInk,
    surface: Palette.night,
    onSurface: Palette.textOnNight,
    onSurfaceVariant: Palette.dimOnNight,
    surfaceContainerLowest: Palette.nightLowest,
    surfaceContainerLow: Palette.nightLow,
    surfaceContainer: Palette.nightAlt,
    surfaceContainerHigh: Palette.nightHigh,
    surfaceContainerHighest: Palette.nightHighest,
    outline: Palette.outlineOnInk,
    outlineVariant: Palette.lineOnNight,
    // Snack bars at night: paper on Madinah green with a gold action,
    // not a bright paper bar across a dark screen.
    inverseSurface: Palette.greenHigh,
    onInverseSurface: Palette.paper,
    inversePrimary: Palette.goldOnInk,
    shadow: Colors.black,
    scrim: Colors.black,
    surfaceTint: Colors.transparent,
  );

  static ThemeData _build(ColorScheme scheme, SuhbaColors colors) {
    final textTheme = AppTypography.textTheme(scheme.onSurface);
    const pill = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(AppRadii.pill),
    );
    // Button labels set on a tall line: at the default size it still fits
    // Material's 40 dp minimum height, so nothing changes there, but as the
    // system text size grows the pill grows with it, keeping the marks
    // above and dots below the letters (the tail and dots of «التالي»)
    // inside the button rather than spilling past its edge.
    final buttonText = WidgetStatePropertyAll(
      textTheme.labelLarge?.copyWith(height: 2),
    );
    final dark = scheme.brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppFonts.plexArabic,
      fontFamilyFallback: const [AppFonts.amiri],
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      dividerTheme: DividerThemeData(
        color: colors.line,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceAlt,
        elevation: 0,
        margin: EdgeInsets.zero,
        // A hairline edges each card: by day a card is only a little
        // lighter than the page, and at night tone alone separates too
        // little.
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(AppRadii.md),
          side: BorderSide(color: colors.line),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: BorderSide(color: colors.line),
        labelStyle: textTheme.labelMedium,
        backgroundColor: scheme.surface,
        selectedColor: scheme.secondaryContainer,
      ),
      navigationBarTheme: NavigationBarThemeData(
        // The bar sits a step above the page: the cards' tone by day,
        // a lifted one at night.
        backgroundColor: dark
            ? scheme.surfaceContainerLow
            : scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: scheme.brightness == Brightness.light
            ? Palette.greenWashStrong
            : scheme.secondaryContainer,
        // Five labels share a phone's width: the floor size, 13 (F01).
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelMedium?.copyWith(fontSize: 13),
        ),
      ),
      // Snack bars are Madinah green, like the feature bands they often
      // rise over; a gold hairline keeps them apart from the band.
      snackBarTheme: SnackBarThemeData(
        shape: Border(
          top: BorderSide(color: Palette.goldOnInk.withValues(alpha: 0.6)),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: AppRadii.lg),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(pill),
          textStyle: buttonText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(pill),
          textStyle: buttonText,
          side: WidgetStatePropertyAll(BorderSide(color: scheme.outline)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(pill),
          textStyle: buttonText,
        ),
      ),
      extensions: [
        colors,
        SuhbaTextStyles.forColors(
          text: scheme.onSurface,
          dimText: colors.onSurfaceDim,
        ),
      ],
    );
  }
}
