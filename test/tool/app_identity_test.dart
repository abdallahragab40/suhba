import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/app_identity.dart';

void main() {
  const valid = AppIdentity(
    displayName: 'سِيَر الصحابة',
    androidApplicationId: 'org.publisher.siyar',
    iosBundleId: 'org.publisher.siyar',
  );

  AppIdentity withIds({String? android, String? ios, String? name}) {
    return AppIdentity(
      displayName: name ?? valid.displayName,
      androidApplicationId: android ?? valid.androidApplicationId,
      iosBundleId: ios ?? valid.iosBundleId,
    );
  }

  group('parseAppIdentity', () {
    test('reads all keys and trims them', () {
      final identity = parseAppIdentity('''
displayName: " سِيَر الصحابة "
androidApplicationId: org.publisher.siyar
iosBundleId: org.publisher.siyar
''');
      expect(identity.displayName, 'سِيَر الصحابة');
      expect(identity.androidApplicationId, 'org.publisher.siyar');
      expect(identity.iosBundleId, 'org.publisher.siyar');
    });

    test('rejects a missing key', () {
      expect(
        () => parseAppIdentity('displayName: x\nandroidApplicationId: a.b'),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects a non-map document', () {
      expect(() => parseAppIdentity('- a'), throwsA(isA<FormatException>()));
    });

    test('the committed config parses and is valid for development', () {
      final identity = parseAppIdentity(
        File('config/app_identity.yaml').readAsStringSync(),
      );
      expect(validateAppIdentity(identity), isEmpty);
    });
  });

  group('validateAppIdentity', () {
    test('accepts a valid identity, also for release', () {
      expect(validateAppIdentity(valid), isEmpty);
      expect(validateAppIdentity(valid, release: true), isEmpty);
    });

    test('rejects malformed Android IDs', () {
      for (final id in [
        'siyar',
        'org.1publisher.siyar',
        'org..siyar',
        'a-b.c',
      ]) {
        expect(
          validateAppIdentity(withIds(android: id)),
          hasLength(1),
          reason: id,
        );
      }
    });

    test('rejects malformed iOS IDs, including underscores', () {
      for (final id in ['siyar', 'org.publisher_x.siyar', 'org.pub lisher']) {
        expect(validateAppIdentity(withIds(ios: id)), hasLength(1), reason: id);
      }
    });

    test('rejects display names that would need escaping', () {
      for (final name in ['A & B', "Ali's", r'C:\x', 'a/b', r'$(X)']) {
        expect(
          validateAppIdentity(withIds(name: name)),
          hasLength(1),
          reason: name,
        );
      }
    });

    test('placeholders pass in development and fail for release', () {
      final placeholder = withIds(
        android: 'com.example.siyarsahaba',
        ios: 'com.example.siyarsahaba',
      );
      expect(validateAppIdentity(placeholder), isEmpty);
      expect(validateAppIdentity(placeholder, release: true), hasLength(2));
    });

    test('a prefix that only looks like the placeholder is fine', () {
      final id = withIds(
        android: 'com.examples.siyar',
        ios: 'com.examples.siyar',
      );
      expect(validateAppIdentity(id, release: true), isEmpty);
    });
  });

  group('rendering', () {
    test('Android properties carry the ID and the Arabic name', () {
      final out = renderAndroidProperties(valid);
      expect(out, contains('applicationId=org.publisher.siyar\n'));
      expect(out, contains('appName=سِيَر الصحابة\n'));
      expect(out, startsWith('# GENERATED'));
    });

    test('iOS xcconfig carries the ID and the Arabic name', () {
      final out = renderIosXcconfig(valid);
      expect(out, contains('APP_BUNDLE_ID = org.publisher.siyar\n'));
      expect(out, contains('APP_DISPLAY_NAME = سِيَر الصحابة\n'));
      expect(out, startsWith('// GENERATED'));
    });

    test('the committed platform files match the committed config', () {
      final identity = parseAppIdentity(
        File('config/app_identity.yaml').readAsStringSync(),
      );
      expect(
        File(androidPropertiesPath).readAsStringSync(),
        renderAndroidProperties(identity),
      );
      expect(
        File(iosXcconfigPath).readAsStringSync(),
        renderIosXcconfig(identity),
      );
    });
  });
}
