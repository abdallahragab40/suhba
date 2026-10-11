import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_badge.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/review.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// What the editor says about how complete a text is, when it is not
/// complete: a short pilot or a profile without a written text. Never
/// shown for complete texts (their review state has its own badge).
class CoverageNote extends StatelessWidget {
  const CoverageNote({required this.review, super.key});

  final ReviewInfo review;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final text = switch (review.coverage) {
      Coverage.sample => l10n.coverageSample,
      Coverage.skeleton => l10n.coverageSkeleton,
      Coverage.complete || null => null,
    };
    if (text == null) return const SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.edit_note, size: 20, color: colors.onSurfaceDim),
        const SizedBox(width: AppSpacing.xxs),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
          ),
        ),
      ],
    );
  }
}

/// One shared event as an archive row: its date at the start, then its
/// name and where it happened. Opens the event page.
class EventRow extends StatelessWidget {
  const EventRow({required this.event, super.key});

  final HistoricalEvent event;

  @override
  Widget build(BuildContext context) {
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final e = event;
    return InkWell(
      onTap: () => context.push(AppRoutes.event(e.id)),
      child: Container(
        constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          border: BorderDirectional(bottom: BorderSide(color: colors.line)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 108,
              child: Text(
                format.historicalDate(e.date, withGregorian: false),
                style: SahabaTextStyles.of(
                  context,
                ).kicker.copyWith(color: colors.accentText),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.name.of(context), style: textTheme.titleMedium),
                  if (e.place case final p?)
                    Text(
                      p.of(context),
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceDim,
                      ),
                    ),
                ],
              ),
            ),
            if (!e.review.isApproved)
              DraftBadge(preliminary: e.review.isPreliminary),
          ],
        ),
      ),
    );
  }
}

/// The events of [ids] that this build has, as archive rows.
class EventRows extends ConsumerWidget {
  const EventRows({required this.ids, super.key});

  final List<String> ids;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider).value ?? const {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final id in ids)
          if (events[id] case final e?) EventRow(event: e),
      ],
    );
  }
}

/// Places as chips that open their pages.
class PlaceChips extends ConsumerWidget {
  const PlaceChips({required this.ids, super.key});

  final List<String> ids;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider).value ?? const {};
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final id in ids)
          if (places[id] case final p?)
            ActionChip(
              avatar: const Icon(Icons.place_outlined, size: 18),
              label: Text(p.name.of(context)),
              onPressed: () => context.push(AppRoutes.place(p.id)),
            ),
      ],
    );
  }
}

/// Companions as chips that open their profiles.
class CompanionChips extends ConsumerWidget {
  const CompanionChips({required this.ids, super.key});

  final List<String> ids;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(companionIndexProvider).value ?? const [];
    final byId = {for (final c in index) c.id: c};
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final id in ids)
          if (byId[id] case final c?)
            ActionChip(
              avatar: const Icon(Icons.person_outline, size: 18),
              label: Text(c.name.of(context)),
              onPressed: () => context.push(AppRoutes.companion(c.id)),
            ),
      ],
    );
  }
}

/// A heading for a group of links at the end of a page.
class LinkGroupTitle extends StatelessWidget {
  const LinkGroupTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(
      top: AppSpacing.lg,
      bottom: AppSpacing.xs,
    ),
    child: Semantics(
      header: true,
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    ),
  );
}
