import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

/// Keeps imperative content navigation above full-screen tools without adding
/// a second instance of the stateful tab shell to the root Navigator.
///
/// Canonical routes still serve deep links and tab navigation. These generated
/// aliases reuse the same pages for push/replace from an overlay, keeping its
/// Back stack without duplicating route definitions or changing stored links.
class ContentRouter extends GoRouter {
  ContentRouter({
    required super.initialLocation,
    required GoRouterRedirect redirect,
    required super.errorBuilder,
    required List<RouteBase> routes,
  }) : super.routingConfig(
         routingConfig: ValueNotifier(
           RoutingConfig(
             routes: _withContentRoutes(routes),
             redirect: redirect,
           ),
         ),
       );

  static const _prefix = '/content';

  static List<RouteBase> _withContentRoutes(List<RouteBase> routes) => [
    ...routes,
    for (final shell in routes.whereType<StatefulShellRoute>())
      for (final branch in shell.branches)
        for (final route in branch.routes.cast<GoRoute>())
          _copyContentRoute(route, root: true),
  ];

  static GoRoute _copyContentRoute(GoRoute route, {bool root = false}) =>
      GoRoute(
        path: root ? '$_prefix${route.path}' : route.path,
        builder: route.builder,
        pageBuilder: route.pageBuilder,
        routes: [
          for (final child in route.routes.cast<GoRoute>())
            _copyContentRoute(child),
        ],
      );

  String _contentLocation(String location) {
    final matches = routerDelegate.currentConfiguration.matches;
    if (matches.isEmpty || matches.last is ShellRouteMatch) return location;
    final uri = Uri.parse(location);
    // Only mirror destinations that would otherwise reinsert the tab shell.
    final target = configuration.findMatch(uri);
    if (target.matches.isEmpty || target.matches.last is! ShellRouteMatch) {
      return location;
    }
    return uri.replace(path: '$_prefix${uri.path}').toString();
  }

  @override
  Future<T?> push<T extends Object?>(String location, {Object? extra}) =>
      super.push<T>(_contentLocation(location), extra: extra);

  @override
  Future<T?> replace<T>(String location, {Object? extra}) =>
      super.replace<T>(_contentLocation(location), extra: extra);

  @override
  Future<T?> pushReplacement<T extends Object?>(
    String location, {
    Object? extra,
  }) => super.pushReplacement<T>(_contentLocation(location), extra: extra);
}
