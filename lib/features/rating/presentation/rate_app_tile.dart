import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/rating/presentation/rating_providers.dart';

/// Settings: opens the app's Google Play page to rate it. Android only
/// until the app has an App Store page.
class RateAppTile extends ConsumerWidget {
  const RateAppTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.star_outline),
      title: Text(l10n.rateAppTitle),
      subtitle: Text(l10n.rateAppHint),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => ref.read(ratingServiceProvider).openStoreListing(),
    );
  }
}
