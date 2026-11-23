import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/geometric_pattern.dart';

/// The reference site's hero, for mobile: a green frame with a licensed
/// landscape or architecture photo under a veil, or the geometric pattern
/// when there is no photo. [child] is laid out on it in the feature theme
/// ([AppTheme.featureOf]: Madinah green by day, the deep green at night).
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
    // Madinah green by day, the deep green at night.
    final feature = AppTheme.featureOf(context);
    final ground = feature.colorScheme.surface;
    final night = identical(feature, AppTheme.featureDark);
    return DecoratedBox(
      // A hairline keeps the frame visible on the night page.
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(AppRadii.lg),
        border: Border.all(color: feature.extension<SuhbaColors>()!.line),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(AppRadii.lg),
        child: ColoredBox(
          color: ground,
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
                    child: ColoredBox(color: ground.withValues(alpha: 0.55)),
                  ),
                ] else
                  Positioned.fill(
                    child: GeometricPattern(
                      tileSize: 64,
                      // Fainter at night: an ornament, not a glow.
                      color: Palette.gold.withValues(
                        alpha: night ? 0.14 : 0.22,
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ground.withValues(alpha: 0),
                          ground.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                ),
                Theme(
                  data: feature,
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
