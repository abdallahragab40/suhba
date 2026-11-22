import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';

/// Semantic colors that Material's [ColorScheme] has no role for.
///
/// Read with `SuhbaColors.of(context)`.
@immutable
class SuhbaColors extends ThemeExtension<SuhbaColors> {
  const SuhbaColors({
    required this.surfaceAlt,
    required this.onSurfaceDim,
    required this.line,
    required this.accent,
    required this.accentText,
    required this.link,
    required this.mark,
    required this.verseSurface,
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

  /// Links and source marks: green on paper, gold on ink and green.
  /// Gold text on paper is for illumination, not for things to tap.
  final Color link;

  /// Source marks set in running text: quieter than [link], so a page of
  /// prose is not dotted with accents (least of all gold ones at night).
  final Color mark;

  /// The ground of a Qur'anic verse: a faint gold wash, the one
  /// illuminated panel on a page.
  final Color verseSurface;

  /// Reliability badge: established (ثابت).
  final Color established;

  /// Reliability badge: disputed (مختلف فيه).
  final Color disputed;

  /// Draft label text and icon (مسودة).
  final Color draft;

  /// Draft label and banner background.
  final Color draftSurface;

  static const light = SuhbaColors(
    // Cards are lighter than the page, not darker: sheets on paper.
    surfaceAlt: Palette.paperLowest,
    onSurfaceDim: Palette.inkDim,
    line: Palette.lineOnPaper,
    accent: Palette.gold,
    accentText: Palette.goldText,
    link: Palette.green,
    mark: Palette.markOnPaper,
    verseSurface: Palette.verseWash,
    established: Palette.establishedOnPaper,
    disputed: Palette.disputedOnPaper,
    draft: Palette.draftOnPaper,
    draftSurface: Palette.draftWash,
  );

  static const dark = SuhbaColors(
    surfaceAlt: Palette.nightAlt,
    onSurfaceDim: Palette.dimOnNight,
    line: Palette.lineOnNight,
    accent: Palette.goldOnInk,
    accentText: Palette.goldOnInk,
    link: Palette.goldOnInk,
    mark: Palette.markOnNight,
    verseSurface: Palette.verseWashOnNight,
    established: Palette.establishedOnInk,
    disputed: Palette.disputedOnInk,
    draft: Palette.dimOnNight,
    draftSurface: Palette.nightHigh,
  );

  /// The feature sections: dark text roles on Madinah green.
  static final feature = dark.copyWith(
    surfaceAlt: Palette.greenAlt,
    onSurfaceDim: Palette.paperDimOnGreen,
    line: Palette.lineOnGreen,
    mark: Palette.goldOnInk,
    verseSurface: Palette.greenAlt,
    established: Palette.establishedOnGreen,
    draft: Palette.draftOnGreen,
    draftSurface: Palette.draftWashOnGreen,
  );

  static SuhbaColors of(BuildContext context) =>
      Theme.of(context).extension<SuhbaColors>()!;

  @override
  SuhbaColors copyWith({
    Color? surfaceAlt,
    Color? onSurfaceDim,
    Color? line,
    Color? accent,
    Color? accentText,
    Color? link,
    Color? mark,
    Color? verseSurface,
    Color? established,
    Color? disputed,
    Color? draft,
    Color? draftSurface,
  }) {
    return SuhbaColors(
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      onSurfaceDim: onSurfaceDim ?? this.onSurfaceDim,
      line: line ?? this.line,
      accent: accent ?? this.accent,
      accentText: accentText ?? this.accentText,
      link: link ?? this.link,
      mark: mark ?? this.mark,
      verseSurface: verseSurface ?? this.verseSurface,
      established: established ?? this.established,
      disputed: disputed ?? this.disputed,
      draft: draft ?? this.draft,
      draftSurface: draftSurface ?? this.draftSurface,
    );
  }

  @override
  SuhbaColors lerp(SuhbaColors? other, double t) {
    if (other == null) return this;
    return SuhbaColors(
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      onSurfaceDim: Color.lerp(onSurfaceDim, other.onSurfaceDim, t)!,
      line: Color.lerp(line, other.line, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentText: Color.lerp(accentText, other.accentText, t)!,
      link: Color.lerp(link, other.link, t)!,
      mark: Color.lerp(mark, other.mark, t)!,
      verseSurface: Color.lerp(verseSurface, other.verseSurface, t)!,
      established: Color.lerp(established, other.established, t)!,
      disputed: Color.lerp(disputed, other.disputed, t)!,
      draft: Color.lerp(draft, other.draft, t)!,
      draftSurface: Color.lerp(draftSurface, other.draftSurface, t)!,
    );
  }
}
