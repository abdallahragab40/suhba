import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/presentation/glossary_links.dart';
import 'package:suhba/shared/content/providers.dart';

/// Every glossary term in alphabetical order (review E3); each opens its
/// definition with its sources.
class GlossaryPage extends ConsumerWidget {
  const GlossaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final glossary = ref.watch(glossaryProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.glossaryTitle)),
      body: switch (glossary) {
        AsyncData(:final value) when value.isEmpty => EmptyState(
          icon: Icons.menu_book_outlined,
          title: l10n.glossaryEmpty,
        ),
        AsyncData(:final value) => Builder(
          builder: (context) {
            final terms = value.values.toList()
              ..sort(
                (a, b) => a.term.of(context).compareTo(b.term.of(context)),
              );
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              itemCount: terms.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, i) {
                final t = terms[i];
                return ListTile(
                  title: Text(t.term.of(context)),
                  subtitle: Text(
                    t.definition.of(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colors.onSurfaceDim),
                  ),
                  onTap: () => showGlossarySheet(context, t),
                );
              },
            );
          },
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(glossaryProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 8),
        ),
      },
    );
  }
}
