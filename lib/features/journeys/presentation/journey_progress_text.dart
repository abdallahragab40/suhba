import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// "أنجزت ٣ من ١٤ خطوة", or "لم تبدأ بعد، ١٤ خطوة" when nothing is done:
/// zero is written in words, never as ٠ (review F06).
String journeyProgressText(
  AppLocalizations l10n,
  DisplayFormatter format, {
  required int done,
  required int total,
}) => done == 0
    ? l10n.journeyNotStarted(total, format.integer(total))
    : l10n.journeyProgress(format.integer(done), total, format.integer(total));
