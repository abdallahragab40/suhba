import 'dart:convert';

/// Synthetic content for scale tests (plan task E09): [companions] copies of
/// one real companion's structure, under ids `scale-0001`…, named "صحابي
/// تجريبي" with a number, and one section (`scale-0001.long`) of
/// [passageWords] placeholder words.
///
/// It is test data only: generated in memory, never bundled or shown, and
/// its text is placeholder wording, not biography. [base] maps asset keys
/// (`assets/content/…`) to the committed draft build, which supplies the
/// structure; the result is a full set of asset keys to serve instead.
Map<String, String> scaleContent(
  Map<String, String> base, {
  int companions = 1000,
  int passageWords = 5000,
}) {
  const root = 'assets/content';
  Map<String, dynamic> read(String path) =>
      jsonDecode(base['$root/$path']!) as Map<String, dynamic>;

  final template = base['$root/companions/abu-bakr.json']!;
  final index = read('index/companions.json');
  final templateSummary = jsonEncode(
    (index['companions'] as List).firstWhere(
      (c) => (c as Map)['id'] == 'abu-bakr',
    ),
  );

  String idOf(int i) => 'scale-${i.toString().padLeft(4, '0')}';
  String nameOf(int i) => 'صحابي تجريبي $i';

  final out = Map.of(base)
    ..removeWhere((key, _) => key.startsWith('$root/companions/'));
  final summaries = <Object?>[];
  for (var i = 1; i <= companions; i++) {
    final id = idOf(i);
    final companion =
        jsonDecode(template.replaceAll('abu-bakr', id)) as Map<String, dynamic>
          ..['name'] = {'ar': nameOf(i)}
          ..['order'] = i
          ..['storyIds'] = <String>[];
    if (i == 1) {
      final sections = companion['sections'] as List;
      final paragraph = Map<String, dynamic>.of(
        ((sections.first as Map)['blocks'] as List).first
            as Map<String, dynamic>,
      );
      sections.insert(0, {
        'id': '$id.long',
        'kind': 'custom',
        'title': {'ar': 'نص طويل للقياس'},
        'blocks': _paragraphs(paragraph, passageWords),
      });
    }
    out['$root/companions/$id.json'] = jsonEncode(companion);
    summaries.add(
      (jsonDecode(templateSummary.replaceAll('abu-bakr', id))
            as Map<String, dynamic>)
        ..['name'] = {'ar': nameOf(i)}
        ..['order'] = i,
    );
  }
  index['companions'] = summaries;
  out['$root/index/companions.json'] = jsonEncode(index);

  final manifest = read('manifest.json')..['companionCount'] = companions;
  out['$root/manifest.json'] = jsonEncode(manifest);
  return out;
}

/// [words] placeholder words in paragraphs of 50, shaped like [template].
List<Map<String, dynamic>> _paragraphs(
  Map<String, dynamic> template,
  int words,
) {
  const vocabulary = ['نص', 'تجريبي', 'لقياس', 'أداء', 'القارئ', 'فقط'];
  final blocks = <Map<String, dynamic>>[];
  for (var start = 0; start < words; start += 50) {
    final count = (words - start).clamp(0, 50);
    final text = [
      for (var w = 0; w < count; w++)
        vocabulary[(start + w) % vocabulary.length],
    ].join(' ');
    blocks.add({
      ...template,
      'text': {'ar': '$text.'},
    });
  }
  return blocks;
}
