import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/format/digits.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';
import 'package:siyar_sahaba/features/settings/presentation/digit_style_controller.dart';

/// The reading text size in logical points (before the system text scale),
/// saved on the device.
final readingTextSizeProvider =
    NotifierProvider<ReadingTextSizeController, double>(
      ReadingTextSizeController.new,
    );

class ReadingTextSizeController extends Notifier<double> {
  static const min = 16.0;
  static const max = 28.0;
  static const initial = 19.0;

  @override
  double build() =>
      ref.read(settingsStoreProvider).getDouble(SettingsKeys.readingTextSize) ??
      initial;

  void select(double size) {
    state = size.clamp(min, max).roundToDouble();
    ref
        .read(settingsStoreProvider)
        .setDouble(SettingsKeys.readingTextSize, state);
  }
}

/// The app-bar button that opens [ReadingSettingsSheet].
class ReadingSettingsButton extends StatelessWidget {
  const ReadingSettingsButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: AppLocalizations.of(context).readerSettings,
    icon: const Icon(Icons.text_fields),
    onPressed: () => showReadingSettings(context),
  );
}

Future<void> showReadingSettings(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (_) => const ReadingSettingsSheet(),
    );

/// Text size and digit style, applied live to the open reader.
class ReadingSettingsSheet extends ConsumerWidget {
  const ReadingSettingsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final size = ref.watch(readingTextSizeProvider);
    final digits = ref.watch(digitStyleProvider);
    final format = DisplayFormatter.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(l10n.readerSettings, style: textTheme.titleLarge),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.readerTextSize(format.integer(size.round())),
            style: textTheme.labelLarge,
          ),
          Slider(
            value: size,
            min: ReadingTextSizeController.min,
            max: ReadingTextSizeController.max,
            divisions:
                (ReadingTextSizeController.max - ReadingTextSizeController.min)
                    .round(),
            label: format.integer(size.round()),
            onChanged: ref.read(readingTextSizeProvider.notifier).select,
          ),
          Text(
            l10n.readerTextSample,
            style: SahabaTextStyles.of(
              context,
            ).reading.copyWith(fontSize: size),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.readerDigits, style: textTheme.labelLarge),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<DigitStyle>(
            segments: [
              ButtonSegment(
                value: DigitStyle.arabicIndic,
                label: Text(l10n.digitsArabicIndic),
              ),
              ButtonSegment(
                value: DigitStyle.western,
                label: Text(l10n.digitsWestern),
              ),
            ],
            selected: {digits},
            onSelectionChanged: (s) =>
                ref.read(digitStyleProvider.notifier).select(s.single),
          ),
        ],
      ),
    );
  }
}
