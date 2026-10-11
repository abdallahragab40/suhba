// Scale baseline (plan task E09). Not part of `flutter test` (which runs
// test/ only); run explicitly:
//
//   flutter test benchmark/scale_benchmark_test.dart
//
// It runs on the host VM in JIT (debug) mode, so absolute numbers are
// indicative only; the on-device profile-mode numbers come from
// integration_test/scale_perf_test.dart. Results are printed and written
// to build/perf/scale_baseline.json.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/features/search/presentation/search_providers.dart';
import 'package:suhba/shared/content/providers.dart';

import '../test/helpers/content_bundle.dart';
import '../test/helpers/scale_fixture.dart';

const _companions = 1000;
const _passageWords = 5000;
const _queries = ['صحابي', 'تجريبي ٥٠٠', 'الهجرة', 'ابو بكر', 'لا يوجد هذا'];
const _runs = 200;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('scale baseline', () async {
    final base = MemoryAssetBundle.builtContent().files;
    final bundle = MemoryAssetBundle(
      // The defaults: 1,000 companions and a 5,000-word passage.
      scaleContent(base),
    );
    ProviderContainer fresh() => ProviderContainer(
      retry: noAutomaticRetry,
      overrides: [assetBundleProvider.overrideWithValue(bundle)],
    );

    final results = <String, Object>{
      'mode': 'host VM, JIT (flutter test)',
      'host':
          '${Platform.operatingSystem} ${Platform.version.split(' ').first}',
      'fixture': {'companions': _companions, 'passageWords': _passageWords},
    };

    // Directory: the companion index alone.
    var container = fresh();
    var watch = Stopwatch()..start();
    final index = await container.read(companionIndexProvider.future);
    results['indexLoadMs'] = watch.elapsedMilliseconds;
    expect(index, hasLength(_companions));
    container.dispose();

    // Search: every companion file loaded in full, then indexed.
    container = fresh();
    final rssBefore = ProcessInfo.currentRss;
    watch = Stopwatch()..start();
    final search = await container.read(searchIndexProvider.future);
    results['searchIndexBuildMs'] = watch.elapsedMilliseconds;
    results['searchIndexRssDeltaMb'] =
        ((ProcessInfo.currentRss - rssBefore) / (1024 * 1024)).round();

    // Queries, after warm-up.
    final perQuery = <String, Object>{};
    for (final q in _queries) {
      search.search(q);
      final times = <int>[];
      for (var i = 0; i < _runs; i++) {
        final w = Stopwatch()..start();
        search.search(q);
        times.add(w.elapsedMicroseconds);
      }
      times.sort();
      perQuery[q] = {
        'medianMs': times[times.length ~/ 2] / 1000,
        'p95Ms': times[(times.length * 0.95).floor()] / 1000,
        'maxMs': times.last / 1000,
        'hits': search.search(q).length,
      };
    }
    results['queries'] = perQuery;
    container.dispose();

    // The long passage: load and map.
    container = fresh();
    watch = Stopwatch()..start();
    final first = await container.read(companionProvider('scale-0001').future);
    results['longPassageLoadMs'] = watch.elapsedMilliseconds;
    results['longPassageBlocks'] = first.sections.first.blocks.length;
    container.dispose();

    final json = const JsonEncoder.withIndent('  ').convert(results);
    Directory('build/perf').createSync(recursive: true);
    File('build/perf/scale_baseline.json').writeAsStringSync('$json\n');
    // ignore: avoid_print
    print(json);
  }, timeout: const Timeout(Duration(minutes: 5)));
}
