import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/format/digits.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';

/// The digit style for the UI; Arabic-Indic by default. Saved on the device.
final digitStyleProvider = NotifierProvider<DigitStyleController, DigitStyle>(
  DigitStyleController.new,
);

class DigitStyleController extends Notifier<DigitStyle> {
  @override
  DigitStyle build() {
    final saved = ref
        .read(settingsStoreProvider)
        .getString(SettingsKeys.digitStyle);
    return DigitStyle.values.where((s) => s.name == saved).firstOrNull ??
        DigitStyle.arabicIndic;
  }

  void select(DigitStyle style) {
    state = style;
    ref
        .read(settingsStoreProvider)
        .setString(SettingsKeys.digitStyle, style.name);
  }
}
