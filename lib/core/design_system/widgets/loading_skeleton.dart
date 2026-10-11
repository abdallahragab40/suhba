import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/motion.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Placeholder bars shown while content loads: a title bar and [lines] text
/// bars. Pulses gently, or stays still when the user asks to reduce motion.
///
/// Note for tests: while pulsing, the animation never settles, so use
/// `pump()` rather than `pumpAndSettle()`.
class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({this.lines = 3, this.showTitle = true, super.key});

  final int lines;
  final bool showTitle;

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
    lowerBound: 0.45,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      _controller.value = 1;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHigh;
    final lineHeight = MediaQuery.textScalerOf(context).scale(12);

    Widget bar(double widthFactor, double height) => Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: widthFactor,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(AppRadii.sm),
          ),
        ),
      ),
    );

    return Semantics(
      label: AppLocalizations.of(context).loading,
      child: ExcludeSemantics(
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: _controller,
            curve: AppMotion.easeStandard,
          ),
          // A placeholder may be taller than a short screen (a phone on its
          // side); it is cut off rather than overflowing.
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showTitle) ...[
                  bar(0.6, lineHeight * 2),
                  const SizedBox(height: AppSpacing.xs),
                ],
                for (var i = 0; i < widget.lines; i++)
                  bar(i == widget.lines - 1 ? 0.7 : 1, lineHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
