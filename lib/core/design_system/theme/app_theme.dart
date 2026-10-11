import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/fonts.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';

/// Light (paper) and dark (ink) Material 3 themes, and the feature theme:
/// the dark roles on Madinah green, for the app's showcase sections.
abstract final class AppTheme {
  static final ThemeData light = _build(_lightScheme, SahabaColors.light);
  static final ThemeData dark = _build(_darkScheme, SahabaColors.dark);
  static final ThemeData feature = _build(
    _darkScheme.copyWith(
      surface: Palette.green,
      surfaceContainerLowest: Palette.greenLowest,
      surfaceContainerLow: Palette.greenLow,
      surfaceContainer: Palette.greenAlt,
      surfaceContainerHigh: Palette.greenHigh,
      surfaceContainerHighest: Palette.greenHighest,
      onSurfaceVariant: Palette.paperDimOnGreen,
      onPrimary: Palette.green,
      outline: Palette.outlineOnGreen,
      outlineVariant: Palette.lineOnGreen,
    ),
    SahabaColors.feature,
  );

  static const _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Palette.green,
    onPrimary: Palette.paper,
    primaryContainer: Palette.greenWash,
    onPrimaryContainer: Palette.green,
    secondary: Palette.goldText,
    onSecondary: Palette.paper,
    secondaryContainer: Palette.goldWash,
    onSecondaryContainer: Palette.goldDeep,
    tertiary: Palette.establishedOnPaper,
    onTertiary: Palette.paper,
    error: Palette.draftOnPaper,
    onError: Palette.paper,
    errorContainer: Palette.draftWash,
    onErrorContainer: Palette.draftOnPaper,
    surface: Palette.paper,
    onSurface: Palette.ink,
    onSurfaceVariant: Palette.inkDim,
    surfaceContainerLowest: Palette.paperLowest,
    surfaceContainerLow: Palette.paperLow,
    surfaceContainer: Palette.paperAlt,
    surfaceContainerHigh: Palette.paperHigh,
    surfaceContainerHighest: Palette.paperHighest,
    outline: Palette.outlineOnPaper,
    outlineVariant: Palette.lineOnPaper,
    inverseSurface: Palette.ink,
    onInverseSurface: Palette.paper,
    inversePrimary: Palette.goldOnInk,
    shadow: Palette.ink,
    scrim: Palette.ink,
    surfaceTint: Colors.transparent,
  );

  static const _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Palette.paper,
    onPrimary: Palette.ink,
    primaryContainer: Palette.inkHighest,
    onPrimaryContainer: Palette.paper,
    secondary: Palette.goldOnInk,
    onSecondary: Palette.ink,
    secondaryContainer: Palette.goldWashOnInk,
    onSecondaryContainer: Palette.goldWash,
    tertiary: Palette.establishedOnInk,
    onTertiary: Palette.ink,
    error: Palette.draftOnInk,
    onError: Palette.ink,
    errorContainer: Palette.draftWashOnInk,
    onErrorContainer: Palette.draftOnInk,
    surface: Palette.ink,
    onSurface: Palette.paper,
    onSurfaceVariant: Palette.paperDim,
    surfaceContainerLowest: Palette.inkLowest,
    surfaceContainerLow: Palette.inkLow,
    surfaceContainer: Palette.inkAlt,
    surfaceContainerHigh: Palette.inkHigh,
    surfaceContainerHighest: Palette.inkHighest,
    outline: Palette.outlineOnInk,
    outlineVariant: Palette.lineOnInk,
    inverseSurface: Palette.paper,
    onInverseSurface: Palette.ink,
    inversePrimary: Palette.goldText,
    shadow: Colors.black,
    scrim: Colors.black,
    surfaceTint: Colors.transparent,
  );

  static ThemeData _build(ColorScheme scheme, SahabaColors colors) {
    final textTheme = AppTypography.textTheme(scheme.onSurface);
    const pill = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(AppRadii.pill),
    );
    final buttonText = WidgetStatePropertyAll(textTheme.labelLarge);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppFonts.cairo,
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(AppRadii.md),
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
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: scheme.secondaryContainer,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
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
        SahabaTextStyles.forColors(
          text: scheme.onSurface,
          dimText: colors.onSurfaceDim,
        ),
      ],
    );
  }
}
