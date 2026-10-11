import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';

/// Where an item is in the editorial workflow. Only [approved] items can be
/// published, and only with a valid approval record (enforced by
/// tool/content_validate.dart).
enum ReviewStatus {
  draft,
  sourced,

  /// Checked in a preliminary review: every claim against its cited source
  /// and every quote against the source text, with problems corrected. Not
  /// an approval: a qualified scholar must still approve before
  /// publication.
  preliminaryReview,
  inReview,
  approved,
  rejected,
}

/// Editorial markers that need attention before publication.
enum EditorialFlag {
  /// Touches the fitna; needs the reviewer's explicit sign-off.
  fitnaAdjacent,

  /// Some citation locators (volume, page, number) are still pending.
  needsLocators,

  /// Some quoted text must still be copied verbatim from the source.
  needsSourceText,
}

/// How complete the editor says a text is. It is a statement about the
/// writing, not an approval: only a reviewer approves.
enum Coverage {
  /// Headings or a profile only.
  skeleton,

  /// A short pilot, not the full treatment.
  sample,

  /// Written to the editorial brief.
  complete,
}

/// Which build of the content the app is running.
enum ContentChannel {
  /// Development and internal previews: unreviewed items included and
  /// labelled as drafts.
  draft,

  /// Store releases: approved items only.
  published,
}

/// The review state shipped with each item.
@freezed
abstract class ReviewInfo with _$ReviewInfo {
  const factory ReviewInfo({
    required ReviewStatus status,
    @Default(<EditorialFlag>{}) Set<EditorialFlag> editorialFlags,

    /// The editor's coverage statement; null when none was made.
    Coverage? coverage,
  }) = _ReviewInfo;

  const ReviewInfo._();

  bool get isApproved => status == ReviewStatus.approved;

  /// Checked in a preliminary review, but not approved.
  bool get isPreliminary => status == ReviewStatus.preliminaryReview;
}
