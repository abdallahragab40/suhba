import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/content_block.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

part 'catalog.freezed.dart';

/// A grouping such as العشرة المبشرون بالجنة. Membership is recorded (and
/// cited) on each companion.
@freezed
abstract class CompanionCategory with _$CompanionCategory {
  const factory CompanionCategory({
    required String id,
    required LocalizedText name,
    required int order,
    required ReviewInfo review,
    LocalizedText? description,

    /// What defines the category, with its sources.
    ContentBlock? basis,

    /// Every companion in the content has been checked against the
    /// category: anyone not a member is certainly not one, except those in
    /// [contested].
    @Default(false) bool complete,

    /// Companions whose membership the sources dispute; never offered as
    /// a member or as a non-member.
    @Default(<String>[]) List<String> contested,
  }) = _CompanionCategory;
}

enum EventType {
  hijrah,
  battle,
  treaty,
  pledge,
  appointment,
  death,
  revelation,
  migration,
  community,
  other,
}

@freezed
abstract class HistoricalEvent with _$HistoricalEvent {
  const factory HistoricalEvent({
    required String id,
    required LocalizedText name,
    required EventType type,
    required HistoricalDate date,
    required LocalizedText summary,
    required Reliability reliability,
    required List<Citation> citations,
    required ReviewInfo review,
    LocalizedText? place,
    @Default(<PersonRef>[]) List<PersonRef> participants,

    /// Where it happened (`HistoricalPlace` ids).
    @Default(<String>[]) List<String> placeIds,

    /// What led to it, and what came of it.
    LocalizedText? context,
    LocalizedText? outcome,
  }) = _HistoricalEvent;
}

enum SourceType {
  quran,
  hadithCollection,
  biographical,
  history,
  sira,
  tafsir,
  other,
}

/// A referenced work.
@freezed
abstract class SourceReference with _$SourceReference {
  const factory SourceReference({
    required String id,
    required SourceType type,
    required LocalizedText title,
    required ReviewInfo review,
    LocalizedText? author,
    int? authorDeathAH,
    LocalizedText? edition,
    LocalizedText? publisher,
    LocalizedText? numberingScheme,
  }) = _SourceReference;
}

/// How a non-catalog person's name is honoured.
enum PersonHonorific {
  /// رضي الله عنه / عنها (a Companion not yet in the catalog).
  sahabi,

  /// ﷺ.
  prophet,

  /// عليه السلام.
  alayhiSalam,
  none,
}

/// Someone referenced but not (yet) in the catalog.
@freezed
abstract class Person with _$Person {
  const factory Person({
    required String id,
    required LocalizedText name,
    required PersonHonorific honorific,
    required ReviewInfo review,
    Gender? gender,
  }) = _Person;
}
