import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/core/result/failure.dart';

/// The standard "could not show this" state, with an optional retry.
///
/// Given the [error], it explains the cases a user can act on: content in a
/// format this app cannot read asks for an app update (and offers no retry,
/// which could not help).
class ErrorView extends StatelessWidget {
  const ErrorView({this.message, this.onRetry, this.error, super.key});

  /// Defaults to a generic message.
  final String? message;
  final VoidCallback? onRetry;
  final Object? error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unsupported = error is UnsupportedFormatFailure;
    final message = unsupported ? l10n.errorUnsupportedContent : this.message;
    final onRetry = unsupported ? null : this.onRetry;
    return Semantics(
      liveRegion: true,
      child: EmptyState(
        icon: Icons.error_outline,
        title: l10n.errorTitle,
        message: message ?? l10n.errorMessage,
        action: onRetry == null
            ? null
            : OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
              ),
      ),
    );
  }
}
