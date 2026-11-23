import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/release/android_artifact.dart';

/// Trimmed `aapt2 dump xmltree` of the 2.2.0 (code 4) bundle's manifest.
const _dump = r'''
N: android=http://schemas.android.com/apk/res/android (line=2)
  E: manifest (line=2)
    A: package="com.abdallahragab.suhba" (Raw: "com.abdallahragab.suhba")
    A: http://schemas.android.com/apk/res/android:versionCode(0x0101021b)=4 (Raw: "4")
    A: http://schemas.android.com/apk/res/android:versionName(0x0101021c)="2.2.0" (Raw: "2.2.0")
    A: http://schemas.android.com/apk/res/android:compileSdkVersion(0x01010572)=36 (Raw: "36")
      T: '\n\n    '
      E: uses-sdk (line=7)
        A: http://schemas.android.com/apk/res/android:minSdkVersion(0x0101020c)=24 (Raw: "24")
        A: http://schemas.android.com/apk/res/android:targetSdkVersion(0x01010270)=36 (Raw: "36")
      E: uses-permission (line=11)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.permission.POST_NOTIFICATIONS" (Raw: "android.permission.POST_NOTIFICATIONS")
      E: uses-permission (line=13)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.permission.RECEIVE_BOOT_COMPLETED" (Raw: "android.permission.RECEIVE_BOOT_COMPLETED")
      E: queries (line=21)
          E: intent (line=22)
              E: action (line=23)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.action.PROCESS_TEXT" (Raw: "android.intent.action.PROCESS_TEXT")
      E: permission (line=35)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.abdallahragab.suhba.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION" (Raw: "com.abdallahragab.suhba.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION")
        A: http://schemas.android.com/apk/res/android:protectionLevel(0x01010009)=0x00000002 (Raw: "signature")
      E: uses-permission (line=39)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.abdallahragab.suhba.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION" (Raw: "com.abdallahragab.suhba.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION")
      E: application (line=41)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.app.Application" (Raw: "android.app.Application")
        A: http://schemas.android.com/apk/res/android:supportsRtl(0x010103af)=true (Raw: "true")
          E: receiver (line=48)
            A: http://schemas.android.com/apk/res/android:exported(0x01010010)=false (Raw: "false")
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" (Raw: "com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver")
          E: activity (line=52)
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.abdallahragab.suhba.MainActivity" (Raw: "com.abdallahragab.suhba.MainActivity")
              E: meta-data (line=68)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="io.flutter.embedding.android.NormalTheme" (Raw: "io.flutter.embedding.android.NormalTheme")
''';

const _keytool = '''
Signer #1:

Certificate #1:
Owner: CN=Someone, O=suhba, C=EG
Certificate fingerprints:
	 SHA1: E2:9C:56:4E:FE:35:18:05:2C:57:42:DA:9B:EB:1F:CB:48:81:24:92
	 SHA256: C1:15:54:A6:0B:26:4B:AD:4D:82:FE:CF:9C:FD:C9:FE:3A:DB:EE:50:6A:37:D0:8C:B5:DA:27:13:24:42:03:34
Signature algorithm name: SHA384withRSA
''';

const _upload =
    'C1:15:54:A6:0B:26:4B:AD:4D:82:FE:CF:9C:FD:C9:FE:'
    '3A:DB:EE:50:6A:37:D0:8C:B5:DA:27:13:24:42:03:34';

