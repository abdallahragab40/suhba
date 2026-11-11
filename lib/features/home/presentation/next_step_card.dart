import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/time/local_day_provider.dart';
import 'package:suhba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:suhba/features/home/domain/next_step.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/reading_progress/presentation/continue_reading.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

final nextStepProvider = FutureProvider<NextStep?>((ref) async {
  final today = ref.watch(localDayProvider);
  final enrollments = ref.watch(journeyEnrollmentsProvider);
  final steps = ref.watch(journeyStepsProvider);
  final reading = ref.watch(allProgressProvider);
  final saved = ref.watch(bookmarksProvider);
  final history = ref.watch(reviewItemsProvider);
  final best = ref.watch(quizBestProvider);
  final content = ref.watch(contentRepositoryProvider);
  final journeys = await ref.watch(journeysProvider.future);
  final e = enrollments.hasValue
      ? enrollments.requireValue
      : await ref.watch(journeyEnrollmentsProvider.future);
  final s = steps.hasValue
      ? steps.requireValue
      : await ref.watch(journeyStepsProvider.future);
  final r = reading.hasValue
      ? reading.requireValue
      : await ref.watch(allProgressProvider.future);
  final b = saved.hasValue
      ? saved.requireValue
      : await ref.watch(bookmarksProvider.future);
  final h = history.hasValue
      ? history.requireValue
      : await ref.watch(reviewItemsProvider.future);
  // Establish the higher-priority journey before loading review facts.
  final journey = chooseNextStep(
    today: today,
    journeys: journeys,
    enrollments: e,
    steps: s,
    dueCount: 0,
    reading: const [],
    hasHistory: true,
  );
  if (journey != null) return journey;
  final due = await ref.watch(dueReviewsProvider.future);
  if (due.isNotEmpty) return ReviewNextStep(due.length);
  // Confirmed removals are omitted; read failures still use the existing
  // continue-reading tile's retry, rather than pretending no history exists.
  final removed = <String>{};
  for (final p in r.where((p) => !p.completed)) {
    if ((await lookUpTarget(content, p.contentTarget)).valueOrNull
        is TargetMissing) {
      removed.add('${p.target.name}:${p.targetId}');
    }
  }
  return chooseNextStep(
    today: today,
    journeys: journeys,
    enrollments: e,
    steps: s,
    dueCount: 0,
    reading: r
        .where((p) => !removed.contains('${p.target.name}:${p.targetId}'))
        .toList(),
    hasHistory:
        e.isNotEmpty ||
        s.isNotEmpty ||
        r.isNotEmpty ||
        b.isNotEmpty ||
        h.isNotEmpty ||
        best.isNotEmpty,
  );
});

class NextStepCard extends ConsumerWidget {
  const NextStepCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final result = ref.watch(nextStepProvider);
    if (result.hasError) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSpacing.md),
        child: OutlinedButton.icon(
          onPressed: () {
            ref.invalidate(journeysProvider);
            ref.invalidate(reviewQuestionBankProvider);
            ref.invalidate(reviewQuestionsProvider);
            ref.invalidate(nextStepProvider);
          },
          icon: const Icon(Icons.refresh),
          label: Text(l10n.retry),
        ),
      );
    }
    final next = result.value;
    if (next == null) return const SizedBox.shrink();
    final format = DisplayFormatter.of(context);
    if (next case ReadingNextStep(:final progress)) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                l10n.nextStepTitle,
                style: SuhbaTextStyles.of(context).kicker,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            ContinueReadingTile(progress: progress),
          ],
        ),
      );
    }
    final (title, body, action, route) = switch (next) {
      JourneyNextStep(:final journey, :final step) => (
        step.title.of(context),
        journey.title.of(context),
        l10n.journeyContinue,
        AppRoutes.journeyStep(journey.id, step.id),
      ),
      ReviewNextStep(:final count) => (
        l10n.reviewDueCount(count, format.integer(count)),
        l10n.reviewIntro,
        l10n.reviewStart,
        AppRoutes.review,
      ),
      StartJourneyNextStep() => (
        l10n.journeysTitle,
        l10n.nextStepStartBody,
        l10n.journeyStart,
        AppRoutes.journeys,
      ),
      ReadingNextStep() => throw StateError('Handled above'),
    };
    return Card(
      margin: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.nextStepTitle, style: SuhbaTextStyles.of(context).kicker),
            const SizedBox(height: AppSpacing.xs),
            Semantics(
              header: true,
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            Text(body),
            const SizedBox(height: AppSpacing.sm),
            FilledButton.icon(
              onPressed: () => context.push(route),
              icon: Icon(
                next is ReviewNextStep
                    ? Icons.psychology_outlined
                    : Icons.menu_book_outlined,
              ),
              label: Text(action),
            ),
          ],
        ),
      ),
    );
  }
}
