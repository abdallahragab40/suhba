import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/shared/content/domain/content_block.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

part 'story.freezed.dart';

@freezed
abstract class StoryChapter with _$StoryChapter {
  const factory StoryChapter({
    required String id,
    required LocalizedText title,
    required List<ContentBlock> blocks,

    /// Fingerprint of the chapter's content; changes whenever it is edited.
    required String revision,
  }) = _StoryChapter;
}

/// The light version of a story used by lists.
@freezed
abstract class StorySummary with _$StorySummary {
  const factory StorySummary({
    required String id,
    required LocalizedText title,
    required LocalizedText synopsis,
    required List<String> companionIds,
    required int readingMinutes,
    required ReviewInfo review,
  }) = _StorySummary;
}

@freezed
abstract class Story with _$Story {
  const factory Story({
    required String id,
    required LocalizedText title,
    required LocalizedText synopsis,
    required List<String> companionIds,
    required int readingMinutes,
    required List<StoryChapter> chapters,
    required ReviewInfo review,
    @Default(<String>[]) List<String> eventIds,
  }) = _Story;
}
