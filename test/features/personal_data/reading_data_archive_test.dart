import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/personal_data/domain/reading_data_archive.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';

Bookmark _b(
  String id, {
  BookmarkTarget target = BookmarkTarget.section,
  String? parent = 'abu-bakr',
  int day = 1,
}) => Bookmark(
  target: target,
  targetId: id,
  parentId: parent,
  createdAt: DateTime.utc(2026, 10, day),
);

ReadingProgress _p(
  String id, {
  bool completed = false,
  double fraction = 0.5,
  int day = 1,
}) => ReadingProgress(
  target: ProgressTarget.section,
  targetId: id,
  parentId: 'abu-bakr',
  fraction: fraction,
  completed: completed,
  contentVersion: '0.2.0',
  updatedAt: DateTime.utc(2026, 10, day),
  targetRevision: 'r1',
  blockIndex: 3,
  blockOffset: 0.25,
);

ReadingDataArchive _archive({
  List<Bookmark> bookmarks = const [],
  List<ReadingProgress> progress = const [],
}) => ReadingDataArchive(
  bookmarks: bookmarks,
  progress: progress,
  exportedAt: DateTime.utc(2026, 10, 11, 9, 30),
  contentVersion: '0.2.0',
);

/// The export format: one JSON document whose records mirror the stored
/// rows, with the format's name and version.
Map<String, Object?> _json({
  Object? bookmarks = const [],
  Object? progress = const [],
  Object? version = 1,
}) => {
  'format': ReadingDataArchive.format,
  'version': version,
  'exportedAt': '2026-10-11T09:30:00.000Z',
  'bookmarks': bookmarks,
  'progress': progress,
};

Map<String, Object?> _progressJson([Map<String, Object?> changes = const {}]) =>
    {
      'target': 'section',
      'targetId': 'abu-bakr.hijrah',
      'parentId': 'abu-bakr',
      'fraction': 0.5,
      'completed': false,
      'contentVersion': '0.2.0',
      'updatedAt': '2026-10-10T20:15:00.000Z',
      ...changes,
    };

ArchiveDecoding _decode(Map<String, Object?> json) =>
    decodeArchive(jsonEncode(json));

