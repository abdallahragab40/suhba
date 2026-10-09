import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/presentation/reader_scaffold.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/infographic_view.dart';

/// Opens the sources of one claim.
typedef OpenCitations =
    void Function(List<Citation> citations, Reliability? reliability);

/// Renders biography, story and Seerah blocks for long-form reading.
///
/// Every claim keeps its sources one tap away. A reliability badge is shown
/// when a claim is not established (established is the quiet default).
/// Qur'anic text is never typed by hand: verses appear by reference until a
/// verified mushaf dataset is bundled.
class ReadingBody extends StatelessWidget {
  const ReadingBody({
    required this.blocks,
    required this.provisional,
    required this.onCitations,
    this.textSize,
    super.key,
  });

  final List<ContentBlock> blocks;

  /// True for unreviewed (draft) content: badges are drawn as provisional.
  final bool provisional;
  final OpenCitations onCitations;

  /// Reading font size before the system text scale; theme default if null.
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, block) in blocks.indexed)
          // In a reader, each block anchors saved positions.
          ReaderAnchor(
            index: index,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
              child: _block(context, block),
            ),
          ),
      ],
    );
  }

  TextStyle _reading(BuildContext context, {bool strong = false}) {
    final styles = SahabaTextStyles.of(context);
    final base = strong ? styles.readingStrong : styles.reading;
    return textSize == null ? base : base.copyWith(fontSize: textSize);
  }

  Widget _block(BuildContext context, ContentBlock block) => switch (block) {
    ParagraphBlock(:final text, :final reliability, :final citations) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text.of(context), style: _reading(context)),
        _ClaimFooter(
          reliability: reliability,
          citations: citations,
          provisional: provisional,
          showBadge: reliability != Reliability.established,
          onCitations: onCitations,
        ),
      ],
    ),
    LessonBlock(:final text) => _Callout(
      kicker: AppLocalizations.of(context).lessonLabel,
      icon: Icons.lightbulb_outline,
      child: Text(text.of(context), style: _reading(context)),
    ),
    QuranQuoteBlock(:final ref, :final note) => _QuranQuote(
      reference: DisplayFormatter.of(context).quranRef(ref),
      note: note?.of(context),
    ),
    HadithQuoteBlock(
      :final textStatus,
      :final reliability,
      :final citations,
      :final text,
      :final summary,
    ) =>
      _Quote(
        kicker: AppLocalizations.of(context).hadithLabel,
        text: textStatus == TextStatus.complete ? text?.of(context) : null,
        summary: summary?.of(context),
        textStyle: _reading(context, strong: true),
        summaryStyle: _reading(context),
        footer: _ClaimFooter(
          reliability: reliability,
          citations: citations,
          provisional: provisional,
          showBadge: true,
          onCitations: onCitations,
        ),
        grading: citations.map((c) => c.grading).nonNulls.firstOrNull,
      ),
    ReportQuoteBlock(
      :final textStatus,
      :final reliability,
      :final citations,
      :final text,
      :final summary,
    ) =>
      _Quote(
        kicker: AppLocalizations.of(context).reportLabel,
        text: textStatus == TextStatus.complete ? text?.of(context) : null,
        summary: summary?.of(context),
        textStyle: _reading(context, strong: true),
        summaryStyle: _reading(context),
        footer: _ClaimFooter(
          reliability: reliability,
          citations: citations,
          provisional: provisional,
          showBadge: true,
          onCitations: onCitations,
        ),
      ),
    DisputeNoteBlock(:final text, :final opinions) => _DisputeNote(
      intro: text.of(context),
      opinions: opinions,
      textStyle: _reading(context),
      provisional: provisional,
      onCitations: onCitations,
    ),
    HeadingBlock(:final text) => Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: Semantics(
        header: true,
        child: Text(
          text.of(context),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    ),
    InfographicBlock(:final visualId, :final caption) => InfographicView(
      visualId: visualId,
      inline: true,
      caption: caption?.of(context),
    ),
  };
}

/// Badge and source marker under a claim.
class _ClaimFooter extends StatelessWidget {
  const _ClaimFooter({
    required this.reliability,
    required this.citations,
    required this.provisional,
    required this.showBadge,
    required this.onCitations,
  });

