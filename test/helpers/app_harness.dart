import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:siyar_sahaba/app/app.dart';
import 'package:siyar_sahaba/app/provider_retry.dart';
import 'package:siyar_sahaba/app/router/app_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/database/app_database.dart';
import 'package:siyar_sahaba/core/database/database_provider.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

import 'content_bundle.dart';

/// The whole app at [location], reading content from [bundle] (the
/// committed draft build by default).
class AppUnderTest {
  AppUnderTest({
    String location = AppRoutes.home,
    AssetBundle? bundle,
    AppDatabase? database,
    SettingsStore? settings,
    DateTime? now,
    List<Override> overrides = const [],
  }) : router = buildAppRouter(initialLocation: location),
       bundle = bundle ?? MemoryAssetBundle.builtContent(),
       database = database ?? AppDatabase(NativeDatabase.memory()) {
    // Each test opens its own in-memory database.
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    _live.add(this);
    container = ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [
        appRouterProvider.overrideWithValue(router),
        assetBundleProvider.overrideWithValue(this.bundle),
        // The fake clock never delivers a background isolate's result.
        contentIsolateThresholdProvider.overrideWithValue(null),
        appDatabaseProvider.overrideWithValue(this.database),
        if (settings != null) settingsStoreProvider.overrideWithValue(settings),
        // A fixed day, so the companion of the day is predictable.
        clockProvider.overrideWithValue(() => now ?? DateTime(2026, 10, 9)),
        // Test-specific overrides last, e.g. a failing repository.
        ...overrides,
      ],
    );
  }

  final GoRouter router;
  final AssetBundle bundle;

  /// In-memory by default; pass one to keep data across two app runs.
  final AppDatabase database;
  late final ProviderContainer container;

  Widget get widget =>
      UncontrolledProviderScope(container: container, child: const SiyarApp());

  /// Pumps the app and lets content load. Use inside [testApp], which
  /// disposes the app and closes its database when the test ends.
  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  bool _disposed = false;

  Future<void> _dispose() async {
    if (_disposed) return;
    _disposed = true;
    container.dispose();
    router.dispose();
  }

  /// The location of the top-most route, including pushed routes.
  String get location => router.state.uri.toString();
}

final _live = <AppUnderTest>[];

/// A widget test of the whole app. After [body] (pass or fail) the app is
/// unmounted, its providers disposed and its database closed, while still
/// on the test's fake clock, as Drift requires: closing in a tear-down
/// would wait on timers that never fire.
@isTest
void testApp(
  String description,
  Future<void> Function(WidgetTester tester) body, {
  Timeout? timeout,
}) {
  testWidgets(description, (tester) async {
    try {
      await body(tester);
    } finally {
      final apps = [..._live];
      _live.clear();
      if (apps.isNotEmpty) {
        await tester.pumpWidget(const SizedBox.shrink());
        for (final app in apps) {
          await app._dispose();
        }
        // Cancelling Drift streams schedules timers that close() waits for;
        // on the fake clock they only fire as time is pumped forward.
        for (final db in {for (final app in apps) app.database}) {
          var closed = false;
          unawaited(db.close().then((_) => closed = true));
          for (var i = 0; i < 50 && !closed; i++) {
            await tester.pump(const Duration(milliseconds: 20));
          }
        }
      }
    }
  }, timeout: timeout);
}
