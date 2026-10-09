import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/shared/visuals/presentation/infographic_view.dart';

/// One visual on its own page (S22): the full, zoomable chart with its
/// takeaway, notes, sources and equivalent list.
class VisualPage extends StatelessWidget {
  const VisualPage({required this.visualId, super.key});

  final String visualId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).visualPageTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: InfographicView(visualId: visualId),
            ),
          ),
        ],
      ),
    );
  }
}
