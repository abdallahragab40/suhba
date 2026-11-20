import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';

/// About credits every bundled third-party resource (review K10). When a
/// font or an image is added to the bundle, this fails until About names
/// it.
void main() {
  /// How About writes a pubspec font family.
  const displayNames = {
    'IBMPlexSansArabic': 'IBM Plex Sans Arabic',
    'Amiri': 'Amiri',
    'AmiriQuran': 'Amiri Quran',
  };

  Future<String> aboutText(WidgetTester tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 6000);
    addTearDown(tester.view.reset);
    await AppUnderTest(location: '/settings/about').pump(tester);
    return [
      for (final t in tester.widgetList<Text>(find.byType(Text)))
        t.data ?? t.textSpan?.toPlainText() ?? '',
    ].join('\n');
  }

  testApp('every bundled font family is credited, with its licence', (
    tester,
  ) async {
    final families = RegExp(r'^\s+- family: (\S+)$', multiLine: true)
        .allMatches(File('pubspec.yaml').readAsStringSync())
        .map((m) => m.group(1)!)
        .toList();
    expect(families, isNotEmpty);
    final text = await aboutText(tester);
    for (final family in families) {
      final name = displayNames[family];
      expect(name, isNotNull, reason: 'add $family to displayNames');
      expect(text, contains(name), reason: family);
    }
    expect(text, contains('SIL OFL 1.1'));
    expect(text, contains('tanzil.net'));
  });

  testApp('every bundled image is credited', (tester) async {
    final credits =
        jsonDecode(File('assets/images/credits.json').readAsStringSync())
            as Map<String, Object?>;
    final images = (credits['images']! as List).cast<Map<String, Object?>>();
    final text = await aboutText(tester);
    for (final image in images) {
      final credit = image['author'] ?? image['credit'] ?? image['source'];
      expect(credit, isA<String>(), reason: '$image has no credit');
      expect(text, contains(credit! as String), reason: '$image');
    }
  });
}
