import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/design_system/widgets/undo_snack_bar.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:suhba/features/reading_progress/presentation/continue_reading.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/presentation/target_description.dart';
import 'package:suhba/shared/content/providers.dart';

/// Saved items and unfinished reading (S11). Loading, a failed load and an
/// empty list are three different states: a failure never looks like
/// "nothing saved", and nothing is deleted because of it.
class SavedPage extends ConsumerWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final bookmarksAsync = ref.watch(bookmarksProvider);
    final progressAsync = ref.watch(inProgressProvider);

    final Widget body;
    if (bookmarksAsync is AsyncError || progressAsync is AsyncError) {
      body = ErrorView(
        error: bookmarksAsync.error ?? progressAsync.error,
        message: l10n.savedLoadErrorMessage,
        onRetry: () => ref
          ..invalidate(bookmarksProvider)
          ..invalidate(inProgressProvider),
      );
    } else if (!bookmarksAsync.hasValue || !progressAsync.hasValue) {
      body = const Padding(
        padding: EdgeInsets.all(AppSpacing.gutter),
        child: LoadingSkeleton(),
      );
    } else if (bookmarksAsync.requireValue.isEmpty &&
        progressAsync.requireValue.isEmpty) {
      body = EmptyState(
        icon: Icons.bookmark_border,
        title: l10n.savedEmptyTitle,
        message: l10n.savedEmptyMessage,
      );
    } else {
      body = _SavedList(bookmarks: bookmarksAsync.requireValue);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabSaved),
        actions: [
          IconButton(
            tooltip: l10n.historyTitle,
            icon: const Icon(Icons.history),
            onPressed: () => context.go(AppRoutes.readingHistory),
          ),
        ],
      ),
      body: body,
    );
  }
}

class _SavedList extends StatelessWidget {
  const _SavedList({required this.bookmarks});

  final List<Bookmark> bookmarks;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    String groupLabel(BookmarkTarget t) => switch (t) {
      BookmarkTarget.companion => l10n.savedCompanions,
      BookmarkTarget.section => l10n.savedSections,
      BookmarkTarget.story => l10n.savedStories,
      BookmarkTarget.chapter => l10n.savedChapters,
      BookmarkTarget.seerahChapter => l10n.savedSeerahChapters,
      BookmarkTarget.seerahTopic => l10n.savedSeerahTopics,
    };

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter,
        AppSpacing.xxl,
      ),
      children: [
        ContinueReadingList(
          limit: 10,
          header: Padding(
            padding: const EdgeInsetsDirectional.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: SectionHeader(
              kicker: l10n.continueKicker,
              title: l10n.continueTitle,
            ),
          ),
        ),
        if (bookmarks.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(top: AppSpacing.md),
            child: SectionHeader(
              kicker: l10n.savedKicker,
              title: l10n.savedTitle,
            ),
          ),
        for (final target in BookmarkTarget.values)
          if (bookmarks.where((b) => b.target == target).toList()
              case final group when group.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsetsDirectional.only(top: AppSpacing.md),
              child: Text(
                groupLabel(target),
                style: SuhbaTextStyles.of(context).kicker,
              ),
            ),
            for (final b in group)
              SavedTile(
                key: ValueKey('${b.target}.${b.targetId}'),
                bookmark: b,
              ),
          ],
      ],
    );
  }
}

/// One saved item, resolved against the content. While loading it shows a
/// placeholder; if its content fails to load it offers a retry; if the item
/// was removed from the content it says so and can be removed from Saved.
class SavedTile extends ConsumerWidget {
  const SavedTile({required this.bookmark, super.key});

  final Bookmark bookmark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final b = bookmark;
    final target = b.contentTarget;
    final lookup = target == null
        ? const AsyncData<TargetLookup>(TargetMissing())
        : ref.watch(targetLookupProvider(target));

    final removeButton = IconButton(
      tooltip: l10n.bookmarkRemove,
      icon: const Icon(Icons.bookmark_remove_outlined),
      onPressed: () => _remove(context, ref),
    );
    Text dim(String text, {int maxLines = 1}) => Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: colors.onSurfaceDim),
    );

    switch (lookup) {
      case AsyncData(value: TargetMissing()):
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.link_off, color: colors.onSurfaceDim),
          title: Text(l10n.savedItemUnavailableTitle),
          subtitle: dim(l10n.savedItemUnavailableMessage, maxLines: 3),
          trailing: removeButton,
        );
      case AsyncData(:final value):
        final d = describeTarget(context, value)!;
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(d.title),
          subtitle: d.parent == null ? null : dim(d.parent!),
          onTap: () => context.push(d.route),
          trailing: removeButton,
        );
      case AsyncError():
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.error_outline, color: colors.onSurfaceDim),
          title: Text(l10n.savedItemLoadError),
          trailing: IconButton(
            tooltip: l10n.retry,
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(targetLookupProvider(target!)),
          ),
        );
      default:
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            l10n.savedItemLoading,
            style: TextStyle(color: colors.onSurfaceDim),
          ),
        );
    }
  }

  /// Removes the item, offering to put it back exactly as it was.
  Future<void> _remove(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final l10n = AppLocalizations.of(context);
    final repository = ref.read(bookmarkRepositoryProvider);
    try {
      await repository.remove(bookmark.target, bookmark.targetId);
    } on Object {
      messenger?.showSnackBar(
        SnackBar(content: Text(l10n.bookmarkUpdateFailed)),
      );
      return;
    }
    showUndoSnackBar(
      messenger,
      l10n,
      message: l10n.bookmarkRemovedUndo,
      onUndo: () => repository.restore(bookmark),
    );
  }
}
