import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Compact review status for content awaiting specialist approval.
///
/// The full pill belongs on detail pages. In a list whose items share a
/// status, use [DraftBadge.mark] on each row and one [ListStatusNote] for
/// the list (review F09, decision 1): the status is still on every item and
/// still announced, but no longer louder than the content.
class DraftBadge extends StatelessWidget {
  const DraftBadge({this.preliminary = false, super.key}) : _mark = false;

  /// The icon alone, with the label for screen readers and as a tooltip.
  const DraftBadge.mark({this.preliminary = false, super.key}) : _mark = true;

  /// The item had a preliminary review (see `ReviewStatus`).
  final bool preliminary;
  final bool _mark;

  /// True for [DraftBadge.mark], the icon-only form.
  bool get isMark => _mark;

  static const icon = Icons.edit_note;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final l10n = AppLocalizations.of(context);
    final label = preliminary ? l10n.draftBadgePreliminary : l10n.draftBadge;
    if (_mark) {
      return Tooltip(
        message: label,
        excludeFromSemantics: true,
        child: Semantics(
          label: label,
          excludeSemantics: true,
          child: Icon(
            icon,
            size: MediaQuery.textScalerOf(context).scale(18),
            color: colors.draft,
          ),
        ),
      );
    }
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colors.draftSurface,
          border: Border.all(color: colors.line),
          borderRadius: const BorderRadius.all(AppRadii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: MediaQuery.textScalerOf(context).scale(14),
              color: colors.draft,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: colors.draft),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One line above a list whose items carry [DraftBadge.mark]: what the
/// mark means, said once instead of on every row.
class ListStatusNote extends StatelessWidget {
  const ListStatusNote({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    final l10n = AppLocalizations.of(context);
    final style = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(
          child: Icon(
            DraftBadge.icon,
            size: MediaQuery.textScalerOf(context).scale(18),
            color: colors.draft,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(child: Text(l10n.listStatusNote, style: style)),
      ],
    );
  }
}
