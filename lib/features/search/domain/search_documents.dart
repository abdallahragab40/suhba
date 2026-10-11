import 'package:suhba/features/search/domain/search_index.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/content_block.dart';
import 'package:suhba/shared/content/domain/seerah.dart';
import 'package:suhba/shared/content/domain/story.dart';

/// The readable prose of [blocks] (see [readableProse]), headings
/// included. A quote whose text is still pending from its source
/// contributes nothing, and Qur'anic verses are referenced, not stored.
List<String> searchableText(List<ContentBlock> blocks) =>
    readableProse(blocks, headings: true);

/// The searchable documents of the catalog (Arabic text): names, titles
/// and headings, plus summaries and passage text as body (see
/// [searchableText]). The Seerah's chapters and essays, the events and the
/// places are documents too.
List<SearchDocument> buildSearchDocuments({
  required List<Companion> companions,
  required List<Story> stories,
  required List<CompanionCategory> categories,
  List<SeerahChapter> seerahChapters = const [],
  List<SeerahTopic> seerahTopics = const [],
  List<HistoricalEvent> events = const [],
  List<HistoricalPlace> places = const [],
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
    for (final c in seerahChapters)
      SearchDocument(
        kind: SearchKind.seerahChapter,
        id: c.id,
        title: c.title.ar,
        subtitle: c.abstract.ar,
        fields: [
          SearchField(c.title.ar, SearchField.headingWeight),
          SearchField.body(c.abstract.ar),
          for (final t in searchableText(c.blocks)) SearchField.body(t),
        ],
      ),
    for (final t in seerahTopics)
      SearchDocument(
        kind: SearchKind.seerahTopic,
        id: t.id,
        title: t.title.ar,
        subtitle: t.abstract.ar,
        fields: [
          SearchField(t.title.ar, SearchField.headingWeight),
          SearchField.body(t.abstract.ar),
          for (final text in searchableText(t.blocks)) SearchField.body(text),
        ],
      ),
    for (final e in events)
      SearchDocument(
        kind: SearchKind.event,
        id: e.id,
        title: e.name.ar,
        subtitle: e.place?.ar,
        fields: [
          SearchField(e.name.ar, SearchField.headingWeight),
          SearchField.body(e.summary.ar),
          if (e.context case final c?) SearchField.body(c.ar),
          if (e.outcome case final o?) SearchField.body(o.ar),
        ],
      ),
    for (final p in places)
      SearchDocument(
        kind: SearchKind.place,
        id: p.id,
        title: p.name.ar,
        subtitle: p.modernName?.ar,
        fields: [
          SearchField(p.name.ar, SearchField.headingWeight),
          if (p.modernName case final m?)
            SearchField(m.ar, SearchField.aliasWeight),
          SearchField.body(p.summary.ar),
        ],
      ),
  ];
}
