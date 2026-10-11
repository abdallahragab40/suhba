import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/motion.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/quiz/domain/quiz_generator.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/quiz/presentation/quiz_widgets.dart';

/// A round of the quiz in [mode]: ten questions generated from the content,
/// one at a time, with feedback and a link to the passage after each, then
/// the result. On Madinah green, like the app's feature sections.
class QuizPlayPage extends ConsumerStatefulWidget {
  const QuizPlayPage({required this.mode, super.key});

  final QuizMode mode;

  @override
  ConsumerState<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends ConsumerState<QuizPlayPage> {
  List<QuizQuestion>? _round;
  var _index = 0;
  int? _picked;
  var _score = 0;
  var _streak = 0;
  final _answers = <int?>[];
  var _finished = false;
  var _newBest = false;

  void _start(QuizContent content) {
    _round = QuizGenerator(
      content,
      random: ref.read(quizRandomProvider),
    ).round(widget.mode, recent: ref.read(quizRecentProvider));
    _index = 0;
    _picked = null;
    _score = 0;
    _streak = 0;
    _answers.clear();
    _finished = false;
    _newBest = false;
  }

  void _pick(int i) {
    final q = _round![_index];
    if (_picked != null) return;
    final right = i == q.correct;
    setState(() {
      _picked = i;
      _answers.add(i);
      if (right) {
        _score++;
        _streak++;
      } else {
        _streak = 0;
      }
    });
    right ? HapticFeedback.lightImpact() : HapticFeedback.mediumImpact();
  }

  Future<void> _next() async {
    final round = _round!;
    if (_index < round.length - 1) {
      setState(() {
        _index++;
        _picked = null;
      });
      return;
    }
    await ref
        .read(quizRecentProvider.notifier)
        .remember(round.map((q) => q.key));
    final best = await ref
        .read(quizBestProvider.notifier)
        .record(widget.mode, _score);
    if (!mounted) return;
    setState(() {
      _finished = true;
      _newBest = best;
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = ref.watch(quizContentProvider);
    return Theme(
      data: AppTheme.feature,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: Palette.green,
          appBar: AppBar(
            backgroundColor: Palette.green,
            leading: const CloseButton(),
            title: Text(_modeName(AppLocalizations.of(context), widget.mode)),
          ),
          body: SafeArea(
            top: false,
            child: switch (content) {
              AsyncData(:final value) => _body(value),
              AsyncError() => ErrorView(
                onRetry: () => ref.invalidate(quizContentProvider),
              ),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ),
        ),
      ),
    );
  }

  Widget _body(QuizContent content) {
    if (_round == null) _start(content);
    final round = _round!;
    final long = AppMotion.resolve(context, AppMotion.long);
    return AnimatedSwitcher(
      duration: long,
      switchInCurve: AppMotion.easeStandard,
      transitionBuilder: (child, a) => FadeTransition(
        opacity: a,
        child: SlideTransition(
          position: Tween(
            begin: const Offset(-0.08, 0),
            end: Offset.zero,
          ).animate(a),
          child: child,
        ),
      ),
      child: _finished
          ? _QuizResult(
              key: const ValueKey('result'),
              round: round,
              answers: _answers,
              score: _score,
              newBest: _newBest,
              onAgain: () => setState(() => _start(content)),
            )
          : _QuizStep(
              key: ValueKey(_index),
              question: round[_index],
              index: _index,
              total: round.length,
              picked: _picked,
              streak: _streak,
              onPick: _pick,
              onNext: _next,
            ),
    );
  }
}

String _modeName(AppLocalizations l10n, QuizMode mode) => switch (mode) {
  QuizMode.mixed => l10n.quizModeMixed,
  QuizMode.companions => l10n.quizModeCompanions,
  QuizMode.seerah => l10n.quizModeSeerah,
};

/// One question: progress, the prompt, the choices and, once answered, the
/// feedback with a link to read more.
class _QuizStep extends StatefulWidget {
  const _QuizStep({
    required this.question,
    required this.index,
    required this.total,
    required this.picked,
    required this.streak,
    required this.onPick,
    required this.onNext,
    super.key,
  });

  final QuizQuestion question;
  final int index;
  final int total;
  final int? picked;
  final int streak;
  final ValueChanged<int> onPick;
  final VoidCallback onNext;

  @override
  State<_QuizStep> createState() => _QuizStepState();
}

class _QuizStepState extends State<_QuizStep>
    with SingleTickerProviderStateMixin {
  late final _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _entrance.value = 1;
    } else if (_entrance.value == 0 && !_entrance.isAnimating) {
      _entrance.forward();
    }
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  Animation<double> _part(double start, double end) => CurvedAnimation(
    parent: _entrance,
    curve: Interval(start, end, curve: AppMotion.easeStandard),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final textTheme = Theme.of(context).textTheme;
    final styles = SuhbaTextStyles.of(context);
    final q = widget.question;
    final picked = widget.picked;
    final answered = picked != null;
    final medium = AppMotion.resolve(context, AppMotion.medium);
    final last = widget.index == widget.total - 1;

    ChoiceState stateOf(int i) {
      if (!answered) return ChoiceState.idle;
      if (i == q.correct) return ChoiceState.correct;
      if (i == picked) return ChoiceState.wrong;
      return ChoiceState.dimmed;
    }

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.gutter,
        AppSpacing.xs,
        AppSpacing.gutter,
        AppSpacing.xl,
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.quizProgress(
                  format.integer(widget.index + 1),
                  format.integer(widget.total),
                ),
                style: styles.kicker.copyWith(color: Palette.paperDimOnGreen),
              ),
            ),
            QuizStreak(count: widget.streak),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        TweenAnimationBuilder<double>(
          tween: Tween(
            begin: widget.index / widget.total,
            end: (widget.index + (answered ? 1 : 0)) / widget.total,
          ),
          duration: medium,
          builder: (context, value, _) => ClipRRect(
            borderRadius: const BorderRadius.all(AppRadii.pill),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              color: Palette.goldOnInk,
              backgroundColor: Palette.greenHighest,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        FadeTransition(
          opacity: _part(0, 0.4),
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(_part(0, 0.4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  q.kind.mode == QuizMode.seerah
                      ? l10n.quizAboutSeerah
                      : l10n.quizAboutCompanions,
                  style: styles.kicker.copyWith(color: Palette.goldOnInk),
                ),
                const SizedBox(height: AppSpacing.xs),
                Semantics(
                  header: true,
                  child: Text(
                    quizPrompt(l10n, q),
                    style: textTheme.headlineSmall?.copyWith(
                      color: Palette.paper,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (var i = 0; i < q.choices.length; i++) ...[
          QuizChoiceTile(
            label: quizChoiceLabel(format, q.choices[i]),
            state: stateOf(i),
            entrance: _part(0.25 + i * 0.12, 0.6 + i * 0.12),
            burst: answered && i == picked && i == q.correct,
            onTap: answered ? null : () => widget.onPick(i),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        AnimatedSize(
          duration: medium,
          curve: AppMotion.easeStandard,
          alignment: Alignment.topCenter,
          child: !answered
              ? const SizedBox(width: double.infinity)
              : _Feedback(
                  question: q,
                  right: picked == q.correct,
                  last: last,
                  onNext: widget.onNext,
                ),
        ),
      ],
    );
  }
}

/// After answering: right or wrong, a line from the content, a link to read
/// more, and the way on.
class _Feedback extends StatelessWidget {
  const _Feedback({
    required this.question,
    required this.right,
    required this.last,
    required this.onNext,
  });

  final QuizQuestion question;
  final bool right;
  final bool last;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final textTheme = Theme.of(context).textTheme;
    final route = question.route;
    final explanation = question.explanation;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Palette.greenLow,
          borderRadius: const BorderRadius.all(AppRadii.md),
          border: Border.all(color: Palette.lineOnGreen),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              liveRegion: true,
              child: Text(
                right
                    ? l10n.quizCorrect
                    : l10n.quizAnswerWas(
                        quizChoiceLabel(format, question.answer),
                      ),
                style: textTheme.titleMedium?.copyWith(
                  color: right ? Palette.goldOnInk : Palette.draftOnGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (explanation != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                explanation.ar,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: Palette.paperDimOnGreen,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                if (route != null)
                  TextButton.icon(
                    onPressed: () => context.push(route),
                    icon: const Icon(Icons.menu_book_outlined),
                    label: Text(l10n.quizReadMore),
                  ),
                const Spacer(),
                FilledButton(
                  onPressed: onNext,
                  child: Text(last ? l10n.quizSeeResult : l10n.quizNext),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The end of a round: the ring, the stars, a word, and the answers to
/// review.
class _QuizResult extends StatefulWidget {
  const _QuizResult({
    required this.round,
    required this.answers,
    required this.score,
    required this.newBest,
    required this.onAgain,
    super.key,
  });

  final List<QuizQuestion> round;
  final List<int?> answers;
  final int score;
  final bool newBest;
  final VoidCallback onAgain;

  @override
  State<_QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<_QuizResult> {
  var _review = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final textTheme = Theme.of(context).textTheme;
    final total = widget.round.length;
    final ratio = total == 0 ? 0.0 : widget.score / total;
    final stars = ratio >= 0.9
        ? 3
        : ratio >= 0.7
        ? 2
        : ratio >= 0.5
        ? 1
        : 0;
    final message = switch (stars) {
      3 => l10n.quizResult3,
      2 => l10n.quizResult2,
      1 => l10n.quizResult1,
      _ => l10n.quizResult0,
    };

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      children: [
        const SizedBox(height: AppSpacing.md),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              QuizScoreRing(score: widget.score, total: total),
              if (stars == 3) const IgnorePointer(child: GoldBurst(size: 300)),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Center(child: QuizStars(count: stars)),
        const SizedBox(height: AppSpacing.md),
        Text(
          message,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(color: Palette.paper),
        ),
        if (widget.newBest) ...[
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(AppRadii.pill),
                border: Border.all(color: Palette.goldOnInk),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    color: Palette.goldOnInk,
                    size: 18,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    l10n.quizNewBest,
                    style: textTheme.labelLarge?.copyWith(
                      color: Palette.goldOnInk,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        FilledButton.icon(
          onPressed: widget.onAgain,
          icon: const Icon(Icons.refresh),
          label: Text(l10n.quizPlayAgain),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: () => setState(() => _review = !_review),
          icon: Icon(_review ? Icons.expand_less : Icons.expand_more),
          label: Text(l10n.quizReview),
        ),
        AnimatedSize(
          duration: AppMotion.resolve(context, AppMotion.medium),
          alignment: Alignment.topCenter,
          child: !_review
              ? const SizedBox(width: double.infinity)
              : Column(
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    for (var i = 0; i < total; i++)
                      _ReviewRow(
                        question: widget.round[i],
                        picked: widget.answers[i],
                        number: i + 1,
                        format: format,
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.question,
    required this.picked,
    required this.number,
    required this.format,
  });

  final QuizQuestion question;
  final int? picked;
  final int number;
  final DisplayFormatter format;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final right = picked == question.correct;
    final route = question.route;
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Icon(
          right ? Icons.check_circle : Icons.cancel,
          color: right ? Palette.goldOnInk : Palette.draftOnGreen,
        ),
        title: Text(
          quizPrompt(l10n, question),
          style: textTheme.titleSmall?.copyWith(color: Palette.paper),
        ),
        subtitle: Text(
          [
            l10n.quizAnswerWas(quizChoiceLabel(format, question.answer)),
            if (!right && picked != null)
              l10n.quizYourAnswer(
                quizChoiceLabel(format, question.choices[picked!]),
              ),
          ].join('\n'),
          style: textTheme.bodySmall?.copyWith(color: Palette.paperDimOnGreen),
        ),
        trailing: route == null ? null : const Icon(Icons.chevron_right),
        onTap: route == null ? null : () => context.push(route),
      ),
    );
  }
}
