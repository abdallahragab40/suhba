import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/core/share/share_service.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/bookmark_providers.dart';
import 'package:siyar_sahaba/features/personal_data/domain/reading_data_archive.dart';
import 'package:siyar_sahaba/features/personal_data/presentation/reading_data_transfer.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/progress_providers.dart';

/// The reader's own data on this device (E10): the reading history, export
/// and import of saved items and positions, and separate controls to clear
/// either kind. Clearing everything of a kind asks first, says how much
/// will go, and never touches the other kind or the settings. Importing
/// says what it will add first and never deletes anything.
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
        Builder(
          builder: (tile) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.ios_share),
            title: Text(l10n.settingsExport),
            subtitle: Text(l10n.settingsExportSubtitle),
            enabled: progress + saved > 0,
            onTap: () => _export(tile, ref),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.file_open_outlined),
          title: Text(l10n.settingsImport),
          subtitle: Text(l10n.settingsImportSubtitle),
          onTap: () => _import(context, ref),
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

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      await ref
          .read(readingDataTransferProvider)
          .export(
            subject: l10n.exportSubject(l10n.appTitle),
            origin: shareOriginOf(context),
          );
    } on Object {
      messenger?.showSnackBar(SnackBar(content: Text(l10n.exportFailed)));
    }
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final transfer = ref.read(readingDataTransferProvider);
    final ImportChoice choice;
    try {
      choice = await transfer.choose();
    } on Object {
      messenger?.showSnackBar(SnackBar(content: Text(l10n.importReadFailed)));
      return;
    }
    if (!context.mounted) return;
    switch (choice) {
      case ImportCancelled():
        return;
      case ImportRefused(:final problem, :final where):
        await showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(l10n.importRefusedTitle),
            content: Text(switch (problem) {
              ArchiveProblem.notJson => l10n.importRefusedNotJson,
              ArchiveProblem.notAnExport => l10n.importRefusedNotAnExport,
              ArchiveProblem.newerVersion => l10n.importRefusedNewer,
              ArchiveProblem.invalidRecord => l10n.importRefusedInvalid(
                // A technical path, kept in Latin script.
                '\u2066${where ?? ''}\u2069',
              ),
            }),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n.dialogOk),
              ),
            ],
          ),
        );
      case ImportReady(:final plan) when plan.isEmpty:
        messenger?.showSnackBar(SnackBar(content: Text(l10n.importNothingNew)));
      case ImportReady(:final plan):
        final items = plan.newBookmarks.length;
        final texts = plan.progressToSave.length;
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(l10n.importConfirmTitle),
            content: Text(
              l10n.importConfirmMessage(
                l10n.countItems(items, format.integer(items)),
                l10n.countTexts(texts, format.integer(texts)),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(l10n.importConfirm),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
        try {
          await transfer.apply(plan);
          messenger?.showSnackBar(SnackBar(content: Text(l10n.importDone)));
        } on Object {
          messenger?.showSnackBar(SnackBar(content: Text(l10n.importFailed)));
        }
    }
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
