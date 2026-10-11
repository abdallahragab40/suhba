import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/core/design_system/tokens/motion.dart';

/// A fade-through page: the new page fades in while scaling up slightly.
/// Instant when the user has asked to reduce motion.
Page<void> fadeThroughPage(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  final duration = AppMotion.resolve(context, AppMotion.medium);
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: AppMotion.easeStandard,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}
