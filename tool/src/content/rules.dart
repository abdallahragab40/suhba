import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/core/domain/quran_ref.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/shared/content/data/dto/atlas_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/block_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/catalog_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/common_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/companion_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/seerah_dto.dart';
import 'package:siyar_sahaba/shared/content/data/dto/story_dto.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/domain/content_block.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';

import 'content_hash.dart';
import 'content_tree.dart';
import 'issues.dart';

/// Runs rules V2–V13 over a parsed [tree]. Rules that only matter for a
/// store release (V9 pending work, V11 closure) are errors on the published
/// channel; on the draft channel pending work is counted instead, and the
/// counts per item key are returned.
Map<String, int> checkRules(
  ContentTree tree,
  ContentChannel channel,
  IssueSink sink,
) {
  final rules = _Rules(tree, channel, sink)..run();
  return rules._pendingByItem;
}

/// A citation found somewhere in an item, with its path.
typedef _Cited = (String path, CitationDto citation);

class _Rules {
  _Rules(this.tree, this.channel, this.sink);

  final ContentTree tree;
  final ContentChannel channel;
  final IssueSink sink;

  bool get _published => channel == ContentChannel.published;

  void run() {
    if (tree.meta == null) {
      sink.error('V2', 'meta.json', '', 'meta.json is missing or invalid.');
    }
    _duplicates();
    for (final item in tree.companions) {
      _companion(item);
    }
    for (final item in tree.stories) {
      _story(item);
    }
    for (final item in tree.events) {
      _event(item);
    }
    for (final item in tree.categories) {
      _category(item);
    }
    for (final item in tree.people) {
      _noHonorificInName(item, r'$.name', item.dto.name);
    }
    for (final item in tree.places) {
      _place(item);
    }
    if (tree.seerah case final seerah?) _seerah(seerah);
    for (final item in tree.seerahChapters) {
      _seerahChapter(item);
    }
    for (final item in tree.seerahTopics) {
      _seerahTopic(item);
    }
    for (final item in tree.visuals) {
      _visual(item);
    }
    for (final item in tree.allItems) {
      _wording(item, item.raw, item.at(r'$'));
      _approval(item);
    }
    _orphanApprovals();
    if (_published) _publicationClosure();
  }

  // ── V2: IDs and references ────────────────────────────────────────────

  void _duplicates() {
    void check<T>(List<Item<T>> items) {
      final seen = <String>{};
      for (final item in items) {
        if (!seen.add(item.id)) {
          sink.error('V2', item.file, item.path, 'Duplicate id "${item.id}".');
        }
      }
    }

    check(tree.sources);
    check(tree.categories);
    check(tree.people);
    check(tree.events);
    check(tree.companions);
    check(tree.stories);
    check(tree.places);
    check(tree.seerahChapters);
    check(tree.seerahTopics);
    check(tree.visuals);
  }

  void _fileNameMatchesId(Item<Object> item, String folder) {
    if (item.file != '$folder/${item.id}.json') {
      sink.error(
        'V2',
        item.file,
        r'$.id',
        'File name must be "$folder/${item.id}.json" to match the id.',
      );
    }
  }

  void _childIds(Item<Object> item, String path, Iterable<String> ids) {
    final seen = <String>{};
    var index = 0;
    for (final id in ids) {
      if (!id.startsWith('${item.id}.')) {
        sink.error(
          'V2',
          item.file,
          '$path[$index].id',
          'Id "$id" must start with "${item.id}." so it is unique app-wide.',
        );
      }
      if (!seen.add(id)) {
        sink.error('V2', item.file, '$path[$index].id', 'Duplicate id "$id".');
      }
      index++;
    }
  }

  void _ref(
    Item<Object> item,
    String path,
    String id,
    Map<String, Object> pool,
    ContentKind kind,
  ) {
    if (pool.containsKey(id)) return;
    // Its own file failed the schema and is already reported.
    if (tree.invalidKeys.contains('${kind.name}.$id')) return;
    sink.error('V2', item.file, item.at(path), 'Unknown ${kind.name} "$id".');
  }

  void _personRef(Item<Object> item, String path, PersonRefDto ref) {
    if (ref.companionId case final id?) {
      _ref(
        item,
        '$path.companionId',
        id,
        tree.companionById,
        ContentKind.companion,
      );
    }
    if (ref.personId case final id?) {
      _ref(item, '$path.personId', id, tree.personById, ContentKind.person);
    }
  }

  void _refs(
    Item<Object> item,
    String path,
    List<String> ids,
    Map<String, Object> pool,
    ContentKind kind,
  ) {
    for (var i = 0; i < ids.length; i++) {
      _ref(item, '$path[$i]', ids[i], pool, kind);
    }
  }

  // ── Items ─────────────────────────────────────────────────────────────

