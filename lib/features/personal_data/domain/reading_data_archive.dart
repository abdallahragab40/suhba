import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:suhba/features/bookmarks/domain/bookmark.dart';
import 'package:suhba/features/journeys/domain/journey_import.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/review/domain/review_item.dart';

/// A reader's saved items, reading positions and review history, exported
/// to a file and imported back (E10). Settings are not part of it: importing must never
/// change how the app looks.
///
/// The file is JSON:
///
/// ```json
/// {
///   "format": "suhba.reading-data",
///   "version": 3,
///   "exportedAt": "2026-10-11T09:30:00.000Z",
///   "contentVersion": "0.2.0",
///   "bookmarks": [
///     {"target": "section", "targetId": "abu-bakr.hijrah",
///      "parentId": "abu-bakr", "createdAt": "2026-10-09T08:00:00.000Z"}
///   ],
///   "reviews": [],
///   "progress": [
///     {"target": "section", "targetId": "abu-bakr.hijrah",
///      "parentId": "abu-bakr", "fraction": 0.35, "completed": false,
///      "contentVersion": "0.2.0", "updatedAt": "2026-10-10T20:15:00.000Z",
///      "targetRevision": "a1b2", "blockIndex": 3, "blockOffset": 0.2}
///   ]
/// }
/// ```
///
/// `target` names are the stored enum names ([BookmarkTarget],
/// [ProgressTarget]); IDs are content slugs. Dates are ISO 8601 in UTC.
@immutable
class ReadingDataArchive {
  const ReadingDataArchive({
    required this.bookmarks,
    required this.progress,
    required this.exportedAt,
    this.contentVersion,
    this.reviews = const [],
    this.journeys = const [],
    this.journeySteps = const [],
  });

  static const format = 'suhba.reading-data';

  /// Files exported before the app was renamed; still imported.
  static const legacyFormats = {'siyar-sahaba.reading-data'};
  static const version = 3;

  /// Files larger than this are refused before parsing.
  static const maxBytes = 2 * 1024 * 1024;

  final List<Bookmark> bookmarks;
  final List<ReadingProgress> progress;
  final List<ReviewItem> reviews;
  final List<JourneyEnrollment> journeys;
  final List<JourneyStepProgress> journeySteps;
  final DateTime exportedAt;

  /// The content build the data was exported from; informational only.
  final String? contentVersion;
}

/// Why a file was refused. The whole file is refused on the first problem:
/// a partial import would be hard to reason about.
enum ArchiveProblem {
  /// Not JSON, or larger than [ReadingDataArchive.maxBytes].
  notJson,

  /// JSON, but not a reading-data export from this app.
  notAnExport,

  /// Made by a newer version of the app.
  newerVersion,

  /// A record is missing a field or has an invalid value.
  invalidRecord,
}

sealed class ArchiveDecoding {
  const ArchiveDecoding();
}

final class ArchiveDecoded extends ArchiveDecoding {
  const ArchiveDecoded(this.archive);
  final ReadingDataArchive archive;
}

final class ArchiveRejected extends ArchiveDecoding {
  const ArchiveRejected(this.problem, [this.where]);
  final ArchiveProblem problem;

  /// Where the problem is, e.g. `progress[3].fraction`.
  final String? where;

  @override
  String toString() => 'ArchiveRejected(${problem.name}, $where)';
}

/// Same rule as route IDs: ASCII slugs.
final _slug = RegExp(r'^[a-z0-9]+(?:[-.][a-z0-9]+)*$');

String encodeArchive(ReadingDataArchive a) =>
    const JsonEncoder.withIndent('  ').convert({
      'format': ReadingDataArchive.format,
      'version': ReadingDataArchive.version,
      'exportedAt': a.exportedAt.toUtc().toIso8601String(),
      'contentVersion': ?a.contentVersion,
      'bookmarks': [
        for (final b in a.bookmarks)
          {
            'target': b.target.name,
            'targetId': b.targetId,
            'parentId': ?b.parentId,
            'createdAt': b.createdAt.toUtc().toIso8601String(),
          },
      ],
      'journeys': [
        for (final j in a.journeys)
          {
            'journeyId': j.journeyId,
            'startedAt': j.startedAt.toUtc().toIso8601String(),
            'updatedAt': j.updatedAt.toUtc().toIso8601String(),
            'paused': j.paused,
          },
      ],
      'journeySteps': [
        for (final s in a.journeySteps)
          {
            'journeyId': s.journeyId,
            'stepId': s.stepId,
            'startedAt': s.startedAt.toUtc().toIso8601String(),
            'updatedAt': s.updatedAt.toUtc().toIso8601String(),
            'completedAt': ?s.completedAt?.toUtc().toIso8601String(),
            'skipped': s.skipped,
            'answeredKeys': s.answeredKeys.toList()..sort(),
          },
      ],
      'reviews': [
        for (final r in a.reviews)
          {
            'questionKey': r.questionKey,
            'box': r.box,
            'dueOn': r.dueOn.toUtc().toIso8601String(),
            'lastAnsweredAt': r.lastAnsweredAt.toUtc().toIso8601String(),
            'timesRight': r.timesRight,
            'timesWrong': r.timesWrong,
          },
      ],
      'progress': [
        for (final p in a.progress)
          {
            'target': p.target.name,
            'targetId': p.targetId,
            'parentId': p.parentId,
            'fraction': p.fraction,
            'completed': p.completed,
            'contentVersion': p.contentVersion,
            'updatedAt': p.updatedAt.toUtc().toIso8601String(),
            'targetRevision': ?p.targetRevision,
            'blockIndex': ?p.blockIndex,
            'blockOffset': ?p.blockOffset,
          },
      ],
    });

