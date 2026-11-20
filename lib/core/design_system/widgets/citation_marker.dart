import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/touch_area.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// The mark after a claim that opens its sources: a small book glyph, with
/// the number of sources only when there is more than one (a lone number
/// read as an out-of-order footnote, review F03).
///
/// A [reported] claim (رواية تاريخية) shows a scroll-and-quill glyph, which
/// the passage legend explains; the full label is in the source sheet and in
/// the screen-reader label (review F10, decision 1).
///
/// The glyph is small; the tap target is the full 48 × 48.
class CitationMarker extends StatelessWidget {
  const CitationMarker({
    required this.count,
    required this.onPressed,
    this.reported = false,
    super.key,
  }) : inline = false,
       lineHeight = null;

  /// The mark set inside a line of text, after a paragraph's last word, as
  /// a footnote mark is. Its box is as tall as the line ([lineHeight], the
  /// unscaled font size × line height), so the line keeps its height, and a
  /// little wider than the glyph: that box is the touch area. The screen
  /// reader's area is a full 48 × 48 ([TouchArea]).
  ///
  /// Sizes are unscaled: a [WidgetSpan] scales its child with the text.
  const CitationMarker.inline({
    required this.count,
    required this.onPressed,
    required double this.lineHeight,
    this.reported = false,
    super.key,
  }) : inline = true;

  /// How many sources the claim has.
  final int count;
  final VoidCallback onPressed;
  final bool reported;
  final bool inline;
  final double? lineHeight;

  static const glyphSource = Icons.menu_book_outlined;
  static const glyphReported = Icons.history_edu;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final formatted = DisplayFormatter.of(context).integer(count);
    final scaler = MediaQuery.textScalerOf(context);
    final label = reported
        ? '${l10n.reliabilityReported}، ${l10n.citationsButton(formatted)}'
        : l10n.citationsButton(formatted);
    // Inline, the enclosing WidgetSpan does the scaling.
    final glyphSize = inline ? 16.0 : scaler.scale(16);
    final glyph = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          reported ? glyphReported : glyphSource,
          size: glyphSize,
          color: colors.link,
        ),
        if (count > 1)
          Text(
            formatted,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: colors.link),
          ),
      ],
    );
    if (inline) {
      return TouchArea(
        label: label,
        onTap: onPressed,
        child: MediaQuery.withNoTextScaling(
          child: InkResponse(
            onTap: onPressed,
            radius: 24,
            child: SizedBox(
              height: lineHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(widthFactor: 1, child: glyph),
              ),
            ),
          ),
        ),
      );
    }
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      // The child's tap is excluded with its semantics, so the action has
      // to be declared here or screen readers get a button that does nothing.
      onTap: onPressed,
      child: InkResponse(
        onTap: onPressed,
        radius: 24,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: Center(widthFactor: 1, heightFactor: 1, child: glyph),
        ),
      ),
    );
  }
}
