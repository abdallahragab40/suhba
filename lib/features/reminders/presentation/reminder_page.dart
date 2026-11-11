import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/reminders/domain/reading_reminder.dart';
import 'package:suhba/features/reminders/presentation/reminder_providers.dart';

String reminderTimeLabel(BuildContext context, ReadingReminder settings) {
  final format = DisplayFormatter.of(context);
  return '${format.padded(settings.hour)}:${format.padded(settings.minute)}';
}

/// One shared entry, available from Settings and journey overviews.
class ReminderSettingsTile extends ConsumerWidget {
  const ReminderSettingsTile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final config =
        ref.watch(reminderProvider).value?.settings ?? const ReadingReminder();
    final time = reminderTimeLabel(context, config);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.notifications_none),
      title: Text(l10n.reminderTitle),
      subtitle: Text(
        config.enabled ? l10n.reminderOnAt(time) : l10n.reminderOffAt(time),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(AppRoutes.settingsReminder),
    );
  }
}

class ReminderPage extends ConsumerWidget {
  const ReminderPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final reminder = ref.watch(reminderProvider);
    final value = reminder.value;
    final controller = ref.read(reminderProvider.notifier);
    final Widget body;
    if (value == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      final config = value.settings;
      final canChange = value.supported && !reminder.isLoading && !value.busy;
      body = ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: [
          Text(
            l10n.reminderIntro,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.reminderSwitch),
            value: config.enabled,
            onChanged: canChange ? controller.setEnabled : null,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: Text(l10n.reminderTime),
            subtitle: Text(reminderTimeLabel(context, config)),
            enabled: canChange,
            onTap: canChange
                ? () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: config.hour,
                        minute: config.minute,
                      ),
                      initialEntryMode: TimePickerEntryMode.input,
                      builder: (context, child) => MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      ),
                    );
                    if (time != null) {
                      await controller.setTime(time.hour, time.minute);
                    }
                  }
                : null,
          ),
          if (!value.supported)
            Text(l10n.reminderUnsupported)
          else ...[
            if (value.issue == ReminderIssue.denied) ...[
              const SizedBox(height: AppSpacing.md),
              Semantics(liveRegion: true, child: Text(l10n.reminderDenied)),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: canChange ? controller.openSettings : null,
                  icon: const Icon(Icons.settings_outlined),
                  label: Text(l10n.reminderSystemSettings),
                ),
              ),
            ],
            if (value.issue == ReminderIssue.failed) ...[
              const SizedBox(height: AppSpacing.md),
              Semantics(liveRegion: true, child: Text(l10n.reminderFailed)),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: canChange
                      ? () => ref.invalidate(reminderProvider)
                      : null,
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.retry),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.reminderTimingNote,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.reminderTitle)),
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
