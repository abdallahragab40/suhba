import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/seerah.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/presentation/record_links.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/relationship_diagram.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/schematic_map.dart';

/// The display name of an event type.
String eventTypeLabel(AppLocalizations l10n, EventType type) => switch (type) {
  EventType.hijrah => l10n.eventTypeHijrah,
  EventType.battle => l10n.eventTypeBattle,
  EventType.treaty => l10n.eventTypeTreaty,
  EventType.pledge => l10n.eventTypePledge,
  EventType.appointment => l10n.eventTypeAppointment,
  EventType.death => l10n.eventTypeDeath,
  EventType.revelation => l10n.eventTypeRevelation,
  EventType.migration => l10n.eventTypeMigration,
  EventType.community => l10n.eventTypeCommunity,
  EventType.other => l10n.eventTypeOther,
};

/// A shared historical event (S20): when and where, what led to it, what
/// happened and what came of it, who took part, and its sources. It links
/// to the Seerah chapters that tell it. Opened above the tabs, so back
/// returns to wherever it was opened from.
class EventPage extends ConsumerWidget {
  const EventPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final events = ref.watch(eventsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.eventPageTitle)),
      body: switch (events) {
        AsyncData(:final value) => switch (value[eventId]) {
          final e? => _Event(event: e),
          null => EmptyState(
            icon: Icons.event_busy_outlined,
            title: l10n.eventNotFound,
          ),
        },
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(eventsProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 8),
        ),
      },
    );
  }
}

class _Event extends ConsumerWidget {
  const _Event({required this.event});

  final HistoricalEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final reading = SahabaTextStyles.of(context).reading;
    final e = event;
    final provisional = !e.review.isApproved;
    final places = ref.watch(placesProvider).value ?? const {};
    final people = ref.watch(peopleProvider).value ?? const {};
    final chapters = [
      for (final c
          in ref.watch(allSeerahChaptersProvider).value ??
              const <SeerahChapter>[])
        if (c.eventIds.contains(e.id)) c,
    ];
    final eventPlaces = [for (final id in e.placeIds) ?places[id]];

    Widget part(String title, String text) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinkGroupTitle(title),
        Text(text, style: reading),
      ],
    );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        [
                          eventTypeLabel(l10n, e.type),
                          format.historicalDate(e.date),
                        ].join(' · '),
                        style: SahabaTextStyles.of(
                          context,
                        ).kicker.copyWith(color: colors.accentText),
                      ),
                    ),
                    if (provisional) const DraftBadge(),
                  ],
                ),
                Semantics(
                  header: true,
                  child: Text(
                    e.name.of(context),
                    style: textTheme.displaySmall,
                  ),
                ),
                if (e.place case final p?)
                  Text(
                    p.of(context),
                    style: textTheme.titleSmall?.copyWith(
                      color: colors.onSurfaceDim,
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                Text(e.summary.of(context), style: reading),
                Row(
                  children: [
                    if (e.reliability != Reliability.established)
                      Flexible(
                        child: ReliabilityBadge(
                          e.reliability,
                          provisional: provisional,
                        ),
                      ),
                    CitationMarker(
                      count: e.citations.length,
                      onPressed: () => showCitationSheet(
                        context,
                        citations: e.citations,
                        reliability: e.reliability,
                        provisional: provisional,
                      ),
                    ),
                  ],
                ),
                if (e.context case final c?)
                  part(l10n.eventContext, c.of(context)),
                if (e.outcome case final o?)
                  part(l10n.eventOutcome, o.of(context)),
                if (e.participants.isNotEmpty) ...[
                  LinkGroupTitle(l10n.eventParticipants),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: [
                      for (final p in e.participants)
                        if (p.companionId case final id?)
                          ActionChip(
                            avatar: const Icon(Icons.person_outline, size: 18),
                            label: Text(p.displayName.of(context)),
                            onPressed: () =>
                                context.push(AppRoutes.companion(id)),
                          )
                        else
                          Chip(label: Text(personName(context, p, people))),
                    ],
                  ),
                ],
                if (eventPlaces.isNotEmpty) ...[
                  LinkGroupTitle(l10n.relatedPlaces),
                  PlaceChips(ids: e.placeIds),
                  const SizedBox(height: AppSpacing.sm),
                  SchematicMap(
                    places: eventPlaces,
                    interactive: false,
                    height: 220,
                    onOpenPlace: (p) => context.push(AppRoutes.place(p.id)),
                  ),
                ],
                if (chapters.isNotEmpty) ...[
                  LinkGroupTitle(l10n.eventInSeerah),
                  for (final c in chapters)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.auto_stories_outlined),
                      title: Text(c.title.of(context)),
                      subtitle: Text(
                        l10n.seerahChapterLabel(
                          format.integer(c.number),
                          format.historicalDate(c.date),
                        ),
                      ),
                      onTap: () => context.push(AppRoutes.seerahChapter(c.id)),
                    ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
