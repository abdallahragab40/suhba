import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/quran_ref.dart';
import 'package:siyar_sahaba/shared/content/data/dto/block_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/companion_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/story_dto.dart';
import 'package:siyar_sahaba/shared/content/data/mappers/revision.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/content_manifest.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';

// DTO → domain. One extension per DTO; nested values map recursively.

List<Citation> _citations(List<CitationDto> list) => [
  for (final c in list) c.toDomain(),
];

extension LocalizedTextDtoMapper on LocalizedTextDto {
  LocalizedText toDomain() => LocalizedText(ar: ar, en: en);
}

extension HistoricalDateDtoMapper on HistoricalDateDto {
  HistoricalDate toDomain() => HistoricalDate(
    precision: precision,
    era: era,
    hijriYear: hijriYear,
    hijriMonth: hijriMonth,
    hijriDay: hijriDay,
    gregorianYear: gregorianYear,
    endEra: endEra,
    hijriYearEnd: hijriYearEnd,
    gregorianYearEnd: gregorianYearEnd,
  );
}

extension QuranRefDtoMapper on QuranRefDto {
  QuranRef toDomain() =>
      QuranRef(surah: surah, ayahFrom: ayahFrom, ayahTo: ayahTo);
}

extension CitationDtoMapper on CitationDto {
  Citation toDomain() => Citation(
    sourceId: sourceId,
    locatorStatus: locatorStatus,
    volume: volume,
    page: page,
    hadithNumber: hadithNumber,
    chapterTitle: chapterTitle?.toDomain(),
    quranRef: quranRef?.toDomain(),
    grading: grading == null
        ? null
        : Grading(
            grade: grading!.grade,
            gradedBy: grading!.gradedBy.toDomain(),
          ),
    note: note?.toDomain(),
  );
}

extension DatedClaimDtoMapper on DatedClaimDto {
  DatedClaim toDomain() => DatedClaim(
    date: date.toDomain(),
    reliability: reliability,
    citations: _citations(citations),
    note: note?.toDomain(),
  );
}

extension FactDtoMapper on FactDto {
  Fact toDomain() => Fact(
    label: label.toDomain(),
    reliability: reliability,
    text: text?.toDomain(),
    date: date?.toDomain(),
    citations: _citations(citations),
  );
}

extension ReviewDtoMapper on ReviewDto {
  ReviewInfo toDomain() =>
      ReviewInfo(status: status, editorialFlags: editorialFlags.toSet());
}

extension PersonRefDtoMapper on PersonRefDto {
  PersonRef toDomain() => PersonRef(
    displayName: displayName.toDomain(),
    companionId: companionId,
    personId: personId,
  );
}

extension ContentBlockDtoMapper on ContentBlockDto {
  ContentBlock toDomain() => switch (this) {
    ParagraphBlockDto(:final text, :final reliability, :final citations) =>
      ContentBlock.paragraph(
        text: text.toDomain(),
        reliability: reliability,
        citations: _citations(citations),
      ),
    LessonBlockDto(:final text) => ContentBlock.lesson(text: text.toDomain()),
    QuranQuoteBlockDto(:final ref, :final note) => ContentBlock.quranQuote(
      ref: ref.toDomain(),
      note: note?.toDomain(),
    ),
    HadithQuoteBlockDto(
      :final textStatus,
      :final reliability,
      :final citations,
      :final text,
      :final summary,
    ) =>
      ContentBlock.hadithQuote(
        textStatus: textStatus,
        reliability: reliability,
        citations: _citations(citations),
        text: text?.toDomain(),
        summary: summary?.toDomain(),
      ),
    ReportQuoteBlockDto(
      :final textStatus,
      :final reliability,
      :final citations,
      :final text,
      :final summary,
    ) =>
      ContentBlock.reportQuote(
        textStatus: textStatus,
        reliability: reliability,
        citations: _citations(citations),
        text: text?.toDomain(),
        summary: summary?.toDomain(),
      ),
    DisputeNoteBlockDto(:final text, :final opinions) =>
      ContentBlock.disputeNote(
        text: text.toDomain(),
        opinions: [
          for (final o in opinions)
            Opinion(
              text: o.text.toDomain(),
              citations: _citations(o.citations),
            ),
        ],
      ),
  };
}

extension BiographySectionDtoMapper on BiographySectionDto {
  BiographySection toDomain() => BiographySection(
    id: id,
    kind: kind,
    title: title.toDomain(),
    blocks: [for (final b in blocks) b.toDomain()],
    revision: contentRevision(toJson()),
  );
}

extension TimelineEventDtoMapper on TimelineEventDto {
  TimelineEvent toDomain() => TimelineEvent(
    id: id,
    era: era,
    date: date.toDomain(),
    title: title.toDomain(),
    reliability: reliability,
    citations: _citations(citations),
    summary: summary?.toDomain(),
    eventId: eventId,
    sectionId: sectionId,
  );
}

