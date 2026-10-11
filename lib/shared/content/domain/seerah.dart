import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/domain/content_block.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

part 'seerah.freezed.dart';

/// The period a Seerah chapter belongs to.
enum SeerahEra { preIslam, makkan, madinan }

/// A broad period of the Seerah (the Makkan and Madinan years), as a
/// sourced date range with the chapters it spans.
@freezed
abstract class SeerahPeriod with _$SeerahPeriod {
  const factory SeerahPeriod({
    required String id,
    required LocalizedText name,
    required HistoricalDate date,
    required LocalizedText summary,
    required Reliability reliability,
    required List<Citation> citations,
    required List<String> chapterIds,
  }) = _SeerahPeriod;
}

/// The Seerah section (محمد رسول الله ﷺ): its opening, periods, and the
/// reading order of its chapters and topics.
///
/// It is its own content type: the Prophet ﷺ is never a Companion entry,
/// never counted among a category of Companions, and never featured as a
/// "companion of the day".
@freezed
abstract class SeerahCollection with _$SeerahCollection {
  const factory SeerahCollection({
    required LocalizedText title,
    required LocalizedText subtitle,
    required List<ContentBlock> introduction,
    required List<SeerahPeriod> periods,

    /// Reading order.
    required List<String> chapterIds,
    required List<String> topicIds,
    required LocalizedText methodology,
    required List<String> references,
    required ReviewInfo review,
    @Default(<String>[]) List<String> featuredEventIds,
    @Default(<String>[]) List<String> featuredPlaceIds,
    @Default(<String>[]) List<String> companionIds,
    @Default(<String>[]) List<String> visualIds,
  }) = _SeerahCollection;
}

/// The light version of a chapter used by the hub and Home.
@freezed
abstract class SeerahChapterSummary with _$SeerahChapterSummary {
  const factory SeerahChapterSummary({
    required String id,

    /// 1-based position in the reading order.
    required int number,
    required LocalizedText title,
    required LocalizedText abstract,
    required SeerahEra era,
    required HistoricalDate date,
    required ReviewInfo review,

    /// Words of readable prose, for an estimated reading time.
    required int wordCount,
    @Default(<String>[]) List<String> visualIds,
  }) = _SeerahChapterSummary;
}

@freezed
abstract class SeerahChapter with _$SeerahChapter {
  const factory SeerahChapter({
    required String id,
    required int number,
    required LocalizedText title,
    required LocalizedText abstract,
    required SeerahEra era,
    required HistoricalDate date,
    required List<String> references,
    required List<ContentBlock> blocks,
    required ReviewInfo review,

    /// Fingerprint of the chapter's content; changes whenever it is edited.
    required String revision,
    @Default(<String>[]) List<String> eventIds,
    @Default(<String>[]) List<String> placeIds,
    @Default(<String>[]) List<String> companionIds,
    @Default(<String>[]) List<String> visualIds,
  }) = _SeerahChapter;
}

@freezed
abstract class SeerahTopicSummary with _$SeerahTopicSummary {
  const factory SeerahTopicSummary({
    required String id,
    required int number,
    required LocalizedText title,
    required LocalizedText abstract,
    required ReviewInfo review,
    required int wordCount,
  }) = _SeerahTopicSummary;
}

/// A thematic essay (رحمته ﷺ, عبادته …). Lessons in it are editorial.
@freezed
abstract class SeerahTopic with _$SeerahTopic {
  const factory SeerahTopic({
    required String id,
    required int number,
    required LocalizedText title,
    required LocalizedText abstract,
    required List<String> references,
    required List<ContentBlock> blocks,
    required ReviewInfo review,
    required String revision,
    @Default(<String>[]) List<String> chapterIds,
    @Default(<String>[]) List<String> companionIds,
  }) = _SeerahTopic;
}

/// The Seerah index: the collection with every chapter and topic summary,
/// in reading order.
@freezed
abstract class SeerahIndex with _$SeerahIndex {
  const factory SeerahIndex({
    required SeerahCollection collection,
    required List<SeerahChapterSummary> chapters,
    required List<SeerahTopicSummary> topics,
  }) = _SeerahIndex;
}
