import 'package:siyar_sahaba/core/text/arabic_normalizer.dart';

/// What a search result points to, in display order.
enum SearchKind {
  companion,
  story,
  section,
  chapter,
  seerahChapter,
  seerahTopic,
  event,
  place,
}

/// One searchable text of a document and how much a match in it counts.
class SearchField {
  const SearchField(this.text, this.weight);

  /// Body text (a summary or a passage's prose): matched last, and shown as
  /// an excerpt around the match.
  const SearchField.body(this.text) : weight = bodyWeight;

  final String text;
  final int weight;

  bool get isBody => weight == bodyWeight;

  /// Name fields: a companion's usual name.
  static const nameWeight = 5;

  /// Full name, kunya, titles, aliases.
  static const aliasWeight = 3;

  /// Section, story and chapter titles.
  static const headingWeight = 2;

  /// Category names.
  static const categoryWeight = 1;

  /// Summaries and passage text. Matched with a lower score scale too, so
  /// a name always outranks a body match (see [SearchIndex]).
  static const bodyWeight = 0;
}

/// Something that can be found: a companion, story, section or chapter.
class SearchDocument {
  const SearchDocument({
    required this.kind,
    required this.id,
    required this.title,
    required this.fields,
    this.parentId,
    this.subtitle,
  });

  final SearchKind kind;
  final String id;

  /// The companion of a section, or the story of a chapter; null for
  /// everything else.
  final String? parentId;
  final String title;
  final String? subtitle;
  final List<SearchField> fields;
}

class SearchHit {
  const SearchHit(this.document, this.score, {this.excerpt});

  final SearchDocument document;
  final int score;

  /// Where the query was found when it matched body text only: the original
  /// words around the match, with the match marked.
  final SearchExcerpt? excerpt;
}

/// A piece of original text around a match. [text] is shown as is; the
/// match is `text.substring(matchStart, matchEnd)`.
class SearchExcerpt {
  const SearchExcerpt(this.text, this.matchStart, this.matchEnd);

  final String text;
  final int matchStart;
  final int matchEnd;

  /// The excerpt of [original] around the first match of the normalized
  /// [token], about [context] characters each side, cut at word boundaries
  /// and marked with ellipses where text was left out. Null if [token] is
  /// not in [original].
  static SearchExcerpt? around(
    String original,
    String token, {
    int context = 40,
  }) {
    final (normalized, offsets) = ArabicNormalizer.normalizeWithOffsets(
      original,
    );
    final at = normalized.indexOf(token);
    if (at < 0 || token.isEmpty) return null;
    final start = offsets[at];
    final last = at + token.length - 1;
    // The end of the match's last character, including marks after it.
    var end = offsets[last] + 1;
    while (end < original.length &&
        ArabicNormalizer.isMark(original.codeUnitAt(end))) {
      end++;
    }

    var from = (start - context).clamp(0, original.length);
    var to = (end + context).clamp(0, original.length);
    if (from > 0) {
      final space = original.indexOf(' ', from);
      if (space >= 0 && space < start) from = space + 1;
    }
    if (to < original.length) {
      final space = original.lastIndexOf(' ', to);
      if (space > end) to = space;
    }
    final head = from > 0 ? '… ' : '';
    final tail = to < original.length ? ' …' : '';
    return SearchExcerpt(
      '$head${original.substring(from, to)}$tail',
      head.length + start - from,
      head.length + end - from,
    );
  }
}

/// Narrows results to some kinds of document and, for passages, to one
/// companion or story.
class SearchFilter {
  const SearchFilter({this.kinds, this.parentId});

  static const all = SearchFilter();

  /// Null for every kind.
  final Set<SearchKind>? kinds;

  /// Only passages (sections, chapters) of this companion or story, and the
  /// companion or story itself.
  final String? parentId;

  bool accepts(SearchDocument d) =>
      (kinds == null || kinds!.contains(d.kind)) &&
      (parentId == null || d.parentId == parentId || d.id == parentId);
}

