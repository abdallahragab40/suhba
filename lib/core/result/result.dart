import 'package:siyar_sahaba/core/result/failure.dart';

/// The outcome of an operation that can fail in an expected way: either
/// [Ok] with a value or [Err] with a [Failure]. Use a `switch` to handle
/// both cases.
sealed class Result<T> {
  const Result();

  /// Runs [body] and wraps its value, or turns a thrown error into a
  /// [Failure] (an [UnexpectedFailure] unless [onError] says otherwise).
  static Future<Result<T>> guard<T>(
    Future<T> Function() body, {
    Failure Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      return Ok(await body());
    } on Object catch (error, stackTrace) {
      return Err(
        onError?.call(error, stackTrace) ??
            UnexpectedFailure('$error', cause: error, stackTrace: stackTrace),
      );
    }
  }

  bool get isOk => this is Ok<T>;

  T? get valueOrNull => switch (this) {
    Ok(:final value) => value,
    Err() => null,
  };

  Failure? get failureOrNull => switch (this) {
    Ok() => null,
    Err(:final failure) => failure,
  };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Ok(:final value) => Ok(transform(value)),
    Err(:final failure) => Err(failure),
  };

  /// The value, or throws the [Failure] (for use inside providers, where it
  /// becomes an `AsyncValue.error`).
  T getOrThrow() => switch (this) {
    Ok(:final value) => value,
    Err(:final failure) => throw failure,
  };

  R fold<R>(R Function(T value) onOk, R Function(Failure failure) onErr) =>
      switch (this) {
        Ok(:final value) => onOk(value),
        Err(:final failure) => onErr(failure),
      };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
