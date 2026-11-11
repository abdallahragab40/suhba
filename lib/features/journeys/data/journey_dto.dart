import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/shared/content/data/dto/common_dto.dart';
import 'package:suhba/shared/content/data/mappers/content_mappers.dart';

part 'journey_dto.freezed.dart';
part 'journey_dto.g.dart';

@freezed
abstract class StepRefDto with _$StepRefDto {
  const factory StepRefDto({
    required StepRefType type,
    required String targetId,
    String? parentId,
  }) = _StepRefDto;
  factory StepRefDto.fromJson(Map<String, dynamic> json) =>
      _$StepRefDtoFromJson(json);
}

@freezed
abstract class JourneyStepDto with _$JourneyStepDto {
  const factory JourneyStepDto({
    required String id,
    required LocalizedTextDto title,
    required List<StepRefDto> readings,
    LocalizedTextDto? framing,
    LocalizedTextDto? reflection,
  }) = _JourneyStepDto;
  factory JourneyStepDto.fromJson(Map<String, dynamic> json) =>
      _$JourneyStepDtoFromJson(json);
}

@freezed
abstract class JourneyDto with _$JourneyDto {
  const factory JourneyDto({
    required int schemaVersion,
    required String id,
    required LocalizedTextDto title,
    required LocalizedTextDto description,
    required List<JourneyStepDto> steps,
    required ReviewDto review,
  }) = _JourneyDto;
  factory JourneyDto.fromJson(Map<String, dynamic> json) =>
      _$JourneyDtoFromJson(json);
}

extension JourneyDtoMapper on JourneyDto {
  Journey toDomain() => Journey(
    id: id,
    title: title.toDomain(),
    description: description.toDomain(),
    review: review.toDomain(),
    steps: [
      for (final s in steps)
        JourneyStep(
          id: s.id,
          title: s.title.toDomain(),
          framing: s.framing?.toDomain(),
          reflection: s.reflection?.toDomain(),
          readings: [
            for (final r in s.readings)
              StepRef(type: r.type, targetId: r.targetId, parentId: r.parentId),
          ],
        ),
    ],
  );
}