  final Reliability reliability;
  final List<Citation> citations;
  final bool provisional;
  final bool showBadge;
  final OpenCitations onCitations;

  @override
  Widget build(BuildContext context) {
    if (!showBadge && citations.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        if (showBadge)
          Flexible(
            child: ReliabilityBadge(reliability, provisional: provisional),
          ),
        if (citations.isNotEmpty)
          CitationMarker(
            count: citations.length,
            onPressed: () => onCitations(citations, reliability),
          ),
      ],
    );
  }
}

/// A framed block with a kicker: lessons, quotations, disputes.
class _Callout extends StatelessWidget {
  const _Callout({
    required this.kicker,
    required this.child,
    this.icon,
    this.accent,
  });

  final String kicker;
  final Widget child;
  final IconData? icon;

  /// The start-edge rule colour; the hairline colour by default.
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final colors = SahabaColors.of(context);
    final icon = this.icon;
    // A Material (not a plain coloured box) so ink from the markers and the
    // dispute's expansion tile shows. The start-edge rule is a positioned
    // strip: a rounded box cannot have a border on one side only.
    return Material(
      color: colors.surfaceAlt,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(AppRadii.md),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            width: 3,
            child: ColoredBox(color: accent ?? colors.line),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 18, color: colors.accentText),
                      const SizedBox(width: AppSpacing.xxs),
                    ],
                    Flexible(
                      child: Text(
                        kicker,
                        style: SahabaTextStyles.of(context).kicker,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuranQuote extends StatelessWidget {
  const _QuranQuote({required this.reference, this.note});

  final String reference;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final note = this.note;
    return _Callout(
      kicker: l10n.quranReference(reference),
      icon: Icons.menu_book_outlined,
      accent: colors.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.quranTextPending,
            style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
          ),
          if (note != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(note, style: textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}

class _Quote extends StatelessWidget {
  const _Quote({
    required this.kicker,
    required this.text,
    required this.summary,
    required this.textStyle,
    required this.summaryStyle,
    required this.footer,
    this.grading,
  });

  final String kicker;

  /// The exact wording, or null while it is pending from the source.
  final String? text;
  final String? summary;
  final TextStyle textStyle;
  final TextStyle summaryStyle;
  final Widget footer;
  final Grading? grading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final text = this.text;
    final summary = this.summary;
    final grading = this.grading;
    return _Callout(
      kicker: kicker,
      icon: Icons.format_quote_outlined,
      accent: colors.established,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text != null)
            Text('«$text»', style: textStyle)
          else ...[
            if (summary != null) Text(summary, style: summaryStyle),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.quoteTextPending,
              style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
            ),
          ],
          if (grading != null)
            Text(
              l10n.citationGrading(switch (grading.grade) {
                HadithGrade.sahih => l10n.gradeSahih,
                HadithGrade.hasan => l10n.gradeHasan,
                HadithGrade.daif => l10n.gradeDaif,
              }, grading.gradedBy.of(context)),
              style: textTheme.bodySmall?.copyWith(color: colors.established),
            ),
          footer,
        ],
      ),
    );
  }
}

class _DisputeNote extends StatelessWidget {
  const _DisputeNote({
    required this.intro,
    required this.opinions,
    required this.textStyle,
    required this.provisional,
    required this.onCitations,
  });

  final String intro;
  final List<Opinion> opinions;
  final TextStyle textStyle;
  final bool provisional;
  final OpenCitations onCitations;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    return _Callout(
      kicker: l10n.disputeLabel,
      icon: Icons.call_split,
      accent: colors.disputed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(intro, style: textStyle),
          ReliabilityBadge(Reliability.disputed, provisional: provisional),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                l10n.disputeShowOpinions(format.integer(opinions.length)),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              children: [
                for (var i = 0; i < opinions.length; i++)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSpacing.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.disputeOpinion(format.integer(i + 1)),
                          style: SahabaTextStyles.of(context).kicker,
                        ),
                        Text(opinions[i].text.of(context), style: textStyle),
                        if (opinions[i].citations.isNotEmpty)
                          CitationMarker(
                            count: opinions[i].citations.length,
                            onPressed: () => onCitations(
                              opinions[i].citations,
                              Reliability.disputed,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
