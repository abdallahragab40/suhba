import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/shared/content/domain/content_block.dart';
import 'package:suhba/shared/content/domain/content_repository.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';

class JourneyReading {
  const JourneyReading({
    required this.ref,
    required this.title,
    required this.blocks,
  });
  final StepRef ref;
  final LocalizedText title;
  final List<ContentBlock> blocks;

  int get wordCount => proseWordCount(blocks);
  int get minutes => readingMinutes(wordCount);
}

/// Words read per minute for the reading-time estimates.
const readingWordsPerMinute = 160;

/// Minutes to read [words] words, at least one.
int readingMinutes(int words) =>
    (words / readingWordsPerMinute).ceil().clamp(1, 1000);

/// Null only for a confirmed removal; load failures are thrown and retried.
Future<JourneyReading?> resolveJourneyReading(
  ContentRepository content,
  StepRef ref,
) async {
  final found = (await lookUpTarget(content, ref.target)).getOrThrow();
  return switch (found) {
    FoundSection(:final section) => JourneyReading(
      ref: ref,
      title: section.title,
      blocks: section.blocks,
    ),
    FoundChapter(:final chapter) => JourneyReading(
      ref: ref,
      title: chapter.title,
      blocks: chapter.blocks,
    ),
    FoundSeerahChapter(:final chapter) => JourneyReading(
      ref: ref,
      title: chapter.title,
      blocks: chapter.blocks,
    ),
    FoundSeerahTopic(:final topic) => JourneyReading(
      ref: ref,
      title: topic.title,
      blocks: topic.blocks,
    ),
    TargetMissing() => null,
    _ => throw StateError('Journey reference is not a passage'),
  };
}
