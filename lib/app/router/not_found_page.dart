import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Shown for an unknown route or an outdated deep link.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: EmptyState(
        icon: Icons.explore_off_outlined,
        title: l10n.notFoundTitle,
        message: l10n.notFoundMessage,
        action: FilledButton(
          onPressed: () => context.go(AppRoutes.home),
          child: Text(l10n.goHome),
        ),
      ),
    );
  }
}
