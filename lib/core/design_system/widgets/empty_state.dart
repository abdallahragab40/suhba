import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/widgets/geometric_pattern.dart';

/// A calm, centred message for empty lists and screens, with an icon set in
/// a small medallion of the geometric pattern.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    this.message,
    this.icon,
    this.action,
    super.key,
  });

  final String title;
  final String? message;
  final IconData? icon;

  /// Usually a button.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = SahabaColors.of(context);
    final icon = this.icon;
    final message = this.message;
    final action = this.action;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                SizedBox.square(
                  dimension: 96,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: ClipOval(
                          child: GeometricPattern(
                            tileSize: 24,
                            color: colors.accent.withValues(alpha: 0.35),
                          ),
                        ),
                      ),
                      Icon(icon, size: 36, color: colors.onSurfaceDim),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  message,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceDim,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: AppSpacing.lg),
                action,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
