import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/reading_progress/domain/continue_items.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/shared/content/domain/content_target.dart';

ReadingProgress _p(
  ProgressTarget target,
  String parent,
  String id, {
  bool completed = false,
  int day = 1,
}) => ReadingProgress(
  target: target,
  targetId: id,
  parentId: parent,
  fraction: completed ? 1 : 0.4,
  completed: completed,
  contentVersion: '1',
  updatedAt: DateTime(2026, 11, day),
);

void main() {
  const s = ProgressTarget.section;
  const seerah = ProgressTarget.seerahChapter;
  final orders = {
    (s, 'abu-bakr'): ['ab.1', 'ab.2', 'ab.3'],
    (seerah, 'seerah'): ['c1', 'c2', 'c3', 'c4', 'c5'],
  };
  List<String>? orderOf(ProgressTarget t, String parent) => orders[(t, parent)];

  test('unfinished passages are listed as they are', () {
    final items = continueItems([
      _p(s, 'abu-bakr', 'ab.1', completed: true),
      _p(s, 'abu-bakr', 'ab.2', day: 2),
    ], orderOf);
    expect(items, hasLength(1));
    expect(items.single.isNext, isFalse);
    expect(items.single.passageId, 'ab.2');
  });

  test('a biography read in part offers its next section', () {
    // One section finished, none open: still «in progress» (the bug: it
    // was missing from «مكتبتي»).
    final items = continueItems([
      _p(s, 'abu-bakr', 'ab.1', completed: true),
    ], orderOf);
    expect(items.single.isNext, isTrue);
    expect(items.single.passageId, 'ab.2');
    expect(
      items.single.contentTarget,
      const ContentTarget.section('abu-bakr', 'ab.2'),
    );
  });

  test('the Seerah goes on after the furthest chapter read', () {
    final items = continueItems([
      _p(seerah, 'seerah', 'c4', completed: true),
    ], orderOf);
    expect(items.single.passageId, 'c5');
  });

  test('finished works, essays and unknown works offer nothing', () {
    expect(
      continueItems([
        for (final id in ['ab.1', 'ab.2', 'ab.3'])
          _p(s, 'abu-bakr', id, completed: true),
        _p(ProgressTarget.seerahTopic, 'seerah', 'mercy', completed: true),
        _p(s, 'gone', 'gone.1', completed: true),
      ], orderOf),
      isEmpty,
    );
  });

  test('most recent first', () {
    final items = continueItems([
      _p(seerah, 'seerah', 'c1', completed: true, day: 5),
      _p(s, 'abu-bakr', 'ab.1', day: 3),
    ], orderOf);
    expect(items.map((i) => i.passageId), ['c2', 'ab.1']);
  });

  test('only works with nothing unfinished need their order', () {
    expect(
      worksNeedingOrder([
        _p(s, 'abu-bakr', 'ab.1', completed: true),
        _p(s, 'abu-bakr', 'ab.2'),
        _p(seerah, 'seerah', 'c1', completed: true),
        _p(ProgressTarget.seerahTopic, 'seerah', 'mercy', completed: true),
      ]),
      {(seerah, 'seerah')},
    );
  });
}
