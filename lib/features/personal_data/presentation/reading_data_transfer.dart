import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/app/reconciliation/user_data_reconciliation.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/share/share_service.dart';
import 'package:suhba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:suhba/features/personal_data/data/file_opener.dart';
import 'package:suhba/features/personal_data/domain/reading_data_archive.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/shared/content/providers.dart';

/// What choosing a file to import produced.
sealed class ImportChoice {
  const ImportChoice();
}

/// The reader cancelled the file chooser.
final class ImportCancelled extends ImportChoice {
  const ImportCancelled();
}

/// The file was refused; nothing was written.
final class ImportRefused extends ImportChoice {
  const ImportRefused(this.problem, [this.where]);
  final ArchiveProblem problem;
  final String? where;
}

/// The file is valid; [plan] says what importing it would change.
final class ImportReady extends ImportChoice {
  const ImportReady(this.plan);
  final ImportPlan plan;
}

/// Export and import of saved items and reading positions (E10).
class ReadingDataTransfer {
  ReadingDataTransfer(this._ref);

  final Ref _ref;

  /// Everything to export, as of now.
  Future<ReadingDataArchive> snapshot() async => ReadingDataArchive(
    bookmarks: await _ref.read(bookmarkRepositoryProvider).all(),
    progress: await _ref.read(readingProgressRepositoryProvider).all(),
    exportedAt: _ref.read(clockProvider)(),
    contentVersion: _ref.read(contentManifestProvider).value?.contentVersion,
  );

  /// The export's file name, dated by the device's local day.
  String fileName(DateTime when) {
    String two(int n) => n.toString().padLeft(2, '0');
    return 'suhba-reading-data-'
        '${when.year}-${two(when.month)}-${two(when.day)}.json';
  }

  /// Hands the export file to the share sheet (to save it or send it).
  Future<void> export({String? subject, Rect? origin}) async {
    final archive = await snapshot();
    await _ref
        .read(shareServiceProvider)
        .shareFile(
          Uint8List.fromList(utf8.encode(encodeArchive(archive))),
          fileName: fileName(archive.exportedAt.toLocal()),
          mimeType: 'application/json',
          subject: subject,
          origin: origin,
        );
  }

  /// Lets the reader choose a file and works out what importing it would
  /// do, without writing anything.
  Future<ImportChoice> choose() async {
    final String? text;
    try {
      text = await _ref.read(fileOpenerProvider).openJsonText();
    } on FileTooLarge {
      return const ImportRefused(ArchiveProblem.notJson);
    }
    if (text == null) return const ImportCancelled();
    return switch (decodeArchive(text)) {
      ArchiveRejected(:final problem, :final where) => ImportRefused(
        problem,
        where,
      ),
      ArchiveDecoded(:final archive) => ImportReady(
        planImport(
          localBookmarks: await _ref.read(bookmarkRepositoryProvider).all(),
          localProgress: await _ref
              .read(readingProgressRepositoryProvider)
              .all(),
          archive: archive,
        ),
      ),
    };
  }

  /// Writes [plan], then checks the result against the content as on a
  /// new build: positions in passages that no longer exist are dropped,
  /// and positions in edited passages are kept but not restored silently.
  Future<void> apply(ImportPlan plan) async {
    final bookmarks = _ref.read(bookmarkRepositoryProvider);
    final progress = _ref.read(readingProgressRepositoryProvider);
    for (final b in plan.newBookmarks) {
      await bookmarks.restore(b);
    }
    for (final p in plan.progressToSave) {
      await progress.save(p);
    }
    final manifest = await _ref.read(contentManifestProvider.future);
    await reconcileUserData(
      content: _ref.read(contentRepositoryProvider),
      bookmarks: bookmarks,
      progress: progress,
      contentVersion: manifest.contentVersion,
    );
  }
}

final readingDataTransferProvider = Provider<ReadingDataTransfer>(
  ReadingDataTransfer.new,
);
