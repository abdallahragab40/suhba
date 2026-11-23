import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/reliability_badge.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/design_system/widgets/wordmark.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/settings/presentation/feedback_tile.dart';
import 'package:suhba/shared/content/providers.dart';

/// About and methodology (S13): what the app is, how it treats sources,
/// what each reliability level means, whether the content is reviewed, the
/// image policy and privacy.
class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isDraft = ref.watch(contentManifestProvider).value?.isDraft ?? true;
    final version = ref.watch(appVersionProvider).value;
    final format = DisplayFormatter.of(context);

    var index = 0;
    Widget section(String title, Widget child) => Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // No kicker: it would only repeat the page's title.
          SectionHeader(index: ++index, title: title),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );

    final levels = <(Reliability, String)>[
      (Reliability.established, l10n.reliabilityExplainEstablished),
      (Reliability.reported, l10n.reliabilityExplainReported),
      (Reliability.disputed, l10n.reliabilityExplainDisputed),
      (Reliability.unknown, l10n.reliabilityExplainUnknown),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsAbout)),
      body: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.gutter,
          AppSpacing.sm,
          AppSpacing.gutter,
          AppSpacing.xxl,
        ),
        children: [
          const Wordmark(size: 40),
          if (version != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
              child: Text(
                l10n.aboutVersion(format.digits(version)),
                style: textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceDim,
                ),
              ),
            ),
          Text(l10n.aboutIntro, style: textTheme.bodyLarge),
          section(
            l10n.aboutReviewTitle,
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: isDraft ? colors.draftSurface : colors.surfaceAlt,
                border: Border.all(color: colors.line),
                borderRadius: const BorderRadius.all(AppRadii.sm),
              ),
              child: Text(
                isDraft ? l10n.aboutReviewDraft : l10n.aboutReviewPublished,
                style: textTheme.bodyMedium?.copyWith(
                  color: isDraft ? colors.draft : null,
                ),
              ),
            ),
          ),
          section(
            l10n.aboutMethodTitle,
            Text(l10n.aboutMethodBody, style: textTheme.bodyLarge),
          ),
          section(
            l10n.aboutReliabilityTitle,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (level, text) in levels)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSpacing.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReliabilityBadge(level),
                        Text(text, style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Every bundled third-party resource, its origin and its terms
          // (review K10). A test keeps this in step with the fonts and
          // images actually bundled.
          section(
            l10n.aboutCreditsTitle,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.sourcesQuranTextTitle, style: textTheme.titleSmall),
                Text(l10n.aboutCreditQuranBody, style: textTheme.bodyMedium),
                TextButton.icon(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  icon: const Icon(Icons.menu_book_outlined, size: 18),
                  label: Text(l10n.aboutCreditSources),
                  onPressed: () => context.push(AppRoutes.sourcesDirectory),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.aboutCreditFontsTitle, style: textTheme.titleSmall),
                Text(l10n.aboutCreditAmiri, style: textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.xxs),
                Text(l10n.aboutCreditPlex, style: textTheme.bodyMedium),
                // The licences of the software and fonts in the app,
                // Flutter's own page (fonts registered at start-up).
                TextButton.icon(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  icon: const Icon(Icons.description_outlined, size: 18),
                  label: Text(l10n.aboutLicenses),
                  onPressed: () => showLicensePage(
                    context: context,
                    applicationName: l10n.appTitle,
                    applicationVersion: version == null
                        ? null
                        : format.digits(version),
                  ),
                ),
              ],
            ),
          ),
          section(
            l10n.aboutImagesTitle,
            Text(l10n.aboutImagesBody, style: textTheme.bodyLarge),
          ),
          section(
            l10n.aboutPrivacyTitle,
            Text(l10n.aboutPrivacyBody, style: textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
