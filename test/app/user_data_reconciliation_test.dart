import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/provider_retry.dart';
import 'package:suhba/app/reconciliation/user_data_reconciliation.dart';
import 'package:suhba/core/database/app_database.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/bookmarks/data/drift_bookmark_repository.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/reading_progress/data/drift_reading_progress_repository.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/shared/content/data/asset_content_repository.dart';
import 'package:suhba/shared/content/data/asset_content_source.dart';
import 'package:suhba/shared/content/domain/content_target.dart';
import 'package:suhba/shared/content/providers.dart';

import '../helpers/content_bundle.dart';

void main() {
  const abuBakr = 'assets/content/companions/abu-bakr.json';
  const theCave = 'assets/content/stories/the-cave.json';

  late MemoryAssetBundle bundle;
  late AppDatabase db;
  late DriftBookmarkRepository bookmarks;
  late DriftReadingProgressRepository progress;

  setUp(() {
    bundle = MemoryAssetBundle.builtContent();
    db = AppDatabase(NativeDatabase.memory());
    bookmarks = DriftBookmarkRepository(db, clock: () => DateTime(2026, 10, 9));
    progress = DriftReadingProgressRepository(db);
  });
  tearDown(() => db.close());

  /// The current revision of a section, as the app computes it.
  Future<String> revisionOf(String companionId, String sectionId) async {
    final repo = AssetContentRepository(AssetContentSource(bundle));
    final c = (await repo.companion(companionId)).getOrThrow();
    return c.sections.firstWhere((s) => s.id == sectionId).revision;
  }

  Future<void> savePosition(
    String sectionId, {
    String companionId = 'abu-bakr',
    ProgressTarget target = ProgressTarget.section,
    String? revision,
    String version = '0.1.0',
  }) => progress.save(
    ReadingProgress(
      target: target,
      targetId: sectionId,
      parentId: companionId,
      fraction: 0.5,
      completed: false,
      contentVersion: version,
      updatedAt: DateTime(2026, 10, 9),
      targetRevision: revision,
    ),
  );

  Future<ReadingProgress?> position(String id) async =>
      (await progress.all()).where((p) => p.targetId == id).firstOrNull;

  Future<ReconciliationReport> reconcile() => reconcileUserData(
    content: AssetContentRepository(AssetContentSource(bundle)),
    bookmarks: bookmarks,
    progress: progress,
    contentVersion: '0.1.0',
  );

  test('revisions are stable and change only when the passage does', () async {
    final before = await revisionOf('abu-bakr', 'abu-bakr.hijrah');
    expect(before, matches(RegExp(r'^[0-9a-f]{16}$')));
    expect(await revisionOf('abu-bakr', 'abu-bakr.hijrah'), before);
    final other = await revisionOf('abu-bakr', 'abu-bakr.virtues');

    bundle.editJson(abuBakr, (json) {
      final sections = (json['sections'] as List).cast<Map<String, dynamic>>();
      final hijrah = sections.firstWhere((s) => s['id'] == 'abu-bakr.hijrah');
      final block = (hijrah['blocks'] as List).first as Map<String, dynamic>;
      (block['text'] as Map<String, dynamic>)['ar'] = 'نص معدّل للاختبار.';
    });
    expect(await revisionOf('abu-bakr', 'abu-bakr.hijrah'), isNot(before));
    expect(await revisionOf('abu-bakr', 'abu-bakr.virtues'), other);
  });

  test('Seerah chapters and essays: unchanged, edited, removed', () async {
    const chapterFile = 'assets/content/seerah/chapters/hijrah-to-madinah.json';
    final repo = AssetContentRepository(AssetContentSource(bundle));
    final hijrah = (await repo.seerahChapter('hijrah-to-madinah')).getOrThrow();
    final mercy = (await repo.seerahTopic('mercy')).getOrThrow();

    await savePosition(
      'mercy',
      companionId: seerahParentId,
      target: ProgressTarget.seerahTopic,
      revision: mercy.revision,
    );
    await savePosition(
      'hijrah-to-madinah',
      companionId: seerahParentId,
      target: ProgressTarget.seerahChapter,
      revision: hijrah.revision,
    );
    await savePosition(
      'no-such-chapter',
      companionId: seerahParentId,
      target: ProgressTarget.seerahChapter,
      revision: 'whatever',
    );
    await bookmarks.toggle(
      BookmarkTarget.seerahChapter,
      'hijrah-to-madinah',
      parentId: seerahParentId,
    );

    bundle.editJson(chapterFile, (json) {
      final block = (json['blocks'] as List)[1] as Map<String, dynamic>;
      (block['text'] as Map<String, dynamic>)['ar'] = 'نص معدّل للاختبار.';
    });

    final report = await reconcile();
    expect(report.confirmedPositions, 1, reason: 'mercy');
    expect(report.outdatedPositions, 1, reason: 'the edited chapter');
    expect(report.removedPositions, 1, reason: 'no-such-chapter');
    expect(report.unavailableBookmarks, 0);
    expect(await position('no-such-chapter'), isNull);
    expect(await position('hijrah-to-madinah'), isNotNull);
  });

  test('unchanged, edited, removed and unreadable targets', () async {
    final umarRevision = await revisionOf('umar', 'umar.virtues');
    final hijrahBefore = await revisionOf('abu-bakr', 'abu-bakr.hijrah');

    // Unchanged passage, recorded against an older build.
    await savePosition(
      'umar.virtues',
      companionId: 'umar',
      revision: umarRevision,
      version: '0.0.9',
    );
    // Saved before revisions existed, against this build.
    await savePosition('abu-bakr.early-life');
    // Saved before revisions existed, against an older build.
    await savePosition('abu-bakr.conversion', version: '0.0.9');
    // Edited since.
    await savePosition('abu-bakr.hijrah', revision: hijrahBefore);
    // Removed since.
    await savePosition('abu-bakr.virtues', revision: 'whatever');
    // Its story file cannot be read.
    await savePosition(
      'the-cave.1',
      companionId: 'the-cave',
      target: ProgressTarget.chapter,
      revision: 'whatever',
    );

    await bookmarks.toggle(BookmarkTarget.companion, 'umar');
    await bookmarks.toggle(BookmarkTarget.companion, 'gone');
    await bookmarks.toggle(BookmarkTarget.section, 'abu-bakr.hijrah');
    await bookmarks.toggle(
      BookmarkTarget.chapter,
      'the-cave.2',
      parentId: 'the-cave',
    );

    bundle
      ..editJson(abuBakr, (json) {
        final sections = (json['sections'] as List)
            .cast<Map<String, dynamic>>();
        final hijrah = sections.firstWhere((s) => s['id'] == 'abu-bakr.hijrah');
        final block = (hijrah['blocks'] as List).first as Map<String, dynamic>;
        (block['text'] as Map<String, dynamic>)['ar'] = 'نص معدّل للاختبار.';
        sections.removeWhere((s) => s['id'] == 'abu-bakr.virtues');
      })
      ..files[theCave] = '{}';

    final report = await reconcile();
    expect(report.confirmedPositions, 2, reason: 'umar.virtues, early-life');
    expect(report.outdatedPositions, 2, reason: 'hijrah, conversion');
    expect(report.removedPositions, 1, reason: 'virtues');
    expect(report.unavailableBookmarks, 2, reason: 'gone, parentless');
    expect(report.failedLookups, 2, reason: 'the-cave.1, the-cave.2');
    expect(report.complete, isFalse);

    final umar = (await position('umar.virtues'))!;
    expect(umar.contentVersion, '0.1.0');
    expect(umar.targetRevision, umarRevision);
    expect(umar.fraction, 0.5);

    final earlyLife = (await position('abu-bakr.early-life'))!;
    expect(
      earlyLife.targetRevision,
      await revisionOf('abu-bakr', 'abu-bakr.early-life'),
    );

    // Edited and unreadable ones are left exactly as they were.
    expect((await position('abu-bakr.hijrah'))!.targetRevision, hijrahBefore);
    expect((await position('abu-bakr.conversion'))!.targetRevision, isNull);
    expect(await position('the-cave.1'), isNotNull);
    expect(await position('abu-bakr.virtues'), isNull);

    // Saved items are never deleted automatically.
    expect(await bookmarks.all(), hasLength(4));
  });

  test('the same records give the same result on a second pass', () async {
    await savePosition('abu-bakr.virtues', revision: 'old');
    await bookmarks.toggle(BookmarkTarget.companion, 'gone');
    bundle.editJson(abuBakr, (json) {
      (json['sections'] as List).removeWhere(
        (s) => (s as Map<String, dynamic>)['id'] == 'abu-bakr.virtues',
      );
    });
    final first = await reconcile();
    final second = await reconcile();
    expect(first.removedPositions, 1);
    expect(second.removedPositions, 0);
    expect(second.unavailableBookmarks, first.unavailableBookmarks);
    expect(second.complete, isTrue);
  });

  group('runs once per content build', () {
    ProviderContainer containerWith(SettingsStore settings) {
      final container = ProviderContainer(
        retry: noAutomaticRetry,
        overrides: [
          assetBundleProvider.overrideWithValue(bundle),
          appDatabaseProvider.overrideWithValue(db),
          settingsStoreProvider.overrideWithValue(settings),
        ],
      );
      addTearDown(container.dispose);
      return container;
    }

    test('a complete pass is remembered', () async {
      final settings = MemorySettingsStore();
      final report = await containerWith(
        settings,
      ).read(userDataReconciliationProvider.future);
      expect(report, isNotNull);
      expect(settings.getString(SettingsKeys.reconciledContent), '0.2.0+draft');
      expect(
        await containerWith(
          settings,
        ).read(userDataReconciliationProvider.future),
        isNull,
        reason: 'nothing to do for the same build',
      );
    });

    test('an incomplete pass runs again next time', () async {
      final settings = MemorySettingsStore();
      await bookmarks.toggle(
        BookmarkTarget.chapter,
        'the-cave.2',
        parentId: 'the-cave',
      );
      bundle.files[theCave] = '{}';
      final report = await containerWith(
        settings,
      ).read(userDataReconciliationProvider.future);
      expect(report!.complete, isFalse);
      expect(settings.getString(SettingsKeys.reconciledContent), isNull);
      expect(await bookmarks.all(), hasLength(1));
    });
  });
}