void main() {
  group('round trip', () {
    test('every field survives export and import', () {
      final archive = _archive(
        bookmarks: [
          _b('abu-bakr.hijrah'),
          _b('umar', target: BookmarkTarget.companion, parent: null),
        ],
        progress: [
          _p('abu-bakr.hijrah'),
          _p('abu-bakr.virtues', completed: true, fraction: 1),
        ],
      );
      final decoded = decodeArchive(encodeArchive(archive));
      expect(decoded, isA<ArchiveDecoded>());
      final back = (decoded as ArchiveDecoded).archive;
      expect(back.bookmarks, archive.bookmarks);
      expect(back.progress, archive.progress);
      expect(back.exportedAt, archive.exportedAt);
      expect(back.contentVersion, '0.2.0');
    });

    test('optional fields may be absent', () {
      final decoded = _decode(_json(progress: [_progressJson()]));
      final p = (decoded as ArchiveDecoded).archive.progress.single;
      expect(
        (p.targetRevision, p.blockIndex, p.blockOffset),
        (null, null, null),
      );
    });
  });

  group('malformed files are refused whole', () {
    void refused(ArchiveDecoding d, ArchiveProblem problem, [String? where]) {
      expect(d, isA<ArchiveRejected>());
      final r = d as ArchiveRejected;
      expect(r.problem, problem);
      if (where != null) expect(r.where, where);
    }

    test('not JSON', () {
      refused(decodeArchive('{not json'), ArchiveProblem.notJson);
    });

    test('too large', () {
      refused(
        decodeArchive(' ' * (ReadingDataArchive.maxBytes + 1)),
        ArchiveProblem.notJson,
      );
    });

    test('JSON from somewhere else', () {
      refused(decodeArchive('[1, 2]'), ArchiveProblem.notAnExport);
      refused(
        decodeArchive(jsonEncode({'format': 'other', 'version': 1})),
        ArchiveProblem.notAnExport,
      );
    });

    test('a file exported before the rename is still read', () {
      final legacy = {..._json(), 'format': 'siyar-sahaba.reading-data'};
      expect(decodeArchive(jsonEncode(legacy)), isNot(isA<ArchiveRejected>()));
    });

    test('a newer format version', () {
      refused(_decode(_json(version: 2)), ArchiveProblem.newerVersion);
    });

    for (final (field, value, where) in [
      ('targetId', 'Abu Bakr', 'progress[0].targetId'),
      ('targetId', '../etc', 'progress[0].targetId'),
      ('target', 'poem', 'progress[0].target'),
      ('fraction', 1.5, 'progress[0].fraction'),
      ('fraction', 'half', 'progress[0].fraction'),
      ('completed', 'yes', 'progress[0].completed'),
      ('updatedAt', 'yesterday', 'progress[0].updatedAt'),
      ('blockIndex', -1, 'progress[0].blockIndex'),
      ('blockOffset', 2, 'progress[0].blockOffset'),
      ('contentVersion', '', 'progress[0].contentVersion'),
    ]) {
      test('progress with a bad $field ($value)', () {
        refused(
          _decode(
            _json(
              progress: [
                _progressJson({field: value}),
              ],
            ),
          ),
          ArchiveProblem.invalidRecord,
          where,
        );
      });
    }

    test('a section saved without its companion', () {
      refused(
        _decode(
          _json(
            bookmarks: [
              {
                'target': 'section',
                'targetId': 'abu-bakr.hijrah',
                'createdAt': '2026-10-09T08:00:00.000Z',
              },
            ],
          ),
        ),
        ArchiveProblem.invalidRecord,
        'bookmarks[0].parentId',
      );
    });

    test('a list that is not a list, or a record that is not one', () {
      refused(
        _decode(_json(bookmarks: 'none')),
        ArchiveProblem.invalidRecord,
        'bookmarks',
      );
      refused(
        _decode(_json(progress: [_progressJson(), 3])),
        ArchiveProblem.invalidRecord,
        'progress[1]',
      );
    });
  });

  group('merging', () {
    test('saved items already here are kept; new ones are added', () {
      final local = _b('abu-bakr.hijrah', day: 5);
      final plan = planImport(
        localBookmarks: [local],
        localProgress: const [],
        archive: _archive(
          bookmarks: [
            _b('abu-bakr.hijrah'),
            _b('umar', target: BookmarkTarget.companion, parent: null, day: 3),
          ],
        ),
      );
      expect(plan.newBookmarks.map((b) => b.targetId), ['umar']);
      expect(plan.keptBookmarks, 1);
    });

    test('duplicates within the file keep the earliest saved', () {
      final plan = planImport(
        localBookmarks: const [],
        localProgress: const [],
        archive: _archive(
          bookmarks: [_b('abu-bakr.hijrah', day: 4), _b('abu-bakr.hijrah')],
        ),
      );
      expect(plan.newBookmarks.single.createdAt, DateTime.utc(2026, 10));
    });

    test('a finished position beats a later unfinished one', () {
      final plan = planImport(
        localBookmarks: const [],
        localProgress: [_p('a', day: 9)],
        archive: _archive(progress: [_p('a', completed: true, day: 2)]),
      );
      expect(plan.progressToSave.single.completed, isTrue);

      final reverse = planImport(
        localBookmarks: const [],
        localProgress: [_p('a', completed: true, day: 2)],
        archive: _archive(progress: [_p('a', day: 9)]),
      );
      expect(reverse.progressToSave, isEmpty);
      expect(reverse.keptPositions, 1);
    });

    test('otherwise the later position wins; a tie keeps this device', () {
      final newer = planImport(
        localBookmarks: const [],
        localProgress: [_p('a', fraction: 0.2, day: 2)],
        archive: _archive(progress: [_p('a', fraction: 0.6, day: 3)]),
      );
      expect(newer.progressToSave.single.fraction, 0.6);

      final tie = planImport(
        localBookmarks: const [],
        localProgress: [_p('a', fraction: 0.2, day: 3)],
        archive: _archive(progress: [_p('a', fraction: 0.6, day: 3)]),
      );
      expect(tie.progressToSave, isEmpty);
    });

    test('the plan does not depend on the order of the file', () {
      final records = [
        _p('a', fraction: 0.1),
        _p('a', fraction: 0.9, day: 4),
        _p('b', completed: true, fraction: 1, day: 2),
        _p('b', fraction: 0.3, day: 8),
      ];
      ImportPlan plan(List<ReadingProgress> progress) => planImport(
        localBookmarks: const [],
        localProgress: const [],
        archive: _archive(progress: progress),
      );
      final forward = plan(records);
      final backward = plan(records.reversed.toList());
      expect(forward.progressToSave, backward.progressToSave);
      expect(forward.progressToSave.map((p) => (p.targetId, p.fraction)), [
        ('a', 0.9),
        ('b', 1.0),
      ]);
    });

    test('an import with nothing new is empty', () {
      final plan = planImport(
        localBookmarks: [_b('x')],
        localProgress: [_p('a', day: 5)],
        archive: _archive(bookmarks: [_b('x')], progress: [_p('a', day: 5)]),
      );
      expect(plan.isEmpty, isTrue);
    });
  });
}
