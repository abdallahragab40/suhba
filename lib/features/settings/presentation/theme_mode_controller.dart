import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/storage/settings_store.dart';

/// The selected theme mode, saved on the device. The app opens in the
/// light theme until the reader picks another (2026-11-21).
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
        defaultMode;
  }

  static const defaultMode = ThemeMode.light;

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
