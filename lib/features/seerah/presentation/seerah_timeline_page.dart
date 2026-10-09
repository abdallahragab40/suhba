import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/infographic_view.dart';

/// The Seerah on one time line (S18): the periods at a glance, then every
/// event of the archive at its date. Each opens its event page.
class SeerahTimelinePage extends ConsumerWidget {
  const SeerahTimelinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final index = ref.watch(seerahIndexProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.seerahTimelineTitle)),
      body: switch (index) {
        AsyncData(:final value) => ListView(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final id in value.collection.visualIds)
                      if (id == 'seerah-periods' || id == 'seerah-timeline')
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            bottom: AppSpacing.xl,
                          ),
                          child: InfographicView(visualId: id),
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(seerahIndexProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 10),
        ),
      },
    );
  }
}