/// Reads an export, refusing anything malformed. IDs must be slugs; a
/// section or chapter must name its parent; fractions and offsets lie in
/// 0–1; dates must parse.
ArchiveDecoding decodeArchive(String text) {
  if (utf8.encode(text).length > ReadingDataArchive.maxBytes) {
    return const ArchiveRejected(ArchiveProblem.notJson);
  }
  final Object? json;
  try {
    json = jsonDecode(text);
  } on FormatException {
    return const ArchiveRejected(ArchiveProblem.notJson);
  }
  if (json is! Map<String, Object?> ||
      !(json['format'] == ReadingDataArchive.format ||
          ReadingDataArchive.legacyFormats.contains(json['format']))) {
    return const ArchiveRejected(ArchiveProblem.notAnExport);
  }
  final version = json['version'];
  if (version is! int || version < 1) {
    return const ArchiveRejected(ArchiveProblem.notAnExport, 'version');
  }
  if (version > ReadingDataArchive.version) {
    return const ArchiveRejected(ArchiveProblem.newerVersion);
  }
  try {
    final exportedAt = _date(json['exportedAt'], 'exportedAt');
    final contentVersion = json['contentVersion'];
    if (contentVersion != null && contentVersion is! String) {
      throw const _Invalid('contentVersion');
    }
    final journeys = [
      for (final (i, r) in _list(json, 'journeys').indexed)
        _journey(r, 'journeys[$i]'),
    ];
    final journeySteps = [
      for (final (i, r) in _list(json, 'journeySteps').indexed)
        _journeyStep(r, 'journeySteps[$i]'),
    ];
    for (final (i, step) in journeySteps.indexed) {
      if (!journeys.any(
        (j) => j.journeyId == step.journeyId && j.startedAt == step.startedAt,
      )) {
        throw _Invalid('journeySteps[$i].startedAt');
      }
    }
    return ArchiveDecoded(
      ReadingDataArchive(
        exportedAt: exportedAt,
        journeys: journeys,
        journeySteps: journeySteps,
        contentVersion: contentVersion as String?,
        bookmarks: [
          for (final (i, r) in _list(json, 'bookmarks').indexed)
            _bookmark(r, 'bookmarks[$i]'),
        ],
        reviews: [
          for (final (i, r) in _list(json, 'reviews').indexed)
            _review(r, 'reviews[$i]'),
        ],
        progress: [
          for (final (i, r) in _list(json, 'progress').indexed)
            _progress(r, 'progress[$i]'),
        ],
      ),
    );
  } on _Invalid catch (e) {
    return ArchiveRejected(ArchiveProblem.invalidRecord, e.where);
  }
}

class _Invalid implements Exception {
  const _Invalid(this.where);
  final String where;
}

List<Object?> _list(Map<String, Object?> json, String key) =>
    switch (json[key]) {
      null => const [],
      final List<Object?> list => list,
      _ => throw _Invalid(key),
    };

Map<String, Object?> _record(Object? r, String at) =>
    r is Map<String, Object?> ? r : throw _Invalid(at);

T _enum<T extends Enum>(List<T> values, Object? name, String at) =>
    values.where((v) => v.name == name).firstOrNull ?? (throw _Invalid(at));

String _id(Object? v, String at) =>
    v is String && _slug.hasMatch(v) ? v : throw _Invalid(at);

String? _optionalId(Object? v, String at) => v == null ? null : _id(v, at);

DateTime _date(Object? v, String at) {
  if (v is String) {
    if (DateTime.tryParse(v) case final d?) return d.toUtc();
  }
  throw _Invalid(at);
}

double _unit(Object? v, String at) => switch (v) {
  final num n when n.isFinite && n >= 0 && n <= 1 => n.toDouble(),
  _ => throw _Invalid(at),
};

