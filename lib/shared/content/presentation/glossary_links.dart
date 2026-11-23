import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/sources/presentation/citation_sheet.dart';
import 'package:suhba/shared/content/domain/glossary.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// The matcher for this build's glossary; empty until it loads.
final glossaryMatcherProvider = Provider<GlossaryMatcher>(
  (ref) => GlossaryMatcher(
    ref.watch(glossaryProvider).value?.values ?? const <GlossaryTerm>[],
  ),
);

/// One linked occurrence of a glossary term in a text.
typedef TermMatch = ({int start, int end, GlossaryTerm term});

/// Finds glossary terms in Arabic text whatever its tashkeel (review E3).
/// A form matches as a whole word, optionally after a one-letter prefix
/// (و ف ب ل ك); the longest form wins where two overlap.
class GlossaryMatcher {
  GlossaryMatcher(Iterable<GlossaryTerm> terms)
    : _patterns = [
        for (final t in terms)
          for (final f in t.forms) (t, RegExp(_pattern(f)), f.length),
      ]..sort((a, b) => b.$3.compareTo(a.$3));

  final List<(GlossaryTerm, RegExp, int)> _patterns;

  static const _marks = '[ً-ْٰـ]*';

  static String _pattern(String form) {
    final letters = form
        .replaceAll(RegExp('[ً-ْٰـ]'), '')
        .split('')
        .map((c) => c == ' ' ? r'\s+' : RegExp.escape(c) + _marks)
        .join();
    return '(?<![ء-يً-ْ])(?:[وفبلك]$_marks)?'
        '($letters)(?![ء-ي])';
  }

  bool get isEmpty => _patterns.isEmpty;

  /// The first occurrence in [text] of each term not in [seen], which it
  /// then adds to [seen]: a term is linked once a passage.
  List<TermMatch> firstMatches(String text, Set<String> seen) {
    final found = <TermMatch>[];
    bool overlaps(int s, int e) => found.any((m) => s < m.end && m.start < e);
    for (final (term, re, _) in _patterns) {
      if (seen.contains(term.id)) continue;
      for (final m in re.allMatches(text)) {
        final start = m.start + (m.group(0)!.length - m.group(1)!.length);
        if (overlaps(start, m.end)) continue;
        found.add((start: start, end: m.end, term: term));
        seen.add(term.id);
        break;
      }
    }
    return found..sort((a, b) => a.start.compareTo(b.start));
  }
}

/// Makes the glossary available to [ReadingBody]s below it. Without one,
/// passages show no links.
class GlossaryScope extends InheritedWidget {
  const GlossaryScope({required this.matcher, required super.child, super.key});

  final GlossaryMatcher matcher;

  static GlossaryMatcher? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GlossaryScope>()?.matcher;

  @override
  bool updateShouldNotify(GlossaryScope old) => old.matcher != matcher;
}

/// [text] as spans, with each match a link that opens its definition.
/// The caller owns the recognizers it receives in [recognizers].
List<InlineSpan> linkedSpans(
  BuildContext context,
  String text,
  List<TermMatch> matches,
  List<TapGestureRecognizer> recognizers,
) {
  if (matches.isEmpty) return [TextSpan(text: text)];
  final style = glossaryLinkStyle(SuhbaColors.of(context));
  final spans = <InlineSpan>[];
  var at = 0;
  for (final m in matches) {
    if (m.start > at) spans.add(TextSpan(text: text.substring(at, m.start)));
    final tap = TapGestureRecognizer()
      ..onTap = () => showGlossarySheet(context, m.term);
    recognizers.add(tap);
    spans.add(
      TextSpan(
        text: text.substring(m.start, m.end),
        recognizer: tap,
        semanticsLabel: text.substring(m.start, m.end),
        style: style,
      ),
    );
    at = m.end;
  }
  if (at < text.length) spans.add(TextSpan(text: text.substring(at)));
  return spans;
}

/// How a linked glossary term is set in running text: in the link colour on
/// a faint wash of it. Not underlined: an underline, dotted or solid, runs
/// through the dots below Arabic letters (the ي of «قريش», «يُكنى»), and
/// Flutter cannot lower it beneath them. The wash marks the term by more
/// than its colour alone, and follows the theme: green on paper and sepia,
/// soft gold at night on a fainter wash ([SuhbaColors.linkWash]).
TextStyle glossaryLinkStyle(SuhbaColors colors) => TextStyle(
  color: colors.link,
  background: Paint()..color = colors.link.withValues(alpha: colors.linkWash),
);

/// A term's definition, with its sources and a way to the full glossary.
Future<void> showGlossarySheet(BuildContext context, GlossaryTerm term) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (sheet) {
      final l10n = AppLocalizations.of(sheet);
      final textTheme = Theme.of(sheet).textTheme;
      final provisional = !term.review.isApproved;
      return SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.glossaryKicker, style: SuhbaTextStyles.of(sheet).kicker),
            Semantics(
              header: true,
              child: Text(term.term.of(sheet), style: textTheme.titleLarge),
            ),
            if (provisional) ...[
              const SizedBox(height: AppSpacing.xs),
              DraftBadge(preliminary: term.review.isPreliminary),
            ],
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    term.definition.of(sheet),
                    style: SuhbaTextStyles.of(sheet).reading,
                  ),
                ),
                if (term.citations.isNotEmpty)
                  CitationMarker(
                    count: term.citations.length,
                    onPressed: () => showCitationSheet(
                      sheet,
                      citations: term.citations,
                      reliability: term.reliability,
                      provisional: provisional,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton.icon(
              onPressed: () {
                Navigator.of(sheet).pop();
                context.push(AppRoutes.glossary);
              },
              icon: const Icon(Icons.menu_book_outlined),
              label: Text(l10n.glossaryAll),
            ),
          ],
        ),
      );
    },
  );
}
