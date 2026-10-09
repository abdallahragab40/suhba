import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

part 'companion.freezed.dart';

enum Gender { male, female }

/// A reference to a person: a Companion in the catalog, or another person
/// (see `Person`). Promoting a person to a Companion later keeps the link.
@freezed
abstract class PersonRef with _$PersonRef {
  const factory PersonRef({
    required LocalizedText displayName,
    String? companionId,
    String? personId,
  }) = _PersonRef;
}

enum RelationType {
  father,
  mother,
  child,
  spouse,
  sibling,
  relative,
  teacher,
  student,
  brotherhood,
}

@freezed
abstract class Relation with _$Relation {
  const factory Relation({
    required RelationType type,
    required PersonRef person,
    @Default(<Citation>[]) List<Citation> citations,
  }) = _Relation;
}

/// Membership of a category, itself a sourced claim.
@freezed
abstract class Membership with _$Membership {
  const factory Membership({
    required String categoryId,
    required List<Citation> citations,
    LocalizedText? note,
  }) = _Membership;
}

enum SectionKind {
  earlyLife,
  conversion,
  withProphet,
  virtues,
  contributions,
  character,
  lessons,
  death,
  custom,
}

@freezed
abstract class BiographySection with _$BiographySection {
  const factory BiographySection({
    required String id,
    required SectionKind kind,
    required LocalizedText title,
    required List<ContentBlock> blocks,

    /// Fingerprint of the section's content; changes whenever it is edited.
    required String revision,
  }) = _BiographySection;
}

/// Broad periods used to group a timeline.
enum TimelineEra { preIslam, makkan, madinan, afterProphet }

@freezed
abstract class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent({
    required String id,
    required TimelineEra era,
    required HistoricalDate date,
    required LocalizedText title,
    required Reliability reliability,
    required List<Citation> citations,
    LocalizedText? summary,
    String? eventId,
    String? sectionId,
  }) = _TimelineEvent;
}

/// The light version of a companion used by the directory, home and
/// search.
@freezed
abstract class CompanionSummary with _$CompanionSummary {
  const factory CompanionSummary({
    required String id,
    required Gender gender,
    required LocalizedText name,
    required LocalizedText summary,
    required ReviewInfo review,

    /// Display order in lists (lower first); null sorts last.
    int? order,
    LocalizedText? kunya,
    @Default(<LocalizedText>[]) List<LocalizedText> titles,
    @Default(<String>[]) List<String> aliases,
    @Default(<String>[]) List<String> categoryIds,
    HistoricalDate? death,
  }) = _CompanionSummary;
}

@freezed
abstract class Companion with _$Companion {
  const factory Companion({
    required String id,
    required Gender gender,

    /// The usual short name, e.g. أبو بكر الصديق.
    required LocalizedText name,
    required LocalizedText fullName,
    required LocalizedText summary,
    required ReviewInfo review,

    /// Work-level bibliography for the whole biography (source IDs).
    required List<String> references,
    int? order,
    LocalizedText? lineage,
    LocalizedText? kunya,
    @Default(<LocalizedText>[]) List<LocalizedText> titles,
    @Default(<String>[]) List<String> aliases,
    DatedClaim? birth,
    DatedClaim? death,
    LocalizedText? deathPlace,
    @Default(<Fact>[]) List<Fact> atAGlance,
    @Default(<Membership>[]) List<Membership> memberships,
    @Default(<Relation>[]) List<Relation> relations,
    @Default(<BiographySection>[]) List<BiographySection> sections,
    @Default(<String>[]) List<String> storyIds,
    @Default(<TimelineEvent>[]) List<TimelineEvent> timeline,
  }) = _Companion;
}
