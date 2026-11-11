import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/storage/settings_store.dart';

/// Whether the app shows its welcome screens at all. Tests turn them off
/// unless they are about them.
final welcomeEnabledProvider = Provider<bool>((ref) => true);

/// What the welcome screens show, if anything.
enum WelcomeMode {
  /// Seen (or skipped): the app opens directly.
  hidden,

  /// First launch: every welcome page.
  full,

  /// Upgraded from 1.0, whose welcome screens came before journeys: only
  /// the page about what is new.
  whatsNew,
}

/// The welcome screens: on the first launch, or once after the upgrade
/// from 1.0, until they are finished or skipped.
final welcomeProvider = NotifierProvider<WelcomeController, WelcomeMode>(
  WelcomeController.new,
);

class WelcomeController extends Notifier<WelcomeMode> {
  /// Stored once the current welcome screens are seen.
  static const seen = '2';

  /// Stored by 1.0, whose welcome screens had no journeys page.
  static const seenBeforeJourneys = '1';

  @override
  WelcomeMode build() {
    if (!ref.watch(welcomeEnabledProvider)) return WelcomeMode.hidden;
    return switch (ref
        .watch(settingsStoreProvider)
        .getString(SettingsKeys.welcomeSeen)) {
      null => WelcomeMode.full,
      seenBeforeJourneys => WelcomeMode.whatsNew,
      _ => WelcomeMode.hidden,
    };
  }

  /// Hides the welcome screens for good.
  Future<void> finish() async {
    state = WelcomeMode.hidden;
    await ref
        .read(settingsStoreProvider)
        .setString(SettingsKeys.welcomeSeen, seen);
  }
}
