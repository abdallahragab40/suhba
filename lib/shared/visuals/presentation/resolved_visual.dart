import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// One mark on a timeline, resolved to the record it stands for: a shared
/// event or a companion's timeline entry. Its label, date and sources all
/// come from that record.
class TimelineMark {
  const TimelineMark({
    required this.title,
    required this.date,
    required this.reliability,
    required this.citations,
    this.eventId,
    this.sectionId,
  });

  final LocalizedText title;
  final HistoricalDate date;
  final Reliability reliability;
  final List<Citation> citations;

  /// The shared event it is (or belongs to), if any.
  final String? eventId;

  /// A companion's biography section that tells it, if any.
  final String? sectionId;
}

/// A visual with the records its marks resolve to.
class ResolvedVisual {
  const ResolvedVisual({
    required this.visual,
    required this.places,
    required this.events,
    required this.people,
    this.companion,
  });

  final Infographic visual;
  final Map<String, HistoricalPlace> places;
  final Map<String, HistoricalEvent> events;
  final Map<String, Person> people;

  /// The companion whose timeline a timeline visual shows.
  final Companion? companion;

  /// Timeline marks in order. Records missing from this build are left
  /// out (the content gate keeps published builds complete).
  List<TimelineMark> get timelineMarks {
    final data = visual.data;
    if (data is! TimelineData) return const [];
    final marks = [
      if (companion case final c?)
        for (final t in c.timeline)
          TimelineMark(
            title: t.title,
            date: t.date,
            reliability: t.reliability,
            citations: t.citations,
            eventId: t.eventId,
            sectionId: t.sectionId,
          )
      else
        for (final id in data.eventIds)
          if (events[id] case final e?)
            TimelineMark(
              title: e.name,
              date: e.date,
              reliability: e.reliability,
              citations: e.citations,
              eventId: e.id,
            ),
    ];
    // Stable: equal dates keep their authored order.
    final indexed = marks.indexed.toList()
      ..sort((a, b) {
        final byDate = a.$2.date.compareTo(b.$2.date);
        return byDate != 0 ? byDate : a.$1.compareTo(b.$1);
      });
    return [for (final (_, m) in indexed) m];
  }

  /// Every citation the visual's marks carry, for its sources sheet.
  List<Citation> get allCitations => switch (visual.data) {
    TimelineData() => [for (final m in timelineMarks) ...m.citations],
    MapData(:final placeIds, :final route) => [
      for (final id in placeIds) ...?places[id]?.citations,
      for (final leg in route) ...leg.citations,
    ],
    RelationshipsData(:final edges) => [for (final e in edges) ...e.citations],
    SequenceData(:final steps) => [for (final s in steps) ...s.citations],
    PeriodsData(:final bands) => [for (final b in bands) ...b.citations],
    PlacePanelData(:final placeId, :final callouts) => [
      ...?places[placeId]?.citations,
      for (final c in callouts) ...c.citations,
    ],
  };
}

/// A visual and its records; throws `NotFoundFailure` for an unknown id.
/// Kept for the session (visuals are few and small), so a visual scrolled
/// back into view never reloads and shifts the page.
final resolvedVisualProvider = FutureProvider.family<ResolvedVisual, String>((
  ref,
  id,
) async {
  final visuals = await ref.watch(visualsProvider.future);
  final visual = visuals[id];
  if (visual == null) throw NotFoundFailure('No visual "$id"');
  final places = await ref.watch(placesProvider.future);
  final events = await ref.watch(eventsProvider.future);
  final people = await ref.watch(peopleProvider.future);
  final companionId = switch (visual.data) {
    TimelineData(:final companionId) => companionId,
    _ => null,
  };
  final companion = companionId == null
      ? null
      : await ref.watch(companionProvider(companionId).future);
  return ResolvedVisual(
    visual: visual,
    places: places,
    events: events,
    people: people,
    companion: companion,
  );
});
