import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

/// "All" followed by one choice chip per category, scrolling sideways.
class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    required this.categories,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<CompanionCategory> categories;

  /// The selected category id, or null for all.
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = <(String?, String)>[
      (null, AppLocalizations.of(context).directoryAll),
      for (final c in categories) (c.id, c.name.of(context)),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          for (final (id, label) in options) ...[
            ChoiceChip(
              label: Text(label),
              selected: selected == id,
              onSelected: (_) => onSelected(id),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
        ],
      ),
    );
  }
}
