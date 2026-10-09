import 'package:flutter/foundation.dart';

/// Where uncaught errors go. The MVP sends nothing off the device: errors
/// are only printed in debug builds. A crash reporter can implement this
/// later.
abstract interface class ErrorReporter {
  void report(Object error, StackTrace? stackTrace, {String? context});
}

class DebugErrorReporter implements ErrorReporter {
  const DebugErrorReporter();

  @override
  void report(Object error, StackTrace? stackTrace, {String? context}) {
    if (!kDebugMode) return;
    debugPrint('[${context ?? 'error'}] $error');
    if (stackTrace != null) debugPrintStack(stackTrace: stackTrace);
  }
}
