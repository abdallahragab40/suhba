import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/reliability_badge.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/providers.dart';

/// About and methodology (S13): what the app is, how it treats sources,
/// what each reliability level means, whether the content is reviewed, and
/// the image policy.
class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isDraft = ref.watch(contentManifestProvider).value?.isDraft ?? true;

    var index = 0;
    Widget section(String title, Widget child) => Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            index: ++index,
            kicker: l10n.settingsAbout,
            title: title,
          ),
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
          Text(l10n.aboutIntro, style: textTheme.bodyLarge),
          section(
            l10n.aboutReviewTitle,
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: isDraft ? colors.draftSurface : colors.surfaceAlt,
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
          section(
            l10n.aboutImagesTitle,
            Text(l10n.aboutImagesBody, style: textTheme.bodyLarge),
          ),
          const SizedBox(height: AppSpacing.lg),
          // The notices the open-source packages and the bundled fonts' OFL
          // require to ship with the app; this is the only place they show.
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: () => showLicensePage(
                context: context,
                applicationName: l10n.appTitle,
              ),
              child: Text(l10n.aboutLicensesLink),
            ),
          ),
        ],
      ),
    );
  }
}
