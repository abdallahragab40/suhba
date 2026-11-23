import 'package:flutter/foundation.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// The footer of a shared card: the app's name, and the store it can be
/// found in where it is published there (Google Play, on Android). On
/// other platforms no store is named.
String shareCardFooter(AppLocalizations l10n, {TargetPlatform? platform}) =>
    l10n.shareCardFooter(
      (platform ?? defaultTargetPlatform) == TargetPlatform.android
          ? 'googlePlay'
          : 'other',
    );
