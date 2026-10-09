import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';

/// The bottom navigation shell. In RTL the first tab (home) sits on the
/// right.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const homeBranch = 0;

  void _select(int index) {
    // Tapping the current tab again returns it to its root.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final onHome = navigationShell.currentIndex == homeBranch;

    return PopScope(
      // Back from another tab's root goes home before leaving the app.
      canPop: onHome,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _select(homeBranch);
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _select,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: l10n.tabHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.people_alt_outlined),
              selectedIcon: const Icon(Icons.people_alt),
              label: l10n.tabCompanions,
            ),
            NavigationDestination(
              icon: const Icon(Icons.bookmark_border),
              selectedIcon: const Icon(Icons.bookmark),
              label: l10n.tabSaved,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: l10n.tabSettings,
            ),
          ],
        ),
      ),
    );
  }
}
