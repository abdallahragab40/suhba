import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/app/app.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/core/error/app_error_widget.dart';
import 'package:suhba/core/error/error_reporter.dart';
import 'package:suhba/core/storage/settings_store.dart';

/// Starts the app: installs the global error handlers
/// and runs [SuhbaApp] in a [ProviderScope].
///
/// Settings are loaded before the first frame (so the theme never flashes);
/// the database opens lazily on first use.
Future<void> bootstrap({
  ErrorReporter reporter = const DebugErrorReporter(),
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  installErrorHandlers(reporter);

  final settings = await PrefsSettingsStore.open();

  runApp(
    ProviderScope(
      retry: noAutomaticRetry,
      overrides: [settingsStoreProvider.overrideWithValue(settings)],
      child: const SuhbaApp(),
    ),
  );
}

/// Routes framework and platform errors to [reporter] instead of crashing
/// or blanking the screen.
@visibleForTesting
void installErrorHandlers(ErrorReporter reporter) {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    reporter.report(
      details.exception,
      details.stack,
      context: details.context?.toDescription() ?? 'flutter',
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    reporter.report(error, stackTrace, context: 'platform');
    return true; // Handled: keep the app running.
  };

  // Keep the debug red screen for developers; show a quiet placeholder to
  // users.
  if (kReleaseMode) {
    ErrorWidget.builder = (_) => const AppErrorWidget();
  }
}