  void _companion(Item<CompanionDto> item) {
    final c = item.dto;
    _fileNameMatchesId(item, 'companions');
    _childIds(item, r'$.sections', c.sections.map((s) => s.id));
    _childIds(item, r'$.timeline', c.timeline.map((t) => t.id));

    for (final name in [
      (r'$.name', c.name),
      (r'$.fullName', c.fullName),
      if (c.kunya != null) (r'$.kunya', c.kunya!),
      for (var i = 0; i < c.titles.length; i++) ('\$.titles[$i]', c.titles[i]),
    ]) {
      _noHonorificInName(item, name.$1, name.$2);
    }

    if (c.references.isEmpty) {
      sink.error(
        'V3',
        item.file,
        r'$.references',
        'A biography needs at '
            'least one work-level reference.',
      );
    }
    for (var i = 0; i < c.references.length; i++) {
      _ref(
        item,
        '\$.references[$i]',
        c.references[i],
        tree.sourceById,
        ContentKind.source,
      );
    }
    for (var i = 0; i < c.memberships.length; i++) {
      final m = c.memberships[i];
      _ref(
        item,
        '\$.memberships[$i].categoryId',
        m.categoryId,
        tree.categoryById,
        ContentKind.category,
      );
      _needsCitations(item, '\$.memberships[$i]', m.citations, null);
    }
    for (var i = 0; i < c.relations.length; i++) {
      _personRef(item, '\$.relations[$i].person', c.relations[i].person);
    }
    for (var i = 0; i < c.storyIds.length; i++) {
      final id = c.storyIds[i];
      _ref(item, '\$.storyIds[$i]', id, tree.storyById, ContentKind.story);
      final story = tree.storyById[id];
      if (story != null && !story.dto.companionIds.contains(c.id)) {
        sink.warning(
          'V2',
          item.file,
          '\$.storyIds[$i]',
          'Story "$id" does not list "${c.id}" in its companionIds.',
        );
      }
    }
    final sectionIds = {for (final s in c.sections) s.id};
    for (var i = 0; i < c.timeline.length; i++) {
      final t = c.timeline[i];
      final path = '\$.timeline[$i]';
      if (t.eventId case final id?) {
        _ref(item, '$path.eventId', id, tree.eventById, ContentKind.event);
      }
      if (t.sectionId case final id? when !sectionIds.contains(id)) {
        sink.error(
          'V2',
          item.file,
          '$path.sectionId',
          'Unknown section "$id" (must be in this companion).',
        );
      }
      _needsCitations(item, path, t.citations, t.reliability);
      _date(item, '$path.date', t.date);
    }
    for (final (key, claim) in [('birth', c.birth), ('death', c.death)]) {
      if (claim == null) continue;
      final unknown = claim.date.precision == DatePrecision.unknown;
      _needsCitations(
        item,
        '\$.$key',
        claim.citations,
        unknown ? Reliability.unknown : claim.reliability,
      );
      _date(item, '\$.$key.date', claim.date);
    }
    for (var i = 0; i < c.atAGlance.length; i++) {
      final f = c.atAGlance[i];
      _needsCitations(item, '\$.atAGlance[$i]', f.citations, f.reliability);
      if (f.date != null) _date(item, '\$.atAGlance[$i].date', f.date!);
    }
    for (var s = 0; s < c.sections.length; s++) {
      final blocks = c.sections[s].blocks;
      for (var b = 0; b < blocks.length; b++) {
        _block(item, '\$.sections[$s].blocks[$b]', blocks[b]);
      }
    }
    _citations(item, _companionCitations(c));
  }

  void _story(Item<StoryDto> item) {
    final story = item.dto;
    _fileNameMatchesId(item, 'stories');
    _childIds(item, r'$.chapters', story.chapters.map((c) => c.id));
    for (var i = 0; i < story.companionIds.length; i++) {
      _ref(
        item,
        '\$.companionIds[$i]',
        story.companionIds[i],
        tree.companionById,
        ContentKind.companion,
      );
    }
    for (var i = 0; i < story.eventIds.length; i++) {
      _ref(
        item,
        '\$.eventIds[$i]',
        story.eventIds[i],
        tree.eventById,
        ContentKind.event,
      );
    }
    final cited = <_Cited>[];
    for (var c = 0; c < story.chapters.length; c++) {
      final blocks = story.chapters[c].blocks;
      for (var b = 0; b < blocks.length; b++) {
        final path = '\$.chapters[$c].blocks[$b]';
        _block(item, path, blocks[b]);
        cited.addAll(_blockCitations(path, blocks[b]));
      }
    }
    _citations(item, cited);
  }

