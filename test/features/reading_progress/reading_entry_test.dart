import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/reading_progress/domain/reading_entry.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';

ReadingProgress _p(
  String id, {
  double fraction = 0.5,
  bool completed = false,
  int day = 1,
}) => ReadingProgress(
  target: ProgressTarget.section,
  targetId: id,
  parentId: 'c',
  fraction: fraction,
  completed: completed,
  contentVersion: '0.1.0',
  updatedAt: DateTime(2026, 10, day),
);

void main() {
  const ids = ['a', 'b', 'c'];

  test('nothing read: start at the first passage', () {
    final e = readingEntryFor(ids, const {});
    expect(e, isA<StartReading>());
    expect((e as StartReading).passageId, 'a');
  });

  test('the unfinished passage read most recently wins', () {
    final e = readingEntryFor(ids, {
      'a': _p('a', day: 3),
      'c': _p('c', fraction: 0.4, day: 5),
    });
    expect(e, isA<ResumeReading>());
    final r = e as ResumeReading;
    expect(r.passageId, 'c');
    expect(r.fraction, 0.4);
  });

  test('when the read ones are finished, the next unread one is next', () {
    final e = readingEntryFor(ids, {
      'a': _p('a', completed: true),
      'b': _p('b', completed: true),
    });
    // Not «resume at 0%» (decision Q4): the next passage.
    expect(e, isA<NextReading>());
    expect((e as NextReading).passageId, 'c');
  });

  test('one read out of order moves the reader on from there', () {
    // Chapter 2 of 4 read through a journey: chapter 3 is next, not 1.
    const four = ['a', 'b', 'c', 'd'];
    expect(
      (readingEntryFor(four, {'b': _p('b', completed: true)}) as NextReading)
          .passageId,
      'c',
    );
    expect(nextUnreadPassage(four, {'b': _p('b', completed: true)}), 'c');
    // Nothing left after the furthest: back to the first one not finished.
    expect(
      nextUnreadPassage(four, {
        'a': _p('a', completed: true),
        'd': _p('d', completed: true),
      }),
      'b',
    );
    expect(resumePassage(four, {'d': _p('d', completed: true)}), 'a');
    expect(resumePassage(four, const {}), isNull, reason: 'nothing read');
  });

  test('all finished', () {
    final e = readingEntryFor(ids, {
      for (final id in ids) id: _p(id, completed: true),
    });
    expect(e, isA<FinishedReading>());
    expect((e as FinishedReading).firstPassageId, 'a');
  });

  test('positions outside the work are ignored', () {
    final e = readingEntryFor(ids, {'gone': _p('gone')});
    expect(e, isA<StartReading>());
  });
}
