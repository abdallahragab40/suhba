import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/feedback/haptics.dart';
import 'package:suhba/core/format/digits.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/settings/presentation/digit_style_controller.dart';

/// The reading text size in logical points (before the system text scale),
/// saved on the device.
final readingTextSizeProvider =
    NotifierProvider<ReadingTextSizeController, double>(
      ReadingTextSizeController.new,
    );

class ReadingTextSizeController extends Notifier<double> {
  static const min = 16.0;
  static const max = 28.0;
  static const initial = SuhbaTextStyles.readingSize;

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

/// The readers' page: the app's own theme, or warm paper (review K5).
enum ReaderTone { app, warmPaper }

final readerToneProvider = NotifierProvider<ReaderToneController, ReaderTone>(
  ReaderToneController.new,
);

class ReaderToneController extends Notifier<ReaderTone> {
  @override
  ReaderTone build() {
    final saved = ref
        .read(settingsStoreProvider)
        .getString(SettingsKeys.readerTone);
    return ReaderTone.values.where((t) => t.name == saved).firstOrNull ??
        ReaderTone.app;
  }

  void select(ReaderTone tone) {
    state = tone;
    ref
        .read(settingsStoreProvider)
        .setString(SettingsKeys.readerTone, tone.name);
  }
}

/// [child] in the readers' chosen tone.
class ReaderToneScope extends ConsumerWidget {
  const ReaderToneScope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      switch (ref.watch(readerToneProvider)) {
        ReaderTone.app => child,
        // The warm tone follows the theme: warm paper by day, warm night
        // in the dark theme, so a reader never flashes bright at night.
        ReaderTone.warmPaper => Theme(
          data: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.warmNight
              : AppTheme.warmPaper,
          child: child,
        ),
      };
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
    final tone = ref.watch(readerToneProvider);
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
            onChanged: (v) {
              if (v != size) Haptics.selection(context);
              ref.read(readingTextSizeProvider.notifier).select(v);
            },
          ),
          Text(
            l10n.readerTextSample,
            style: SuhbaTextStyles.of(context).reading.copyWith(fontSize: size),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.readerTone, style: textTheme.labelLarge),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<ReaderTone>(
            segments: [
              ButtonSegment(
                value: ReaderTone.app,
                label: Text(l10n.readerToneApp),
              ),
              ButtonSegment(
                value: ReaderTone.warmPaper,
                label: Text(
                  Theme.of(context).brightness == Brightness.dark
                      ? l10n.readerToneWarmNight
                      : l10n.readerToneWarmPaper,
                ),
              ),
            ],
            selected: {tone},
            onSelectionChanged: (s) {
              Haptics.selection(context);
              ref.read(readerToneProvider.notifier).select(s.single);
            },
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
            onSelectionChanged: (s) {
              Haptics.selection(context);
              ref.read(digitStyleProvider.notifier).select(s.single);
            },
          ),
        ],
      ),
    );
  }
}
