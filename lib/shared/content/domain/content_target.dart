import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/core/result/failure.dart';
import 'package:siyar_sahaba/core/result/result.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_repository.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';

part 'content_target.freezed.dart';

/// Something in the content that user data points at: a saved item or a
/// reading position.
@freezed
sealed class ContentTarget with _$ContentTarget {
  const factory ContentTarget.companion(String id) = CompanionTarget;
  const factory ContentTarget.section(String companionId, String sectionId) =
      SectionTarget;
  const factory ContentTarget.story(String id) = StoryTarget;
  const factory ContentTarget.chapter(String storyId, String chapterId) =
      ChapterTarget;
}

/// What a [ContentTarget] resolves to in the current content.
sealed class TargetLookup {
  const TargetLookup();
}

/// The content loaded and the target is not in it (removed or renamed).
/// Distinct from a load failure, which is reported as a [Failure].
final class TargetMissing extends TargetLookup {
  const TargetMissing();
}

final class FoundCompanion extends TargetLookup {
  const FoundCompanion(this.companion);
  final CompanionSummary companion;
}

final class FoundSection extends TargetLookup {
  const FoundSection(this.companion, this.section);
  final Companion companion;
  final BiographySection section;
}

final class FoundStory extends TargetLookup {
  const FoundStory(this.story);
  final StorySummary story;
}

final class FoundChapter extends TargetLookup {
  const FoundChapter(this.story, this.chapter);
  final Story story;
  final StoryChapter chapter;
}

/// Resolves [target] against [content]. A target counts as missing only
/// when the content that should hold it loaded without it (or its file is
/// absent); any other failure is returned as an [Err], so callers never
/// mistake a transient error for a removal.
Future<Result<TargetLookup>> lookUpTarget(
  ContentRepository content,
  ContentTarget target,
) async {
  Result<TargetLookup> missingIfNotFound<T>(
    Result<T> result,
    TargetLookup Function(T value) found,
  ) => switch (result) {
    Ok(:final value) => Ok(found(value)),
    Err(failure: NotFoundFailure()) => const Ok(TargetMissing()),
    Err(:final failure) => Err(failure),
  };

  switch (target) {
    case CompanionTarget(:final id):
      return missingIfNotFound(await content.companionIndex(), (index) {
        final c = index.where((c) => c.id == id).firstOrNull;
        return c == null ? const TargetMissing() : FoundCompanion(c);
      });
    case SectionTarget(:final companionId, :final sectionId):
      return missingIfNotFound(await content.companion(companionId), (c) {
        final s = c.sections.where((s) => s.id == sectionId).firstOrNull;
        return s == null ? const TargetMissing() : FoundSection(c, s);
      });
    case StoryTarget(:final id):
      return missingIfNotFound(await content.storyIndex(), (index) {
        final s = index.where((s) => s.id == id).firstOrNull;
        return s == null ? const TargetMissing() : FoundStory(s);
      });
    case ChapterTarget(:final storyId, :final chapterId):
      return missingIfNotFound(await content.story(storyId), (s) {
        final ch = s.chapters.where((c) => c.id == chapterId).firstOrNull;
        return ch == null ? const TargetMissing() : FoundChapter(s, ch);
      });
  }
}