/// An in-memory index over normalized text (see [ArabicNormalizer]), so
/// hamza, tashkeel, ta marbuta and digit variants all match.
///
/// Ranking per query word, best field wins: the whole field equals the word
/// (4) > the field starts with it (3) > a word in the field starts with it
/// (2) > it appears anywhere (1), times the field's weight. Every query word
/// must match; scores add up, and a field equal to the whole query earns a
/// bonus.
///
/// Body text scores on its own scale (1 for any match in it), below every
/// other field (at least 1 × 1 for a contains-match in a category, and
/// usually far more), so names and titles outrank body matches.
///
/// The catalog is small enough to search in memory; the interface lets a
/// build-time full-text index replace this if it grows to thousands (see
/// docs/performance.md).
class SearchIndex {
  SearchIndex(List<SearchDocument> documents, {this.unavailable = 0})
    : _entries = [
        for (final d in documents)
          (
            d,
            [
              for (final f in d.fields)
                if (ArabicNormalizer.normalize(f.text) case final text
                    when text.isNotEmpty)
                  (text, text.split(' '), f.weight, f.text),
            ],
          ),
      ];

  final List<(SearchDocument, List<(String, List<String>, int, String)>)>
  _entries;

  /// Content files that could not be loaded when the index was built: the
  /// index is incomplete when this is above zero.
  final int unavailable;

  bool get isComplete => unavailable == 0;

  int get length => _entries.length;

  List<SearchHit> search(
    String query, {
    int limit = 40,
    SearchFilter filter = SearchFilter.all,
  }) {
    final q = ArabicNormalizer.normalize(query);
    if (q.isEmpty) return const [];
    final tokens = q.split(' ');

    // Excerpts are cut only for the hits returned.
    final hits = <(SearchHit, String?, String)>[];
    for (final (doc, fields) in _entries) {
      if (!filter.accepts(doc)) continue;
      var total = 0;
      String? bodyMatch;
      var bodyToken = '';
      for (final token in tokens) {
        var best = 0;
        var bestIsBody = false;
        String? bodyText;
        for (final (text, words, weight, original) in fields) {
          if (weight == SearchField.bodyWeight) {
            // Any match in body text counts 1, below every other field.
            if (best == 0 && bodyText == null && text.contains(token)) {
              bodyText = original;
            }
            continue;
          }
          final score = text == token
              ? 4
              : text.startsWith(token)
              ? 3
              : words.any((w) => w.startsWith(token))
              ? 2
              : text.contains(token)
              ? 1
              : 0;
          if (score * weight > best) best = score * weight;
        }
        if (best == 0 && bodyText != null) {
          best = 1;
          bestIsBody = true;
        }
        if (best == 0) {
          total = 0;
          break;
        }
        total += best;
        if (bestIsBody && bodyMatch == null) {
          bodyMatch = bodyText;
          bodyToken = token;
        }
      }
      if (total == 0) continue;
      for (final (text, _, weight, _) in fields) {
        if (weight > 0 && text == q) {
          total += 10 * weight;
          break;
        }
      }
      // The whole query as a phrase in the body ranks above scattered words.
      if (bodyMatch != null) {
        for (final (text, _, weight, original) in fields) {
          if (weight == SearchField.bodyWeight && text.contains(q)) {
            total += 1;
            bodyMatch = original;
            bodyToken = q;
            break;
          }
        }
      }
      hits.add((SearchHit(doc, total), bodyMatch, bodyToken));
    }

    hits.sort((x, y) {
      final (a, _, _) = x;
      final (b, _, _) = y;
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      final byKind = a.document.kind.index.compareTo(b.document.kind.index);
      return byKind != 0
          ? byKind
          : a.document.title.compareTo(b.document.title);
    });
    return [
      for (final (hit, body, token) in hits.take(limit))
        body == null
            ? hit
            : SearchHit(
                hit.document,
                hit.score,
                excerpt: SearchExcerpt.around(body, token),
              ),
    ];
  }
}
