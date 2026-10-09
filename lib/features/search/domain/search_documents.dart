import 'package:siyar_sahaba/features/search/domain/search_index.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';

/// The readable prose of [blocks], one string per piece. A quote whose
/// text is still pending from its source contributes nothing: neither a
/// placeholder nor the stand-in summary is searchable as if it were the
/// quote. Qur'anic verses are referenced, not stored, so they are not here.
List<String> searchableText(List<ContentBlock> blocks) => [
  for (final b in blocks)
    ...switch (b) {
      ParagraphBlock(:final text) || LessonBlock(:final text) => [text.ar],
      HadithQuoteBlock(textStatus: TextStatus.complete, :final text?) ||
      ReportQuoteBlock(
        textStatus: TextStatus.complete,
        :final text?,
      ) => [text.ar],
      DisputeNoteBlock(:final text, :final opinions) => [
        text.ar,
        for (final o in opinions) o.text.ar,
      ],
      _ => const <String>[],
    },
];

/// The searchable documents of the catalog (Arabic text): names, titles
/// and headings, plus summaries and passage text as body (see
/// [searchableText]).
List<SearchDocument> buildSearchDocuments({
  required List<Companion> companions,
  required List<Story> stories,
  required List<CompanionCategory> categories,
}) {
  final categoryNames = {for (final c in categories) c.id: c.name.ar};
  return [
    for (final c in companions) ...[
      SearchDocument(
        kind: SearchKind.companion,
        id: c.id,
        title: c.name.ar,
        subtitle: [?c.kunya?.ar, ...c.titles.map((t) => t.ar)].join(' · '),
        fields: [
          SearchField(c.name.ar, SearchField.nameWeight),
          SearchField(c.fullName.ar, SearchField.aliasWeight),
          if (c.kunya case final k?) SearchField(k.ar, SearchField.aliasWeight),
          for (final t in c.titles) SearchField(t.ar, SearchField.aliasWeight),
          for (final a in c.aliases) SearchField(a, SearchField.aliasWeight),
          for (final m in c.memberships)
            if (categoryNames[m.categoryId] case final name?)
              SearchField(name, SearchField.categoryWeight),
          SearchField.body(c.summary.ar),
        ],
      ),
      for (final s in c.sections)
        SearchDocument(
          kind: SearchKind.section,
          id: s.id,
          parentId: c.id,
          title: s.title.ar,
          subtitle: c.name.ar,
          fields: [
            SearchField(s.title.ar, SearchField.headingWeight),
            for (final t in searchableText(s.blocks)) SearchField.body(t),
          ],
        ),
    ],
    for (final s in stories) ...[
      SearchDocument(
        kind: SearchKind.story,
        id: s.id,
        title: s.title.ar,
        subtitle: s.synopsis.ar,
        fields: [
          SearchField(s.title.ar, SearchField.headingWeight),
          SearchField.body(s.synopsis.ar),
        ],
      ),
      for (final ch in s.chapters)
        SearchDocument(
          kind: SearchKind.chapter,
          id: ch.id,
          parentId: s.id,
          title: ch.title.ar,
          subtitle: s.title.ar,
          fields: [
            SearchField(ch.title.ar, SearchField.headingWeight),
            for (final t in searchableText(ch.blocks)) SearchField.body(t),
          ],
        ),
    ],
  ];
}
