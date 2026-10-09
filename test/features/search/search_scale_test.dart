import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/app/provider_retry.dart';
import 'package:siyar_sahaba/features/search/presentation/search_providers.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

import '../../helpers/content_bundle.dart';
import '../../helpers/scale_fixture.dart';

/// A catalogue large enough that the search index is built on a background
/// isolate (found by the E09 scale benchmark: that path used to fail).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a large catalogue builds its index off the UI isolate', () async {
    final bundle = MemoryAssetBundle(
      scaleContent(
        MemoryAssetBundle.builtContent().files,
        companions: 60,
        passageWords: 500,
      ),
    );
    final container = ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [assetBundleProvider.overrideWithValue(bundle)],
    );
    addTearDown(container.dispose);

    final index = await container.read(searchIndexProvider.future);
    expect(index.search('تجريبي ٤٢').first.document.title, 'صحابي تجريبي 42');
  });
}