Bookmark _bookmark(Object? raw, String at) {
  final r = _record(raw, at);
  final target = _enum(BookmarkTarget.values, r['target'], '$at.target');
  final parentId = _optionalId(r['parentId'], '$at.parentId');
  if (parentId == null &&
      (target == BookmarkTarget.section || target == BookmarkTarget.chapter)) {
    throw _Invalid('$at.parentId');
  }
  return Bookmark(
    target: target,
    targetId: _id(r['targetId'], '$at.targetId'),
    parentId: parentId,
    createdAt: _date(r['createdAt'], '$at.createdAt'),
  );
}

ReadingProgress _progress(Object? raw, String at) {
  final r = _record(raw, at);
  final completed = r['completed'];
  if (completed is! bool) throw _Invalid('$at.completed');
  final contentVersion = r['contentVersion'];
  if (contentVersion is! String || contentVersion.isEmpty) {
    throw _Invalid('$at.contentVersion');
  }
  final revision = r['targetRevision'];
  if (revision != null && revision is! String) {
    throw _Invalid('$at.targetRevision');
  }
  final blockIndex = r['blockIndex'];
  if (blockIndex != null && (blockIndex is! int || blockIndex < 0)) {
    throw _Invalid('$at.blockIndex');
  }
  final blockOffset = r['blockOffset'];
  return ReadingProgress(
    target: _enum(ProgressTarget.values, r['target'], '$at.target'),
    targetId: _id(r['targetId'], '$at.targetId'),
    parentId: _id(r['parentId'], '$at.parentId'),
    fraction: _unit(r['fraction'], '$at.fraction'),
    completed: completed,
    contentVersion: contentVersion,
    updatedAt: _date(r['updatedAt'], '$at.updatedAt'),
    targetRevision: revision as String?,
    blockIndex: blockIndex as int?,
    blockOffset: blockOffset == null
        ? null
        : _unit(blockOffset, '$at.blockOffset'),
  );
}

/// What an import will write, decided before anything is written.
@immutable
class ImportPlan {
  const ImportPlan({
    required this.newBookmarks,
    required this.progressToSave,
    required this.keptBookmarks,
    required this.keptPositions,
    this.reviewsToSave = const [],
    this.keptReviews = 0,
    this.journeysToSave = const [],
    this.journeyStepsToSave = const [],
  });

  /// Saved items not on this device; added exactly as exported.
  final List<Bookmark> newBookmarks;

  /// Positions that are new here or move this device's position on.
  final List<ReadingProgress> progressToSave;

  /// Items or positions already here that the import leaves as they are.
  final int keptBookmarks;
  final int keptPositions;
  final List<ReviewItem> reviewsToSave;
  final int keptReviews;
  final List<JourneyEnrollment> journeysToSave;
  final List<JourneyStepProgress> journeyStepsToSave;
  int get changedJourneys => {
    ...journeysToSave.map((j) => j.journeyId),
    ...journeyStepsToSave.map((s) => s.journeyId),
  }.length;

  bool get isEmpty =>
      newBookmarks.isEmpty &&
      progressToSave.isEmpty &&
      reviewsToSave.isEmpty &&
      journeysToSave.isEmpty &&
      journeyStepsToSave.isEmpty;
}

