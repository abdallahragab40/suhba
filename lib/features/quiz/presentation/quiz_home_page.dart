import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/motion.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/scene_backdrop.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';

/// The quiz's front page: what it is, and a card for each mode with the
/// best result so far. The cards slide in one after another.
class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends ConsumerState<QuizHomePage>
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final best = ref.watch(quizBestProvider);
    final modes = [
      (
        QuizMode.mixed,
        l10n.quizModeMixed,
        l10n.quizModeMixedHint,
        Icons.shuffle,
      ),
      (
        QuizMode.companions,
        l10n.quizModeCompanions,
        l10n.quizModeCompanionsHint,
        Icons.groups_outlined,
      ),
      (
        QuizMode.seerah,
        l10n.quizModeSeerah,
        l10n.quizModeSeerahHint,
        Icons.auto_stories_outlined,
      ),
    ];

    return Theme(
      data: AppTheme.feature,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: Palette.green,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 240,
                backgroundColor: Palette.green,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      const SceneBackdrop(kind: SceneKind.nightDesert),
                      // A scrim, so the title reads over the dunes.
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.25, 1],
                            colors: [
                              Palette.green.withValues(alpha: 0),
                              Palette.green.withValues(alpha: 0.92),
                            ],
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        start: AppSpacing.gutter,
                        end: AppSpacing.gutter,
                        bottom: AppSpacing.lg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Semantics(
                              header: true,
                              child: Text(
                                l10n.quizTitle,
                                style: Theme.of(context).textTheme.displaySmall
                                    ?.copyWith(color: Palette.paper),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              l10n.quizSubtitle,
                              style: SuhbaTextStyles.of(
                                context,
                              ).reading.copyWith(color: Palette.paper),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.gutter),
                sliver: SliverList.list(
                  children: [
                    for (var i = 0; i < modes.length; i++)
                      _Entrance(
                        animation: CurvedAnimation(
                          parent: _entrance,
                          curve: Interval(
                            i * 0.18,
                            0.55 + i * 0.18,
                            curve: AppMotion.easeStandard,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: _ModeCard(
                            title: modes[i].$2,
                            hint: modes[i].$3,
                            icon: modes[i].$4,
                            best: best[modes[i].$1],
                            onTap: () => context.push(
                              AppRoutes.quizPlay(modes[i].$1.name),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.quizNote,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Palette.paperDimOnGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Entrance extends StatelessWidget {
  const _Entrance({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween(
        begin: const Offset(0, 0.25),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.title,
    required this.hint,
    required this.icon,
    required this.best,
    required this.onTap,
  });

  final String title;
  final String hint;
  final IconData icon;
  final int? best;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final textTheme = Theme.of(context).textTheme;
    final score = best;
    return Material(
      color: Palette.greenAlt,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(AppRadii.lg),
        side: BorderSide(color: Palette.lineOnGreen),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.greenHighest,
                  border: Border.all(color: Palette.goldOnInk),
                ),
                child: Icon(icon, color: Palette.goldOnInk),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleLarge?.copyWith(
                        color: Palette.paper,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      hint,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Palette.paperDimOnGreen,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      score == null
                          ? l10n.quizNoBest
                          : l10n.quizBest(
                              format.integer(score),
                              format.integer(10),
                            ),
                      style: textTheme.labelMedium?.copyWith(
                        color: Palette.goldOnInk,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Palette.paperDimOnGreen),
            ],
          ),
        ),
      ),
    );
  }
}
