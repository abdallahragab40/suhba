import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/app/reconciliation/user_data_reconciliation.dart';
import 'package:siyar_sahaba/app/router/app_router.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/settings/presentation/digit_style_controller.dart';
import 'package:siyar_sahaba/features/settings/presentation/theme_mode_controller.dart';

/// The app is Arabic-first: the locale is fixed to Arabic (and so RTL)
/// whatever the device language. English strings exist for later use.
const appLocale = Locale('ar');

class SiyarApp extends ConsumerWidget {
  const SiyarApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final digitStyle = ref.watch(digitStyleProvider);
    // Check saved items and positions against the content once per build
    // of the content. Listening starts it; the work happens in the provider.
    ref.listen(userDataReconciliationProvider, (_, next) {
      if (next case AsyncError(:final error, :final stackTrace)) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stackTrace,
            library: 'user data reconciliation',
          ),
        );
      }
    });

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      locale: appLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ref.watch(themeModeProvider),
      routerConfig: ref.watch(appRouterProvider),
      builder: (context, child) => DisplayFormatterScope(
        formatter: DisplayFormatter(AppLocalizations.of(context), digitStyle),
        child: child!,
      ),
    );
  }
}