  void _event(Item<HistoricalEventDto> item) {
    final e = item.dto;
    _needsCitations(item, r'$', e.citations, null);
    _refs(item, r'$.placeIds', e.placeIds, tree.placeById, ContentKind.place);
    for (var i = 0; i < e.participants.length; i++) {
      _personRef(item, '\$.participants[$i]', e.participants[i]);
    }
    _date(item, r'$.date', e.date);
    _citations(item, [
      for (var i = 0; i < e.citations.length; i++)
        ('\$.citations[$i]', e.citations[i]),
    ]);
  }

  void _category(Item<CategoryDto> item) {
    _noHonorificInName(item, r'$.name', item.dto.name);
    final basis = item.dto.basis;
    if (basis == null) return;
    _block(item, r'$.basis', basis);
    _citations(item, _blockCitations(r'$.basis', basis));
  }

  void _place(Item<PlaceDto> item) {
    final p = item.dto;
    _noHonorificInName(item, r'$.name', p.name);
    _needsCitations(item, r'$', p.citations, p.reliability);
    _citations(item, _list(r'$', p.citations));
  }

  void _seerah(Item<SeerahDto> item) {
    final s = item.dto;
    if (item.file != 'seerah/seerah.json') {
      sink.error('V2', item.file, '', 'The Seerah must be seerah/seerah.json.');
    }
    _refs(
      item,
      r'$.chapterIds',
      s.chapterIds,
      tree.seerahChapterById,
      ContentKind.seerahChapter,
    );
    _refs(
      item,
      r'$.topicIds',
      s.topicIds,
      tree.seerahTopicById,
      ContentKind.seerahTopic,
    );
    _refs(
      item,
      r'$.featuredEventIds',
      s.featuredEventIds,
      tree.eventById,
      ContentKind.event,
    );
    _refs(
      item,
      r'$.featuredPlaceIds',
      s.featuredPlaceIds,
      tree.placeById,
      ContentKind.place,
    );
    _refs(
      item,
      r'$.companionIds',
      s.companionIds,
      tree.companionById,
      ContentKind.companion,
    );
    _refs(
      item,
      r'$.visualIds',
      s.visualIds,
      tree.visualById,
      ContentKind.visual,
    );
    _refs(
      item,
      r'$.references',
      s.references,
      tree.sourceById,
      ContentKind.source,
    );
    // Every chapter and topic must be in the reading order, or no screen
    // could reach it.
    for (final (items, listed, what) in [
      (tree.seerahChapters, s.chapterIds, 'chapterIds'),
      (tree.seerahTopics, s.topicIds, 'topicIds'),
    ]) {
      for (final i in items) {
        if (!listed.contains(i.id)) {
          sink.error(
            'V2',
            i.file,
            r'$.id',
            '"${i.id}" is not in seerah/seerah.json $what, so nothing '
                'links to it.',
          );
        }
      }
    }
    for (var e = 0; e < s.eras.length; e++) {
      final era = s.eras[e];
      final path = '\$.eras[$e]';
      for (var i = 0; i < era.chapterIds.length; i++) {
        if (!s.chapterIds.contains(era.chapterIds[i])) {
          sink.error(
            'V2',
            item.file,
            '$path.chapterIds[$i]',
            'Chapter "${era.chapterIds[i]}" is not in chapterIds.',
          );
        }
      }
      _needsCitations(item, path, era.citations, era.reliability);
      _date(item, '$path.date', era.date);
    }
    for (var b = 0; b < s.introduction.length; b++) {
      _block(item, '\$.introduction[$b]', s.introduction[b]);
    }
    _citations(item, _itemCitations(item));
  }

  void _seerahChapter(Item<SeerahChapterDto> item) {
    final c = item.dto;
    _fileNameMatchesId(item, 'seerah/chapters');
    _workRefs(item, c.references);
    _refs(item, r'$.eventIds', c.eventIds, tree.eventById, ContentKind.event);
    _refs(item, r'$.placeIds', c.placeIds, tree.placeById, ContentKind.place);
    _refs(
      item,
      r'$.companionIds',
      c.companionIds,
      tree.companionById,
      ContentKind.companion,
    );
    _refs(
      item,
      r'$.visualIds',
      c.visualIds,
      tree.visualById,
      ContentKind.visual,
    );
    _date(item, r'$.date', c.date);
    for (var b = 0; b < c.blocks.length; b++) {
      _block(item, '\$.blocks[$b]', c.blocks[b]);
    }
    _citations(item, _itemCitations(item));
  }

  void _seerahTopic(Item<SeerahTopicDto> item) {
    final t = item.dto;
    _fileNameMatchesId(item, 'seerah/topics');
    _workRefs(item, t.references);
    _refs(
      item,
      r'$.chapterIds',
      t.chapterIds,
      tree.seerahChapterById,
      ContentKind.seerahChapter,
    );
    _refs(
      item,
      r'$.companionIds',
      t.companionIds,
      tree.companionById,
      ContentKind.companion,
    );
    for (var b = 0; b < t.blocks.length; b++) {
      _block(item, '\$.blocks[$b]', t.blocks[b]);
    }
    _citations(item, _itemCitations(item));
  }

