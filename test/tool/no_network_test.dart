import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The app works offline and sends nothing anywhere; the privacy text relies
/// on it. These guard against a network capability creeping in.
void main() {
  test('the release Android manifest does not request network access', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();
    expect(manifest, isNot(contains('android.permission.INTERNET')));
  });

  test('no app code opens network connections', () {
    final network = RegExp(
      r'''HttpClient|WebSocket|Socket\.connect|package:http/|package:dio/'''
      r'''|package:url_launcher/|NetworkImage|Image\.network''',
    );
    final offenders = [
      for (final f in Directory('lib').listSync(recursive: true))
        if (f is File &&
            f.path.endsWith('.dart') &&
            network.hasMatch(f.readAsStringSync()))
          f.path,
    ];
    expect(offenders, isEmpty);
  });
}
