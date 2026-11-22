import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/shared/content/domain/seerah.dart';

/// The kinds of achievement after which the reader may be asked to rate the
/// app. Each kind asks at most once. Stored by name: never rename.
enum RatingMilestone {
  /// Five passages finished, of any kind.
  fiveReadings,

  /// Every chapter of one Seerah period finished.
  seerahPeriod,

  /// Every Seerah chapter finished.
  wholeSeerah,

  /// Every step of a journey finished, in its current attempt.
  journey,
}

/// How many finished passages count as [RatingMilestone.fiveReadings].
const ratingReadingsThreshold = 5;

/// One reached achievement: its kind and what it was, e.g. a period's id.
typedef Achievement = ({RatingMilestone kind, String id});

/// Every achievement the reader's progress shows. A period or journey is
/// its own achievement, so finishing a second period is news.
Set<Achievement> reachedAchievements({
  required List<ReadingProgress> completed,
  required SeerahIndex? seerah,
  required List<Journey> journeys,
  required List<JourneyEnrollment> enrollments,
  required List<JourneyStepProgress> steps,
}) {
  final reached = <Achievement>{};
  final finished = completed.where((p) => p.completed).toList();
  if (finished.length >= ratingReadingsThreshold) {
    reached.add((kind: RatingMilestone.fiveReadings, id: ''));
  }

  if (seerah != null) {
    final chapters = {
      for (final p in finished)
        if (p.target == ProgressTarget.seerahChapter) p.targetId,
    };
    final collection = seerah.collection;
    for (final period in collection.periods) {
      if (period.chapterIds.isNotEmpty &&
          chapters.containsAll(period.chapterIds)) {
        reached.add((kind: RatingMilestone.seerahPeriod, id: period.id));
      }
    }
    if (collection.chapterIds.isNotEmpty &&
        chapters.containsAll(collection.chapterIds)) {
      reached.add((kind: RatingMilestone.wholeSeerah, id: ''));
    }
  }

  for (final enrollment in enrollments) {
    final journey = journeys
        .where((j) => j.id == enrollment.journeyId)
        .firstOrNull;
    if (journey == null || journey.steps.isEmpty) continue;
    final done = {
      for (final s in steps)
        if (s.journeyId == journey.id &&
            s.startedAt == enrollment.startedAt &&
            s.finished)
          s.stepId,
    };
    if (journey.steps.every((s) => done.contains(s.id))) {
      reached.add((kind: RatingMilestone.journey, id: journey.id));
    }
  }
  return reached;
}

/// What the rating prompt remembers between launches.
class RatingState {
  const RatingState({
    required this.known,
    this.asked = const {},
    this.lastAskedAt,
  });

  /// Achievements already seen, as `kind:id`; null before the first look,
  /// when whatever the reader had already done is taken as known.
  final Set<String>? known;

  /// Kinds already asked about.
  final Set<RatingMilestone> asked;
  final DateTime? lastAskedAt;
}

/// The outcome of [decideRatingPrompt]: the state to keep, and whether to
/// ask now.
typedef RatingDecision = ({RatingState state, bool ask});

/// The least time between two requests, so two achievements in one sitting
/// ask once.
const ratingMinimumGap = Duration(days: 2);

String achievementKey(Achievement a) => '${a.kind.name}:${a.id}';

/// Asks after a new achievement of a kind not yet asked about, at most once
/// in [ratingMinimumGap]. Achievements present the first time the progress
/// is seen (an update to a reader with history) never ask: the request
/// belongs to the moment of finishing, not to the next launch.
RatingDecision decideRatingPrompt({
  required RatingState state,
  required Set<Achievement> reached,
  required DateTime now,
}) {
  final keys = {for (final a in reached) achievementKey(a)};
  final known = state.known;
  if (known == null) {
    return (
      state: RatingState(
        known: keys,
        asked: state.asked,
        lastAskedAt: state.lastAskedAt,
      ),
      ask: false,
    );
  }
  final fresh = {
    for (final a in reached)
      if (!known.contains(achievementKey(a))) a.kind,
  }.difference(state.asked);
  final rested =
      state.lastAskedAt == null ||
      now.difference(state.lastAskedAt!) >= ratingMinimumGap;
  final ask = fresh.isNotEmpty && rested;
  return (
    state: RatingState(
      known: {...known, ...keys},
      asked: ask ? {...state.asked, ...fresh} : state.asked,
      lastAskedAt: ask ? now : state.lastAskedAt,
    ),
    ask: ask,
  );
}
