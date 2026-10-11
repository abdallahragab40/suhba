import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:suhba/features/companions/presentation/profile/biography_entry.dart';
import 'package:suhba/features/companions/presentation/profile/profile_connections.dart';
import 'package:suhba/features/companions/presentation/profile/profile_facts.dart';
import 'package:suhba/features/companions/presentation/profile/profile_header.dart';
import 'package:suhba/features/companions/presentation/profile/profile_sections.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// A companion's profile (S04): header, key facts, the biography's
/// sections, a timeline preview, where they appear in the Seerah, events
/// and visuals, stories, related people and references.
class CompanionProfilePage extends ConsumerWidget {
  const CompanionProfilePage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final companion = ref.watch(companionProvider(id));

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (companion.hasValue)
            BookmarkButton(target: BookmarkTarget.companion, targetId: id),
        ],
      ),
      body: switch (companion) {
        AsyncData(:final value) => _Profile(companion: value),
        AsyncError(error: NotFoundFailure()) => EmptyState(
          icon: Icons.person_search_outlined,
          title: l10n.companionNotFound,
          action: FilledButton(
            onPressed: () => context.go(AppRoutes.companions),
            child: Text(l10n.backToDirectory),
          ),
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(companionProvider(id)),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 8),
        ),
      },
    );
  }
}

class _Profile extends ConsumerWidget {
  const _Profile({required this.companion});

  final Companion companion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final c = companion;
    final connections = ref.watch(profileConnectionsProvider(c.id));
    final provisional = !c.review.isApproved;

    // Number the page's sections in the order they appear (٠١، ٠٢ …).
    var index = 0;
    Widget header(String kicker, String title) => Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSpacing.xl,
        bottom: AppSpacing.sm,
      ),
      child: SectionHeader(index: ++index, kicker: kicker, title: title),
    );

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.readingMaxWidth),
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.gutter,
            0,
            AppSpacing.gutter,
            AppSpacing.xxl,
          ),
          children: [
            ProfileHeader(companion: c),
            const SizedBox(height: AppSpacing.lg),
            Text(
              c.summary.of(context),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            BiographyEntry(companion: c),
            header(l10n.profileAtAGlanceKicker, l10n.profileAtAGlance),
            ProfileFacts(companion: c, provisional: provisional),
            if (c.sections.isNotEmpty) ...[
              header(l10n.profileSectionsKicker, l10n.profileSectionsTitle),
              SectionIndex(companionId: c.id, sections: c.sections),
            ],
            if (c.timeline.isNotEmpty) ...[
              header(
                l10n.profileTimelineKicker,
                c.gender == Gender.female
                    ? l10n.profileTimelineTitleFemale
                    : l10n.profileTimelineTitle,
              ),
              TimelinePreview(
                companionId: c.id,
                entries: c.timeline,
                provisional: provisional,
              ),
            ],
            if (!connections.isEmpty) ...[
              header(
                l10n.profileConnectionsKicker,
                l10n.profileConnectionsTitle,
              ),
              ProfileConnectionsView(connections: connections),
            ],
            if (c.storyIds.isNotEmpty) ...[
              header(l10n.profileStoriesKicker, l10n.profileStoriesTitle),
              StoryList(storyIds: c.storyIds),
            ],
            if (c.relations.isNotEmpty) ...[
              header(l10n.profileRelatedKicker, l10n.profileRelatedTitle),
              RelatedPeople(relations: c.relations),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  icon: const Icon(Icons.account_tree_outlined),
                  label: Text(l10n.profileAllRelations),
                  onPressed: () =>
                      context.push(AppRoutes.relations(companionId: c.id)),
                ),
              ),
            ],
            header(l10n.profileReferencesKicker, l10n.profileReferencesTitle),
            ReferenceList(sourceIds: c.references),
          ],
        ),
      ),
    );
  }
}
