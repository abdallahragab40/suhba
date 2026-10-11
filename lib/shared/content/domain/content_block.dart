import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/core/domain/quran_ref.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';

part 'content_block.freezed.dart';

/// Whether quoted text is final or must still be copied from the source.
enum TextStatus { complete, pendingFromSource }

/// One opinion in a [DisputeNoteBlock].
@freezed
abstract class Opinion with _$Opinion {
  const factory Opinion({
    required LocalizedText text,
    required List<Citation> citations,
  }) = _Opinion;
}

/// A unit of biography or story text. Claims are sourced block by block.
@freezed
sealed class ContentBlock with _$ContentBlock {
  /// Narrative text.
  const factory ContentBlock.paragraph({
    required LocalizedText text,
    required Reliability reliability,
    required List<Citation> citations,
  }) = ParagraphBlock;

  /// An editorial reflection ("درس وعبرة"); commentary, not a claim.
  const factory ContentBlock.lesson({required LocalizedText text}) =
      LessonBlock;

  /// A Qur'anic verse, stored by reference only.
  const factory ContentBlock.quranQuote({
    required QuranRef ref,
    LocalizedText? note,
  }) = QuranQuoteBlock;

  /// A hadith. [text] is null while it is pending from the source; the
  /// [summary] can stand in meanwhile.
  const factory ContentBlock.hadithQuote({
    required TextStatus textStatus,
    required Reliability reliability,
    required List<Citation> citations,
    LocalizedText? text,
    LocalizedText? summary,
  }) = HadithQuoteBlock;

  /// A historical report (athar), handled like a hadith quote.
  const factory ContentBlock.reportQuote({
    required TextStatus textStatus,
    required Reliability reliability,
    required List<Citation> citations,
    LocalizedText? text,
    LocalizedText? summary,
  }) = ReportQuoteBlock;

  /// Where reports differ: an introduction and each opinion with its
  /// sources.
  const factory ContentBlock.disputeNote({
    required LocalizedText text,
    required List<Opinion> opinions,
  }) = DisputeNoteBlock;

  /// A subheading inside a long passage. Not a claim.
  const factory ContentBlock.heading({required LocalizedText text}) =
      HeadingBlock;

  /// A visual shown inside the passage. Its facts are sourced in the
  /// visual itself (see `Infographic`).
  const factory ContentBlock.infographic({
    required String visualId,
    LocalizedText? caption,
  }) = InfographicBlock;
}

extension ContentBlockCitations on ContentBlock {
  /// Every citation in this block, including each opinion's in a dispute.
  List<Citation> get allCitations => switch (this) {
    ParagraphBlock(:final citations) ||
    HadithQuoteBlock(:final citations) ||
    ReportQuoteBlock(:final citations) => citations,
    DisputeNoteBlock(:final opinions) => [
      for (final o in opinions) ...o.citations,
    ],
    LessonBlock() ||
    QuranQuoteBlock() ||
    HeadingBlock() ||
    InfographicBlock() => const [],
  };
}

/// The readable prose of [blocks], one string per piece: paragraphs,
/// lessons, dispute notes and their opinions, and quotes whose text is
/// complete. A quote still pending from its source contributes nothing:
/// neither a placeholder nor its stand-in summary counts as the quote.
/// Qur'anic verses are referenced, not stored, so they are not here.
/// Headings are included only when [headings] is true.
List<String> readableProse(
  List<ContentBlock> blocks, {
  bool headings = false,
}) => [
  for (final b in blocks)
    ...switch (b) {
      ParagraphBlock(:final text) || LessonBlock(:final text) => [text.ar],
      HadithQuoteBlock(textStatus: TextStatus.complete, :final text?) ||
      ReportQuoteBlock(
        textStatus: TextStatus.complete,
        :final text?,
      ) => [text.ar],
      DisputeNoteBlock(:final text, :final opinions) => [
        text.ar,
        for (final o in opinions) o.text.ar,
      ],
      HeadingBlock(:final text) when headings => [text.ar],
      _ => const <String>[],
    },
];

/// How many words of readable prose [blocks] hold (see [readableProse]).
int proseWordCount(List<ContentBlock> blocks) => [
  for (final text in readableProse(blocks))
    ...text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty),
].length;
