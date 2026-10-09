import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';

/// The reader's own data on this device (E10): the reading history, and
/// separate controls to clear it or the saved items. Clearing everything of
/// a kind asks first, says how much will go, and never touches the other
/// kind or the settings.
class PersonalDataSection extends ConsumerWidget {
  const PersonalDataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final progress = ref.watch(allProgressProvider).value?.length ?? 0;
    final saved = ref.watch(bookmarksProvider).value?.length ?? 0;
    final texts = l10n.countTexts(progress, format.integer(progress));
    final items = l10n.countItems(saved, format.integer(saved));

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.history),
          title: Text(l10n.historyTitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.go(AppRoutes.readingHistory),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.delete_sweep_outlined),
          title: Text(l10n.settingsClearHistory),
          subtitle: Text(progress == 0 ? l10n.settingsNothingToClear : texts),
          enabled: progress > 0,
          onTap: () => _confirmAndClear(
            context,
            title: l10n.clearHistoryTitle,
            message: l10n.clearHistoryMessage(texts),
            done: l10n.historyCleared,
            clear: ref.read(readingProgressRepositoryProvider).clearAll,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.bookmark_remove_outlined),
          title: Text(l10n.settingsClearSaved),
          subtitle: Text(saved == 0 ? l10n.settingsNothingToClear : items),
          enabled: saved > 0,
          onTap: () => _confirmAndClear(
            context,
            title: l10n.clearSavedTitle,
            message: l10n.clearSavedMessage(items),
            done: l10n.savedCleared,
            clear: ref.read(bookmarkRepositoryProvider).clearAll,
          ),
        ),
      ],
    );
  }

  Future<void> _confirmAndClear(
    BuildContext context, {
    required String title,
    required String message,
    required String done,
    required Future<int> Function() clear,
  }) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.clearConfirm),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await clear();
      messenger?.showSnackBar(SnackBar(content: Text(done)));
    } on Object {
      messenger?.showSnackBar(
        SnackBar(content: Text(l10n.bookmarkUpdateFailed)),
      );
    }
  }
}
