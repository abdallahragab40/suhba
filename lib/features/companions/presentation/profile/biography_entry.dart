import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/reading_progress/domain/reading_entry.dart';
import 'package:suhba/features/reading_progress/domain/reading_progress.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

/// The one-tap way into a biography from the profile: start it, continue
/// the section read last, or (when every section is finished) read it again
/// from the start. A profile without a written biography says so instead
/// of leaving the reader to wonder, without promising a date.
class BiographyEntry extends ConsumerWidget {
  const BiographyEntry({required this.companion, super.key});

  final Companion companion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final c = companion;
    final female = c.gender == Gender.female;

    if (c.sections.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: colors.onSurfaceDim),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  female
                      ? l10n.profileBiographyNotWrittenFemale
                      : l10n.profileBiographyNotWrittenMale,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final progress =
        ref.watch(workProgressProvider((ProgressTarget.section, c.id))).value ??
        const {};
    final entry = readingEntryFor([for (final s in c.sections) s.id], progress);
    String titleOf(String id) =>
        c.sections.firstWhere((s) => s.id == id).title.of(context);
    void open(String sectionId) =>
        context.push(AppRoutes.section(c.id, sectionId));

    final count = l10n.profileSectionCount(
      c.sections.length,
      format.integer(c.sections.length),
    );

    return switch (entry) {
      StartReading(:final passageId) => _EntryRow(
        detail: count,
        button: FilledButton.icon(
          onPressed: () => open(passageId),
          icon: const Icon(Icons.menu_book_outlined),
          label: Text(l10n.profileStartReading),
        ),
      ),
      ResumeReading(:final passageId, :final fraction) => _EntryRow(
        detail: l10n.profileResumeDetail(
          titleOf(passageId),
          format.percent((fraction * 100).round()),
        ),
        button: FilledButton.icon(
          onPressed: () => open(passageId),
          icon: const Icon(Icons.play_arrow),
          label: Text(l10n.profileContinueReading),
        ),
      ),
      FinishedReading(:final firstPassageId) => _EntryRow(
        leading: Icon(Icons.check_circle, color: colors.accent),
        detail: female
            ? l10n.profileBiographyFinishedFemale
            : l10n.profileBiographyFinishedMale,
        button: OutlinedButton(
          onPressed: () => open(firstPassageId),
          child: Text(l10n.profileReadFromStart),
        ),
      ),
    };
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.detail, required this.button, this.leading});

  final String detail;
  final Widget button;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    // Button and detail side by side when there is room, stacked otherwise
    // (narrow screens, large text).
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        button,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSpacing.xs),
            ],
            Flexible(
              child: Text(detail, style: TextStyle(color: colors.onSurfaceDim)),
            ),
          ],
        ),
      ],
    );
  }
}
