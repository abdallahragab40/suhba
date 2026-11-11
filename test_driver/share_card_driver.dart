import 'dart:async';
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final device = Platform.environment['SUHBA_TEST_DEVICE'] ?? 'emulator-5554';
  final adb =
      '${Platform.environment['ANDROID_HOME'] ?? '${Platform.environment['HOME']}/Library/Android/sdk'}/platform-tools/adb';
  var busy = false;
  var dismissed = false;
  Future<String> read(List<String> args) async =>
      (await Process.run(adb, ['-s', device, ...args])).stdout as String;
  late Timer poll;
  poll = Timer.periodic(const Duration(seconds: 2), (_) async {
    if (busy || dismissed) return;
    busy = true;
    try {
      final pid = (await read([
        'shell',
        'pidof',
        'com.abdallahragab.suhba.integration_test',
      ])).trim();
      if (pid.isEmpty) return;
      final log = await read(['logcat', '--pid=$pid', '-d', '-s', 'flutter:I']);
      if (!log.contains('SHARE_CARD_SMOKE_OPEN_CHOOSER')) return;
      final activity = await read([
        'shell',
        'dumpsys',
        'activity',
        'activities',
      ]);
      if (!RegExp(
        r'(?:mResumedActivity|topResumedActivity)[^\n]*ChooserActivity',
      ).hasMatch(activity)) {
        return;
      }
      // Cancel only the test-owned chooser after its explicit open marker.
      await read(['shell', 'input', 'keyevent', '4']);
      dismissed = true;
      poll.cancel();
      stdout.writeln(
        'Observed and cancelled the native image chooser; no recipient selected.',
      );
    } finally {
      busy = false;
    }
  });
  await integrationDriver(
    responseDataCallback: (_) async {
      poll.cancel();
      if (!dismissed) throw StateError('The native chooser was not observed.');
    },
  );
}