  /// A passage's work-level bibliography: at least one, all known.
  void _workRefs(Item<Object> item, List<String> references) {
    if (references.isEmpty) {
      sink.error(
        'V3',
        item.file,
        r'$.references',
        'A passage needs at least one work-level reference.',
      );
    }
    _refs(
      item,
      r'$.references',
      references,
      tree.sourceById,
      ContentKind.source,
    );
  }

  // ── V13: visuals ────────────────────────────────────────────────────────

  void _visual(Item<VisualDto> item) {
    final v = item.dto;
    _fileNameMatchesId(item, 'visuals');

    // Only the data of the visual's own type may be filled in, so nothing
    // is authored that the reader never sees.
    final present = <String, bool>{
      'companionId': v.companionId != null,
      'route': v.route.isNotEmpty,
      'edges': v.edges.isNotEmpty,
      'steps': v.steps.isNotEmpty,
      'bands': v.bands.isNotEmpty,
      'placeId': v.placeId != null,
      'callouts': v.callouts.isNotEmpty,
      'placeIds': v.placeIds.isNotEmpty,
      'eventIds': v.eventIds.isNotEmpty,
    };
    final allowed = switch (v.type) {
      InfographicType.timeline => {'companionId', 'eventIds'},
      InfographicType.map => {'placeIds', 'route'},
      InfographicType.relationships => {'edges'},
      InfographicType.sequence => {'steps', 'eventIds'},
      InfographicType.periods => {'bands'},
      InfographicType.placePanel => {'placeId', 'callouts'},
    };
    for (final MapEntry(:key, :value) in present.entries) {
      if (value && !allowed.contains(key)) {
        sink.error(
          'V13',
          item.file,
          '\$.$key',
          '"$key" does not apply to a ${v.type.name} visual.',
        );
      }
    }

    _refs(item, r'$.eventIds', v.eventIds, tree.eventById, ContentKind.event);
    _refs(item, r'$.placeIds', v.placeIds, tree.placeById, ContentKind.place);
    if (v.companionId case final id?) {
      _ref(
        item,
        r'$.companionId',
        id,
        tree.companionById,
        ContentKind.companion,
      );
      final timeline = tree.companionById[id]?.dto.timeline;
      if (timeline != null && timeline.isEmpty) {
        sink.error(
          'V13',
          item.file,
          r'$.companionId',
          'Companion "$id" has no timeline entries to show.',
        );
      }
    }
    if (v.placeId case final id?) {
      _ref(item, r'$.placeId', id, tree.placeById, ContentKind.place);
    }
    for (var i = 0; i < v.route.length; i++) {
      final leg = v.route[i];
      final path = '\$.route[$i]';
      for (final (key, id) in [('from', leg.from), ('to', leg.to)]) {
        if (!v.placeIds.contains(id)) {
          sink.error(
            'V13',
            item.file,
            '$path.$key',
            'A journey can only join places shown on the map ("$id" is not '
                'in placeIds).',
          );
        }
      }
      _needsCitations(item, path, leg.citations, leg.reliability);
    }
    for (var i = 0; i < v.edges.length; i++) {
      final e = v.edges[i];
      final path = '\$.edges[$i]';
      _personRef(item, '$path.from', e.from);
      _personRef(item, '$path.to', e.to);
      _needsCitations(item, path, e.citations, e.reliability);
    }
    for (var i = 0; i < v.steps.length; i++) {
      final s = v.steps[i];
      final path = '\$.steps[$i]';
      if (s.placeId case final id?) {
        _ref(item, '$path.placeId', id, tree.placeById, ContentKind.place);
      }
      if (s.date case final d?) _date(item, '$path.date', d);
      _needsCitations(item, path, s.citations, s.reliability);
    }
    for (var i = 0; i < v.bands.length; i++) {
      final b = v.bands[i];
      final path = '\$.bands[$i]';
      if (b.date.precision == DatePrecision.unknown) {
        sink.error(
          'V13',
          item.file,
          '$path.date',
          'A period with an unknown date cannot be drawn as a band; leave '
              'it out and say so in the notes.',
        );
      }
      _date(item, '$path.date', b.date);
      _needsCitations(item, path, b.citations, b.reliability);
    }
    for (var i = 0; i < v.callouts.length; i++) {
      final c = v.callouts[i];
      _needsCitations(item, '\$.callouts[$i]', c.citations, c.reliability);
    }
    _citations(item, _itemCitations(item));
  }

  // ── V3 / V4 / V9 / V10: blocks ──────────────────────────────────────────

