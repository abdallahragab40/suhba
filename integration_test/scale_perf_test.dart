// Scale baseline on a device (plan task E09): 1,000 synthetic companions
// and a 5,000-word passage, in profile mode:
//   flutter drive --profile --no-dds --driver=test_driver/perf_driver.dart \
//     --target=integration_test/scale_perf_test.dart -d <device>
// Results go to build/integration_response_data.json. The synthetic content
// is generated in memory from the bundled structure and never shown
// outside this test.
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:siyar_sahaba/app/app.dart';
import 'package:siyar_sahaba/app/provider_retry.dart';
import 'package:siyar_sahaba/app/router/app_router.dart';
import 'package:siyar_sahaba/core/database/app_database.dart';
import 'package:siyar_sahaba/core/database/database_provider.dart';
import 'package:siyar_sahaba/features/search/presentation/search_providers.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

import '../test/helpers/content_bundle.dart';
import '../test/helpers/scale_fixture.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
    ..framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  late MemoryAssetBundle bundle;
  final results = <String, Object>{};

  setUpAll(() async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final base = {
      for (final key in manifest.listAssets())
        if (key.startsWith('assets/content/') && key.endsWith('.json'))
          key: await rootBundle.loadString(key),
    };
    bundle = MemoryAssetBundle(scaleContent(base));
  });

  tearDownAll(() {
    binding.reportData = {...?binding.reportData, 'scale': results};
  });

  Future<ProviderContainer> launch(WidgetTester tester, String location) async {
    final container = ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [
        appRouterProvider.overrideWithValue(
          buildAppRouter(initialLocation: location),
        ),
        assetBundleProvider.overrideWithValue(bundle),
        appDatabaseProvider.overrideWithValue(
          AppDatabase(NativeDatabase.memory()),
        ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const SiyarApp()),
    );
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> scroll(WidgetTester tester, String reportKey) async {
    final scrollable = find
        .byWidgetPredicate(
          (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
        )
        .hitTestable()
        .first;
    await binding.watchPerformance(() async {
      for (var i = 0; i < 3; i++) {
        await tester.fling(scrollable, const Offset(0, -600), 3000);
        await tester.pumpAndSettle();
      }
      for (var i = 0; i < 3; i++) {
        await tester.fling(scrollable, const Offset(0, 600), 3000);
        await tester.pumpAndSettle();
      }
    }, reportKey: reportKey);
  }

  testWidgets('search over 1,000 companions', (tester) async {
    final container = await launch(tester, '/home');
    final watch = Stopwatch()..start();
    final index = await tester.runAsync(
      () => container.read(searchIndexProvider.future),
    );
    results['searchIndexBuildMs'] = watch.elapsedMilliseconds;
    for (final q in ['صحابي', 'تجريبي ٥٠٠', 'الهجرة']) {
      index!.search(q);
      final times = <int>[];
      for (var i = 0; i < 200; i++) {
        final w = Stopwatch()..start();
        index.search(q);
        times.add(w.elapsedMicroseconds);
      }
      times.sort();
      results['query $q'] = {
        'medianMs': times[100] / 1000,
        'p95Ms': times[190] / 1000,
        'maxMs': times.last / 1000,
      };
    }
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
  });

  testWidgets('scrolling the directory of 1,000', (tester) async {
    final container = await launch(tester, '/companions');
    await scroll(tester, 'directory_1000');
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
  });

  testWidgets('scrolling a 5,000-word passage', (tester) async {
    final container = await launch(
      tester,
      '/companions/scale-0001/sections/scale-0001.long',
    );
    await scroll(tester, 'reader_5000_words');
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
  });
}
