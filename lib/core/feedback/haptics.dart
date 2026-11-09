import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/storage/settings_store.dart';

/// Whether the app gives touch feedback (light vibrations); on by default.
/// Saved on the device. The phone's own haptics setting still applies.
final hapticsEnabledProvider = NotifierProvider<HapticsController, bool>(
  HapticsController.new,
);

class HapticsController extends Notifier<bool> {
  @override
  bool build() =>
      ref.read(settingsStoreProvider).getString(SettingsKeys.haptics) != 'off';

  void select(bool enabled) {
    state = enabled;
    ref
        .read(settingsStoreProvider)
        .setString(SettingsKeys.haptics, enabled ? 'on' : 'off');
  }
}

/// Touch feedback by meaning, so the same kind of moment always feels the
/// same. Kept quiet: a tick for choosing, a tap for doing, and a pattern
/// only for answers and achievements.
abstract final class Haptics {
  /// Moving between choices: tabs, filters, segments, slider steps.
  static void selection(BuildContext context) =>
      _play(context, HapticFeedback.selectionClick);

  /// Something done: saving, removing, undoing, moving to another passage.
  static void tap(BuildContext context) =>
      _play(context, HapticFeedback.lightImpact);

  /// A right answer: two light taps.
  static void success(BuildContext context) => _play(context, () async {
    await HapticFeedback.lightImpact();
    await Future<void>.delayed(const Duration(milliseconds: 90));
    await HapticFeedback.lightImpact();
  });

  /// A wrong answer: one firmer tap.
  static void error(BuildContext context) =>
      _play(context, HapticFeedback.mediumImpact);

  /// A finished round or a new best: a short rising pattern.
  static void celebrate(BuildContext context) => _play(context, () async {
    await HapticFeedback.lightImpact();
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.mediumImpact();
    await Future<void>.delayed(const Duration(milliseconds: 120));
    await HapticFeedback.heavyImpact();
  });

  static void _play(BuildContext context, Future<void> Function() effect) {
    final enabled = ProviderScope.containerOf(
      context,
      listen: false,
    ).read(hapticsEnabledProvider);
    if (enabled) effect().ignore();
  }
}