/// Merges an archive into what is on the device, deterministically and
/// without ever removing anything:
///
/// - A **saved item** already here is kept as it is; one that is not is
///   added with its original date. Duplicates within the file keep the
///   earliest.
/// - A **position** replaces this device's only if it wins: a finished
///   position beats an unfinished one, otherwise the later `updatedAt`
///   wins, and a tie keeps what is here. Duplicates within the file are
///   resolved by the same rule first.
ImportPlan planImport({
  required List<Bookmark> localBookmarks,
  required List<ReadingProgress> localProgress,
  required ReadingDataArchive archive,
  List<ReviewItem> localReviews = const [],
  List<JourneyEnrollment> localJourneys = const [],
  List<JourneyStepProgress> localJourneySteps = const [],
}) {
  String bKey(Bookmark b) => '${b.target.name}/${b.targetId}';
  String pKey(ReadingProgress p) => '${p.target.name}/${p.targetId}';

  final incomingBookmarks = <String, Bookmark>{};
  for (final b in archive.bookmarks) {
    final prior = incomingBookmarks[bKey(b)];
    if (prior == null || b.createdAt.isBefore(prior.createdAt)) {
      incomingBookmarks[bKey(b)] = b;
    }
  }
  final here = {for (final b in localBookmarks) bKey(b)};
  final newBookmarks = [
    for (final MapEntry(:key, :value) in incomingBookmarks.entries)
      if (!here.contains(key)) value,
  ]..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  final incomingProgress = <String, ReadingProgress>{};
  for (final p in archive.progress) {
    final prior = incomingProgress[pKey(p)];
    if (prior == null || _wins(p, over: prior)) incomingProgress[pKey(p)] = p;
  }
  final localByKey = {for (final p in localProgress) pKey(p): p};
  final toSave = <ReadingProgress>[];
  var keptPositions = 0;
  for (final MapEntry(:key, :value) in incomingProgress.entries) {
    final local = localByKey[key];
    if (local == null || _wins(value, over: local)) {
      toSave.add(value);
    } else {
      keptPositions++;
    }
  }
  toSave.sort((a, b) => pKey(a).compareTo(pKey(b)));

  // A review history is a snapshot, not an event log: keep the later answer,
  // keeping the local snapshot on ties. Never add counters from two devices.
  final incomingReviews = <String, ReviewItem>{};
  for (final r in archive.reviews) {
    final prior = incomingReviews[r.questionKey];
    if (prior == null || r.lastAnsweredAt.isAfter(prior.lastAnsweredAt)) {
      incomingReviews[r.questionKey] = r;
    }
  }
  final localReviewByKey = {for (final r in localReviews) r.questionKey: r};
  final reviewsToSave = [
    for (final r in incomingReviews.values)
      if (localReviewByKey[r.questionKey] == null ||
          r.lastAnsweredAt.isAfter(
            localReviewByKey[r.questionKey]!.lastAnsweredAt,
          ))
        r,
  ]..sort((a, b) => a.questionKey.compareTo(b.questionKey));

  final journeyPlan = mergeJourneys(
    local: localJourneys,
    localSteps: localJourneySteps,
    incoming: archive.journeys,
    incomingSteps: archive.journeySteps,
  );
  return ImportPlan(
    journeysToSave: journeyPlan.enrollments,
    journeyStepsToSave: journeyPlan.steps,
    reviewsToSave: reviewsToSave,
    keptReviews: incomingReviews.length - reviewsToSave.length,
    newBookmarks: newBookmarks,
    progressToSave: toSave,
    keptBookmarks: incomingBookmarks.length - newBookmarks.length,
    keptPositions: keptPositions,
  );
}

/// Whether [p] should replace [over]: finished beats unfinished, then the
/// later update; ties keep [over].
bool _wins(ReadingProgress p, {required ReadingProgress over}) {
  if (p.completed != over.completed) return p.completed;
  return p.updatedAt.isAfter(over.updatedAt);
}

int _nonNegative(Object? v, String at) =>
    v is int && v >= 0 ? v : throw _Invalid(at);

ReviewItem _review(Object? raw, String at) {
  final r = _record(raw, at);
  final key = r['questionKey'];
  if (key is! String || key.trim().isEmpty || key.length > 1024) {
    throw _Invalid('$at.questionKey');
  }
  final box = r['box'];
  if (box is! int || box < 1 || box > 5) throw _Invalid('$at.box');
  final dueOn = _date(r['dueOn'], '$at.dueOn');
  if (dueOn != DateTime.utc(dueOn.year, dueOn.month, dueOn.day)) {
    throw _Invalid('$at.dueOn');
  }
  return ReviewItem(
    questionKey: key,
    box: box,
    dueOn: dueOn,
    lastAnsweredAt: _date(r['lastAnsweredAt'], '$at.lastAnsweredAt'),
    timesRight: _nonNegative(r['timesRight'], '$at.timesRight'),
    timesWrong: _nonNegative(r['timesWrong'], '$at.timesWrong'),
  );
}

JourneyEnrollment _journey(Object? raw, String at) {
  final r = _record(raw, at);
  final paused = r['paused'];
  if (paused is! bool) throw _Invalid('$at.paused');
  return JourneyEnrollment(
    journeyId: _id(r['journeyId'], '$at.journeyId'),
    startedAt: _date(r['startedAt'], '$at.startedAt'),
    updatedAt: _date(r['updatedAt'], '$at.updatedAt'),
    paused: paused,
  );
}

JourneyStepProgress _journeyStep(Object? raw, String at) {
  final r = _record(raw, at);
  final skipped = r['skipped'];
  if (skipped is! bool) throw _Invalid('$at.skipped');
  final keys = r['answeredKeys'];
  if (keys is! List ||
      keys.any((k) => k is! String || k.trim().isEmpty || k.length > 1024)) {
    throw _Invalid('$at.answeredKeys');
  }
  return JourneyStepProgress(
    journeyId: _id(r['journeyId'], '$at.journeyId'),
    stepId: _id(r['stepId'], '$at.stepId'),
    startedAt: _date(r['startedAt'], '$at.startedAt'),
    updatedAt: _date(r['updatedAt'], '$at.updatedAt'),
    completedAt: r['completedAt'] == null
        ? null
        : _date(r['completedAt'], '$at.completedAt'),
    skipped: skipped,
    answeredKeys: keys.cast<String>().toSet(),
  );
}
