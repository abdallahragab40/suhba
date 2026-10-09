import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Small key–value storage for user settings. Reads are synchronous (the
/// values are cached), so settings are ready on the first frame.
abstract interface class SettingsStore {
  String? getString(String key);
  double? getDouble(String key);
  Future<void> setString(String key, String value);
  Future<void> setDouble(String key, double value);
}

/// The app's settings store. In-memory unless bootstrap overrides it with
/// [PrefsSettingsStore], so tests need no setup.
final settingsStoreProvider = Provider<SettingsStore>(
  (ref) => MemorySettingsStore(),
);

/// Setting keys, in one place.
abstract final class SettingsKeys {
  static const themeMode = 'themeMode';
  static const digitStyle = 'digitStyle';
  static const readingTextSize = 'readingTextSize';

  /// The content build that saved items and positions were last checked
  /// against (see `reconcileUserData`).
  static const reconciledContent = 'reconciledContent';

  static const all = {
    themeMode,
    digitStyle,
    readingTextSize,
    reconciledContent,
  };
}

class MemorySettingsStore implements SettingsStore {
  final _values = <String, Object>{};

  @override
  String? getString(String key) => _values[key] as String?;

  @override
  double? getDouble(String key) => _values[key] as double?;

  @override
  Future<void> setString(String key, String value) async =>
      _values[key] = value;

  @override
  Future<void> setDouble(String key, double value) async =>
      _values[key] = value;
}

/// [SettingsStore] over shared_preferences, on the device only.
class PrefsSettingsStore implements SettingsStore {
  PrefsSettingsStore(this._prefs);

  static Future<PrefsSettingsStore> open() async => PrefsSettingsStore(
    await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: SettingsKeys.all,
      ),
    ),
  );

  final SharedPreferencesWithCache _prefs;

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  double? getDouble(String key) => _prefs.getDouble(key);

  @override
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  Future<void> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);
}
