import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/undo_snack_bar.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/time/local_day_provider.dart';
import 'package:suhba/features/home/domain/next_step.dart';
import 'package:suhba/features/home/presentation/next_step_card.dart';
import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/reading_plan/domain/reading_plan.dart';
import 'package:suhba/features/reading_plan/presentation/reading_plan_providers.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_label.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/seerah/presentation/seerah_hub_page.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/seerah.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// Today's one item to read (review K1, «ورد اليوم»): the next step of
/// the journey in progress, else the next Seerah chapter. The same item
/// is named on Home and in the evening reminder.
sealed class DailyPortion {
  const DailyPortion();

  LocalizedText get title;
  int get minutes;
  String get route;
}

/// A journey step. It is finished in the journey, after its questions,
/// so the card opens it rather than marking it read.
class JourneyPortion extends DailyPortion {
  const JourneyPortion(this.journey, this.step, this.minutes);
  final Journey journey;
  final JourneyStep step;
  @override
  final int minutes;
  @override
  LocalizedText get title => step.title;
  @override
  String get route => AppRoutes.journeyStep(journey.id, step.id);
}

/// A Seerah chapter, which can be marked read with one tap.
class SeerahPortion extends DailyPortion {
  const SeerahPortion(this.chapter, {this.progress, this.target});
  final SeerahChapterSummary chapter;

  /// How far the reader got in it, if they started.
  final ReadingProgress? progress;

  /// Today's share under the reader's plan (K3); null without a plan,
  /// when every tap simply moves on to the next chapter.
  final DailyTarget? target;

  /// The plan's chapters for today are read; [chapter] is tomorrow's.
  bool get doneForToday => target?.done ?? false;
  @override
  int get minutes => readingMinutes(chapter.wordCount);
  @override
  LocalizedText get title => chapter.title;
  @override
  String get route => AppRoutes.seerahChapter(chapter.id);
}

/// Null when there is nothing to read today: a journey step was already
/// finished today (one portion a day), or there is no journey step and
/// the Seerah is finished (or not in this build).
final dailyPortionProvider = FutureProvider<DailyPortion?>((ref) async {
  final today = ref.watch(localDayProvider);
  final journeys = await ref.watch(journeysProvider.future);
  final enrollments = await ref.watch(journeyEnrollmentsProvider.future);
  final steps = await ref.watch(journeyStepsProvider.future);
  final doneToday = steps.any((s) {
    final done = s.completedAt?.toLocal();
    return done != null &&
        !s.skipped &&
        done.year == today.year &&
        done.month == today.month &&
        done.day == today.day &&
        enrollments.any(
          (e) =>
              !e.paused &&
              e.journeyId == s.journeyId &&
              e.startedAt == s.startedAt,
        );
  });
  if (doneToday) return null;
  final journey = chooseNextStep(
    today: today,
    journeys: journeys,
    enrollments: enrollments,
    steps: steps,
    dueCount: 0,
    reading: const [],
    hasHistory: true,
  );
  if (journey case JourneyNextStep(:final journey, :final step)) {
    final runtime = await ref.watch(journeyRuntimeProvider(journey.id).future);
    return JourneyPortion(journey, step, runtime.minutes(step.id));
  }
  final SeerahIndex index;
  try {
    index = await ref.watch(seerahIndexProvider.future);
  } on Object {
    return null; // A build without the Seerah.
  }
  final progress = await ref.watch(
    workProgressProvider((ProgressTarget.seerahChapter, seerahParentId)).future,
  );
  final chapter =
      seerahResumeChapter(index.chapters, progress) ??
      (progress.isEmpty ? index.chapters.firstOrNull : null);
  if (chapter == null) return null;
  final plan = await ref.watch(readingPlanProvider.future);
  final counts = seerahFinished(progress.values, today);
  return SeerahPortion(
    chapter,
    progress: progress[chapter.id],
    target: plan == null
        ? null
        : dailyTarget(
            plan: plan,
            today: today,
            finished: counts.finished,
            finishedToday: counts.finishedToday,
            total: index.chapters.length,
          ),
  );
});

