import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/passage_contents.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/features/settings/presentation/reading_settings.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/features/sources/presentation/passage_share.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/content_target.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';
import 'package:siyar_sahaba/shared/content/presentation/reader_navigation.dart';
import 'package:siyar_sahaba/shared/content/presentation/reading_body.dart';
import 'package:siyar_sahaba/shared/content/presentation/record_links.dart';

/// A previous or next passage.
typedef PassageLink = ({String label, String title, VoidCallback open});

/// The reader shared by Seerah chapters and thematic essays: a tracked
/// reader (position, completion, contents, bookmark, reading settings)
/// with a heading, an abstract, the sourced blocks, related records and
/// previous/next links.
class SeerahPassageReader extends ConsumerWidget {
  const SeerahPassageReader({
    required this.target,
    required this.bookmarkTarget,
    required this.id,
    required this.revision,
    required this.appBarTitle,
    required this.kicker,
    required this.title,
    required this.abstract,
    required this.blocks,
    required this.review,
    required this.contentsLabel,
    required this.contents,
    this.related = const [],
    this.previous,
    this.next,
    super.key,
  });

  final ProgressTarget target;
  final BookmarkTarget bookmarkTarget;
  final String id;
  final String revision;
  final String appBarTitle;
  final String kicker;
  final String title;
  final String abstract;
  final List<ContentBlock> blocks;
  final ReviewInfo review;
  final String contentsLabel;
  final List<ContentsEntry> contents;

  /// Shown after the text: events, places, companions, linked passages.
  final List<Widget> related;
  final PassageLink? previous;
  final PassageLink? next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final provisional = !review.isApproved;
    final citations = [for (final b in blocks) ...b.allCitations];
    final previous = this.previous;
    final next = this.next;

    return TrackedReaderScaffold(
      target: target,
      targetId: id,
      revision: revision,
      parentId: seerahParentId,
      title: appBarTitle,
      actions: [
        BookmarkButton(
          target: bookmarkTarget,
          targetId: id,
          parentId: seerahParentId,
        ),
        PassageContentsButton(
          label: contentsLabel,
          target: target,
          parentId: seerahParentId,
          currentId: id,
          entries: contents,
        ),
        const ReadingSettingsButton(),
      ],
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                kicker,
                style: SahabaTextStyles.of(
                  context,
                ).kicker.copyWith(color: colors.accentText),
              ),
            ),
            if (provisional) const DraftBadge(),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Semantics(
          header: true,
          child: Text(title, style: Theme.of(context).textTheme.displaySmall),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          abstract,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: colors.onSurfaceDim),
        ),
        const SizedBox(height: AppSpacing.xs),
        CoverageNote(review: review),
        const Divider(height: AppSpacing.xl),
        ReadingBody(
          blocks: blocks,
          provisional: provisional,
          textSize: ref.watch(readingTextSizeProvider),
          onCitations: (cites, reliability, {passage}) => showCitationSheet(
            context,
            citations: cites,
            reliability: reliability,
            provisional: provisional,
            share: passage == null
                ? null
                : PassageShare(text: passage, origin: '$appBarTitle — $title'),
          ),
        ),
        const PassageCompletion(),
        ...related,
        const SizedBox(height: AppSpacing.lg),
        PassageSources(
          citations: citations,
          onOpen: () => showCitationSheet(
            context,
            citations: citations,
            provisional: provisional,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        ReaderNavigation(
          previousLabel: previous?.label,
          previousTitle: previous?.title,
          onPrevious: previous?.open,
          nextLabel: next?.label ?? l10n.storyNextChapter,
          nextTitle: next?.title,
          onNext: next?.open,
        ),
      ],
    );
  }
}
