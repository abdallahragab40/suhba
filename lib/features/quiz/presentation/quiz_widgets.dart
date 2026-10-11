import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/motion.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/quiz/domain/quiz_question.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';

/// The question as the player reads it.
String quizPrompt(AppLocalizations l10n, QuizQuestion q) {
  final s = q.subject?.ar ?? '';
  final female = q.subjectGender == Gender.female;
  return switch (q.kind) {
    QuizKind.companionByKunya =>
      female ? l10n.quizQKunyaFemale(s) : l10n.quizQKunyaMale(s),
    QuizKind.kunyaOfCompanion => l10n.quizQKunyaOf(s),
    QuizKind.companionByTitle =>
      female ? l10n.quizQTitleFemale(s) : l10n.quizQTitleMale(s),
    QuizKind.deathPlace =>
      female ? l10n.quizQDeathFemale(s) : l10n.quizQDeathMale(s),
    QuizKind.memberOfCategory => l10n.quizQMember(s),
    QuizKind.fatherOf => l10n.quizQFather(s),
    QuizKind.motherOf => l10n.quizQMother(s),
    QuizKind.companionInStory => l10n.quizQStory(s),
    QuizKind.eventYear => l10n.quizQEventYear(s),
    QuizKind.earliestEvent => l10n.quizQEarliestEvent,
    QuizKind.eventPlace => l10n.quizQEventPlace(s),
    QuizKind.eventAtPlace => l10n.quizQEventAtPlace(s),
    QuizKind.earliestChapter => l10n.quizQEarliestChapter,
  };
}

/// An answer as the player reads it.
String quizChoiceLabel(DisplayFormatter format, QuizChoice c) => switch (c) {
  TextChoice(:final text) => text.ar,
  DateChoice(:final date) => format.historicalDate(date, withGregorian: false),
};

/// How a choice looks once the question is answered.
enum ChoiceState { idle, correct, wrong, dimmed }

/// One answer: it enters after [delay], glows gold when it is the answer,
/// shakes when it was a wrong pick, and fades back when it is neither.
class QuizChoiceTile extends StatefulWidget {
  const QuizChoiceTile({
    required this.label,
    required this.state,
    required this.onTap,
    required this.entrance,
    this.burst = false,
    super.key,
  });

  final String label;
  final ChoiceState state;
  final VoidCallback? onTap;

  /// The tile's share of the question's entrance animation.
  final Animation<double> entrance;

  /// Whether to throw gold sparks (the player picked the right answer).
  final bool burst;

  @override
  State<QuizChoiceTile> createState() => _QuizChoiceTileState();
}

class _QuizChoiceTileState extends State<QuizChoiceTile>
    with SingleTickerProviderStateMixin {
  late final _shake = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );

  @override
  void didUpdateWidget(QuizChoiceTile old) {
    super.didUpdateWidget(old);
    if (widget.state == ChoiceState.wrong && old.state != ChoiceState.wrong) {
      _shake.duration = AppMotion.resolve(
        context,
        const Duration(milliseconds: 420),
      );
      _shake.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (background, border, icon, iconColor) = switch (widget.state) {
      ChoiceState.idle => (Palette.greenAlt, Palette.lineOnGreen, null, null),
      ChoiceState.correct => (
        Palette.greenHighest,
        Palette.goldOnInk,
        Icons.check_circle,
        Palette.goldOnInk,
      ),
      ChoiceState.wrong => (
        Palette.draftWashOnGreen,
        Palette.draftOnGreen,
        Icons.cancel,
        Palette.draftOnGreen,
      ),
      ChoiceState.dimmed => (Palette.greenLow, Palette.lineOnGreen, null, null),
    };
    final medium = AppMotion.resolve(context, AppMotion.medium);

    final tile = AnimatedContainer(
      duration: medium,
      curve: AppMotion.easeStandard,
      constraints: const BoxConstraints(minHeight: 60),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(AppRadii.md),
        border: Border.all(
          color: border,
          width: widget.state == ChoiceState.idle ? 1 : 2,
        ),
        boxShadow: [
          if (widget.state == ChoiceState.correct)
            BoxShadow(
              color: Palette.goldOnInk.withValues(alpha: 0.35),
              blurRadius: 18,
            ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: const BorderRadius.all(AppRadii.md),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedOpacity(
                    duration: medium,
                    opacity: widget.state == ChoiceState.dimmed ? 0.55 : 1,
                    child: Text(
                      widget.label,
                      style: textTheme.titleMedium?.copyWith(
                        color: Palette.paper,
                      ),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: medium,
                  transitionBuilder: (child, a) =>
                      ScaleTransition(scale: a, child: child),
                  child: icon == null
                      ? const SizedBox(width: 24, key: ValueKey('none'))
                      : Icon(icon, key: ValueKey(icon), color: iconColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: Listenable.merge([widget.entrance, _shake]),
      builder: (context, child) {
        final t = widget.entrance.value;
        final shake =
            math.sin(_shake.value * math.pi * 6) * (1 - _shake.value) * 10;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(shake, (1 - t) * 24),
            child: child,
          ),
        );
      },
      child: AnimatedScale(
        duration: medium,
        curve: Curves.easeOutBack,
        scale: widget.state == ChoiceState.correct ? 1.02 : 1,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            tile,
            if (widget.burst)
              const Positioned.fill(
                child: IgnorePointer(child: Center(child: GoldBurst())),
              ),
          ],
        ),
      ),
    );
  }
}

/// A brief burst of gold sparks (small eight-pointed stars), played once.
/// Nothing is drawn when the user has asked to reduce motion.
class GoldBurst extends StatefulWidget {
  const GoldBurst({this.size = 220, this.count = 14, super.key});

  final double size;
  final int count;

  @override
  State<GoldBurst> createState() => _GoldBurstState();
}

class _GoldBurstState extends State<GoldBurst>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  late final List<(double, double, double)> _sparks;

  @override
  void initState() {
    super.initState();
    final random = math.Random();
    _sparks = [
      for (var i = 0; i < widget.count; i++)
        (
          // angle, distance, size
          i * 2 * math.pi / widget.count + random.nextDouble() * 0.4,
          0.55 + random.nextDouble() * 0.45,
          3 + random.nextDouble() * 4,
        ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!MediaQuery.disableAnimationsOf(context) && !_controller.isAnimating) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return const SizedBox();
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) =>
            CustomPaint(painter: _BurstPainter(_sparks, _controller.value)),
      ),
    );
  }
}

