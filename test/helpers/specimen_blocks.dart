import 'package:siyar_sahaba/core/domain/quran_ref.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';

const _pending = Citation(sourceId: 's', locatorStatus: LocatorStatus.pending);
const _graded = Citation(
  sourceId: 'bukhari',
  locatorStatus: LocatorStatus.pending,
  grading: Grading(
    grade: HadithGrade.sahih,
    gradedBy: LocalizedText(ar: 'البخاري'),
  ),
);

/// One block of every type, for the renderer tests and the golden.
final specimenBlocks = <ContentBlock>[
  const ContentBlock.paragraph(
    text: LocalizedText(ar: 'فقرة ثابتة بلا شارة ظاهرة.'),
    reliability: Reliability.established,
    citations: [_pending, _pending],
  ),
  const ContentBlock.paragraph(
    text: LocalizedText(ar: 'فقرة من رواية تاريخية.'),
    reliability: Reliability.reported,
    citations: [_pending],
  ),
  const ContentBlock.quranQuote(ref: QuranRef(surah: 9, ayahFrom: 40)),
  const ContentBlock.hadithQuote(
    textStatus: TextStatus.pendingFromSource,
    reliability: Reliability.established,
    citations: [_graded],
    summary: LocalizedText(ar: 'وصف مضمون الحديث.'),
  ),
  const ContentBlock.reportQuote(
    textStatus: TextStatus.complete,
    reliability: Reliability.reported,
    citations: [_pending],
    text: LocalizedText(ar: 'نص الرواية'),
  ),
  const ContentBlock.disputeNote(
    text: LocalizedText(ar: 'اختُلف في هذه المسألة.'),
    opinions: [
      Opinion(
        text: LocalizedText(ar: 'القول الأول.'),
        citations: [_pending],
      ),
      Opinion(
        text: LocalizedText(ar: 'القول الثاني.'),
        citations: [_pending],
      ),
    ],
  ),
  const ContentBlock.lesson(text: LocalizedText(ar: 'درس من القصة.')),
];