  void _block(Item<Object> item, String path, ContentBlockDto block) {
    switch (block) {
      case ParagraphBlockDto(:final reliability, :final citations):
        _needsCitations(item, path, citations, reliability);
        if (reliability == Reliability.disputed) {
          sink.warning(
            'V4',
            item.file,
            item.at(path),
            'A disputed claim '
                'should be a disputeNote listing each opinion with its sources.',
          );
        }
      case HadithQuoteBlockDto(
        :final textStatus,
        :final citations,
        :final text,
      ):
        _quote(item, path, textStatus, citations, text, hadith: true);
      case ReportQuoteBlockDto(
        :final textStatus,
        :final citations,
        :final text,
      ):
        _quote(item, path, textStatus, citations, text, hadith: false);
      case DisputeNoteBlockDto(:final opinions):
        if (opinions.length < 2) {
          sink.error(
            'V4',
            item.file,
            item.at('$path.opinions'),
            'A dispute needs at least two opinions.',
          );
        }
        for (var i = 0; i < opinions.length; i++) {
          _needsCitations(
            item,
            '$path.opinions[$i]',
            opinions[i].citations,
            null,
          );
        }
      case QuranQuoteBlockDto(:final ref):
        _quranRef(item, '$path.ref', ref);
      case LessonBlockDto() || HeadingBlockDto():
        break; // Commentary or structure; reviewed, not sourced by claim.
      case InfographicBlockDto(:final visualId):
        _ref(
          item,
          '$path.visualId',
          visualId,
          tree.visualById,
          ContentKind.visual,
        );
    }
  }

  void _quote(
    Item<Object> item,
    String path,
    TextStatus status,
    List<CitationDto> citations,
    LocalizedTextDto? text, {
    required bool hadith,
  }) {
    if (citations.isEmpty) {
      sink.error('V3', item.file, item.at(path), 'A quotation needs a source.');
    }
    if (status == TextStatus.complete && text == null) {
      sink.error(
        'V3',
        item.file,
        item.at(path),
        'textStatus is "complete" but there is no text.',
      );
    }
    if (status == TextStatus.pendingFromSource) {
      _pending(item, path, 'quoted text still to be copied from the source');
    }
    if (hadith) {
      final graded = citations.any((c) => c.grading != null);
      final fromCollection = citations.any(
        (c) =>
            tree.sourceById[c.sourceId]?.dto.type ==
            SourceType.hadithCollection,
      );
      if (!fromCollection) {
        sink.error(
          'V3',
          item.file,
          item.at(path),
          'A hadith must cite a hadith collection.',
        );
      }
      if (!graded) _pending(item, path, 'hadith grading not recorded');
    }
  }

  // ── V3: citations present ─────────────────────────────────────────────

  /// Claims need at least one citation unless their reliability is unknown.
  void _needsCitations(
    Item<Object> item,
    String path,
    List<CitationDto> citations,
    Reliability? reliability,
  ) {
    if (reliability == Reliability.unknown) return;
    if (citations.isEmpty) {
      sink.error(
        'V3',
        item.file,
        item.at(path),
        'This claim needs at least '
            'one citation (or reliability "unknown").',
      );
    }
  }

  // ── V2 / V9 / V10: each citation ──────────────────────────────────────

  void _citations(Item<Object> item, Iterable<_Cited> cited) {
    for (final (path, c) in cited) {
      final source = tree.sourceById[c.sourceId];
      _ref(
        item,
        '$path.sourceId',
        c.sourceId,
        tree.sourceById,
        ContentKind.source,
      );
      final isQuran = source?.dto.type == SourceType.quran;
      if (c.quranRef != null && source != null && !isQuran) {
        sink.error(
          'V2',
          item.file,
          item.at(path),
          'quranRef is only valid when citing the Qur\'an.',
        );
      }
      if (isQuran && c.quranRef == null) {
        sink.error(
          'V2',
          item.file,
          item.at(path),
          'A Qur\'an citation needs a quranRef.',
        );
      }
      if (c.quranRef case final ref?) _quranRef(item, '$path.quranRef', ref);

      final hasLocator =
          c.volume != null ||
          c.page != null ||
          c.hadithNumber != null ||
          c.quranRef != null;
      if (c.locatorStatus == LocatorStatus.complete && !hasLocator) {
        sink.error(
          'V9',
          item.file,
          item.at(path),
          'locatorStatus is '
              '"complete" but no volume, page, hadith number or quranRef is '
              'given.',
        );
      }
      if (c.locatorStatus == LocatorStatus.pending) {
        _pending(item, path, 'citation locator not yet checked');
      }
    }
  }

