import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// The app's name as a wordmark: «صُحبة», with the damma, in Amiri Bold.
/// The one form wherever the name is shown at reading size (review F18,
/// decision 6); the icon keeps its own form.
class Wordmark extends StatelessWidget {
  const Wordmark({this.size = 26, this.color, super.key});

  final double size;
  final Color? color;

  /// The most the wordmark grows with the system text size. It is a logo,
  /// already large, and sits in a fixed-height app bar: at 2× its damma
  /// would rise out of the bar into the status bar.
  static const maxScale = 1.2;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).appTitle,
      textScaler: MediaQuery.textScalerOf(
        context,
      ).clamp(maxScaleFactor: maxScale),
      style: TextStyle(
        fontFamily: AppFonts.amiri,
        fontWeight: FontWeight.w700,
        fontSize: size,
        height: 1.4,
        letterSpacing: 0,
        color: color ?? DefaultTextStyle.of(context).style.color,
      ),
    );
  }
}
