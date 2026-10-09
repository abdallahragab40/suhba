import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/core/result/failure.dart';
import 'package:siyar_sahaba/features/bookmarks/domain/bookmark.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/passage_contents.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/features/settings/presentation/reading_settings.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/presentation/reader_navigation.dart';
import 'package:siyar_sahaba/shared/content/presentation/reading_body.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// One section of a biography (S05), with its sources and the previous and
/// next sections.
class SectionReaderPage extends ConsumerWidget {
  const SectionReaderPage({
    required this.companionId,
    required this.sectionId,
    super.key,
  });

  final String companionId;
  final String sectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final companion = ref.watch(companionProvider(companionId));

    Widget message(Widget body) => Scaffold(appBar: AppBar(), body: body);

    return switch (companion) {
      AsyncData(:final value) => switch (value.sections.indexWhere(
        (s) => s.id == sectionId,
      )) {
        -1 => message(
          EmptyState(
            icon: Icons.menu_book_outlined,
            title: l10n.sectionNotFound,
          ),
        ),
        final index => _SectionReader(companion: value, index: index),
      },
      AsyncError(error: NotFoundFailure()) => message(
        EmptyState(
          icon: Icons.person_search_outlined,
          title: l10n.companionNotFound,
        ),
      ),
      AsyncError(:final error) => message(
        ErrorView(
          error: error,
          onRetry: () => ref.invalidate(companionProvider(companionId)),
        ),
      ),
      _ => message(
        const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 10),
        ),
      ),
    };
  }
}

class _SectionReader extends ConsumerWidget {
  const _SectionReader({required this.companion, required this.index});

  final Companion companion;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final c = companion;
    final section = c.sections[index];
    final provisional = !c.review.isApproved;
    final previous = index > 0 ? c.sections[index - 1] : null;
    final next = index < c.sections.length - 1 ? c.sections[index + 1] : null;
    final citations = [for (final b in section.blocks) ...b.allCitations];

    void open(BiographySection s) =>
        context.replace(AppRoutes.section(c.id, s.id));

    return TrackedReaderScaffold(
      target: ProgressTarget.section,
      targetId: section.id,
      revision: section.revision,
      parentId: c.id,
      title: c.name.of(context),
      actions: [
        BookmarkButton(
          target: BookmarkTarget.section,
          targetId: section.id,
          parentId: c.id,
        ),
        PassageContentsButton(
          label: l10n.readerSectionContents,
          target: ProgressTarget.section,
          parentId: c.id,
          currentId: section.id,
          entries: [
            for (final s in c.sections)
              (
                id: s.id,
                title: s.title.of(context),
                route: AppRoutes.section(c.id, s.id),
              ),
          ],
        ),
        const ReadingSettingsButton(),
      ],
      children: [
        if (provisional) ...[
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: DraftBadge(),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        // Decorative ordinal, as in section headers: the title carries the
        // meaning for screen readers.
        ExcludeSemantics(
          child: Text(
            format.padded(index + 1),
            style: SahabaTextStyles.of(context).kicker,
          ),
        ),
        Semantics(
          header: true,
          child: Text(
            section.title.of(context),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ReadingBody(
          blocks: section.blocks,
          provisional: provisional,
          textSize: ref.watch(readingTextSizeProvider),
          onCitations: (cites, reliability) => showCitationSheet(
            context,
            citations: cites,
            reliability: reliability,
            provisional: provisional,
          ),
        ),
        const PassageCompletion(),
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
          previousLabel: l10n.readerPreviousSection,
          previousTitle: previous?.title.of(context),
          onPrevious: previous == null ? null : () => open(previous),
          nextLabel: l10n.readerNextSection,
          nextTitle: next?.title.of(context),
          onNext: next == null ? null : () => open(next),
        ),
      ],
    );
  }
}
