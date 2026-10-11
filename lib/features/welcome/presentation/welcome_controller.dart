import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';

/// Whether the app shows its welcome screens at all. Tests turn them off
/// unless they are about them.
final welcomeEnabledProvider = Provider<bool>((ref) => true);

/// Whether the welcome screens are showing: on the first launch only,
/// until they are finished or skipped.
final welcomeProvider = NotifierProvider<WelcomeController, bool>(
  WelcomeController.new,
);

class WelcomeController extends Notifier<bool> {
  @override
  bool build() =>
      ref.watch(welcomeEnabledProvider) &&
      ref.watch(settingsStoreProvider).getString(SettingsKeys.welcomeSeen) ==
          null;

  /// Hides the welcome screens for good.
  Future<void> finish() async {
    state = false;
    await ref
        .read(settingsStoreProvider)
        .setString(SettingsKeys.welcomeSeen, '1');
  }
}
