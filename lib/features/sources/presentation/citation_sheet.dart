import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/citation.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// Opens the sources of one claim.
Future<void> showCitationSheet(
  BuildContext context, {
  required List<Citation> citations,
  required bool provisional,
  Reliability? reliability,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => CitationSheet(
      citations: citations,
      reliability: reliability,
      provisional: provisional,
    ),
  );
}

/// Every source behind a claim: the work and its author, where in the work
/// (or that the location is still being verified), the hadith grading and
/// who made it, and what the claim's reliability level means.
class CitationSheet extends ConsumerWidget {
  const CitationSheet({
    required this.citations,
    required this.provisional,
    this.reliability,
    super.key,
  });

  final List<Citation> citations;

  /// True for unreviewed (draft) content.
  final bool provisional;
  final Reliability? reliability;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colors = SahabaColors.of(context);
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
    final colors = SahabaColors.of(context);
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

    final String locator;
    if (c.quranRef case final ref?) {
      locator = format.quranRef(ref);
    } else if (c.locatorStatus == LocatorStatus.pending || !c.hasLocator) {
      locator = l10n.citationLocatorPending;
    } else {
      locator = [
        if (c.chapterTitle case final t?) t.of(context),
        if (c.volume case final v?) l10n.citationVolume(format.integer(v)),
        if (c.page case final p?) l10n.citationPage(format.digits(p)),
        if (c.hadithNumber case final n?)
          l10n.citationHadithNumber(format.digits(n)),
      ].join(' · ');
    }

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
              l10n.citationGrading(switch (grading.grade) {
                HadithGrade.sahih => l10n.gradeSahih,
                HadithGrade.hasan => l10n.gradeHasan,
                HadithGrade.daif => l10n.gradeDaif,
              }, grading.gradedBy.of(context)),
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
