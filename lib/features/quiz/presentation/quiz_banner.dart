import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';

/// The way into the quiz from Home and Explore: a green card whose gold
/// emblem breathes gently when it appears (not when the user reduces
/// motion).
class QuizBanner extends StatefulWidget {
  const QuizBanner({super.key});

  @override
  State<QuizBanner> createState() => _QuizBannerState();
}

class _QuizBannerState extends State<QuizBanner>
    with SingleTickerProviderStateMixin {
  late final _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  var _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started || MediaQuery.disableAnimationsOf(context)) return;
    _started = true;
    _breathe(2);
  }

  /// Breathes [times] times, then rests (a loop would never let the screen
  /// settle, and would cost battery for nothing).
  Future<void> _breathe(int times) async {
    for (var i = 0; i < times && mounted; i++) {
      await _pulse.forward(from: 0).orCancel.catchError((_) {});
      if (!mounted) return;
      await _pulse.reverse().orCancel.catchError((_) {});
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Palette.green,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(AppRadii.lg),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.quiz),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [Palette.greenHigh, Palette.green],
            ),
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              ScaleTransition(
                scale: Tween(begin: 1.0, end: 1.08).animate(
                  CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
                ),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.greenHighest,
                    border: Border.all(color: Palette.goldOnInk, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.goldOnInk.withValues(alpha: 0.25),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Palette.goldOnInk,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.quizTileTitle,
                      style: textTheme.titleLarge?.copyWith(
                        color: Palette.paper,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      l10n.quizTileSubtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Palette.paperDimOnGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Palette.goldOnInk),
            ],
          ),
        ),
      ),
    );
  }
}
