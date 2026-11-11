import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/domain/journey_runtime.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/quiz/presentation/quiz_widgets.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/reminders/presentation/reminder_page.dart';
import 'package:suhba/features/sources/presentation/citation_sheet.dart';
import 'package:suhba/shared/content/domain/content_block.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

class JourneyPage extends ConsumerStatefulWidget {
  const JourneyPage({required this.journeyId, this.stepId, super.key});
  final String journeyId;
  final String? stepId;
  @override
  ConsumerState<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends ConsumerState<JourneyPage> {
  bool _busy = false;

  /// The choice picked for each question answered on this page, as an index
  /// into the question's own choices.
  final _picks = <String, int>{};

  /// The order the choices are shown in, per question: a question that
  /// comes back is not answered by remembering where its answer was.
  final _orders = <String, List<int>>{};

  List<int> _order(QuizQuestion q) => _orders.putIfAbsent(
    q.key,
    () =>
        List<int>.generate(q.choices.length, (i) => i)
          ..shuffle(ref.read(quizRandomProvider)),
  );

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).progressSaveFailed),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final runtime = ref.watch(journeyRuntimeProvider(widget.journeyId));
    final enrollments = ref.watch(journeyEnrollmentsProvider);
    final steps = ref.watch(journeyStepsProvider);
    Widget body;
    if (runtime.hasError || enrollments.hasError || steps.hasError) {
      final error = runtime.error ?? enrollments.error ?? steps.error;
      body = error is NotFoundFailure
          ? EmptyState(
              icon: Icons.route_outlined,
              title: l10n.journeyUnavailable,
            )
          : ErrorView(
              error: error,
              onRetry: () => ref
                ..invalidate(journeyRuntimeProvider(widget.journeyId))
                ..invalidate(journeyEnrollmentsProvider)
                ..invalidate(journeyStepsProvider),
            );
    } else if (runtime.value != null &&
        enrollments.value != null &&
        steps.value != null) {
      final enrollment = enrollments.value!
          .where((e) => e.journeyId == widget.journeyId)
          .firstOrNull;
      final progress = steps.value!
          .where(
            (s) =>
                s.journeyId == widget.journeyId &&
                s.startedAt == enrollment?.startedAt,
          )
          .toList();
      body = widget.stepId == null
          ? _overview(runtime.value!, enrollment, progress)
          : _step(runtime.value!, enrollment, progress);
    } else {
      body = const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.journeysTitle)),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.readingMaxWidth + AppSpacing.gutter * 2,
            ),
            child: body,
          ),
        ),
      ),
    );
  }

  Widget _heading(String text) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
    child: Semantics(
      header: true,
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    ),
  );

  Widget _overview(
    JourneyRuntime runtime,
    JourneyEnrollment? enrollment,
    List<JourneyStepProgress> progress,
  ) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final j = runtime.journey;
    final finished = {
      for (final p in progress)
        if (p.finished && j.steps.any((s) => s.id == p.stepId)) p.stepId,
    };
    final next = j.steps.where((s) => !finished.contains(s.id)).firstOrNull;
    final actions = ref.read(journeyActionsProvider);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      children: [
        if (!j.review.isApproved)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: DraftBadge(preliminary: j.review.isPreliminary),
          ),
        _heading(j.title.of(context)),
        Text(j.description.of(context)),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.journeyPacing),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.journeyProgress(
            format.integer(finished.length),
            j.steps.length,
            format.integer(j.steps.length),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        LinearProgressIndicator(value: finished.length / j.steps.length),
        const SizedBox(height: AppSpacing.lg),
        if (enrollment?.paused ?? false) Text(l10n.journeyPaused),
        if (next == null)
          Text(l10n.journeyFinished)
        else
          FilledButton.icon(
            onPressed: _busy
                ? null
                : () => _run(() async {
                    await actions.start(j.id);
                    if (enrollment?.paused ?? false) {
                      await actions.pause(j.id, false);
                    }
                    // The new enrollment may need missing steps marked before choosing.
                    ref.invalidate(journeyRuntimeProvider(j.id));
                    await ref.read(journeyRuntimeProvider(j.id).future);
                    final current = await ref
                        .read(journeyRepositoryProvider)
                        .steps();
                    final remaining = j.steps
                        .where(
                          (s) => !current.any(
                            (p) =>
                                p.journeyId == j.id &&
                                p.stepId == s.id &&
                                p.finished,
                          ),
                        )
                        .firstOrNull;
                    if (mounted && remaining != null) {
                      await context.push<void>(
                        AppRoutes.journeyStep(j.id, remaining.id),
                      );
                    }
                  }),
            icon: const Icon(Icons.menu_book_outlined),
            label: Text(
              enrollment == null
                  ? l10n.journeyStart
                  : enrollment.paused
                  ? l10n.journeyResume
                  : l10n.journeyContinue,
            ),
          ),
        if (enrollment != null)
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              if (!enrollment.paused && next != null)
                TextButton(
                  onPressed: _busy
                      ? null
                      : () => _run(() => actions.pause(j.id, true)),
                  child: Text(l10n.journeyPause),
                ),
              TextButton(
                onPressed: _busy
                    ? null
                    : () async {
                        final restart = await showDialog<bool>(
                          context: context,
                          builder: (dialog) => AlertDialog(
                            title: Text(l10n.journeyRestart),
                            content: Text(l10n.journeyRestartMessage),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(dialog, false),
                                child: Text(l10n.cancel),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.pop(dialog, true),
                                child: Text(l10n.journeyRestart),
                              ),
                            ],
                          ),
                        );
                        if (restart == true && mounted) {
                          await _run(() async {
                            await actions.restart(j.id);
                            ref.invalidate(journeyRuntimeProvider(j.id));
                          });
                        }
                      },
                child: Text(l10n.journeyRestart),
              ),
            ],
          ),
        const ReminderSettingsTile(),
        const SizedBox(height: AppSpacing.md),
        for (final (index, step) in j.steps.indexed) ...[
          Semantics(
            label: l10n.journeyStepNumber(
              format.integer(index + 1),
              format.integer(j.steps.length),
            ),
            value: progress.any((p) => p.stepId == step.id && p.skipped)
                ? l10n.journeySkipped
                : finished.contains(step.id)
                ? l10n.journeyCompleteStep
                : null,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ExcludeSemantics(
                child: progress.any((p) => p.stepId == step.id && p.skipped)
                    ? const Icon(Icons.skip_next_outlined)
                    : finished.contains(step.id)
                    ? const Icon(Icons.check_circle_outline)
                    : Text(format.padded(index + 1)),
              ),
              title: Text(step.title.of(context)),
              subtitle: Text(
                runtime.missing(step.id)
                    ? l10n.journeySkipped
                    : runtime.unlocked(step.id, progress)
                    ? l10n.journeyMinutes(
                        runtime.minutes(step.id),
                        format.integer(runtime.minutes(step.id)),
                      )
                    : l10n.journeyLocked,
              ),
              enabled:
                  enrollment != null &&
                  !runtime.missing(step.id) &&
                  runtime.unlocked(step.id, progress),
              onTap: () => context.push(AppRoutes.journeyStep(j.id, step.id)),
            ),
          ),
          const Divider(height: 1),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _step(
    JourneyRuntime runtime,
    JourneyEnrollment? enrollment,
    List<JourneyStepProgress> progress,
  ) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final j = runtime.journey;
    final step = j.steps.where((s) => s.id == widget.stepId).firstOrNull;
    if (step == null) {
      return EmptyState(
        icon: Icons.route_outlined,
        title: l10n.journeyUnavailable,
      );
    }
    if (runtime.missing(step.id)) {
      return EmptyState(icon: Icons.skip_next, title: l10n.journeySkipped);
    }
    if (enrollment == null || !runtime.unlocked(step.id, progress)) {
      return EmptyState(icon: Icons.lock_outline, title: l10n.journeyLocked);
    }
    final saved = progress.where((p) => p.stepId == step.id).firstOrNull;
    final readings = runtime.readings[step.id]!.nonNulls.toList();
    final positions = ref.watch(allProgressProvider);
    if (positions.hasError) {
      return ErrorView(
        error: positions.error,
        onRetry: () => ref.invalidate(allProgressProvider),
      );
    }
    final done = {
      for (final r in readings)
        if (positions.value?.any(
              (p) =>
                  p.target == r.ref.progressTarget &&
                  p.targetId == r.ref.targetId &&
                  p.completed,
            ) ??
            false)
          (r.ref.progressTarget, r.ref.targetId),
    };
    final allRead = done.length == readings.length;
    final questions = runtime.questions[step.id]!;
    final allAnswered = questions.every(
      (q) => saved?.answeredKeys.contains(q.key) ?? false,
    );
    final canAct = !_busy && !enrollment.paused;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      children: [
        if (!j.review.isApproved) ...[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: DraftBadge(preliminary: j.review.isPreliminary),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Text(
          l10n.journeyStepNumber(
            format.integer(j.steps.indexOf(step) + 1),
            format.integer(j.steps.length),
          ),
        ),
        _heading(step.title.of(context)),
        if (step.framing != null) Text(step.framing!.of(context)),
        Text(
          l10n.journeyMinutes(
            runtime.minutes(step.id),
            format.integer(runtime.minutes(step.id)),
          ),
        ),
        if (enrollment.paused) Text(l10n.journeyPaused),
        _heading(l10n.journeyReading),
        for (final r in readings)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              done.contains((r.ref.progressTarget, r.ref.targetId))
                  ? Icons.check_circle_outline
                  : Icons.menu_book_outlined,
            ),
            title: Text(r.title.of(context)),
            subtitle: Text(
              l10n.journeyMinutes(r.minutes, format.integer(r.minutes)),
            ),
            onTap: () => context.push(r.ref.route),
            trailing: IconButton(
              tooltip: l10n.readerSectionSources,
              icon: const Icon(Icons.library_books_outlined),
              onPressed: () => showCitationSheet(
                context,
                citations: [for (final b in r.blocks) ...b.allCitations],
                provisional: !j.review.isApproved,
              ),
            ),
          ),
        if (!allRead)
          FilledButton(
            onPressed: canAct
                ? () => context.push(
                    readings
                        .firstWhere(
                          (r) => !done.contains((
                            r.ref.progressTarget,
                            r.ref.targetId,
                          )),
                        )
                        .ref
                        .route,
                  )
                : null,
            child: Text(l10n.journeyReadNext),
          ),
        if (allRead && questions.isNotEmpty) ...[
          _heading(l10n.journeyQuestions),
          for (final q in questions) ...[
            const SizedBox(height: AppSpacing.md),
            Semantics(
              header: true,
              child: Text(
                quizPrompt(l10n, q),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (saved?.answeredKeys.contains(q.key) ?? false) ...[
              Semantics(
                liveRegion: true,
                child: Text(
                  switch (_picks[q.key]) {
                    null => l10n.journeyAnswerRecorded,
                    final pick when pick == q.correct => l10n.quizCorrect,
                    _ => l10n.quizWrong,
                  },
                  style: _picks.containsKey(q.key)
                      ? Theme.of(context).textTheme.titleMedium
                      : null,
                ),
              ),
              Text(
                l10n.journeyCorrectAnswer(quizChoiceLabel(format, q.answer)),
              ),
              if (q.explanation != null) Text(q.explanation!.of(context)),
              if (q.route != null)
                TextButton(
                  onPressed: () => context.push(q.route!),
                  child: Text(l10n.reviewReadPassage),
                ),
            ] else
              for (final index in _order(q))
                OutlinedButton(
                  key: ValueKey('journey-answer:${q.key}:$index'),
                  onPressed: canAct
                      ? () => _run(() async {
                          await ref
                              .read(journeyActionsProvider)
                              .answer(runtime, step.id, q.key, index);
                          _picks[q.key] = index;
                        })
                      : null,
                  child: Text(quizChoiceLabel(format, q.choices[index])),
                ),
          ],
        ],
        if (allRead && questions.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.lg),
            child: Text(l10n.journeyReflectionOnly),
          ),
        if (step.reflection != null) ...[
          _heading(l10n.journeyReflection),
          Text(step.reflection!.of(context)),
        ],
        const SizedBox(height: AppSpacing.lg),
        if (saved?.finished ?? false)
          Text(l10n.readerCompleted)
        else
          FilledButton.icon(
            key: const ValueKey('complete-journey-step'),
            onPressed: canAct && allRead && allAnswered
                ? () => _run(() async {
                    await ref
                        .read(journeyActionsProvider)
                        .complete(runtime, step.id);
                    if (mounted) context.pop();
                  })
                : null,
            icon: const Icon(Icons.check),
            label: Text(l10n.journeyCompleteStep),
          ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
