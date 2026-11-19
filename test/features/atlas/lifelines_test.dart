import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/providers.dart';

import '../../helpers/content_bundle.dart';

/// E6 (review C9): each of the Ten has a lifeline drawn from their own
/// cited timeline, with the list view as its alternative.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('every one of the Ten has a lifeline from their timeline', () async {
    final container = ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [
        assetBundleProvider.overrideWithValue(MemoryAssetBundle.builtContent()),
      ],
    );
    addTearDown(container.dispose);
    final companions = await container.read(companionIndexProvider.future);
    final ten = [
      for (final c in companions)
        if (c.categoryIds.contains('ashara-mubashshara')) c.id,
    ];
    expect(ten, hasLength(10));
    final visuals = await container.read(visualsProvider.future);
    final lifelines = {
      for (final v in visuals.values)
        if (v.data case TimelineData(:final companionId?)) companionId,
    };
    expect(lifelines, containsAll(ten));
    for (final id in ten) {
      final c = await container.read(companionProvider(id).future);
      expect(c.timeline, isNotEmpty, reason: '$id has entries to draw');
    }
  });
}
