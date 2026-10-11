import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

part 'atlas.freezed.dart';

enum PlaceKind {
  city,
  town,
  mountain,
  cave,
  valley,
  well,
  mosque,
  battlefield,
  region,
  other,
}

/// How well a place's location is known.
enum GeoPrecision {
  /// The site is known today.
  identified,

  /// The area is known, not the exact spot.
  approximate,

  /// Scholars differ on where it was.
  uncertain,
}

/// A point on a schematic map. Never shown as a precise reconstruction.
@freezed
abstract class GeoPoint with _$GeoPoint {
  const factory GeoPoint({
    required double lat,
    required double lon,
    required GeoPrecision precision,
  }) = _GeoPoint;
}

/// A place in the Seerah and the Companions' lives.
@freezed
abstract class HistoricalPlace with _$HistoricalPlace {
  const factory HistoricalPlace({
    required String id,
    required LocalizedText name,
    required PlaceKind kind,
    required GeoPoint location,
    required LocalizedText summary,
    required Reliability reliability,
    required List<Citation> citations,
    required ReviewInfo review,
    LocalizedText? modernName,

    /// A note on what stands there today, so present-day buildings are
    /// never taken for the historical setting.
    LocalizedText? contemporaryNote,
  }) = _HistoricalPlace;
}

/// The six kinds of infographic.
enum InfographicType {
  /// Life or era timeline: sequence and intervals.
  timeline,

  /// Places, and an optional journey between them.
  map,

  /// How referenced people relate.
  relationships,

  /// Context → sequence → outcome.
  sequence,

  /// How a life or the Seerah spans historical periods.
  periods,

  /// Why a place matters, with callouts.
  placePanel,
}

/// One leg of a journey on a [InfographicType.map].
@freezed
abstract class RouteLeg with _$RouteLeg {
  const factory RouteLeg({
    required String fromPlaceId,
    required String toPlaceId,

    /// The path between the two is not known; drawn dashed and labelled
    /// approximate.
    required bool approximate,
    required Reliability reliability,
    required List<Citation> citations,
    LocalizedText? note,
  }) = _RouteLeg;
}

/// A sourced relation between two people.
@freezed
abstract class RelationEdge with _$RelationEdge {
  const factory RelationEdge({
    required PersonRef from,
    required PersonRef to,
    required RelationType type,
    required Reliability reliability,
    required List<Citation> citations,
    LocalizedText? note,
  }) = _RelationEdge;
}

/// One step of a sequence explainer.
@freezed
abstract class SequenceStep with _$SequenceStep {
  const factory SequenceStep({
    required LocalizedText title,
    required LocalizedText text,
    required Reliability reliability,
    required List<Citation> citations,
    String? placeId,
    HistoricalDate? date,

    /// The sources do not settle where this step falls in the order.
    @Default(false) bool orderUncertain,
  }) = _SequenceStep;
}

/// One band of a periods chart.
@freezed
abstract class PeriodBand with _$PeriodBand {
  const factory PeriodBand({
    required LocalizedText label,
    required HistoricalDate date,
    required Reliability reliability,
    required List<Citation> citations,
    LocalizedText? note,
  }) = _PeriodBand;
}

/// One labelled callout of a place panel.
@freezed
abstract class PlaceCallout with _$PlaceCallout {
  const factory PlaceCallout({
    required LocalizedText label,
    required LocalizedText text,
    required Reliability reliability,
    required List<Citation> citations,
  }) = _PlaceCallout;
}

/// What an infographic shows, by type.
@freezed
sealed class InfographicData with _$InfographicData {
  /// A companion's timeline entries, or a list of shared events.
  const factory InfographicData.timeline({
    String? companionId,
    @Default(<String>[]) List<String> eventIds,
  }) = TimelineData;

  const factory InfographicData.map({
    required List<String> placeIds,
    @Default(<RouteLeg>[]) List<RouteLeg> route,
  }) = MapData;

  const factory InfographicData.relationships({
    required List<RelationEdge> edges,
  }) = RelationshipsData;

  const factory InfographicData.sequence({
    required List<SequenceStep> steps,
    @Default(<String>[]) List<String> eventIds,
  }) = SequenceData;

  const factory InfographicData.periods({required List<PeriodBand> bands}) =
      PeriodsData;

  const factory InfographicData.placePanel({
    required String placeId,
    required List<PlaceCallout> callouts,
  }) = PlacePanelData;
}

/// A visual that teaches: a title, a plain-language takeaway, the data,
/// uncertainty notes, and the review state. Every visual also has an
/// equivalent reading-order list.
@freezed
abstract class Infographic with _$Infographic {
  const factory Infographic({
    required String id,
    required InfographicType type,
    required LocalizedText title,
    required LocalizedText takeaway,
    required ReviewInfo review,
    required InfographicData data,
    @Default(<LocalizedText>[]) List<LocalizedText> notes,
  }) = _Infographic;
}
