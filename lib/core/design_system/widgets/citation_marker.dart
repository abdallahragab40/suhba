import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// A small numbered marker after a claim that opens its sources. The
/// visible circle is small; the tap target is the full 48 × 48.
class CitationMarker extends StatelessWidget {
  const CitationMarker({
    required this.count,
    required this.onPressed,
    super.key,
  });

  /// How many sources the claim has.
  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final formatted = DisplayFormatter.of(context).integer(count);
    final size = MediaQuery.textScalerOf(context).scale(22);
    return Semantics(
      button: true,
      label: AppLocalizations.of(context).citationsButton(formatted),
      excludeSemantics: true,
      child: InkResponse(
        onTap: onPressed,
        radius: 24,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: Center(
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colors.accentText),
              ),
              child: Text(
                formatted,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: colors.accentText),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