  void _quranRef(Item<Object> item, String path, QuranRefDto ref) {
    final valid = QuranRef(
      surah: ref.surah,
      ayahFrom: ref.ayahFrom,
      ayahTo: ref.ayahTo,
    ).isValid;
    if (!valid) {
      sink.error(
        'V10',
        item.file,
        item.at(path),
        'No such ayah: '
            '${ref.surah}:${ref.ayahFrom}${ref.ayahTo == null ? '' : '-${ref.ayahTo}'}.',
      );
    }
  }

  // ── V9: pending work ──────────────────────────────────────────────────

  final _pendingByItem = <String, int>{};

  void _pending(Item<Object> item, String path, String what) {
    if (_published) {
      // Unapproved items are left out of a published build entirely.
      if (!item.isApproved) return;
      sink.error(
        'V9',
        item.file,
        item.at(path),
        'Not ready to publish: $what.',
      );
    } else {
      _pendingByItem.update(item.key, (n) => n + 1, ifAbsent: () => 1);
    }
  }

  // ── V5: wording ───────────────────────────────────────────────────────

  static const _companionHonorifics = [
    'رضي الله عن',
    'رضى الله عن',
    'عليه السلام',
    'عليها السلام',
  ];

  static const _abbreviations = ['(ص)', 'صلعم', '(رض)', '(ع)'];

  void _noHonorificInName(Item<Object> item, String path, LocalizedTextDto t) {
    for (final h in _companionHonorifics) {
      if (t.ar.contains(h)) {
        sink.error(
          'V5',
          item.file,
          item.at(path),
          'Do not write "$h" in '
              'a name field; the app adds the honorific itself.',
        );
      }
    }
  }

  /// Walks every string in the raw JSON for abbreviated honorifics.
  void _wording(Item<Object> item, Object? value, String path) {
    if (value is Map) {
      for (final MapEntry(:key, value: v) in value.entries) {
        _wording(item, v, '$path.$key');
      }
    } else if (value is List) {
      for (var i = 0; i < value.length; i++) {
        _wording(item, value[i], '$path[$i]');
      }
    } else if (value is String) {
      for (final a in _abbreviations) {
        if (value.contains(a)) {
          sink.error(
            'V5',
            item.file,
            path,
            'Write the honorific in full '
                '(ﷺ / رضي الله عنه) instead of "$a".',
          );
        }
      }
    }
  }

  // ── V6 / V7 / V8: approvals ───────────────────────────────────────────

  void _approval(Item<Object> item) {
    final record = tree.approvals[item.key];
    if (!item.isApproved) {
      if (record != null) {
        sink.warning(
          'V6',
          record.file,
          '',
          'Approval record exists but the '
              'item\'s status is "${item.review.status.name}".',
        );
      }
      return;
    }
    if (record == null) {
      sink.error(
        'V6',
        item.file,
        item.at(r'$.review.status'),
        'Marked '
            'approved, but there is no reviews/${item.key}.json record.',
      );
      return;
    }
    final a = record.dto;
    final reviewer = tree.reviewers.where((r) => r.id == a.reviewerId);
    if (reviewer.isEmpty) {
      sink.error(
        'V6',
        record.file,
        r'$.reviewerId',
        'Reviewer '
            '"${a.reviewerId}" is not in reviewers.json; only registered, '
            'qualified reviewers can approve content.',
      );
    }
    final checklist = a.checklist;
    final passed =
        checklist.sourcesMatch &&
        checklist.gradingsCorrect &&
        checklist.noEmbellishment &&
        checklist.reliabilityCorrect &&
        checklist.honorificsCorrect;
    if (!passed) {
      sink.error(
        'V6',
        record.file,
        r'$.checklist',
        'Every checklist item must be true to approve.',
      );
    }
    final hash = contentHash(item.raw);
    if (a.contentHash != hash) {
      sink.error(
        'V7',
        record.file,
        r'$.contentHash',
        'The content changed '
            'after approval (current hash $hash); it must be reviewed again.',
      );
    }
    if (item.review.editorialFlags.contains(EditorialFlag.fitnaAdjacent) &&
        !checklist.fitnaSignOff) {
      sink.error(
        'V8',
        record.file,
        r'$.checklist.fitnaSignOff',
        'This item '
            'touches the fitna and needs the reviewer\'s explicit sign-off.',
      );
    }
  }

  void _orphanApprovals() {
    final keys = {for (final i in tree.allItems) i.key};
    for (final MapEntry(key: key, value: record) in tree.approvals.entries) {
      final expected = 'reviews/$key.json';
      if (record.file != expected) {
        sink.error(
          'V2',
          record.file,
          '',
          'Approval file must be named '
              '"$expected".',
        );
      }
      if (!keys.contains(key)) {
        sink.error(
          'V2',
          record.file,
          '',
          'Approves "$key", which does not '
              'exist.',
        );
      }
    }
  }

