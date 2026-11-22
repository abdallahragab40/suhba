import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// The app's loading mark, in place of a spinner: a short gold line that
/// runs, as on the opening screen. When the reader asks for less motion it
/// says "loading" in words instead.
///
/// Note for tests: while running, it never settles, so use `pump()` rather
/// than `pumpAndSettle()`.
class BrandLoader extends StatelessWidget {
  const BrandLoader({this.width = 96, this.color, this.trackColor, super.key});

  final double width;

  /// The line and its track; the theme's accent by default.
  final Color? color, trackColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (MediaQuery.disableAnimationsOf(context)) {
      return Text(
        l10n.savedItemLoading,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: SuhbaColors.of(context).onSurfaceDim,
        ),
      );
    }
    final colors = SuhbaColors.of(context);
    final line = color ?? colors.accent;
    return Semantics(
      label: l10n.loading,
      child: SizedBox(
        width: width,
        child: LinearProgressIndicator(
          minHeight: 3,
          borderRadius: BorderRadius.circular(2),
          color: line,
          backgroundColor: trackColor ?? line.withValues(alpha: 0.18),
        ),
      ),
    );
  }
}

/// [BrandLoader] centred in the space it is given: a page still loading.
class PageLoader extends StatelessWidget {
  const PageLoader({super.key});

  @override
  Widget build(BuildContext context) => const Center(child: BrandLoader());
}