extension CompanionDtoMapper on CompanionDto {
  Companion toDomain() => Companion(
    id: id,
    gender: gender,
    name: name.toDomain(),
    fullName: fullName.toDomain(),
    summary: summary.toDomain(),
    review: review.toDomain(),
    references: references,
    order: order,
    lineage: lineage?.toDomain(),
    kunya: kunya?.toDomain(),
    titles: [for (final t in titles) t.toDomain()],
    aliases: aliases,
    birth: birth?.toDomain(),
    death: death?.toDomain(),
    deathPlace: deathPlace?.toDomain(),
    atAGlance: [for (final f in atAGlance) f.toDomain()],
    memberships: [
      for (final m in memberships)
        Membership(
          categoryId: m.categoryId,
          citations: _citations(m.citations),
          note: m.note?.toDomain(),
        ),
    ],
    relations: [
      for (final r in relations)
        Relation(
          type: r.type,
          person: r.person.toDomain(),
          citations: _citations(r.citations),
        ),
    ],
    sections: [for (final s in sections) s.toDomain()],
    storyIds: storyIds,
    timeline: [for (final t in timeline) t.toDomain()],
  );

  /// The index entry built from this companion (used by the content build).
  CompanionSummaryDto toSummary() => CompanionSummaryDto(
    id: id,
    gender: gender,
    name: name,
    summary: summary,
    review: review,
    order: order,
    kunya: kunya,
    titles: titles,
    aliases: aliases,
    categoryIds: [for (final m in memberships) m.categoryId],
    death: death?.date,
  );
}

extension CompanionSummaryDtoMapper on CompanionSummaryDto {
  CompanionSummary toDomain() => CompanionSummary(
    id: id,
    gender: gender,
    name: name.toDomain(),
    summary: summary.toDomain(),
    review: review.toDomain(),
    order: order,
    kunya: kunya?.toDomain(),
    titles: [for (final t in titles) t.toDomain()],
    aliases: aliases,
    categoryIds: categoryIds,
    death: death?.toDomain(),
  );
}

extension StoryDtoMapper on StoryDto {
  Story toDomain() => Story(
    id: id,
    title: title.toDomain(),
    synopsis: synopsis.toDomain(),
    companionIds: companionIds,
    readingMinutes: readingMinutes,
    chapters: [
      for (final c in chapters)
        StoryChapter(
          id: c.id,
          title: c.title.toDomain(),
          blocks: [for (final b in c.blocks) b.toDomain()],
          revision: contentRevision(c.toJson()),
        ),
    ],
    review: review.toDomain(),
    eventIds: eventIds,
  );

  StorySummaryDto toSummary() => StorySummaryDto(
    id: id,
    title: title,
    synopsis: synopsis,
    companionIds: companionIds,
    readingMinutes: readingMinutes,
    review: review,
  );
}

extension StorySummaryDtoMapper on StorySummaryDto {
  StorySummary toDomain() => StorySummary(
    id: id,
    title: title.toDomain(),
    synopsis: synopsis.toDomain(),
    companionIds: companionIds,
    readingMinutes: readingMinutes,
    review: review.toDomain(),
  );
}

extension CategoryDtoMapper on CategoryDto {
  CompanionCategory toDomain() => CompanionCategory(
    id: id,
    name: name.toDomain(),
    order: order,
    review: review.toDomain(),
    description: description?.toDomain(),
    basis: basis?.toDomain(),
  );
}

extension HistoricalEventDtoMapper on HistoricalEventDto {
  HistoricalEvent toDomain() => HistoricalEvent(
    id: id,
    name: name.toDomain(),
    type: type,
    date: date.toDomain(),
    summary: summary.toDomain(),
    reliability: reliability,
    citations: _citations(citations),
    review: review.toDomain(),
    place: place?.toDomain(),
    participants: [for (final p in participants) p.toDomain()],
  );
}

extension SourceReferenceDtoMapper on SourceReferenceDto {
  SourceReference toDomain() => SourceReference(
    id: id,
    type: type,
    title: title.toDomain(),
    review: review.toDomain(),
    author: author?.toDomain(),
    authorDeathAH: authorDeathAH,
    edition: edition?.toDomain(),
    publisher: publisher?.toDomain(),
    numberingScheme: numberingScheme?.toDomain(),
  );
}

extension PersonDtoMapper on PersonDto {
  Person toDomain() => Person(
    id: id,
    name: name.toDomain(),
    honorific: honorific,
    review: review.toDomain(),
    gender: gender,
  );
}

extension ManifestDtoMapper on ManifestDto {
  ContentManifest toDomain() => ContentManifest(
    contentVersion: contentVersion,
    schemaVersion: schemaVersion,
    channel: channel,
    companionCount: companionCount,
    storyCount: storyCount,
    approvedCount: approvedCount,
    unapprovedCount: unapprovedCount,
  );
}
