import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Whether [fraction] of a passage is too little to show as a percentage:
/// under 1% reads «بدأتَ القراءة», never «قُرئ ٠٪» (decision Q4).
bool barelyStarted(double fraction) => fraction < 0.01;

/// How much of a passage was read, as the reader sees it: «قُرئ ٤٢٪», or
/// «بدأتَ القراءة» under 1%.
String readProgressLabel(
  AppLocalizations l10n,
  DisplayFormatter format,
  double fraction,
) => barelyStarted(fraction)
    ? l10n.progressJustStarted
    : l10n.progressRead(format.percent((fraction * 100).round()));
