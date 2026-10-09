import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/database/database_provider.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/bookmarks/data/drift_bookmark_repository.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';

final bookmarkRepositoryProvider = Provider<BookmarkRepository>(
  (ref) => DriftBookmarkRepository(
    ref.watch(appDatabaseProvider),
    clock: ref.watch(clockProvider),
  ),
);

/// Every saved item, newest first.
final bookmarksProvider = StreamProvider<List<Bookmark>>(
  (ref) => ref.watch(bookmarkRepositoryProvider).watchAll(),
);

/// Whether one item is saved.
final isSavedProvider = StreamProvider.autoDispose
    .family<bool, (BookmarkTarget, String)>(
      (ref, key) =>
          ref.watch(bookmarkRepositoryProvider).watchIsSaved(key.$1, key.$2),
    );

/// The save toggle for an app bar.
class BookmarkButton extends ConsumerWidget {
  const BookmarkButton({
    required this.target,
    required this.targetId,
    this.parentId,
    super.key,
  });

  final BookmarkTarget target;
  final String targetId;
  final String? parentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final saved = ref.watch(isSavedProvider((target, targetId))).value ?? false;
    return IconButton(
      tooltip: saved ? l10n.bookmarkRemove : l10n.bookmarkAdd,
      isSelected: saved,
      icon: const Icon(Icons.bookmark_border),
      selectedIcon: const Icon(Icons.bookmark),
      onPressed: () async {
        final messenger = ScaffoldMessenger.maybeOf(context);
        String message;
        try {
          final nowSaved = await ref
              .read(bookmarkRepositoryProvider)
              .toggle(target, targetId, parentId: parentId);
          message = nowSaved ? l10n.bookmarkSaved : l10n.bookmarkRemoved;
        } on Object catch (error, stackTrace) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: error,
              stack: stackTrace,
              library: 'bookmarks',
            ),
          );
          message = l10n.bookmarkUpdateFailed;
        }
        messenger
          ?..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 2),
            ),
          );
      },
    );
  }
}
