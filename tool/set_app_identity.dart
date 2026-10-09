// Writes the app identity from config/app_identity.yaml into the Android and
// iOS build configuration.
//
//   dart run tool/set_app_identity.dart                    # regenerate
//   dart run tool/set_app_identity.dart --check            # CI: files in sync?
//   dart run tool/set_app_identity.dart --check --release  # + no placeholders
import 'dart:io';

import 'src/app_identity.dart';

void main(List<String> args) {
  final check = args.contains('--check');
  final release = args.contains('--release');

  if (!File('pubspec.yaml').existsSync()) {
    _fail('Run this from the project root.');
  }

  final AppIdentity identity;
  try {
    identity = parseAppIdentity(
      File('config/app_identity.yaml').readAsStringSync(),
    );
  } on FormatException catch (e) {
    _fail('config/app_identity.yaml: ${e.message}');
  }

  final errors = validateAppIdentity(identity, release: release);
  if (errors.isNotEmpty) _fail(errors.join('\n'));

  final outputs = {
    androidPropertiesPath: renderAndroidProperties(identity),
    iosXcconfigPath: renderIosXcconfig(identity),
  };

  if (check) {
    final stale = [
      for (final MapEntry(:key, :value) in outputs.entries)
        if (!File(key).existsSync() || File(key).readAsStringSync() != value)
          key,
    ];
    if (stale.isNotEmpty) {
      _fail(
        'Out of date (run dart run tool/set_app_identity.dart):\n'
        '${stale.join('\n')}',
      );
    }
    stdout.writeln('App identity is in sync.');
    return;
  }

  for (final MapEntry(:key, :value) in outputs.entries) {
    File(key).writeAsStringSync(value);
    stdout.writeln('Wrote $key');
  }
}

Never _fail(String message) {
  stderr.writeln(message);
  exit(1);
}