  // ── V11: publication closure ──────────────────────────────────────────

  void _publicationClosure() {
    final approvedCompanions = tree.companions.where((c) => c.isApproved);
    if (approvedCompanions.isEmpty) {
      sink.error(
        'V11',
        'companions/',
        '',
        'Nothing to publish: no companion '
            'is approved. Approval requires a registered reviewer.',
      );
    }
    void needApproved(Item<Object> from, String what, Item<Object>? target) {
      if (target != null && !target.isApproved) {
        sink.error(
          'V11',
          from.file,
          from.path,
          'Approved ${from.key} uses '
              '$what "${target.id}", which is not approved.',
        );
      }
    }

    for (final item in tree.allItems.where((i) => i.isApproved)) {
      for (final (_, c) in _itemCitations(item)) {
        needApproved(item, 'source', tree.sourceById[c.sourceId]);
      }
      for (final id in _visualRefs(item)) {
        needApproved(item, 'visual', tree.visualById[id]);
      }
      final dto = item.dto;
      switch (dto) {
        case SeerahChapterDto():
          for (final id in dto.eventIds) {
            needApproved(item, 'event', tree.eventById[id]);
          }
          for (final id in dto.placeIds) {
            needApproved(item, 'place', tree.placeById[id]);
          }
        case HistoricalEventDto():
          for (final id in dto.placeIds) {
            needApproved(item, 'place', tree.placeById[id]);
          }
        case VisualDto():
          // A visual's marks are its records: each must be approved too.
          for (final id in dto.eventIds) {
            needApproved(item, 'event', tree.eventById[id]);
          }
          for (final id in [...dto.placeIds, ?dto.placeId]) {
            needApproved(item, 'place', tree.placeById[id]);
          }
          if (dto.companionId case final id?) {
            needApproved(item, 'companion', tree.companionById[id]);
          }
          for (final s in dto.steps) {
            if (s.placeId case final id?) {
              needApproved(item, 'place', tree.placeById[id]);
            }
          }
        case _:
          break;
      }
      if (dto is CompanionDto) {
        for (final id in dto.references) {
          needApproved(item, 'source', tree.sourceById[id]);
        }
        for (final m in dto.memberships) {
          needApproved(item, 'category', tree.categoryById[m.categoryId]);
        }
        for (final t in dto.timeline) {
          if (t.eventId case final id?) {
            needApproved(item, 'event', tree.eventById[id]);
          }
        }
      }
    }
  }

  /// Visuals that [item] shows: in its blocks and its own visual list.
  Iterable<String> _visualRefs(Item<Object> item) {
    final dto = item.dto;
    final blocks = switch (dto) {
      CompanionDto(:final sections) => [for (final s in sections) ...s.blocks],
      StoryDto(:final chapters) => [for (final c in chapters) ...c.blocks],
      SeerahChapterDto(:final blocks) ||
      SeerahTopicDto(:final blocks) => blocks,
      SeerahDto(:final introduction) => introduction,
      _ => const <ContentBlockDto>[],
    };
    return {
      for (final b in blocks)
        if (b case InfographicBlockDto(:final visualId)) visualId,
      ...switch (dto) {
        SeerahChapterDto(:final visualIds) ||
        SeerahDto(:final visualIds) => visualIds,
        _ => const <String>[],
      },
    };
  }

  Iterable<_Cited> _itemCitations(Item<Object> item) {
    final dto = item.dto;
    return switch (dto) {
      CompanionDto() => _companionCitations(dto),
      HistoricalEventDto() => [
        for (var i = 0; i < dto.citations.length; i++)
          ('\$.citations[$i]', dto.citations[i]),
      ],
      CategoryDto(:final basis?) => _blockCitations(r'$.basis', basis),
      StoryDto(:final chapters) => [
        for (var c = 0; c < chapters.length; c++)
          for (var b = 0; b < chapters[c].blocks.length; b++)
            ..._blockCitations(
              '\$.chapters[$c].blocks[$b]',
              chapters[c].blocks[b],
            ),
      ],
      PlaceDto(:final citations) => _list(r'$', citations),
      SeerahDto(:final eras, :final introduction) => [
        for (var e = 0; e < eras.length; e++)
          ..._list('\$.eras[$e]', eras[e].citations),
        ..._blocksCitations(r'$.introduction', introduction),
      ],
      SeerahChapterDto(:final blocks) => _blocksCitations(r'$.blocks', blocks),
      SeerahTopicDto(:final blocks) => _blocksCitations(r'$.blocks', blocks),
      VisualDto() => [
        for (var i = 0; i < dto.route.length; i++)
          ..._list('\$.route[$i]', dto.route[i].citations),
        for (var i = 0; i < dto.edges.length; i++)
          ..._list('\$.edges[$i]', dto.edges[i].citations),
        for (var i = 0; i < dto.steps.length; i++)
          ..._list('\$.steps[$i]', dto.steps[i].citations),
        for (var i = 0; i < dto.bands.length; i++)
          ..._list('\$.bands[$i]', dto.bands[i].citations),
        for (var i = 0; i < dto.callouts.length; i++)
          ..._list('\$.callouts[$i]', dto.callouts[i].citations),
      ],
      _ => const <_Cited>[],
    };
  }

