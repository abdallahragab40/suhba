import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// The way into the quiz from Home and Explore: a green card (the feature
/// green, deep at night) whose gold emblem breathes gently when it appears
/// (not when the user reduces motion).
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
    final feature = AppTheme.featureOf(context);
    final scheme = feature.colorScheme;
    final colors = feature.extension<SuhbaColors>()!;
    final textTheme = Theme.of(context).textTheme;
    // The emblem's halo is a day-time flourish; at night it would glare.
    final halo = !identical(feature, AppTheme.featureDark);
    return Material(
      color: scheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(AppRadii.lg),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.quiz),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [scheme.surfaceContainerHigh, scheme.surface],
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
                    color: scheme.surfaceContainerHighest,
                    border: Border.all(color: colors.accent, width: 1.5),
                    boxShadow: [
                      if (halo)
                        BoxShadow(
                          color: colors.accent.withValues(alpha: 0.25),
                          blurRadius: 14,
                        ),
                    ],
                  ),
                  child: Icon(Icons.auto_awesome, color: colors.accent),
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
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      l10n.quizTileSubtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceDim,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.accent),
            ],
          ),
        ),
      ),
    );
  }
}
