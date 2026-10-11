import 'package:flutter/material.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';

/// Says what was just removed and offers to put it back ("تراجع"). The
/// snack bar stays long enough to reach the button with a screen reader.
void showUndoSnackBar(
  ScaffoldMessengerState? messenger,
  AppLocalizations l10n, {
  required String message,
  required VoidCallback onUndo,
}) {
  messenger
    ?..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(label: l10n.undo, onPressed: onUndo),
      ),
    );
}
