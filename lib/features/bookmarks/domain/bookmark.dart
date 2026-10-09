import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/shared/content/domain/content_target.dart';

part 'bookmark.freezed.dart';

/// What can be saved.
enum BookmarkTarget { companion, section, story, chapter }

@freezed
abstract class Bookmark with _$Bookmark {
  const factory Bookmark({
    required BookmarkTarget target,
    required String targetId,
    required DateTime createdAt,

    /// The companion of a section, or the story of a chapter.
    String? parentId,
  }) = _Bookmark;

  const Bookmark._();

  /// What this item points at; null when a section or chapter was saved
  /// without its parent, so it cannot be found.
  ContentTarget? get contentTarget => switch (target) {
    BookmarkTarget.companion => ContentTarget.companion(targetId),
    BookmarkTarget.story => ContentTarget.story(targetId),
    BookmarkTarget.section when parentId != null => ContentTarget.section(
      parentId!,
      targetId,
    ),
    BookmarkTarget.chapter when parentId != null => ContentTarget.chapter(
      parentId!,
      targetId,
    ),
    _ => null,
  };
}

/// Saved items, newest first. Lives on the device only.
abstract interface class BookmarkRepository {
  Stream<List<Bookmark>> watchAll();

  /// Every saved item, newest first (one-shot).
  Future<List<Bookmark>> all();

  Stream<bool> watchIsSaved(BookmarkTarget target, String targetId);

  /// Saves the item, or removes it if it is already saved. Returns whether
  /// it is saved afterwards.
  Future<bool> toggle(
    BookmarkTarget target,
    String targetId, {
    String? parentId,
  });

  Future<void> remove(BookmarkTarget target, String targetId);

  /// Puts back [bookmark] exactly as it was (its date and parent), e.g. to
  /// undo a removal. Does nothing if the item is saved again meanwhile.
  Future<void> restore(Bookmark bookmark);

  /// Removes every saved item; returns how many there were.
  Future<int> clearAll();
}
