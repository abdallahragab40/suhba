import 'package:siyar_sahaba/shared/content/data/dto/atlas_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/seerah_dto.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/content_mappers.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/revision.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/seerah.dart';

// DTO → domain for the Seerah, places and visuals.

extension SeerahDtoMapper on SeerahDto {
  SeerahCollection toDomain() => SeerahCollection(
    title: title.toDomain(),
    subtitle: subtitle.toDomain(),
    introduction: [for (final b in introduction) b.toDomain()],
    periods: [
      for (final e in eras)
        SeerahPeriod(
          id: e.id,
          name: e.name.toDomain(),
          date: e.date.toDomain(),
          summary: e.summary.toDomain(),
          reliability: e.reliability,
          citations: citationsToDomain(e.citations),
          chapterIds: e.chapterIds,
        ),
    ],
    chapterIds: chapterIds,
    topicIds: topicIds,
    methodology: methodology.toDomain(),
    references: references,
    review: review.toDomain(),
    featuredEventIds: featuredEventIds,
    featuredPlaceIds: featuredPlaceIds,
    companionIds: companionIds,
    visualIds: visualIds,
  );
}

extension SeerahChapterDtoMapper on SeerahChapterDto {
  /// The chapter as chapter [number] of the reading order.
  SeerahChapter toDomain({required int number}) => SeerahChapter(
    id: id,
    number: number,
    title: title.toDomain(),
    abstract: abstract.toDomain(),
    era: era,
    date: date.toDomain(),
    references: references,
    blocks: [for (final b in blocks) b.toDomain()],
    review: review.toDomain(),
    revision: contentRevision(toJson()),
    eventIds: eventIds,
    placeIds: placeIds,
    companionIds: companionIds,
    visualIds: visualIds,
  );

  /// The index entry built from this chapter (used by the content build).
  SeerahChapterSummaryDto toSummary() => SeerahChapterSummaryDto(
    id: id,
    title: title,
    abstract: abstract,
    era: era,
    date: date,
    review: review,
    wordCount: proseWordCount([for (final b in blocks) b.toDomain()]),
    visualIds: visualIds,
  );
}

extension SeerahTopicDtoMapper on SeerahTopicDto {
  SeerahTopic toDomain({required int number}) => SeerahTopic(
    id: id,
    number: number,
    title: title.toDomain(),
    abstract: abstract.toDomain(),
    references: references,
    blocks: [for (final b in blocks) b.toDomain()],
    review: review.toDomain(),
    revision: contentRevision(toJson()),
    chapterIds: chapterIds,
    companionIds: companionIds,
  );

  SeerahTopicSummaryDto toSummary() => SeerahTopicSummaryDto(
    id: id,
    title: title,
    abstract: abstract,
    review: review,
    wordCount: proseWordCount([for (final b in blocks) b.toDomain()]),
  );
}

extension SeerahIndexDtoMapper on SeerahIndexDto {
  SeerahIndex toDomain() => SeerahIndex(
    collection: seerah.toDomain(),
    chapters: [
      for (final (i, c) in chapters.indexed)
        SeerahChapterSummary(
          id: c.id,
          number: i + 1,
          title: c.title.toDomain(),
          abstract: c.abstract.toDomain(),
          era: c.era,
          date: c.date.toDomain(),
          review: c.review.toDomain(),
          wordCount: c.wordCount,
          visualIds: c.visualIds,
        ),
    ],
    topics: [
      for (final (i, t) in topics.indexed)
        SeerahTopicSummary(
          id: t.id,
          number: i + 1,
          title: t.title.toDomain(),
          abstract: t.abstract.toDomain(),
          review: t.review.toDomain(),
          wordCount: t.wordCount,
        ),
    ],
  );
}

extension PlaceDtoMapper on PlaceDto {
  HistoricalPlace toDomain() => HistoricalPlace(
    id: id,
    name: name.toDomain(),
    kind: kind,
    location: GeoPoint(
      lat: location.lat,
      lon: location.lon,
      precision: location.precision,
    ),
    summary: summary.toDomain(),
    reliability: reliability,
    citations: citationsToDomain(citations),
    review: review.toDomain(),
    modernName: modernName?.toDomain(),
    contemporaryNote: contemporaryNote?.toDomain(),
  );
}

extension VisualDtoMapper on VisualDto {
  Infographic toDomain() => Infographic(
    id: id,
    type: type,
    title: title.toDomain(),
    takeaway: takeaway.toDomain(),
    review: review.toDomain(),
    notes: [for (final n in notes) n.toDomain()],
    data: switch (type) {
      InfographicType.timeline => InfographicData.timeline(
        companionId: companionId,
        eventIds: eventIds,
      ),
      InfographicType.map => InfographicData.map(
        placeIds: placeIds,
        route: [
          for (final leg in route)
            RouteLeg(
              fromPlaceId: leg.from,
              toPlaceId: leg.to,
              approximate: leg.approximate,
              reliability: leg.reliability,
              citations: citationsToDomain(leg.citations),
              note: leg.note?.toDomain(),
            ),
        ],
      ),
      InfographicType.relationships => InfographicData.relationships(
        edges: [
          for (final e in edges)
            RelationEdge(
              from: e.from.toDomain(),
              to: e.to.toDomain(),
              type: e.type,
              reliability: e.reliability,
              citations: citationsToDomain(e.citations),
              note: e.note?.toDomain(),
            ),
        ],
      ),
      InfographicType.sequence => InfographicData.sequence(
        eventIds: eventIds,
        steps: [
          for (final s in steps)
            SequenceStep(
              title: s.title.toDomain(),
              text: s.text.toDomain(),
              reliability: s.reliability,
              citations: citationsToDomain(s.citations),
              placeId: s.placeId,
              date: s.date?.toDomain(),
              orderUncertain: s.orderUncertain,
            ),
        ],
      ),
      InfographicType.periods => InfographicData.periods(
        bands: [
          for (final b in bands)
            PeriodBand(
              label: b.label.toDomain(),
              date: b.date.toDomain(),
              reliability: b.reliability,
              citations: citationsToDomain(b.citations),
              note: b.note?.toDomain(),
            ),
        ],
      ),
      InfographicType.placePanel => InfographicData.placePanel(
        placeId: placeId!,
        callouts: [
          for (final c in callouts)
            PlaceCallout(
              label: c.label.toDomain(),
              text: c.text.toDomain(),
              reliability: c.reliability,
              citations: citationsToDomain(c.citations),
            ),
        ],
      ),
    },
  );
}
