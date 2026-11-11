import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/review/domain/learning_topics.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

class LearningPage extends ConsumerWidget {
  const LearningPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topics = ref.watch(learningTopicsProvider);
    final Widget body = switch (topics) {
      AsyncData(:final value) => ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: [
          Text(l10n.learnedIntro, style: Theme.of(context).textTheme.bodyLarge),
          if (value.isEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.learnedEmpty),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: () => context.push(AppRoutes.journeys),
              child: Text(l10n.journeyStart),
            ),
          ],
          for (final state in LearningState.values)
            if (value.any((t) => t.state == state)) ...[
              const SizedBox(height: AppSpacing.lg),
              Semantics(
                header: true,
                child: Text(switch (state) {
                  LearningState.worthRevisiting => l10n.learnedRevisit,
                  LearningState.learning => l10n.learnedLearning,
                  LearningState.mastered => l10n.learnedMastered,
                }, style: Theme.of(context).textTheme.titleLarge),
              ),
              for (final t in value.where((t) => t.state == state))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(switch (state) {
                    LearningState.worthRevisiting => Icons.refresh,
                    LearningState.learning => Icons.menu_book_outlined,
                    LearningState.mastered => Icons.check_circle_outline,
                  }),
                  title: Text(t.title.of(context)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(t.route),
                ),
            ],
        ],
      ),
      AsyncError(:final error) => ErrorView(
        error: error,
        onRetry: () {
          ref.invalidate(reviewItemsProvider);
          ref.invalidate(reviewQuestionBankProvider);
          ref.invalidate(reviewQuestionsProvider);
          ref.invalidate(learningTopicsProvider);
        },
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
    return Scaffold(
      appBar: AppBar(title: Text(l10n.learnedTitle)),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.readingMaxWidth + AppSpacing.gutter * 2,
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}
