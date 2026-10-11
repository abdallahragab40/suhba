import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../../tool/src/app_identity.dart';
import '../../tool/src/content/builder.dart';
import '../../tool/src/content/readiness.dart';
import '../../tool/src/content/schema_set.dart';
import '../../tool/src/release/release_checks.dart';
import 'content_fixture.dart';
import 'content_readiness_test.dart' show fixtureEdition;

void main() {
  final schemas = SchemaSet.fromFile(SchemaSet.defaultPath);
  late ContentFixture fx;

  const finalIdentity = AppIdentity(
    displayName: 'سِيَر الصحابة',
    androidApplicationId: 'org.publisher.suhba',
    iosBundleId: 'org.publisher.suhba',
  );
  const placeholderIdentity = AppIdentity(
    displayName: 'سِيَر الصحابة',
    androidApplicationId: 'com.example.suhba',
    iosBundleId: 'com.example.suhba',
  );

  void approveAll() {
    for (final id in ['quran', 'hadith-a', 'bio-a']) {
      fx.approve('source', id, fx.source(id));
    }
    fx
      ..approve(
        'category',
        'cat-a',
        fx.list('categories.json', 'categories')[0] as Map<String, dynamic>,
      )
      ..approve(
        'event',
        'event-a',
        fx.list('events.json', 'events')[0] as Map<String, dynamic>,
      )
      ..approve('companion', 'comp-a', fx.companionA)
      ..approve('story', 'story-a', fx.files['stories/story-a.json']!);
  }

  ReadinessReport readiness() =>
      contentReadiness(fx.toFiles(), schemas, edition: fixtureEdition());

  setUp(() {
    fx = ContentFixture();
    (fx.companionA['review'] as Map<String, dynamic>)['coverage'] = 'complete';
  });

  group('before the build', () {
    test('draft content cannot produce a public artifact', () {
      final problems = preBuildProblems(
        identity: finalIdentity,
        readiness: readiness(),
      );
      expect(problems, isNotEmpty);
      expect(problems.join('\n'), contains('V11'));
    });

    test('a placeholder identity cannot produce a public artifact', () {
      approveAll();
      final problems = preBuildProblems(
        identity: placeholderIdentity,
        readiness: readiness(),
      );
      expect(problems, isNotEmpty);
      expect(problems.every((p) => p.startsWith('Identity:')), isTrue);
    });

    test('final identity and complete, approved content pass', () {
      approveAll();
      expect(
        preBuildProblems(identity: finalIdentity, readiness: readiness()),
        isEmpty,
      );
    });
  });

  group('the built artifact', () {
    Map<String, String> built(ContentChannel channel) =>
        buildContent(fx.toFiles(), schemas, channel: channel).outputs;

    test('a published build passes', () {
      approveAll();
      expect(
        artifactProblems(
          bundled: built(ContentChannel.published),
          channel: ContentChannel.published,
          contentVersion: '1.0.0',
        ),
        isEmpty,
      );
    });

    test('draft content in a public artifact is caught', () {
      final problems = artifactProblems(
        bundled: built(ContentChannel.draft),
        channel: ContentChannel.published,
        contentVersion: '1.0.0',
      );
      expect(
        problems,
        containsAll([
          'Content channel is "draft", expected "published".',
          contains('unapproved items'),
        ]),
      );
    });

    test('a draft preview passes as a draft', () {
      expect(
        artifactProblems(
          bundled: built(ContentChannel.draft),
          channel: ContentChannel.draft,
          contentVersion: '1.0.0',
        ),
        isEmpty,
      );
    });

    test('a different content version is caught', () {
      approveAll();
      expect(
        artifactProblems(
          bundled: built(ContentChannel.published),
          channel: ContentChannel.published,
          contentVersion: '1.0.1',
        ),
        [contains('Content version is "1.0.0"')],
      );
    });

    test('changed, missing and extra files are caught', () {
      approveAll();
      final files = Map.of(built(ContentChannel.published));
      files['companions/comp-a.json'] = '${files['companions/comp-a.json']} ';
      files.remove('events.json');
      files['companions/extra.json'] = '{}';
      expect(
        artifactProblems(
          bundled: files,
          channel: ContentChannel.published,
          contentVersion: '1.0.0',
        ),
        [
          'Does not match its manifest hash: companions/comp-a.json',
          'Missing from the artifact: events.json',
          'Not listed in the manifest: companions/extra.json',
        ],
      );
    });

    test('no manifest, or a broken one, is caught', () {
      expect(
        artifactProblems(
          bundled: const {},
          channel: ContentChannel.published,
          contentVersion: '1.0.0',
        ),
        ['No content manifest in the artifact.'],
      );
      expect(
        artifactProblems(
          bundled: const {'manifest.json': '{'},
          channel: ContentChannel.published,
          contentVersion: '1.0.0',
        ),
        [startsWith('The content manifest is not valid JSON')],
      );
    });

    test('content paths are found in APK, AAB and IPA layouts', () {
      for (final entry in [
        'assets/flutter_assets/assets/content/manifest.json',
        'base/assets/flutter_assets/assets/content/manifest.json',
        'Payload/Runner.app/Frameworks/App.framework/flutter_assets/'
            'assets/content/manifest.json',
      ]) {
        expect(
          contentEntry.firstMatch(entry)?.group(1),
          'manifest.json',
          reason: entry,
        );
      }
      expect(
        contentEntry.firstMatch('assets/flutter_assets/assets/fonts/a.json'),
        isNull,
      );
    });
  });
}
