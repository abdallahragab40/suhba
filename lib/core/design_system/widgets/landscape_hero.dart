import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/widgets/geometric_pattern.dart';

/// The reference site's hero, for mobile: an ink frame with a licensed
/// landscape or architecture photo under a veil, or the geometric pattern
/// when there is no photo. [child] is laid out on it in the dark theme.
///
/// Never a depiction of a person: photos must be listed, with their licence,
/// in assets/images/credits.json.
class LandscapeHero extends StatelessWidget {
  const LandscapeHero({
    required this.child,
    this.imageAsset,
    this.minHeight = 220,
    super.key,
  });

  final Widget child;

  /// An asset under assets/images/; the pattern is used when null.
  final String? imageAsset;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final image = imageAsset;
    return DecoratedBox(
      // A hairline keeps the frame visible on the ink background (dark mode).
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(AppRadii.lg),
        border: Border.all(color: Palette.lineOnGreen),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(AppRadii.lg),
        child: ColoredBox(
          color: Palette.green,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Stack(
              children: [
                if (image != null) ...[
                  Positioned.fill(
                    child: ExcludeSemantics(
                      child: Image.asset(image, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned.fill(
                    child: ColoredBox(
                      color: Palette.green.withValues(alpha: 0.55),
                    ),
                  ),
                ] else
                  Positioned.fill(
                    child: GeometricPattern(
                      tileSize: 64,
                      color: Palette.gold.withValues(alpha: 0.22),
                    ),
                  ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Palette.green.withValues(alpha: 0),
                          Palette.green.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                ),
                Theme(
                  data: AppTheme.feature,
                  child: Builder(
                    builder: (context) => DefaultTextStyle.merge(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
