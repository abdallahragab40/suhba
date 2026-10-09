import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/design_system/gallery/color_swatches.dart';
import 'package:siyar_sahaba/core/design_system/gallery/core_widgets_specimen.dart';
import 'package:siyar_sahaba/core/design_system/gallery/typography_specimen.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/settings/presentation/theme_mode_controller.dart';

/// A developer-facing view of the design system in the current theme.
/// Reachable from Settings in debug builds only.
class DesignGalleryPage extends ConsumerWidget {
  const DesignGalleryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final mode = ref.watch(themeModeProvider);
    final modeLabel = switch (mode) {
      ThemeMode.system => l10n.themeModeSystem,
      ThemeMode.light => l10n.themeModeLight,
      ThemeMode.dark => l10n.themeModeDark,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.designGalleryTitle),
        actions: [
          IconButton(
            tooltip: '${l10n.changeThemeTooltip}: $modeLabel',
            icon: Icon(switch (mode) {
              ThemeMode.system => Icons.brightness_auto_outlined,
              ThemeMode.light => Icons.light_mode_outlined,
              ThemeMode.dark => Icons.dark_mode_outlined,
            }),
            onPressed: ref.read(themeModeProvider.notifier).cycle,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: const [
          CoreWidgetsSpecimen(),
          SizedBox(height: AppSpacing.xl),
          TypographySpecimen(),
          SizedBox(height: AppSpacing.lg),
          ColorSwatches(),
        ],
      ),
    );
  }
}
