/// An expected failure, returned (not thrown) by repositories. It is an
/// [Exception] so that providers can rethrow it into an `AsyncValue.error`.
sealed class Failure implements Exception {
  const Failure(this.message, {this.cause, this.stackTrace});

  /// Developer-facing description; never shown to users as is.
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => '$runtimeType: $message';
}

/// The requested item does not exist (e.g. an outdated deep link).
final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.cause, super.stackTrace});
}

/// Bundled or stored data could not be read or did not match its schema.
final class DataFormatFailure extends Failure {
  const DataFormatFailure(super.message, {super.cause, super.stackTrace});
}

/// The local database or preferences store failed.
final class StorageFailure extends Failure {
  const StorageFailure(super.message, {super.cause, super.stackTrace});
}

/// Anything else.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.cause, super.stackTrace});
}

/// Data is in a format this version of the app cannot read, e.g. content
/// built for a newer app. Retrying will not help; updating the app will.
final class UnsupportedFormatFailure extends Failure {
  const UnsupportedFormatFailure(
    super.message, {
    required this.found,
    required this.supported,
    super.cause,
    super.stackTrace,
  });

  final int found;
  final Set<int> supported;
}
