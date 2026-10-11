import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';

/// Semantic colors that Material's [ColorScheme] has no role for.
///
/// Read with `SahabaColors.of(context)`.
@immutable
class SahabaColors extends ThemeExtension<SahabaColors> {
  const SahabaColors({
    required this.surfaceAlt,
    required this.onSurfaceDim,
    required this.line,
    required this.accent,
    required this.accentText,
    required this.established,
    required this.disputed,
    required this.draft,
    required this.draftSurface,
  });

  /// Cards and alternate sections.
  final Color surfaceAlt;

  /// Secondary text.
  final Color onSurfaceDim;

  /// Hairline separators.
  final Color line;

  /// Decorative gold: outlined numerals, ornaments, indices on ink.
  /// Not for small text on paper; use [accentText].
  final Color accent;

  /// Gold for small text and links.
  final Color accentText;

  /// Reliability badge: established (ثابت).
  final Color established;

  /// Reliability badge: disputed (مختلف فيه).
  final Color disputed;

  /// Draft label text and icon (مسودة).
  final Color draft;

  /// Draft label and banner background.
  final Color draftSurface;

  static const light = SahabaColors(
    surfaceAlt: Palette.paperAlt,
    onSurfaceDim: Palette.inkDim,
    line: Palette.lineOnPaper,
    accent: Palette.gold,
    accentText: Palette.goldText,
    established: Palette.establishedOnPaper,
    disputed: Palette.disputedOnPaper,
    draft: Palette.draftOnPaper,
    draftSurface: Palette.draftWash,
  );

  static const dark = SahabaColors(
    surfaceAlt: Palette.inkAlt,
    onSurfaceDim: Palette.paperDim,
    line: Palette.lineOnInk,
    accent: Palette.gold,
    accentText: Palette.goldOnInk,
    established: Palette.establishedOnInk,
    disputed: Palette.disputedOnInk,
    draft: Palette.draftOnInk,
    draftSurface: Palette.draftWashOnInk,
  );

  /// The feature sections: dark text roles on Madinah green.
  static final feature = dark.copyWith(
    surfaceAlt: Palette.greenAlt,
    onSurfaceDim: Palette.paperDimOnGreen,
    line: Palette.lineOnGreen,
    draft: Palette.draftOnGreen,
    draftSurface: Palette.draftWashOnGreen,
  );

  static SahabaColors of(BuildContext context) =>
      Theme.of(context).extension<SahabaColors>()!;

  @override
  SahabaColors copyWith({
    Color? surfaceAlt,
    Color? onSurfaceDim,
    Color? line,
    Color? accent,
    Color? accentText,
    Color? established,
    Color? disputed,
    Color? draft,
    Color? draftSurface,
  }) {
    return SahabaColors(
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      onSurfaceDim: onSurfaceDim ?? this.onSurfaceDim,
      line: line ?? this.line,
      accent: accent ?? this.accent,
      accentText: accentText ?? this.accentText,
      established: established ?? this.established,
      disputed: disputed ?? this.disputed,
      draft: draft ?? this.draft,
      draftSurface: draftSurface ?? this.draftSurface,
    );
  }

  @override
  SahabaColors lerp(SahabaColors? other, double t) {
    if (other == null) return this;
    return SahabaColors(
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      onSurfaceDim: Color.lerp(onSurfaceDim, other.onSurfaceDim, t)!,
      line: Color.lerp(line, other.line, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentText: Color.lerp(accentText, other.accentText, t)!,
      established: Color.lerp(established, other.established, t)!,
      disputed: Color.lerp(disputed, other.disputed, t)!,
      draft: Color.lerp(draft, other.draft, t)!,
      draftSurface: Color.lerp(draftSurface, other.draftSurface, t)!,
    );
  }
}
