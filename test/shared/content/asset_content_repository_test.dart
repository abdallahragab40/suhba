import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/result/failure.dart';
import 'package:siyar_sahaba/shared/content/data/asset_content_repository.dart';
import 'package:siyar_sahaba/shared/content/data/asset_content_source.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/content_format.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

/// An asset bundle over an in-memory map that counts loads.
class _MapBundle extends CachingAssetBundle {
  _MapBundle(this.files);

  final Map<String, String> files;
  final loads = <String, int>{};

  @override
  Future<ByteData> load(String key) async {
    loads.update(key, (n) => n + 1, ifAbsent: () => 1);
    final text = files[key];
    if (text == null) throw FlutterError('Unable to load asset: $key');
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(text)));
  }
}

/// The committed draft build, read from disk.
Map<String, String> _builtAssets() => {
  for (final f
      in Directory('assets/content')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.json')))
    f.path: f.readAsStringSync(),
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MapBundle bundle;
  late AssetContentRepository repo;

  setUp(() {
    bundle = _MapBundle(_builtAssets());
    repo = AssetContentRepository(AssetContentSource(bundle));
  });

  test('reads the manifest', () async {
    final manifest = (await repo.manifest()).getOrThrow();
    expect(manifest.channel, ContentChannel.draft);
    expect(manifest.isDraft, isTrue);
    expect(manifest.companionCount, 10);
    expect(manifest.approvedCount, 0);
  });

  test('the index lists the Ten in their traditional order', () async {
    final index = (await repo.companionIndex()).getOrThrow();
    expect(index.map((c) => c.id), [
      'abu-bakr',
      'umar',
      'uthman',
      'ali',
      'talha',
      'zubayr',
      'abd-al-rahman-ibn-awf',
      'sad-ibn-abi-waqqas',
      'said-ibn-zayd',
      'abu-ubaydah',
    ]);
    expect(
      index.every((c) => c.categoryIds.contains('ashara-mubashshara')),
      isTrue,
    );
    expect(index.every((c) => !c.review.isApproved), isTrue);
  });

  test('every bundled companion loads in full', () async {
    final index = (await repo.companionIndex()).getOrThrow();
    for (final summary in index) {
      final companion = (await repo.companion(summary.id)).getOrThrow();
      expect(companion.name, summary.name);
    }
  });

  test('catalog files load', () async {
    final categories = (await repo.categories()).getOrThrow();
    expect(categories.map((c) => c.id), [
      'ashara-mubashshara',
      'khulafa-rashidun',
      'muhajirun',
    ]);
    final sources = (await repo.sources()).getOrThrow();
    expect(sources.keys, containsAll(['quran', 'bukhari', 'isabah']));
    final events = (await repo.events()).getOrThrow();
    expect(events.keys, containsAll(['hijrah', 'badr', 'hudaybiyah']));
    expect(events.keys.first, 'birth-of-the-prophet', reason: 'date order');
    expect(
      (await repo.people()).getOrThrow().keys,
      containsAll(['aisha', 'hafsa', 'muhammad']),
    );
    final places = (await repo.places()).getOrThrow();
    expect(places['makkah']!.location.precision, GeoPrecision.identified);
    final visuals = (await repo.visuals()).getOrThrow();
    expect(visuals['hijrah-route']!.type, InfographicType.map);
    final seerah = (await repo.seerahIndex()).getOrThrow();
    expect(seerah.chapters, hasLength(12));
    expect(seerah.topics, hasLength(8));
    final hijrah = (await repo.seerahChapter('hijrah-to-madinah')).getOrThrow();
    expect(hijrah.number, 8, reason: 'numbered by the reading order');
    expect(hijrah.blocks.whereType<InfographicBlock>(), hasLength(2));
    expect(
      (await repo.seerahChapter('not-a-chapter')).failureOrNull,
      isA<NotFoundFailure>(),
    );
    final stories = (await repo.storyIndex()).getOrThrow();
    expect(stories, hasLength(20));
    expect(
      stories.map((s) => s.id),
      containsAll(['the-cave', 'jam-al-quran', 'the-day-of-saqifah']),
    );
    for (final s in stories) {
      expect((await repo.story(s.id)).getOrThrow().chapters, isNotEmpty);
    }
  });

  test('loads each file once', () async {
    await repo.companion('umar');
    await repo.companion('umar');
    await repo.companionIndex();
    await repo.companionIndex();
    expect(bundle.loads['assets/content/companions/umar.json'], 1);
    expect(bundle.loads['assets/content/index/companions.json'], 1);
  });

  test('an unknown id is NotFound', () async {
    final result = await repo.companion('nobody');
    expect(result.failureOrNull, isA<NotFoundFailure>());
  });

  test('a malformed id never becomes a path', () async {
    for (final id in ['../manifest', 'Abu', 'a/b', '']) {
      final result = await repo.companion(id);
      expect(result.failureOrNull, isA<NotFoundFailure>(), reason: id);
    }
    expect(bundle.loads.keys.where((k) => k.contains('..')), isEmpty);
  });

  test('corrupt content is a DataFormatFailure', () async {
    bundle.files['assets/content/companions/umar.json'] = '{"id": 1}';
    final result = await repo.companion('umar');
    expect(result.failureOrNull, isA<DataFormatFailure>());
  });

  test('failures are not cached, so a retry can succeed', () async {
    final good = bundle.files.remove('assets/content/companions/umar.json')!;
    expect((await repo.companion('umar')).isOk, isFalse);
    bundle.files['assets/content/companions/umar.json'] = good;
    expect((await repo.companion('umar')).isOk, isTrue);
  });

  group('format contract', () {
    const umar = 'assets/content/companions/umar.json';
    const manifest = 'assets/content/manifest.json';

    void setVersion(String path, Object? version) {
      final json = jsonDecode(bundle.files[path]!) as Map<String, dynamic>;
      if (version == null) {
        json.remove('schemaVersion');
      } else {
        json['schemaVersion'] = version;
      }
      bundle.files[path] = jsonEncode(json);
    }

    test('every bundled file is a supported version', () async {
      for (final MapEntry(:key, :value) in _builtAssets().entries) {
        final version = (jsonDecode(value) as Map)['schemaVersion'];
        expect(ContentFormat.supported, contains(version), reason: key);
      }
    });

    test('a newer version fails before mapping, with what was found', () async {
      setVersion(umar, ContentFormat.current + 1);
      final failure = (await repo.companion('umar')).failureOrNull;
      expect(failure, isA<UnsupportedFormatFailure>());
      final unsupported = failure! as UnsupportedFormatFailure;
      expect(unsupported.found, ContentFormat.current + 1);
      expect(unsupported.supported, ContentFormat.supported);
    });

    test('an unsupported manifest fails the same way', () async {
      setVersion(manifest, 0);
      expect(
        (await repo.manifest()).failureOrNull,
        isA<UnsupportedFormatFailure>(),
      );
    });

    test('a missing or non-integer version is a DataFormatFailure', () async {
      setVersion(umar, null);
      expect(
        (await repo.companion('umar')).failureOrNull,
        isA<DataFormatFailure>(),
      );
      setVersion(umar, '1');
      expect(
        (await repo.companion('umar')).failureOrNull,
        isA<DataFormatFailure>(),
      );
    });

    test('a malformed manifest is a DataFormatFailure', () async {
      bundle.files[manifest] = jsonEncode({
        'schemaVersion': ContentFormat.current,
      });
      expect((await repo.manifest()).failureOrNull, isA<DataFormatFailure>());
    });

    test('after a failed load, a fixed file loads on retry', () async {
      final good = bundle.files[umar]!;
      setVersion(umar, ContentFormat.current + 1);
      expect((await repo.companion('umar')).isOk, isFalse);
      bundle.files[umar] = good;
      bundle.clear();
      expect((await repo.companion('umar')).isOk, isTrue);
    });
  });

  test('large files decode off the UI isolate and still parse', () async {
    final big =
        jsonDecode(bundle.files['assets/content/companions/abu-bakr.json']!)
            as Map<String, dynamic>;
    // Pad a field until the file crosses the isolate threshold.
    big['summary'] = {'ar': 'نص ' * (AssetContentSource.defaultIsolateThreshold ~/ 2)};
    bundle.files['assets/content/companions/abu-bakr.json'] = jsonEncode(big);
    final companion = (await repo.companion('abu-bakr')).getOrThrow();
    expect(
      companion.summary.ar.length,
      greaterThan(AssetContentSource.defaultIsolateThreshold),
    );
  });

  test('the real asset bundle contains the content', () async {
    final real = AssetContentRepository(AssetContentSource(rootBundle));
    final manifest = (await real.manifest()).getOrThrow();
    expect(manifest.companionCount, 10);
  });
}
