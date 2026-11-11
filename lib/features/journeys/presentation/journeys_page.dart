import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

class JourneysPage extends ConsumerWidget {
  const JourneysPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final journeys = ref.watch(journeysProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.journeysTitle)),
      body: switch (journeys) {
        AsyncData(:final value) => ListView(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          children: [
            Text(
              l10n.journeysIntro,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (value.isEmpty)
              EmptyState(
                icon: Icons.route_outlined,
                title: l10n.journeyUnavailable,
              ),
            for (final j in value) JourneyCard(journey: j),
          ],
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(journeysProvider),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class JourneyCard extends ConsumerWidget {
  const JourneyCard({required this.journey, super.key});
  final Journey journey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final runtime = ref.watch(journeyRuntimeProvider(journey.id)).value;
    final progress = ref.watch(journeyStepsProvider).value ?? const [];
    final done = journey.steps
        .where(
          (s) => progress.any(
            (p) => p.journeyId == journey.id && p.stepId == s.id && p.finished,
          ),
        )
        .length;
    final minutes = runtime == null
        ? null
        : (journey.steps.fold<int>(0, (n, s) => n + runtime.minutes(s.id)) /
                  journey.steps.length)
              .ceil();
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.journey(journey.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!journey.review.isApproved) ...[
                DraftBadge(preliminary: journey.review.isPreliminary),
                const SizedBox(height: AppSpacing.sm),
              ],
              Text(
                journey.title.of(context),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(journey.description.of(context)),
              if (minutes != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.journeyLength(
                    journey.steps.length,
                    format.integer(journey.steps.length),
                    minutes,
                    format.integer(minutes),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.journeyProgress(
                  format.integer(done),
                  journey.steps.length,
                  format.integer(journey.steps.length),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              LinearProgressIndicator(
                value: done / journey.steps.length,
                semanticsLabel: l10n.journeyProgress(
                  format.integer(done),
                  journey.steps.length,
                  format.integer(journey.steps.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