class _BurstPainter extends CustomPainter {
  _BurstPainter(this.sparks, this.t);

  final List<(double, double, double)> sparks;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    if (t == 0 || t == 1) return;
    final centre = size.center(Offset.zero);
    final eased = Curves.easeOutCubic.transform(t);
    final paint = Paint()
      ..color = Palette.goldOnInk.withValues(alpha: (1 - t).clamp(0, 1));
    for (final (angle, distance, r) in sparks) {
      final at =
          centre +
          Offset(math.cos(angle), math.sin(angle)) *
              size.shortestSide /
              2 *
              distance *
              eased;
      canvas.drawPath(_star(at, r * (1 - t * 0.5)), paint);
    }
  }

  Path _star(Offset c, double outer) {
    final inner = outer * 0.5;
    final path = Path();
    for (var i = 0; i < 16; i++) {
      final a = -math.pi / 2 + i * math.pi / 8;
      final rr = i.isEven ? outer : inner;
      final p = c + Offset(math.cos(a), math.sin(a)) * rr;
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    return path..close();
  }

  @override
  bool shouldRepaint(_BurstPainter old) => old.t != t;
}

/// The result: a gold ring fills to the score while the number counts up.
class QuizScoreRing extends StatelessWidget {
  const QuizScoreRing({
    required this.score,
    required this.total,
    this.size = 180,
    super.key,
  });

  final int score;
  final int total;
  final double size;

  @override
  Widget build(BuildContext context) {
    final format = DisplayFormatter.of(context);
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final fraction = total == 0 ? 0.0 : score / total;
    return Semantics(
      label: l10n.quizScore(format.integer(score), format.integer(total)),
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: fraction),
        duration: AppMotion.resolve(
          context,
          const Duration(milliseconds: 1200),
        ),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) => SizedBox.square(
          dimension: size,
          child: CustomPaint(
            painter: _RingPainter(value),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    format.integer((value * total).round()),
                    style: textTheme.displayMedium?.copyWith(
                      color: Palette.paper,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.quizOutOf(format.integer(total)),
                    style: textTheme.titleSmall?.copyWith(
                      color: Palette.paperDimOnGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.value);

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(10);
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..color = Palette.greenHighest;
    canvas.drawArc(rect, 0, math.pi * 2, false, track);
    if (value <= 0) return;
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
        colors: [
          Color.lerp(Palette.goldOnInk, Palette.paper, 0.3)!,
          Palette.goldOnInk,
        ],
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * value, false, arc);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.value != value;
}

/// Stars earned for a result, popping in one after another.
class QuizStars extends StatelessWidget {
  const QuizStars({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final step = AppMotion.resolve(context, const Duration(milliseconds: 260));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 3; i++)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: step * (i + 3),
            curve: Interval((i + 2) / (i + 3), 1, curve: Curves.elasticOut),
            builder: (context, t, child) =>
                Transform.scale(scale: t, child: child),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              child: Icon(
                i < count ? Icons.star_rounded : Icons.star_outline_rounded,
                size: i == 1 ? 52 : 40,
                color: i < count ? Palette.goldOnInk : Palette.lineOnGreen,
              ),
            ),
          ),
      ],
    );
  }
}

/// The current run of right answers; it pops whenever it grows.
class QuizStreak extends StatelessWidget {
  const QuizStreak({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    return AnimatedSwitcher(
      duration: AppMotion.resolve(context, AppMotion.medium),
      transitionBuilder: (child, a) => ScaleTransition(
        scale: CurvedAnimation(parent: a, curve: Curves.easeOutBack),
        child: child,
      ),
      child: count < 2
          ? const SizedBox(key: ValueKey(0))
          : Container(
              key: ValueKey(count),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xxs,
              ),
              decoration: const BoxDecoration(
                color: Palette.draftWashOnGreen,
                borderRadius: BorderRadius.all(AppRadii.pill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    size: 16,
                    color: Palette.goldOnInk,
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                  Text(
                    l10n.quizStreak(format.integer(count)),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Palette.draftOnGreen,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
