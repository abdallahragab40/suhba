import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/settings/presentation/theme_mode_controller.dart';

void main() {
  test('a first launch opens in the light theme', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(themeModeProvider), ThemeMode.light);
  });

  test('a saved choice wins over the default', () {
    final store = MemorySettingsStore()
      ..setString(SettingsKeys.themeMode, ThemeMode.system.name);
    final container = ProviderContainer(
      overrides: [settingsStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);
    expect(container.read(themeModeProvider), ThemeMode.system);
  });
}
