import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/shared/content/providers.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/content_bundle.dart';

/// E2 (review A2): every biography opens with «في سطور», three to five
/// cited sentences from the text, each leading to its section.
void main() {
  test('all 47 companions have three to five overview sentences', () async {
    final container = ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [
        assetBundleProvider.overrideWithValue(MemoryAssetBundle.builtContent()),
      ],
    );
    addTearDown(container.dispose);
    final index = await container.read(companionIndexProvider.future);
    expect(index, hasLength(47));
    for (final s in index) {
      final c = await container.read(companionProvider(s.id).future);
      expect(c.overview.length, inInclusiveRange(3, 5), reason: s.id);
      for (final f in c.overview) {
        expect(f.citations, isNotEmpty, reason: s.id);
      }
    }
  });

  testApp('a sentence opens the section it comes from', (tester) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: '/companions/abu-bakr');
    await app.pump(tester);
    final line = find.textContaining('أمر أن يصلي أبو بكر بالناس');
    expect(line, findsOneWidget);
    await tester.tap(line);
    await tester.pumpAndSettle();
    expect(app.location, startsWith('/companions/abu-bakr/sections/'));
  });
}
