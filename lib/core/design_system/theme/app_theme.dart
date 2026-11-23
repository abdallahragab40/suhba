import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';

/// Light (paper) and dark (night) Material 3 themes, and the feature
/// themes: the dark roles on Madinah green, for the app's showcase
/// sections, deepened at night ([featureOf]).
abstract final class AppTheme {
  static final ThemeData light = _build(_lightScheme, SuhbaColors.light);
  static final ThemeData dark = _build(
    _darkScheme,
    SuhbaColors.dark,
    night: true,
  );

  /// The feature sections by day: paper text and gold on Madinah green.
  static final ThemeData feature = _build(_featureScheme, SuhbaColors.feature);

  /// The feature sections at night: the night's softer text and gold on a
  /// deeper, quieter green, so a band does not glow on the dark page.
  static final ThemeData featureDark = _build(
    _featureDarkScheme,
    SuhbaColors.featureDark,
    night: true,
  );

  /// The feature theme for [brightness]: [feature] by day, [featureDark]
  /// at night.
  static ThemeData featureFor(Brightness brightness) =>
      brightness == Brightness.dark ? featureDark : feature;

  /// The feature theme for the ambient theme's brightness. Inside a
  /// feature section, that section's own theme, so a feature widget nested
  /// in one keeps its tone.
  static ThemeData featureOf(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<SuhbaColors>();
    if (identical(colors, SuhbaColors.feature)) return feature;
    if (identical(colors, SuhbaColors.featureDark)) return featureDark;
    return featureFor(theme.brightness);
  }

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
    night: true,
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
    // Gold is the dark-mode accent: it belongs with the green-charcoal and
    // stays distinct from the green of the "established" label. The night
    // golds are softened; [primary] is the fill, [secondary] the text gold.
    primary: Palette.goldFillOnNight,
    onPrimary: Palette.nightLowest,
    primaryContainer: Palette.nightHighest,
    onPrimaryContainer: Palette.textOnNight,
    secondary: Palette.goldOnNight,
    onSecondary: Palette.nightLowest,
    secondaryContainer: Palette.greenWashOnNight,
    onSecondaryContainer: Palette.textOnNight,
    tertiary: Palette.establishedOnInk,
    onTertiary: Palette.nightLowest,
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
    outline: Palette.outlineOnNight,
    outlineVariant: Palette.lineOnNight,
    // Snack bars at night: soft text on the deep green with a gold action,
    // not a bright bar across a dark screen.
    inverseSurface: Palette.deepGreen,
    onInverseSurface: Palette.textOnNight,
    inversePrimary: Palette.goldOnNight,
    // No shadows at night: tone and hairlines separate the layers.
    shadow: Colors.transparent,
    scrim: Colors.black,
    surfaceTint: Colors.transparent,
  );

  static const _featureScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Palette.goldOnInk,
    onPrimary: Palette.green,
    primaryContainer: Palette.greenHighest,
    onPrimaryContainer: Palette.paper,
    secondary: Palette.goldOnInk,
    onSecondary: Palette.ink,
    secondaryContainer: Palette.greenHighest,
    onSecondaryContainer: Palette.greenWash,
    tertiary: Palette.establishedOnInk,
    onTertiary: Palette.ink,
    error: Palette.clayOnInk,
    onError: Palette.clayWashOnInk,
    errorContainer: Palette.clayWashOnInk,
    onErrorContainer: Palette.clayOnInk,
    surface: Palette.green,
    onSurface: Palette.paper,
    onSurfaceVariant: Palette.paperDimOnGreen,
    surfaceContainerLowest: Palette.greenLowest,
    surfaceContainerLow: Palette.greenLow,
    surfaceContainer: Palette.greenAlt,
    surfaceContainerHigh: Palette.greenHigh,
    surfaceContainerHighest: Palette.greenHighest,
    outline: Palette.outlineOnGreen,
    outlineVariant: Palette.lineOnGreen,
    inverseSurface: Palette.greenHigh,
    onInverseSurface: Palette.paper,
    inversePrimary: Palette.goldOnInk,
    shadow: Colors.black,
    scrim: Colors.black,
    surfaceTint: Colors.transparent,
  );

  static final _featureDarkScheme = _darkScheme.copyWith(
    surface: Palette.deepGreen,
    surfaceContainerLowest: Palette.deepGreenLowest,
    surfaceContainerLow: Palette.deepGreenLow,
    surfaceContainer: Palette.deepGreenAlt,
    surfaceContainerHigh: Palette.deepGreenHigh,
    surfaceContainerHighest: Palette.deepGreenHighest,
    onSurfaceVariant: Palette.dimOnDeepGreen,
    primaryContainer: Palette.deepGreenHighest,
    secondaryContainer: Palette.deepGreenHighest,
    outline: Palette.outlineOnDeepGreen,
    outlineVariant: Palette.lineOnDeepGreen,
    // A snack bar over a green band: the night's charcoal, not more green.
    inverseSurface: Palette.nightHighest,
  );

  /// [night] adds the dark mode's component themes (the night, its warm
  /// tone and the deep feature green): no shadows, hairline edges, soft
  /// gold used sparingly, dimmer icons and readable disabled states. The
  /// light and day feature themes leave them at Material's defaults.
  static ThemeData _build(
    ColorScheme scheme,
    SuhbaColors colors, {
    bool night = false,
  }) {
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
    // Disabled at night: plainly off, yet still legible (about 4:1).
    final disabled = scheme.onSurface.withValues(alpha: 0.5);
    WidgetStateProperty<Color?> unlessDisabled(Color color) =>
        WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled) ? disabled : color,
        );
    WidgetStateProperty<T> selectedOr<T>(T selected, T other) =>
        WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? selected : other,
        );
    final hairline = BorderSide(color: colors.line);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppFonts.plexArabic,
      fontFamilyFallback: const [AppFonts.amiri],
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      shadowColor: night ? Colors.transparent : null,
      // At night bare icons (chevrons, tile glyphs) are a step quieter
      // than the words beside them; buttons, chips and tabs set their own.
      iconTheme: night ? IconThemeData(color: scheme.onSurfaceVariant) : null,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: night ? Colors.transparent : null,
        // At night the bar's icons are a step quieter than the title.
        iconTheme: night ? IconThemeData(color: scheme.onSurfaceVariant) : null,
        actionsIconTheme: night
            ? IconThemeData(color: scheme.onSurfaceVariant)
            : null,
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
        shadowColor: night ? Colors.transparent : null,
        margin: EdgeInsets.zero,
        // A hairline edges each card: by day a card is only a little
        // lighter than the page, and at night tone alone separates too
        // little.
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(AppRadii.md),
          side: hairline,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: hairline,
        labelStyle: textTheme.labelMedium,
        backgroundColor: scheme.surface,
        selectedColor: scheme.secondaryContainer,
        checkmarkColor: night ? scheme.onSecondaryContainer : null,
      ),
      navigationBarTheme: NavigationBarThemeData(
        // The bar sits a step above the page: the cards' tone by day,
        // a lifted one at night.
        backgroundColor: dark
            ? scheme.surfaceContainerLow
            : scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shadowColor: night ? Colors.transparent : null,
        elevation: 0,
        indicatorColor: scheme.brightness == Brightness.light
            ? Palette.greenWashStrong
            : scheme.secondaryContainer,
        // At night the current tab is lit and the others recede.
        iconTheme: night
            ? selectedOr(
                IconThemeData(color: scheme.onSecondaryContainer),
                IconThemeData(color: scheme.onSurfaceVariant),
              )
            : null,
        // Five labels share a phone's width: the floor size, 13 (F01).
        labelTextStyle: night
            ? selectedOr(
                textTheme.labelMedium?.copyWith(
                  fontSize: 13,
                  color: scheme.onSurface,
                ),
                textTheme.labelMedium?.copyWith(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              )
            : WidgetStatePropertyAll(
                textTheme.labelMedium?.copyWith(fontSize: 13),
              ),
      ),
      // Snack bars are Madinah green, like the feature bands they often
      // rise over; a gold hairline keeps them apart from the band. At night
      // the green is deep, the hairline faint and there is no shadow.
      snackBarTheme: night
          ? SnackBarThemeData(
              backgroundColor: scheme.inverseSurface,
              contentTextStyle: textTheme.bodyMedium?.copyWith(
                color: scheme.onInverseSurface,
              ),
              actionTextColor: scheme.inversePrimary,
              elevation: 0,
              shape: Border(
                top: BorderSide(
                  color: Palette.goldOnNight.withValues(alpha: 0.35),
                ),
              ),
            )
          : SnackBarThemeData(
              shape: Border(
                top: BorderSide(
                  color: Palette.goldOnInk.withValues(alpha: 0.6),
                ),
              ),
            ),
      bottomSheetTheme: BottomSheetThemeData(
        // At night a sheet is lifted a step above the page it covers.
        backgroundColor: night ? scheme.surfaceContainerLow : scheme.surface,
        modalBackgroundColor: night ? scheme.surfaceContainerLow : null,
        surfaceTintColor: Colors.transparent,
        shadowColor: night ? Colors.transparent : null,
        elevation: night ? 0 : null,
        modalElevation: night ? 0 : null,
        dragHandleColor: night
            ? scheme.onSurfaceVariant.withValues(alpha: 0.5)
            : null,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: AppRadii.lg),
        ),
      ),
      dialogTheme: night
          ? DialogThemeData(
              backgroundColor: scheme.surfaceContainerHigh,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(28)),
                side: hairline,
              ),
              titleTextStyle: textTheme.headlineSmall,
              contentTextStyle: textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            )
          : null,
      popupMenuTheme: night
          ? PopupMenuThemeData(
              color: scheme.surfaceContainerHigh,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(AppRadii.sm),
                side: hairline,
              ),
            )
          : null,
      // A quiet charcoal tip, not a bright inverse bubble.
      tooltipTheme: night
          ? TooltipThemeData(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.all(AppRadii.sm),
                border: Border.fromBorderSide(hairline),
              ),
              textStyle: textTheme.bodySmall?.copyWith(color: scheme.onSurface),
            )
          : null,
      listTileTheme: night
          ? ListTileThemeData(iconColor: scheme.onSurfaceVariant)
          : null,
      inputDecorationTheme: night
          ? InputDecorationThemeData(
              labelStyle: TextStyle(color: scheme.onSurfaceVariant),
              hintStyle: TextStyle(color: scheme.onSurfaceVariant),
              floatingLabelStyle: WidgetStateTextStyle.resolveWith(
                (states) => TextStyle(
                  color: states.contains(WidgetState.focused)
                      ? colors.accentText
                      : scheme.onSurfaceVariant,
                ),
              ),
              prefixIconColor: scheme.onSurfaceVariant,
              suffixIconColor: scheme.onSurfaceVariant,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: scheme.outline),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: scheme.primary, width: 2),
              ),
            )
          : null,
      // A switch at night: a soft gold thumb on a dim gold track, rather
      // than a dark thumb on a bright one.
      switchTheme: night
          ? SwitchThemeData(
              thumbColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.disabled)
                    ? disabled
                    : states.contains(WidgetState.selected)
                    ? colors.accent
                    : scheme.outline,
              ),
              trackColor: selectedOr(
                Palette.goldTrackOnNight,
                scheme.surfaceContainerHighest,
              ),
              trackOutlineColor: selectedOr(Colors.transparent, scheme.outline),
            )
          : null,
      checkboxTheme: night
          ? CheckboxThemeData(
              fillColor: selectedOr(scheme.primary, Colors.transparent),
              checkColor: WidgetStatePropertyAll(scheme.onPrimary),
              side: BorderSide(color: scheme.onSurfaceVariant, width: 2),
            )
          : null,
      radioTheme: night
          ? RadioThemeData(
              fillColor: selectedOr(scheme.primary, scheme.onSurfaceVariant),
            )
          : null,
      sliderTheme: night
          ? SliderThemeData(
              activeTrackColor: scheme.primary,
              inactiveTrackColor: scheme.surfaceContainerHighest,
              thumbColor: scheme.primary,
              overlayColor: scheme.primary.withValues(alpha: 0.08),
            )
          : null,
      progressIndicatorTheme: night
          ? ProgressIndicatorThemeData(
              color: scheme.primary,
              linearTrackColor: scheme.surfaceContainerHighest,
            )
          : null,
      segmentedButtonTheme: night
          ? SegmentedButtonThemeData(
              style: ButtonStyle(
                foregroundColor: unlessDisabled(scheme.onSurface),
                side: WidgetStatePropertyAll(BorderSide(color: scheme.outline)),
              ),
            )
          : null,
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(pill),
          textStyle: buttonText,
          shadowColor: night
              ? const WidgetStatePropertyAll(Colors.transparent)
              : null,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(pill),
          textStyle: buttonText,
          // At night the secondary action is neutral: gold is kept for the
          // one filled action and for links.
          foregroundColor: night ? unlessDisabled(scheme.onSurface) : null,
          side: night
              ? WidgetStateProperty.resolveWith(
                  (states) => BorderSide(
                    color: states.contains(WidgetState.disabled)
                        ? colors.line
                        : scheme.outline,
                  ),
                )
              : WidgetStatePropertyAll(BorderSide(color: scheme.outline)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(pill),
          textStyle: buttonText,
          foregroundColor: night ? unlessDisabled(colors.link) : null,
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
