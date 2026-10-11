import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/seerah.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/presentation/record_links.dart';
import 'package:suhba/shared/content/providers.dart';
import 'package:suhba/shared/visuals/presentation/infographic_view.dart';

/// Where a companion appears beyond their own biography: Seerah chapters
/// that name them, shared events they took part in, and visuals that show
/// them. Each list is derived from the records, never authored twice.
class ProfileConnections {
  const ProfileConnections({
    required this.chapters,
    required this.events,
    required this.visuals,
  });

  final List<SeerahChapter> chapters;
  final List<HistoricalEvent> events;
  final List<Infographic> visuals;

  bool get isEmpty => chapters.isEmpty && events.isEmpty && visuals.isEmpty;
}

/// The [ProfileConnections] of [companionId] in this build. Missing parts
/// (no Seerah in the build, a file that fails) simply contribute nothing.
final profileConnectionsProvider = Provider.autoDispose
    .family<ProfileConnections, String>((ref, companionId) {
      final chapters =
          ref.watch(allSeerahChaptersProvider).value ?? const <SeerahChapter>[];
      final events =
          ref.watch(eventsProvider).value ?? const <String, HistoricalEvent>{};
      final visuals =
          ref.watch(visualsProvider).value ?? const <String, Infographic>{};
      bool shows(Infographic v) => switch (v.data) {
        TimelineData(companionId: final shown?) => shown == companionId,
        RelationshipsData(:final edges) => edges.any(
          (e) =>
              e.from.companionId == companionId ||
              e.to.companionId == companionId,
        ),
        _ => false,
      };
      return ProfileConnections(
        chapters: [
          for (final c in chapters)
            if (c.companionIds.contains(companionId)) c,
        ],
        events: [
          for (final e in events.values)
            if (e.participants.any((p) => p.companionId == companionId)) e,
        ]..sort((a, b) => a.date.compareTo(b.date)),
        visuals: [
          for (final v in visuals.values)
            if (shows(v)) v,
        ],
      );
    });

/// The lists of a [ProfileConnections].
class ProfileConnectionsView extends StatelessWidget {
  const ProfileConnectionsView({required this.connections, super.key});

  final ProfileConnections connections;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final c = connections;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (c.chapters.isNotEmpty) ...[
          LinkGroupTitle(l10n.eventInSeerah),
          for (final ch in c.chapters)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.auto_stories_outlined),
              title: Text(ch.title.of(context)),
              subtitle: Text(
                l10n.seerahChapterLabel(
                  format.integer(ch.number),
                  format.historicalDate(ch.date),
                ),
              ),
              onTap: () => context.push(AppRoutes.seerahChapter(ch.id)),
            ),
        ],
        if (c.events.isNotEmpty) ...[
          LinkGroupTitle(l10n.profileEvents),
          for (final e in c.events) EventRow(event: e),
        ],
        if (c.visuals.isNotEmpty) ...[
          LinkGroupTitle(l10n.profileVisuals),
          for (final v in c.visuals)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(infographicTypeIcon(v.type)),
              title: Text(v.title.of(context)),
              subtitle: Text(infographicTypeLabel(l10n, v.type)),
              onTap: () => context.push(AppRoutes.visual(v.id)),
            ),
        ],
      ],
    );
  }
}
