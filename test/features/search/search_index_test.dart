import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/features/search/domain/search_index.dart';

SearchDocument _doc(
  SearchKind kind,
  String id,
  List<SearchField> fields, {
  String? title,
}) => SearchDocument(kind: kind, id: id, title: title ?? id, fields: fields);

void main() {
  final abuBakr = _doc(SearchKind.companion, 'abu-bakr', const [
    SearchField('أبو بكر الصديق', SearchField.nameWeight),
    SearchField('عبد الله بن عثمان', SearchField.aliasWeight),
    SearchField('الصديق', SearchField.aliasWeight),
    SearchField('العشرة المبشرون بالجنة', SearchField.categoryWeight),
  ], title: 'أبو بكر الصديق');
  final umar = _doc(SearchKind.companion, 'umar', const [
    SearchField('عمر بن الخطاب', SearchField.nameWeight),
    SearchField('الفاروق', SearchField.aliasWeight),
    SearchField('العشرة المبشرون بالجنة', SearchField.categoryWeight),
  ], title: 'عمر بن الخطاب');
  final section = _doc(SearchKind.section, 'abu-bakr.hijrah', const [
    SearchField('صاحبه في الهجرة', SearchField.headingWeight),
  ]);
  final chapter = _doc(SearchKind.chapter, 'the-cave.3', const [
    SearchField('الطريق إلى المدينة', SearchField.headingWeight),
  ]);
  final index = SearchIndex([abuBakr, umar, section, chapter]);

  List<String> ids(String q) => [
    for (final h in index.search(q)) h.document.id,
  ];

  final cases = <(String, String, List<String>)>[
    ('without hamza', 'ابو بكر', ['abu-bakr']),
    ('with tanween', 'أبو بكرٍ', ['abu-bakr']),
    ('title only', 'الصديق', ['abu-bakr']),
    ('title with shadda', 'الصِّدِّيق', ['abu-bakr']),
    ('alias', 'الفاروق', ['umar']),
    ('full name', 'عبد الله بن عثمان', ['abu-bakr']),
    ('word prefix', 'الخط', ['umar']),
    ('heading', 'الهجرة', ['abu-bakr.hijrah']),
    ('ta marbuta folded', 'الهجره', ['abu-bakr.hijrah']),
    ('chapter heading', 'المدينه', ['the-cave.3']),
    ('every word must match', 'عمر الصديق', <String>[]),
    ('nothing', 'زيد', <String>[]),
    ('empty', '   ', <String>[]),
  ];
  for (final (name, query, expected) in cases) {
    test(name, () => expect(ids(query), expected));
  }

  test('a category matches its members, after name matches', () {
    expect(ids('العشرة').toSet(), {'abu-bakr', 'umar'});
  });

  test('a name match outranks a heading match', () {
    final index = SearchIndex([
      _doc(SearchKind.section, 's', const [
        SearchField('عمر والخلافة', SearchField.headingWeight),
      ]),
      umar,
    ]);
    expect(index.search('عمر').first.document.id, 'umar');
  });

  test('an exact name outranks a prefix', () {
    final index = SearchIndex([
      _doc(SearchKind.companion, 'long', const [
        SearchField('سعد بن معاذ', SearchField.nameWeight),
      ]),
      _doc(SearchKind.companion, 'exact', const [
        SearchField('سعد', SearchField.nameWeight),
      ]),
    ]);
    expect(index.search('سعد').map((h) => h.document.id), ['exact', 'long']);
  });

  test('a query takes well under a frame on 2,000 documents', () {
    final big = SearchIndex([
      for (var i = 0; i < 2000; i++)
        _doc(SearchKind.companion, 'c$i', [
          SearchField('صحابي رقم $i', SearchField.nameWeight),
          SearchField('لقب $i', SearchField.aliasWeight),
          const SearchField('المهاجرون', SearchField.categoryWeight),
        ]),
    ]);
    big.search('صحابي'); // warm up
    final watch = Stopwatch()..start();
    for (var i = 0; i < 10; i++) {
      big.search('صحابي رقم 19');
    }
    final perQuery = watch.elapsedMicroseconds / 10;
    expect(perQuery, lessThan(16000), reason: '$perQuery µs per query');
  });
}
