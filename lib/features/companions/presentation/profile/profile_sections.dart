import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/reading_progress/domain/reading_progress.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/passage_contents.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// Numbered list of the biography's sections, each opening the reader.
class SectionIndex extends ConsumerWidget {
  const SectionIndex({
    required this.companionId,
    required this.sections,
    super.key,
  });

  final String companionId;
  final List<BiographySection> sections;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final progress =
        ref
            .watch(workProgressProvider((ProgressTarget.section, companionId)))
            .value ??
        const {};
    return Column(
      children: [
        for (var i = 0; i < sections.length; i++)
          InkWell(
            onTap: () =>
                context.push(AppRoutes.section(companionId, sections[i].id)),
            child: Container(
              constraints: const BoxConstraints(minHeight: 48),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(color: colors.line),
                ),
              ),
              child: Row(
                children: [
                  ExcludeSemantics(
                    child: Text(
                      format.padded(i + 1),
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.accentText,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      sections[i].title.of(context),
                      style: textTheme.titleMedium,
                    ),
                  ),
                  PassageProgressMarker(progress: progress[sections[i].id]),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// The first few timeline entries in date order.
class TimelinePreview extends StatelessWidget {
  const TimelinePreview({
    required this.companionId,
    required this.entries,
    required this.provisional,
    this.limit = 4,
    super.key,
  });

  final String companionId;
  final List<TimelineEvent> entries;
  final bool provisional;
  final int limit;

  @override
  Widget build(BuildContext context) {
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final sorted = [...entries]..sort((a, b) => a.date.compareTo(b.date));
    return Column(
      children: [
        for (final t in sorted.take(limit))
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              border: BorderDirectional(bottom: BorderSide(color: colors.line)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        format.historicalDate(t.date, withGregorian: false),
                        style: SahabaTextStyles.of(
                          context,
                        ).kicker.copyWith(color: colors.accentText),
                      ),
                      Text(t.title.of(context), style: textTheme.titleSmall),
                      const SizedBox(height: AppSpacing.xxs),
                      ReliabilityBadge(t.reliability, provisional: provisional),
                    ],
                  ),
                ),
                if (t.citations.isNotEmpty)
                  CitationMarker(
                    count: t.citations.length,
                    onPressed: () => showCitationSheet(
                      context,
                      citations: t.citations,
                      reliability: t.reliability,
                      provisional: provisional,
                    ),
                  ),
              ],
            ),
          ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            icon: const Icon(Icons.timeline),
            label: Text(AppLocalizations.of(context).profileFullTimeline),
            onPressed: () => context.push(AppRoutes.timeline(companionId)),
          ),
        ),
      ],
    );
  }
}

/// The companion's stories, each opening its overview.
class StoryList extends ConsumerWidget {
  const StoryList({required this.storyIds, super.key});

  final List<String> storyIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final stories = ref.watch(storyIndexProvider).value ?? const [];
    final mine = [
      for (final id in storyIds) ...stories.where((s) => s.id == id),
    ];
    return Column(
      children: [
        for (final s in mine)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => context.push(AppRoutes.story(s.id)),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!s.review.isApproved) ...[
                        const DraftBadge(),
                        const SizedBox(height: AppSpacing.xs),
                      ],
                      Text(s.title.of(context), style: textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        s.synopsis.of(context),
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceDim,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        l10n.storyReadingMinutes(
                          s.readingMinutes,
                          format.integer(s.readingMinutes),
                        ),
                        style: SahabaTextStyles.of(context).kicker,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Relatives and other connections; companions in the catalog open their
/// own profile.
class RelatedPeople extends ConsumerWidget {
  const RelatedPeople({required this.relations, super.key});

  final List<Relation> relations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final people = ref.watch(peopleProvider).value ?? const {};
    final companions = ref.watch(companionIndexProvider).value ?? const [];

    String label(RelationType t) => switch (t) {
      RelationType.father => l10n.relationFather,
      RelationType.mother => l10n.relationMother,
      RelationType.child => l10n.relationChild,
      RelationType.spouse => l10n.relationSpouse,
      RelationType.sibling => l10n.relationSibling,
      RelationType.relative => l10n.relationRelative,
      RelationType.teacher => l10n.relationTeacher,
      RelationType.student => l10n.relationStudent,
      RelationType.brotherhood => l10n.relationBrotherhood,
      RelationType.companion => l10n.relationCompanion,
    };

    return Column(
      children: [
        for (final r in relations)
          Builder(
            builder: (context) {
              final companionId = r.person.companionId;
              final companion = companions
                  .where((c) => c.id == companionId)
                  .firstOrNull;
              final person = people[r.person.personId];
              final honorific = companion != null
                  ? companionHonorific(companion.gender)
                  : person == null
                  ? null
                  : personHonorific(person);
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  [r.person.displayName.of(context), ?honorific].join(' '),
                ),
                subtitle: Text(label(r.type)),
                trailing: companion == null
                    ? null
                    : const Icon(Icons.chevron_right),
                onTap: companion == null
                    ? null
                    : () => context.push(AppRoutes.companion(companion.id)),
              );
            },
          ),
      ],
    );
  }
}

/// The works the biography relies on.
class ReferenceList extends ConsumerWidget {
  const ReferenceList({required this.sourceIds, super.key});

  final List<String> sourceIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final sources = ref.watch(sourcesProvider).value ?? const {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final id in sourceIds)
          if (sources[id] case final s?)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.title.of(context), style: textTheme.titleSmall),
                  if (s.author case final a?)
                    Text(
                      s.authorDeathAH == null
                          ? a.of(context)
                          : l10n.citationAuthorDeath(
                              a.of(context),
                              format.integer(s.authorDeathAH!),
                            ),
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceDim,
                      ),
                    ),
                ],
              ),
            ),
      ],
    );
  }
}
