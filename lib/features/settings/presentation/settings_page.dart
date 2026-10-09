import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/format/digits.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/settings/presentation/digit_style_controller.dart';
import 'package:siyar_sahaba/features/settings/presentation/personal_data_section.dart';
import 'package:siyar_sahaba/features/settings/presentation/reading_settings.dart';
import 'package:siyar_sahaba/features/settings/presentation/theme_mode_controller.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// Settings (S12): appearance, reading, and about the content. Everything is
/// saved on the device.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final mode = ref.watch(themeModeProvider);
    final digits = ref.watch(digitStyleProvider);
    final size = ref.watch(readingTextSizeProvider);
    final manifest = ref.watch(contentManifestProvider).value;

    Widget group(String title) => Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSpacing.lg,
        bottom: AppSpacing.xs,
      ),
      child: Semantics(
        header: true,
        child: Text(title, style: SahabaTextStyles.of(context).kicker),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabSettings)),
      body: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.xxl,
        ),
        children: [
          group(l10n.settingsAppearance),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text(l10n.themeModeSystem),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text(l10n.themeModeLight),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text(l10n.themeModeDark),
              ),
            ],
            selected: {mode},
            onSelectionChanged: (s) =>
                ref.read(themeModeProvider.notifier).select(s.single),
          ),
          group(l10n.settingsReading),
          Text(l10n.readerTextSize(format.integer(size.round()))),
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
          const SizedBox(height: AppSpacing.md),
          Text(l10n.readerDigits),
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
          group(l10n.settingsYourData),
          const PersonalDataSection(),
          group(l10n.settingsContent),
          if (manifest != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.inventory_2_outlined),
              title: Text(
                // A technical identifier: never localised.
                l10n.settingsContentVersion(manifest.contentVersion),
              ),
              subtitle: Text(
                manifest.isDraft
                    ? l10n.settingsChannelDraft
                    : l10n.settingsChannelPublished,
              ),
            ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.settingsAbout),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(AppRoutes.about),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.menu_book_outlined),
            title: Text(l10n.settingsSources),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(AppRoutes.sourcesDirectory),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.gavel_outlined),
            title: Text(l10n.settingsLicenses),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showLicensePage(
              context: context,
              applicationName: l10n.appTitle,
              applicationVersion: manifest?.contentVersion,
            ),
          ),
          if (kDebugMode)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.palette_outlined),
              title: Text(l10n.designGalleryTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(AppRoutes.designGallery),
            ),
        ],
      ),
    );
  }
}
