import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final device = Platform.environment['SUHBA_TEST_DEVICE'] ?? 'emulator-5554';
  final sdk =
      Platform.environment['ANDROID_HOME'] ??
      '${Platform.environment['HOME']}/Library/Android/sdk';
  final adb = '$sdk/platform-tools/adb';
  var busy = false;
  var selected = false;
  String? nonce;
  Future<String> read(List<String> args) async =>
      (await Process.run(adb, ['-s', device, ...args])).stdout as String;
  late Timer poll;
  poll = Timer.periodic(const Duration(seconds: 2), (_) async {
    if (busy || selected) return;
    busy = true;
    try {
      final pid = (await read([
        'shell',
        'pidof',
        'com.abdallahragab.suhba.integration_test',
      ])).trim();
      if (pid.isEmpty) return;
      final log = await read(['logcat', '--pid=$pid', '-d', '-s', 'flutter:I']);
      final marker = RegExp(
        r'SHARE_CARD_RECEIVER_OPEN_CHOOSER nonce=(\d+)',
      ).firstMatch(log);
      if (marker == null) return;
      nonce = marker.group(1);
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
      await read([
        'shell',
        'uiautomator',
        'dump',
        '/sdcard/suhba-probe-ui.xml',
      ]);
      final xml = await read(['shell', 'cat', '/sdcard/suhba-probe-ui.xml']);
      final node = RegExp(
        r'<node\b[^>]*(?:text|content-desc)="Suhba probe"[^>]*>',
      ).firstMatch(xml)?.group(0);
      final bounds = node == null
          ? null
          : RegExp(r'bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"').firstMatch(node);
      if (bounds != null) {
        final n = [for (var i = 1; i <= 4; i++) int.parse(bounds.group(i)!)];
        await read([
          'shell',
          'input',
          'tap',
          '${(n[0] + n[2]) ~/ 2}',
          '${(n[1] + n[3]) ~/ 2}',
        ]);
        selected = true;
        poll.cancel();
        stdout.writeln('Selected only the offline Suhba probe.');
      } else {
        final size = RegExp(
          r'(\d+)x(\d+)',
        ).firstMatch(await read(['shell', 'wm', 'size']));
        if (size != null) {
          final width = int.parse(size.group(1)!);
          final height = int.parse(size.group(2)!);
          await read([
            'shell',
            'input',
            'swipe',
            '${width ~/ 2}',
            '${height * 8 ~/ 10}',
            '${width ~/ 2}',
            '${height * 4 ~/ 10}',
            '400',
          ]);
        }
      }
    } finally {
      busy = false;
    }
  });
  await integrationDriver(
    responseDataCallback: (_) async {
      poll.cancel();
      if (!selected || nonce == null) {
        throw StateError('The offline receiver was not selected.');
      }
      final end = DateTime.now().add(const Duration(seconds: 10));
      while (DateTime.now().isBefore(end)) {
        final log = await read(['logcat', '-d', '-s', 'SuhbaShareProbe:I']);
        if (log.contains(
          'SHARE_PROBE_PASSED nonce=$nonce mime=image/png width=1080 height=1080',
        )) {
          await File('build/share-receiver-result.json').writeAsString(
            jsonEncode({
              'receiver': 'com.abdallahragab.suhba.share_probe',
              'nonce': nonce,
              'mimeType': 'image/png',
              'width': 1080,
              'height': 1080,
              'crossAppUriRead': true,
              'receiverImageSaved': false,
              'receiverNetworkPermissions': false,
            }),
          );
          await read(['shell', 'rm', '-f', '/sdcard/suhba-probe-ui.xml']);
          stdout.writeln(
            'Offline receiving app decoded the shared PNG through its granted content URI.',
          );
          return;
        }
        await Future<void>.delayed(const Duration(milliseconds: 250));
      }
      throw StateError('The receiving app did not confirm the matching PNG.');
    },
  );
}
