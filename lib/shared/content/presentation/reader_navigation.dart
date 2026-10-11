import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// A previous/next pair at the end of a reader.
class ReaderNavigation extends StatelessWidget {
  const ReaderNavigation({
    this.previousLabel,
    this.previousTitle,
    this.onPrevious,
    this.nextLabel,
    this.nextTitle,
    this.onNext,
    super.key,
  });

  final String? previousLabel;
  final String? previousTitle;
  final VoidCallback? onPrevious;
  final String? nextLabel;
  final String? nextTitle;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    Widget card(String label, String title, VoidCallback onTap, bool next) =>
        Card(
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: next
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(label, style: SuhbaTextStyles.of(context).kicker),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: next ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: onPrevious == null
              ? const SizedBox.shrink()
              : card(previousLabel!, previousTitle!, onPrevious!, false),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: onNext == null
              ? const SizedBox.shrink()
              : card(nextLabel!, nextTitle!, onNext!, true),
        ),
      ],
    );
  }
}

/// The distinct works cited in a passage, with a marker for all of them.
class PassageSources extends ConsumerWidget {
  const PassageSources({
    required this.citations,
    required this.onOpen,
    super.key,
  });

  final List<Citation> citations;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final format = DisplayFormatter.of(context);
    final sources = ref.watch(sourcesProvider).value ?? const {};
    final ids = <String>{for (final c in citations) c.sourceId};
    if (ids.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SectionHeader(
                kicker: l10n.profileReferencesKicker,
                title: l10n.readerSectionSources,
              ),
            ),
            CitationMarker(count: citations.length, onPressed: onOpen),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        for (final id in ids)
          if (sources[id] case final s?)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
              child: Text(
                [
                  s.title.of(context),
                  if (s.author case final a?)
                    s.authorDeathAH == null
                        ? a.of(context)
                        : l10n.citationAuthorDeath(
                            a.of(context),
                            format.integer(s.authorDeathAH!),
                          ),
                ].join(' — '),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
              ),
            ),
      ],
    );
  }
}