/// Home's first card: today's item, how long it takes, a way into it and,
/// for a Seerah chapter, «قرأتُه» to mark it read (with undo) and move on.
/// With nothing to read today it shows the general next step instead.
class DailyPortionCard extends ConsumerWidget {
  const DailyPortionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(dailyPortionProvider);
    if (!result.hasValue && !result.hasError) return const SizedBox.shrink();
    // Nothing to read today (or it could not be worked out): the general
    // next step, such as review or starting a journey.
    final portion = result.value;
    if (portion == null) return const NextStepCard();
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final title = portion.title.of(context);
    final source = switch (portion) {
      JourneyPortion(:final journey) => journey.title.of(context),
      SeerahPortion(:final chapter) => DisplayFormatter.join([
        l10n.seerahSectionName,
        l10n.storyChapterOf(
          format.integer(chapter.number),
          format.integer(_chapterCount(ref)),
        ),
      ]),
    };
    final minutes = l10n.storyReadingMinutes(
      portion.minutes,
      format.integer(portion.minutes),
    );
    final target = switch (portion) {
      SeerahPortion(:final target) => target,
      JourneyPortion() => null,
    };
    if (portion case SeerahPortion(doneForToday: true)) {
      return _doneCard(context, portion, title);
    }
    final kicker = target != null && target.chapters > 1
        ? l10n.dailyPortionOf(
            format.integer(target.doneToday + 1),
            format.integer(target.chapters),
          )
        : l10n.dailyPortionKicker;
    final started = switch (portion) {
      SeerahPortion(progress: final p?) when !p.completed && p.fraction > 0 =>
        readProgressLabel(l10n, format, p.fraction),
      _ => null,
    };

    return Card(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(kicker, style: SuhbaTextStyles.of(context).kicker),
            const SizedBox(height: AppSpacing.xs),
            Semantics(
              header: true,
              child: Text(title, style: textTheme.titleLarge),
            ),
            Text(
              DisplayFormatter.join([source, minutes, started]),
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceDim),
            ),
            // A missed day: two neutral ways on, the first the default.
            // No streak, no count of days, no red (K3).
            if (target != null && target.askHowToContinue) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.dailyPortionBehind(
                  target.behind,
                  format.integer(target.behind),
                ),
              ),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  TextButton(
                    onPressed: () =>
                        ref.read(readingPlanActionsProvider).continueFromHere(),
                    child: Text(l10n.planContinueFromHere),
                  ),
                  TextButton(
                    onPressed: () =>
                        ref.read(readingPlanActionsProvider).catchUpGradually(),
                    child: Text(l10n.planCatchUp),
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                FilledButton.icon(
                  onPressed: () => context.push(portion.route),
                  icon: const Icon(Icons.menu_book_outlined),
                  label: Text(l10n.dailyPortionRead),
                ),
                if (portion case SeerahPortion(:final chapter))
                  OutlinedButton.icon(
                    onPressed: () => _markRead(context, ref, chapter, title),
                    icon: const Icon(Icons.check),
                    label: Text(l10n.dailyPortionDone),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Today's chapters are read: a calm close, and tomorrow's chapter for
  /// anyone who wants to read ahead.
  Widget _doneCard(BuildContext context, SeerahPortion portion, String next) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.dailyPortionKicker,
              style: SuhbaTextStyles.of(context).kicker,
            ),
            const SizedBox(height: AppSpacing.xs),
            Semantics(
              header: true,
              child: Text(
                l10n.dailyPortionComplete,
                style: textTheme.titleLarge,
              ),
            ),
            Text(
              l10n.dailyPortionTomorrow(next),
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceDim),
            ),
            const SizedBox(height: AppSpacing.xs),
            TextButton.icon(
              onPressed: () => context.push(portion.route),
              icon: const Icon(Icons.menu_book_outlined),
              label: Text(l10n.dailyPortionReadAhead),
            ),
          ],
        ),
      ),
    );
  }

  int _chapterCount(WidgetRef ref) =>
      ref.watch(seerahIndexProvider).value?.chapters.length ?? 0;

  Future<void> _markRead(
    BuildContext context,
    WidgetRef ref,
    SeerahChapterSummary chapter,
    String title,
  ) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final repository = ref.read(readingProgressRepositoryProvider);
    final before = (await repository.all())
        .where(
          (p) =>
              p.target == ProgressTarget.seerahChapter &&
              p.targetId == chapter.id,
        )
        .firstOrNull;
    await repository.save(
      ReadingProgress(
        target: ProgressTarget.seerahChapter,
        targetId: chapter.id,
        parentId: seerahParentId,
        fraction: 1,
        completed: true,
        contentVersion:
            ref.read(contentManifestProvider).value?.contentVersion ??
            'unknown',
        updatedAt: ref.read(clockProvider)(),
      ),
    );
    showUndoSnackBar(
      messenger,
      l10n,
      message: l10n.dailyPortionMarked(title),
      onUndo: () => before == null
          ? repository.remove(ProgressTarget.seerahChapter, chapter.id)
          : repository.restore(before),
    );
  }
}
