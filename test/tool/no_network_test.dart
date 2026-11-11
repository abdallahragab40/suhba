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

  // The feedback tile hands a mailto link to the user's mail app; the app
  // itself sends nothing. It is the only place allowed to use url_launcher.
  const feedbackTile = 'lib/features/settings/presentation/feedback_tile.dart';

  test('no app code opens network connections', () {
    final network = RegExp(
      r'''HttpClient|WebSocket|Socket\.connect|package:http/|package:dio/'''
      r'''|NetworkImage|Image\.network''',
    );
    final launcher = RegExp('package:url_launcher/');
    final offenders = [
      for (final f in Directory('lib').listSync(recursive: true))
        if (f is File && f.path.endsWith('.dart'))
          if (network.hasMatch(f.readAsStringSync()) ||
              (launcher.hasMatch(f.readAsStringSync()) &&
                  f.path != feedbackTile))
            f.path,
    ];
    expect(offenders, isEmpty);
  });

  test('the feedback tile launches only a mailto link', () {
    final source = File(feedbackTile).readAsStringSync();
    expect(source, contains("scheme: 'mailto'"));
    expect(source, isNot(contains('http')));
    expect(RegExp(r'launchUrl\(').allMatches(source), hasLength(1));
  });
}
