import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Where feedback goes. The same address is published in the privacy policy.
const feedbackEmail = 'abdallahragab40@gmail.com';

/// Opens a mailto link in the user's mail app; false when none opened.
/// Overridden in tests.
final mailLauncherProvider = Provider<Future<bool> Function(Uri)>(
  (ref) =>
      (uri) => launchUrl(uri, mode: LaunchMode.externalApplication),
);

/// Opens the user's mail app with a feedback message addressed to the
/// developer. The app itself sends nothing: the user writes and sends the
/// email. Without a mail app, the address is copied instead.
class FeedbackTile extends ConsumerWidget {
  const FeedbackTile({super.key});

  /// A mailto link. Spaces are encoded as %20, not '+', which mail apps
  /// would show literally.
  static Uri mailto({required String subject, required String body}) => Uri(
    scheme: 'mailto',
    path: feedbackEmail,
    query:
        'subject=${Uri.encodeComponent(subject)}'
        '&body=${Uri.encodeComponent(body)}',
  );

  Future<void> _send(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final uri = mailto(subject: l10n.feedbackSubject, body: l10n.feedbackBody);
    var opened = false;
    try {
      opened = await ref.read(mailLauncherProvider)(uri);
    } on Exception {
      // No handler, or no plugin: fall back to copying the address.
      opened = false;
    }
    if (opened) return;
    await Clipboard.setData(const ClipboardData(text: feedbackEmail));
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.feedbackCopied(feedbackEmail))),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.mail_outline),
      title: Text(l10n.feedbackTitle),
      subtitle: Text(l10n.feedbackHint),
      onTap: () => _send(context, ref),
    );
  }
}