void main() {
  const policy = AndroidReleasePolicy(
    minVersionCode: 4,
    minTargetSdk: 35,
    allowedPermissions: [
      'android.permission.POST_NOTIFICATIONS',
      'android.permission.RECEIVE_BOOT_COMPLETED',
      '{package}.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION',
    ],
    forbiddenComponentPrefixes: ['com.google.firebase.'],
    uploadCertificateSha256: _upload,
  );

  List<String> problems(String dump, {List<String>? signers}) =>
      androidArtifactProblems(
        manifest: parseAapt2XmlTree(dump),
        policy: policy,
        expectedVersionName: '2.2.0',
        expectedPackage: 'com.abdallahragab.suhba',
        signers: signers,
      );

  group('aapt2 xmltree', () {
    test('reads the version, SDKs, permissions and components', () {
      final facts = parseAapt2XmlTree(_dump);
      expect(facts.package, 'com.abdallahragab.suhba');
      expect(facts.versionCode, 4);
      expect(facts.versionName, '2.2.0');
      expect(facts.minSdk, 24);
      expect(facts.targetSdk, 36);
      expect(facts.debuggable, isFalse);
      expect(facts.permissions, {
        'android.permission.POST_NOTIFICATIONS',
        'android.permission.RECEIVE_BOOT_COMPLETED',
        'com.abdallahragab.suhba.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION',
      });
      // A declared <permission> and nested names are not requests or components.
      expect(facts.components, {
        'com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver',
        'com.abdallahragab.suhba.MainActivity',
      });
    });

    test('reads a debuggable application', () {
      final dump = _dump.replaceFirst(
        'supportsRtl(0x010103af)=true (Raw: "true")',
        'supportsRtl(0x010103af)=true (Raw: "true")\n'
            '        A: http://schemas.android.com/apk/res/android:debuggable'
            '(0x0101000f)=true (Raw: "true")',
      );
      expect(parseAapt2XmlTree(dump).debuggable, isTrue);
    });
  });

  group('signer', () {
    test('reads keytool and apksigner fingerprints alike', () {
      final expected = normalizeFingerprint(_upload);
      expect(parseSignerSha256(_keytool), [expected]);
      expect(
        parseSignerSha256(
          'Signer #1 certificate SHA-256 digest: ${expected.toLowerCase()}\n',
        ),
        [expected],
      );
      expect(parseSignerSha256('jar is unsigned.'), isEmpty);
    });
  });

  group('artifact problems', () {
    final upload = parseSignerSha256(_keytool);

    test('the 2.2.0 bundle shape passes', () {
      expect(problems(_dump, signers: upload), isEmpty);
    });

    test('a code below the floor fails', () {
      expect(problems(_dump.replaceAll('=4 (Raw: "4")', '=2 (Raw: "2")')), [
        contains('versionCode 2 is below 4'),
      ]);
    });

    test('versionName must match pubspec', () {
      expect(
        androidArtifactProblems(
          manifest: parseAapt2XmlTree(_dump),
          policy: policy,
          expectedVersionName: '2.3.0',
          expectedPackage: 'com.abdallahragab.suhba',
        ),
        [contains('versionName is "2.2.0", expected "2.3.0"')],
      );
    });

    test('the application ID must match the identity', () {
      expect(
        androidArtifactProblems(
          manifest: parseAapt2XmlTree(_dump),
          policy: policy,
          expectedVersionName: '2.2.0',
          expectedPackage: 'org.other.suhba',
        ),
        contains(contains('Application ID')),
      );
    });

    test('target SDK below the Play minimum fails', () {
      expect(problems(_dump.replaceAll('=36 (Raw: "36")', '=34 (Raw: "34")')), [
        contains('targetSdkVersion is 34'),
      ]);
    });

    test('INTERNET and unlisted permissions fail; nothing is required', () {
      final dump = _dump
          .replaceFirst(
            'android.permission.RECEIVE_BOOT_COMPLETED',
            'android.permission.INTERNET',
          )
          .replaceFirst(
            'android.permission.POST_NOTIFICATIONS',
            'android.permission.ACCESS_COARSE_LOCATION',
          );
      expect(
        problems(dump),
        unorderedEquals([
          contains('ACCESS_COARSE_LOCATION'),
          contains('INTERNET'),
        ]),
      );
    });

    test('forbidden components fail', () {
      final dump = _dump.replaceFirst(
        'com.abdallahragab.suhba.MainActivity',
        'com.google.firebase.provider.FirebaseInitProvider',
      );
      expect(problems(dump), [contains('FirebaseInitProvider')]);
    });

    test('a wrong, extra or missing signer fails', () {
      const other = 'AA:BB';
      expect(problems(_dump, signers: const []), [contains('not signed')]);
      expect(problems(_dump, signers: [other]), [contains('expected only')]);
      expect(problems(_dump, signers: [...upload, other]), [
        contains('expected only'),
      ]);
    });
  });

  test(
    'config/android_release.yaml parses and pins the upload certificate',
    () {
      final config = parseAndroidReleasePolicy(
        File('config/android_release.yaml').readAsStringSync(),
      );
      expect(
        normalizeFingerprint(config.uploadCertificateSha256),
        normalizeFingerprint(_upload),
      );
      expect(config.minTargetSdk, greaterThanOrEqualTo(35));
      expect(config.allowedPermissions, isNot(contains(contains('INTERNET'))));
      expect(config.allowedPermissions, isNot(contains(contains('LOCATION'))));
      expect(
        config.forbiddenComponentPrefixes,
        contains('com.google.firebase.'),
      );
    },
  );

  test('pubspec version name drops the build number', () {
    expect(pubspecVersionName('name: x\nversion: 2.2.0+4\n'), '2.2.0');
  });
}
