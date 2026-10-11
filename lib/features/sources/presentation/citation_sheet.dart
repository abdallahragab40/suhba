import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/design_system/widgets/reliability_badge.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/share/share_service.dart';
import 'package:suhba/features/sources/presentation/passage_share.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// Opens the sources of one claim.
///
/// With [share], the sheet also offers to share the passage with these
/// sources (F19).
Future<void> showCitationSheet(
  BuildContext context, {
  required List<Citation> citations,
  required bool provisional,
  Reliability? reliability,
  PassageShare? share,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => CitationSheet(
      citations: citations,
      reliability: reliability,
      provisional: provisional,
      share: share,
    ),
  );
}

/// Where in its work a citation points, in display form; "being verified"
/// while the locator is pending.
String citationLocatorText(BuildContext context, Citation c) {
  final l10n = AppLocalizations.of(context);
  final format = DisplayFormatter.of(context);
  if (c.quranRef case final ref?) return format.quranRef(ref);
  if (c.locatorStatus == LocatorStatus.pending || !c.hasLocator) {
    return l10n.citationLocatorPending;
  }
  return [
    if (c.chapterTitle case final t?) t.of(context),
    if (c.volume case final v?) l10n.citationVolume(format.integer(v)),
    if (c.page case final p?) l10n.citationPage(format.digits(p)),
    if (c.hadithNumber case final n?)
      l10n.citationHadithNumber(format.digits(n)),
  ].join(' · ');
}

String _gradeLabel(AppLocalizations l10n, HadithGrade g) => switch (g) {
  HadithGrade.sahih => l10n.gradeSahih,
  HadithGrade.hasan => l10n.gradeHasan,
  HadithGrade.daif => l10n.gradeDaif,
};

String reliabilityLabel(AppLocalizations l10n, Reliability r) => switch (r) {
  Reliability.established => l10n.reliabilityEstablished,
  Reliability.reported => l10n.reliabilityReported,
  Reliability.disputed => l10n.reliabilityDisputed,
  Reliability.unknown => l10n.reliabilityUnknown,
};

/// Every source behind a claim: the work and its author, where in the work
/// (or that the location is still being verified), the hadith grading and
/// who made it, and what the claim's reliability level means.
class CitationSheet extends ConsumerWidget {
  const CitationSheet({
    required this.citations,
    required this.provisional,
    this.reliability,
    this.share,
    super.key,
  });

  final List<Citation> citations;

  /// The passage these sources support, when it can be shared.
  final PassageShare? share;

  /// True for unreviewed (draft) content.
  final bool provisional;
  final Reliability? reliability;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colors = SuhbaColors.of(context);
    final sources = ref.watch(sourcesProvider);
    final reliability = this.reliability;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.xl,
        ),
        children: [
          Semantics(
            header: true,
            child: Text(l10n.citationsTitle, style: textTheme.titleLarge),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (reliability != null) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: ReliabilityBadge(reliability, provisional: provisional),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              switch (reliability) {
                Reliability.established => l10n.reliabilityExplainEstablished,
                Reliability.reported => l10n.reliabilityExplainReported,
                Reliability.disputed => l10n.reliabilityExplainDisputed,
                Reliability.unknown => l10n.reliabilityExplainUnknown,
              },
              style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (provisional) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: colors.draftSurface,
                borderRadius: const BorderRadius.all(AppRadii.sm),
              ),
              child: Text(
                l10n.citationDraftNotice,
                style: textTheme.bodySmall?.copyWith(color: colors.draft),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          switch (sources) {
            AsyncData(:final value) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final c in citations)
                  _CitationTile(citation: c, source: value[c.sourceId]),
              ],
            ),
            AsyncError() => Text(l10n.errorMessage),
            _ => const LoadingSkeleton(lines: 2),
          },
          if (share case final share?)
            if (sources.value case final sourceMap?) ...[
              const SizedBox(height: AppSpacing.md),
              Builder(
                builder: (button) => FilledButton.tonalIcon(
                  icon: const Icon(Icons.ios_share),
                  label: Text(l10n.citationShareAction),
                  onPressed: () => ref
                      .read(shareServiceProvider)
                      .shareText(
                        formatPassageShare(
                          passage: share,
                          sources: [
                            for (final c in citations)
                              (
                                title:
                                    sourceMap[c.sourceId]?.title.of(context) ??
                                    l10n.citationUnknownSource,
                                locator: citationLocatorText(context, c),
                                grading: switch (c.grading) {
                                  final g? => l10n.citationGrading(
                                    _gradeLabel(l10n, g.grade),
                                    g.gradedBy.of(context),
                                  ),
                                  null => null,
                                },
                              ),
                          ],
                          sourcesHeading: l10n.shareSourcesHeading,
                          reliabilityLine: reliability == null
                              ? null
                              : l10n.shareReliability(
                                  reliabilityLabel(l10n, reliability),
                                ),
                          draftLine: provisional ? l10n.shareDraftNotice : null,
                          appLine: l10n.shareFromApp(l10n.appTitle),
                        ),
                        subject: share.origin,
                        origin: shareOriginOf(button),
                      ),
                ),
              ),
            ],
        ],
      ),
    );
  }
}

class _CitationTile extends StatelessWidget {
  const _CitationTile({required this.citation, required this.source});

  final Citation citation;
  final SourceReference? source;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colors = SuhbaColors.of(context);
    final c = citation;
    final source = this.source;

    final author = source?.author;
    final authorLine = author == null
        ? null
        : source!.authorDeathAH == null
        ? author.of(context)
        : l10n.citationAuthorDeath(
            author.of(context),
            format.integer(source.authorDeathAH!),
          );

    final locator = citationLocatorText(context, c);

    final grading = c.grading;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: colors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            source?.title.of(context) ?? l10n.citationUnknownSource,
            style: textTheme.titleSmall,
          ),
          if (authorLine != null)
            Text(
              authorLine,
              style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
            ),
          const SizedBox(height: AppSpacing.xxs),
          Text(locator, style: textTheme.bodyMedium),
          if (grading != null)
            Text(
              l10n.citationGrading(
                _gradeLabel(l10n, grading.grade),
                grading.gradedBy.of(context),
              ),
              style: textTheme.bodySmall?.copyWith(color: colors.established),
            ),
          if (c.note case final note?)
            Text(
              note.of(context),
              style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
            ),
        ],
      ),
    );
  }
}
