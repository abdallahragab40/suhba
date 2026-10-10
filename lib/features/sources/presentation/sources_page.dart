import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// Every referenced work, grouped by kind (S14).
class SourcesPage extends ConsumerWidget {
  const SourcesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sources = ref.watch(sourcesProvider);

    String label(SourceType t) => switch (t) {
      SourceType.quran => l10n.sourceTypeQuran,
      SourceType.hadithCollection => l10n.sourceTypeHadith,
      SourceType.biographical => l10n.sourceTypeBiographical,
      SourceType.history => l10n.sourceTypeHistory,
      SourceType.sira => l10n.sourceTypeSira,
      SourceType.tafsir => l10n.sourceTypeTafsir,
      SourceType.other => l10n.sourceTypeOther,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsSources)),
      body: switch (sources) {
        AsyncData(:final value) => ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.gutter,
            0,
            AppSpacing.gutter,
            AppSpacing.xxl,
          ),
          children: [
            for (final type in SourceType.values)
              if (value.values.where((s) => s.type == type).toList()
                  case final group when group.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: AppSpacing.lg,
                    bottom: AppSpacing.xs,
                  ),
                  child: Semantics(
                    header: true,
                    child: Text(
                      label(type),
                      style: SahabaTextStyles.of(context).kicker,
                    ),
                  ),
                ),
                for (final s in group) _SourceTile(source: s),
              ],
            const _QuranTextCredit(),
          ],
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(sourcesProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 6),
        ),
      },
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({required this.source});

  final SourceReference source;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final s = source;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: colors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.title.of(context), style: textTheme.titleSmall),
          if (s.author case final a?)
            Text(
              s.authorDeathAH == null
                  ? a.of(context)
                  : l10n.citationAuthorDeath(
                      a.of(context),
                      format.integer(s.authorDeathAH!),
                    ),
              style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
            ),
          if (!s.review.isApproved) ...[
            const SizedBox(height: AppSpacing.xxs),
            const DraftBadge(),
          ],
        ],
      ),
    );
  }
}

/// Where the verse text comes from, with the licence notice its terms ask
/// to be reproduced. Shown only once the text has loaded.
class _QuranTextCredit extends ConsumerWidget {
  const _QuranTextCredit();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verses = ref.watch(quranVersesProvider).value;
    if (verses == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            top: AppSpacing.lg,
            bottom: AppSpacing.xs,
          ),
          child: Semantics(
            header: true,
            child: Text(
              l10n.sourcesQuranTextTitle,
              style: SahabaTextStyles.of(context).kicker,
            ),
          ),
        ),
        Text(verses.sourceName, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xxs),
        SelectableText(
          l10n.sourcesQuranTextBody(verses.sourceUrl),
          style: textTheme.bodyMedium,
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(bottom: AppSpacing.md),
            title: Text(l10n.sourcesQuranNotice, style: textTheme.titleSmall),
            children: [
              // The notice is in English, as Tanzil publishes it.
              Directionality(
                textDirection: TextDirection.ltr,
                child: SelectableText(
                  verses.notice,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceDim,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
