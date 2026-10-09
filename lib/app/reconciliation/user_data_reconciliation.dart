import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/result/result.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/shared/content/domain/content_repository.dart';
import 'package:siyar_sahaba/shared/content/domain/content_target.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// What one pass of [reconcileUserData] found.
class ReconciliationReport {
  const ReconciliationReport({
    required this.confirmedPositions,
    required this.outdatedPositions,
    required this.removedPositions,
    required this.unavailableBookmarks,
    required this.failedLookups,
  });

  /// Positions whose passage is unchanged (now stamped with the build).
  final int confirmedPositions;

  /// Positions whose passage changed; kept, and the reader says so.
  final int outdatedPositions;

  /// Positions in passages that no longer exist; deleted.
  final int removedPositions;

  /// Saved items that no longer exist; kept, shown as unavailable.
  final int unavailableBookmarks;

  /// Targets whose content failed to load; left untouched.
  final int failedLookups;

  /// Whether every record was checked (no load failures).
  bool get complete => failedLookups == 0;
}

/// Checks every saved item and reading position against the content, once
/// per content build. The policy:
///
/// - A position in an **unchanged** passage is kept and stamped with the
///   passage's revision and the build.
/// - A position in an **edited** passage is kept as it is; the reader
///   reopens such a passage at the top and offers the old position.
/// - A position in a **removed** passage is deleted: it can no longer be
///   shown or restored.
/// - A **saved item** is never deleted automatically. If its target was
///   removed, Saved shows it as unavailable with a remove button.
/// - When the content **fails to load**, nothing is changed and the pass is
///   reported incomplete, so it runs again on the next start.
Future<ReconciliationReport> reconcileUserData({
  required ContentRepository content,
  required BookmarkRepository bookmarks,
  required ReadingProgressRepository progress,
  required String contentVersion,
}) async {
  var confirmed = 0;
  var outdated = 0;
  var removed = 0;
  var unavailable = 0;
  var failed = 0;

  for (final p in await progress.all()) {
    switch (await lookUpTarget(content, p.contentTarget)) {
      case Err():
        failed++;
      case Ok(value: TargetMissing()):
        await progress.remove(p.target, p.targetId);
        removed++;
      case Ok(:final value):
        final revision = switch (value) {
          FoundSection(:final section) => section.revision,
          FoundChapter(:final chapter) => chapter.revision,
          _ => null,
        };
        if (revision == null) {
          // A position never points at a companion or story.
          failed++;
        } else if (p.fitFor(
              revision: revision,
              contentVersion: contentVersion,
            ) ==
            PositionFit.current) {
          if (p.targetRevision != revision ||
              p.contentVersion != contentVersion) {
            await progress.confirmRevision(
              p.target,
              p.targetId,
              revision: revision,
              contentVersion: contentVersion,
            );
          }
          confirmed++;
        } else {
          outdated++;
        }
    }
  }

  for (final b in await bookmarks.all()) {
    final target = b.contentTarget;
    if (target == null) {
      unavailable++;
      continue;
    }
    switch (await lookUpTarget(content, target)) {
      case Err():
        failed++;
      case Ok(value: TargetMissing()):
        unavailable++;
      case Ok():
        break;
    }
  }

  return ReconciliationReport(
    confirmedPositions: confirmed,
    outdatedPositions: outdated,
    removedPositions: removed,
    unavailableBookmarks: unavailable,
    failedLookups: failed,
  );
}

/// Runs [reconcileUserData] once per app start when the content build
/// differs from the one last checked. Null when there was nothing to do.
final userDataReconciliationProvider = FutureProvider<ReconciliationReport?>((
  ref,
) async {
  final manifest = await ref.watch(contentManifestProvider.future);
  final settings = ref.watch(settingsStoreProvider);
  final build = '${manifest.contentVersion}+${manifest.channel.name}';
  if (settings.getString(SettingsKeys.reconciledContent) == build) return null;

  final report = await reconcileUserData(
    content: ref.watch(contentRepositoryProvider),
    bookmarks: ref.watch(bookmarkRepositoryProvider),
    progress: ref.watch(readingProgressRepositoryProvider),
    contentVersion: manifest.contentVersion,
  );
  if (report.complete) {
    await settings.setString(SettingsKeys.reconciledContent, build);
  }
  return report;
});
