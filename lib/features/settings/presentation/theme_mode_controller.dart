import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';

/// The selected theme mode, saved on the device.
final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);

class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final saved = ref
        .read(settingsStoreProvider)
        .getString(SettingsKeys.themeMode);
    return ThemeMode.values.where((m) => m.name == saved).firstOrNull ??
        ThemeMode.system;
  }

  void select(ThemeMode mode) {
    state = mode;
    ref
        .read(settingsStoreProvider)
        .setString(SettingsKeys.themeMode, mode.name);
  }

  /// system → light → dark → system.
  void cycle() => select(switch (state) {
    ThemeMode.system => ThemeMode.light,
    ThemeMode.light => ThemeMode.dark,
    ThemeMode.dark => ThemeMode.system,
  });
}
