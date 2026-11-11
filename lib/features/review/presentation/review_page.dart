import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/quiz/presentation/quiz_widgets.dart';
import 'package:suhba/features/review/domain/review_session.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// A snapshot of due questions, so answering one cannot make the current
/// question disappear underneath its explanation as the live queue updates.
class ReviewPage extends ConsumerStatefulWidget {
  const ReviewPage({super.key});
  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  List<DueReview>? _round;
  List<List<int>> _orders = const [];
  int _index = 0;
  int? _picked;
  bool _busy = false;
  bool _stale = false;
  bool _finished = false;

  Future<void> _answer(int index) async {
    if (_busy || _picked != null) return;
    final current = _round![_index];
    setState(() => _busy = true);
    try {
      final recorded = await ref
          .read(reviewRepositoryProvider)
          .answerDue(
            current.history,
            correct: index == current.question.correct,
          );
      if (!mounted) return;
      setState(() {
        _picked = index;
        _stale = !recorded;
      });
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
    final due = ref.watch(dueReviewsProvider);
    final Widget body;
    if (_round != null) {
      body = _session();
    } else {
      body = switch (due) {
        AsyncData(:final value) => _begin(value),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () {
            ref.invalidate(reviewItemsProvider);
            ref.invalidate(reviewQuestionBankProvider);
            ref.invalidate(reviewQuestionsProvider);
          },
        ),
        _ => const Center(child: CircularProgressIndicator()),
      };
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reviewTitle),
        actions: [
          IconButton(
            tooltip: l10n.learnedTitle,
            icon: const Icon(Icons.school_outlined),
            onPressed: () => context.push(AppRoutes.learned),
          ),
        ],
      ),
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

  Widget _begin(List<DueReview> due) {
    if (due.isEmpty) return _end(empty: true);
    final random = ref.read(quizRandomProvider);
    _round = List.of(due);
    // A question that comes back is not answered by remembering where its
    // answer was: each one shows its choices in a new order.
    _orders = [
      for (final d in due)
        List<int>.generate(d.question.choices.length, (i) => i)
          ..shuffle(random),
    ];
    return _session();
  }

  Widget _end({bool empty = false}) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const SizedBox(height: AppSpacing.lg),
        Icon(
          empty ? Icons.event_available_outlined : Icons.check_circle_outline,
          size: 40,
        ),
        const SizedBox(height: AppSpacing.lg),
        Semantics(
          header: true,
          child: Text(
            empty ? l10n.reviewEmptyTitle : l10n.reviewCompleteTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(empty ? l10n.reviewEmptyBody : l10n.reviewCompleteBody),
        const SizedBox(height: AppSpacing.lg),
        FilledButton(
          onPressed: () => context.push(AppRoutes.learned),
          child: Text(l10n.learnedTitle),
        ),
        TextButton(
          onPressed: () => context.push(AppRoutes.journeys),
          child: Text(l10n.journeysTitle),
        ),
      ],
    );
  }

  Widget _session() {
    if (_finished) return _end();
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final current = _round![_index];
    final q = current.question;
    return ListView(
      key: ValueKey(q.key),
      padding: const EdgeInsets.all(AppSpacing.gutter),
      children: [
        if (ref.watch(contentManifestProvider).value?.isDraft ?? false) ...[
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: DraftBadge(),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Text(
          l10n.reviewProgress(
            format.integer(_index + 1),
            format.integer(_round!.length),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Semantics(
          header: true,
          child: Text(
            quizPrompt(l10n, q),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final index in _orders[_index])
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: OutlinedButton(
              key: ValueKey('review-choice:$index'),
              onPressed: _picked == null && !_busy
                  ? () => _answer(index)
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Text(quizChoiceLabel(format, q.choices[index])),
              ),
            ),
          ),
        if (_picked != null) ...[
          const SizedBox(height: AppSpacing.md),
          Semantics(
            liveRegion: true,
            child: Text(
              _stale
                  ? l10n.reviewAlreadyAnswered
                  : _picked == q.correct
                  ? l10n.quizCorrect
                  : l10n.quizWrong,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.journeyCorrectAnswer(quizChoiceLabel(format, q.answer))),
          if (q.explanation != null) Text(q.explanation!.of(context)),
          if (q.route != null)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                onPressed: () => context.push(q.route!),
                icon: const Icon(Icons.menu_book_outlined),
                label: Text(l10n.reviewReadPassage),
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            key: const ValueKey('review-next'),
            onPressed: _busy
                ? null
                : () => setState(() {
                    if (_index == _round!.length - 1) {
                      _finished = true;
                    } else {
                      _index++;
                      _picked = null;
                      _stale = false;
                    }
                  }),
            child: Text(l10n.quizNext),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

/// Kept separate from the free-play modes and shown only for playable due items.
class DueReviewTile extends ConsumerWidget {
  const DueReviewTile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final due = ref.watch(dueReviewsProvider).value ?? const [];
    if (due.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.psychology_outlined),
        title: Text(
          l10n.reviewDueCount(
            due.length,
            DisplayFormatter.of(context).integer(due.length),
          ),
        ),
        subtitle: Text(l10n.reviewIntro),
        onTap: () => context.push(AppRoutes.review),
      ),
    );
  }
}