  // ── V12: dates ────────────────────────────────────────────────────────

  void _date(Item<Object> item, String path, HistoricalDateDto d) {
    final end = d.hijriYearEnd;
    if (d.precision == DatePrecision.range &&
        d.hijriYear != null &&
        end != null) {
      final startKey = d.era == HijriEra.beforeHijra
          ? -d.hijriYear!
          : d.hijriYear!;
      final endEra = d.endEra ?? d.era;
      final endKey = endEra == HijriEra.beforeHijra ? -end : end;
      if (endKey < startKey) {
        sink.error(
          'V12',
          item.file,
          item.at(path),
          'The range ends before '
              'it starts.',
        );
      }
    }
    if (d.gregorianYear != null &&
        d.gregorianYearEnd != null &&
        d.gregorianYearEnd! < d.gregorianYear!) {
      sink.error(
        'V12',
        item.file,
        item.at(path),
        'The Gregorian range ends '
            'before it starts.',
      );
    }
    // A Hijri year is ~0.97 Gregorian years; flag likely typos.
    final h = d.hijriYear;
    final g = d.gregorianYear;
    if (h != null && g != null) {
      final expected = d.era == HijriEra.afterHijra
          ? 622 + (h - 1) * 0.970224
          : 622 - h * 0.970224;
      if ((g - expected).abs() > 2) {
        sink.warning(
          'V12',
          item.file,
          item.at(path),
          'Gregorian year $g '
              'looks inconsistent with $h ${d.era == HijriEra.afterHijra ? 'AH' : 'BH'} '
              '(expected about ${expected.round()}).',
        );
      }
    }
  }

  // ── Citation walkers ──────────────────────────────────────────────────

  Iterable<_Cited> _companionCitations(CompanionDto c) sync* {
    Iterable<_Cited> list(String path, List<CitationDto> cs) sync* {
      for (var i = 0; i < cs.length; i++) {
        yield ('$path.citations[$i]', cs[i]);
      }
    }

    if (c.birth != null) yield* list(r'$.birth', c.birth!.citations);
    if (c.death != null) yield* list(r'$.death', c.death!.citations);
    for (var i = 0; i < c.atAGlance.length; i++) {
      yield* list('\$.atAGlance[$i]', c.atAGlance[i].citations);
    }
    for (var i = 0; i < c.memberships.length; i++) {
      yield* list('\$.memberships[$i]', c.memberships[i].citations);
    }
    for (var i = 0; i < c.relations.length; i++) {
      yield* list('\$.relations[$i]', c.relations[i].citations);
    }
    for (var i = 0; i < c.timeline.length; i++) {
      yield* list('\$.timeline[$i]', c.timeline[i].citations);
    }
    for (var s = 0; s < c.sections.length; s++) {
      for (var b = 0; b < c.sections[s].blocks.length; b++) {
        yield* _blockCitations(
          '\$.sections[$s].blocks[$b]',
          c.sections[s].blocks[b],
        );
      }
    }
  }

  Iterable<_Cited> _blockCitations(String path, ContentBlockDto b) sync* {
    Iterable<_Cited> list(String p, List<CitationDto> cs) sync* {
      for (var i = 0; i < cs.length; i++) {
        yield ('$p.citations[$i]', cs[i]);
      }
    }

    switch (b) {
      case ParagraphBlockDto(:final citations) ||
          HadithQuoteBlockDto(:final citations) ||
          ReportQuoteBlockDto(:final citations):
        yield* list(path, citations);
      case DisputeNoteBlockDto(:final opinions):
        for (var i = 0; i < opinions.length; i++) {
          yield* list('$path.opinions[$i]', opinions[i].citations);
        }
      case LessonBlockDto() ||
          QuranQuoteBlockDto() ||
          HeadingBlockDto() ||
          InfographicBlockDto():
        break;
    }
  }

  Iterable<_Cited> _list(String path, List<CitationDto> cs) sync* {
    for (var i = 0; i < cs.length; i++) {
      yield ('$path.citations[$i]', cs[i]);
    }
  }

  Iterable<_Cited> _blocksCitations(
    String path,
    List<ContentBlockDto> blocks,
  ) sync* {
    for (var b = 0; b < blocks.length; b++) {
      yield* _blockCitations('$path[$b]', blocks[b]);
    }
  }
}
