import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/shared/content/domain/review.dart';

part 'content_manifest.freezed.dart';

/// Describes the bundled content build.
@freezed
abstract class ContentManifest with _$ContentManifest {
  const factory ContentManifest({
    required String contentVersion,
    required int schemaVersion,
    required ContentChannel channel,
    required int companionCount,
    required int storyCount,
    required int approvedCount,
    required int unapprovedCount,
    @Default(0) int seerahChapterCount,
    @Default(0) int seerahTopicCount,
    @Default(0) int placeCount,
    @Default(0) int visualCount,
  }) = _ContentManifest;

  const ContentManifest._();

  bool get isDraft => channel == ContentChannel.draft;
}
