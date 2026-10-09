import 'dart:io';

import 'package:siyar_sahaba/shared/content/domain/review.dart';

/// `--name=value` → value, or null.
String? option(List<String> args, String name) {
  for (final arg in args) {
    if (arg.startsWith('--$name=')) return arg.substring(name.length + 3);
  }
  return null;
}

/// `--channel=draft|published` (default draft).
ContentChannel channelOption(List<String> args) {
  final value = option(args, 'channel') ?? 'draft';
  return ContentChannel.values.firstWhere(
    (c) => c.name == value,
    orElse: () => fail('Unknown channel "$value" (use draft or published).'),
  );
}

void requireProjectRoot() {
  if (!File('pubspec.yaml').existsSync() ||
      !Directory('content').existsSync()) {
    fail('Run this from the project root (it needs content/).');
  }
}

Never fail(String message) {
  stderr.writeln(message);
  exit(1);
}
