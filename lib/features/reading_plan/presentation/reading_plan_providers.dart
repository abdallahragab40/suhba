import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/time/local_day_provider.dart';
import 'package:suhba/features/reading_plan/data/drift_reading_plan_repository.dart';
import 'package:suhba/features/reading_plan/domain/reading_plan.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';

final readingPlanRepositoryProvider = Provider<DriftReadingPlanRepository>(
  (ref) => DriftReadingPlanRepository(
    ref.watch(appDatabaseProvider),
    clock: ref.watch(clockProvider),
  ),
);

/// The plan, or null when the reader has not chosen a pace.
final readingPlanProvider = StreamProvider<ReadingPlan?>(
  (ref) => ref.watch(readingPlanRepositoryProvider).watch(),
);

/// Finished Seerah chapters: all of them, and those finished on [today].
({int finished, int finishedToday}) seerahFinished(
  Iterable<ReadingProgress> progress,
  DateTime today,
) {
  var finished = 0;
  var finishedToday = 0;
  for (final p in progress) {
    if (p.target != ProgressTarget.seerahChapter || !p.completed) continue;
    finished++;
    final at = p.updatedAt.toLocal();
    if (at.year == today.year &&
        at.month == today.month &&
        at.day == today.day) {
      finishedToday++;
    }
  }
  return (finished: finished, finishedToday: finishedToday);
}

final readingPlanActionsProvider = Provider<ReadingPlanActions>(
  ReadingPlanActions.new,
);

class ReadingPlanActions {
  ReadingPlanActions(this._ref);
  final Ref _ref;

  DriftReadingPlanRepository get _plans =>
      _ref.read(readingPlanRepositoryProvider);

  /// Today, and the chapters finished before it: where a plan starts.
  Future<({DateTime today, int before})> _start() async {
    final today = _ref.read(localDayProvider);
    final all = await _ref.read(readingProgressRepositoryProvider).all();
    final c = seerahFinished(all, today);
    return (today: today, before: c.finished - c.finishedToday);
  }

  /// Chooses a pace, starting the plan afresh from today; null ends it.
  Future<void> setPace(int? pace) async {
    if (pace == null) return _plans.clear();
    final s = await _start();
    final current = await _plans.get();
    await _plans.save(
      ReadingPlan(
        pace: pace,
        startedOn: s.today,
        baseline: s.before,
        catchUp: current?.catchUp ?? false,
      ),
    );
  }

  /// After a missed day: carry on from here, with nothing owed.
  Future<void> continueFromHere() async {
    final plan = await _plans.get();
    if (plan == null) return;
    final s = await _start();
    await _plans.save(
      plan.copyWith(startedOn: s.today, baseline: s.before, catchUp: false),
    );
  }

  /// After a missed day: one extra chapter a day until caught up.
  Future<void> catchUpGradually() async {
    final plan = await _plans.get();
    if (plan == null) return;
    await _plans.save(plan.copyWith(catchUp: true));
  }
}
