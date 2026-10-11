import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// The navigation shell: a bottom bar on phones and a rail on wide screens.
/// In RTL the first destination (home) sits on the right (or the top of the
/// rail). Each destination keeps its own navigation stack.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const homeBranch = 0;

  /// From this width the destinations move to a side rail.
  static const railBreakpoint = 840.0;

  void _select(int index) {
    // Tapping the current destination again returns it to its root.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final onHome = navigationShell.currentIndex == homeBranch;
    final destinations = [
      (Icons.home_outlined, Icons.home, l10n.tabHome),
      (Icons.auto_stories_outlined, Icons.auto_stories, l10n.tabSeerah),
      (Icons.people_alt_outlined, Icons.people_alt, l10n.tabCompanions),
      (Icons.explore_outlined, Icons.explore, l10n.tabExplore),
      (Icons.bookmark_border, Icons.bookmark, l10n.tabSaved),
    ];
    final wide = MediaQuery.sizeOf(context).width >= railBreakpoint;

    return PopScope(
      // Back from another destination's root goes home before leaving.
      canPop: onHome,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _select(homeBranch);
      },
      child: wide
          ? Scaffold(
              body: Row(
                children: [
                  NavigationRail(
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: _select,
                    labelType: NavigationRailLabelType.all,
                    destinations: [
                      for (final (icon, selected, label) in destinations)
                        NavigationRailDestination(
                          icon: Icon(icon),
                          selectedIcon: Icon(selected),
                          label: Text(label),
                        ),
                    ],
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: navigationShell),
                ],
              ),
            )
          : Scaffold(
              body: navigationShell,
              bottomNavigationBar: NavigationBar(
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: _select,
                destinations: [
                  for (final (icon, selected, label) in destinations)
                    NavigationDestination(
                      icon: Icon(icon),
                      selectedIcon: Icon(selected),
                      label: label,
                    ),
                ],
              ),
            ),
    );
  }
}

/// The app bar actions every destination shares: search, then settings
/// (which is no longer a destination of its own).
List<Widget> shellActions(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return [
    IconButton(
      tooltip: l10n.searchTooltip,
      icon: const Icon(Icons.search),
      onPressed: () => context.push(AppRoutes.search),
    ),
    IconButton(
      tooltip: l10n.tabSettings,
      icon: const Icon(Icons.settings_outlined),
      onPressed: () => context.push(AppRoutes.settings),
    ),
  ];
}
