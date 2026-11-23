import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/bootstrap.dart';
import 'package:suhba/core/error/error_reporter.dart';
import 'package:suhba/core/storage/settings_store.dart';

class _RecordingReporter implements ErrorReporter {
  final reports = <(Object, String?)>[];

  @override
  void report(Object error, StackTrace? stackTrace, {String? context}) {
    reports.add((error, context));
  }
}

void main() {
  late FlutterExceptionHandler? originalFlutterHandler;
  late ErrorCallback? originalPlatformHandler;
  late _RecordingReporter reporter;

  setUp(() {
    originalFlutterHandler = FlutterError.onError;
    originalPlatformHandler = PlatformDispatcher.instance.onError;
    reporter = _RecordingReporter();
    installErrorHandlers(reporter);
  });

  tearDown(() {
    FlutterError.onError = originalFlutterHandler;
    PlatformDispatcher.instance.onError = originalPlatformHandler;
  });

  test('framework errors are reported', () {
    // presentError would print the error; silence it for the test.
    final originalPresenter = FlutterError.presentError;
    FlutterError.presentError = (_) {};
    addTearDown(() => FlutterError.presentError = originalPresenter);

    FlutterError.onError!(
      FlutterErrorDetails(exception: StateError('layout failed')),
    );
    expect(reporter.reports, hasLength(1));
    expect(reporter.reports.single.$1, isA<StateError>());
  });

  test('platform errors are reported and marked handled', () {
    final handled = PlatformDispatcher.instance.onError!(
      StateError('async failure'),
      StackTrace.current,
    );
    expect(handled, isTrue);
    expect(reporter.reports.single.$2, 'platform');
  });

  test('settings that cannot be opened fall back to memory', () async {
    final store = await openSettingsStore(
      reporter: reporter,
      open: () => Future.error(StateError('no preferences')),
    );
    expect(store, isA<MemorySettingsStore>());
    expect(store.getString(SettingsKeys.themeMode), isNull);
    // Still usable for this run.
    await store.setString(SettingsKeys.themeMode, 'dark');
    expect(store.getString(SettingsKeys.themeMode), 'dark');
    expect(reporter.reports.single.$2, 'settings store');
  });

  test('settings that open are used as they are', () async {
    final saved = MemorySettingsStore();
    final store = await openSettingsStore(
      reporter: reporter,
      open: () async => saved,
    );
    expect(store, same(saved));
    expect(reporter.reports, isEmpty);
  });
}
