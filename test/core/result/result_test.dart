import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/core/result/result.dart';

void main() {
  const failure = NotFoundFailure('missing');

  test('Ok exposes its value', () {
    const Result<int> result = Ok(3);
    expect(result.isOk, isTrue);
    expect(result.valueOrNull, 3);
    expect(result.failureOrNull, isNull);
  });

  test('Err exposes its failure', () {
    const Result<int> result = Err(failure);
    expect(result.isOk, isFalse);
    expect(result.valueOrNull, isNull);
    expect(result.failureOrNull, same(failure));
  });

  test('map transforms Ok and passes Err through', () {
    expect(const Ok(3).map((v) => v * 2).valueOrNull, 6);
    final mapped = const Err<int>(failure).map((v) => v * 2);
    expect(mapped.failureOrNull, same(failure));
  });

  test('fold picks the matching branch', () {
    expect(const Ok(3).fold((v) => 'ok $v', (f) => 'err'), 'ok 3');
    expect(
      const Err<int>(failure).fold((v) => 'ok', (f) => f.message),
      'missing',
    );
  });

  test('switch is exhaustive over Ok and Err', () {
    String describe(Result<int> r) => switch (r) {
      Ok(:final value) => 'ok $value',
      Err(:final failure) => 'err ${failure.message}',
    };
    expect(describe(const Ok(1)), 'ok 1');
    expect(describe(const Err(failure)), 'err missing');
  });

  group('guard', () {
    test('wraps a value', () async {
      final result = await Result.guard(() async => 7);
      expect(result.valueOrNull, 7);
    });

    test('turns a thrown error into an UnexpectedFailure', () async {
      final result = await Result.guard<int>(
        () async => throw StateError('boom'),
      );
      expect(result.failureOrNull, isA<UnexpectedFailure>());
      expect(result.failureOrNull!.cause, isA<StateError>());
      expect(result.failureOrNull!.stackTrace, isNotNull);
    });

    test('uses onError to choose the failure type', () async {
      final result = await Result.guard<int>(
        () async => throw const FormatException('bad json'),
        onError: (e, s) => DataFormatFailure('content', cause: e),
      );
      expect(result.failureOrNull, isA<DataFormatFailure>());
    });
  });
}
