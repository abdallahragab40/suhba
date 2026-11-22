import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/feedback/haptics.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/settings/presentation/reading_settings.dart';
import 'package:suhba/features/settings/presentation/theme_mode_controller.dart';
import 'package:suhba/shared/content/providers.dart';
import 'package:url_launcher/url_launcher.dart';

/// Where feedback goes. The same address is published in the privacy policy.
const feedbackEmail = 'abdallahragab40@gmail.com';

/// Opens a mailto link in the user's mail app; false when none opened.
/// Overridden in tests.
final mailLauncherProvider = Provider<Future<bool> Function(Uri)>(
  (ref) =>
      (uri) => launchUrl(uri, mode: LaunchMode.externalApplication),
);

/// The app's version and build, e.g. "2.0.0 (3)"; null where unknown.
final appVersionProvider = FutureProvider<String?>((ref) async {
  try {
    final info = await PackageInfo.fromPlatform();
    return '${info.version} (${info.buildNumber})';
  } on Exception {
    return null;
  } on Error {
    // No platform plugin (host tests).
    return null;
  }
});

/// What a message is about. Its label leads the email's subject, so the
/// developer can sort the inbox at a glance.
enum FeedbackKind { content, bug, idea, thanks }

String feedbackKindLabel(AppLocalizations l10n, FeedbackKind kind) =>
    switch (kind) {
      FeedbackKind.content => l10n.feedbackKindContent,
      FeedbackKind.bug => l10n.feedbackKindBug,
      FeedbackKind.idea => l10n.feedbackKindIdea,
      FeedbackKind.thanks => l10n.feedbackKindThanks,
    };

/// A passage the reader is reporting: where it is and its words.
typedef FeedbackPassage = ({String origin, String text});

/// The Settings entry that opens [FeedbackSheet].
class FeedbackTile extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.mail_outline),
      title: Text(l10n.feedbackTitle),
      subtitle: Text(l10n.feedbackHint),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => showFeedbackSheet(context),
    );
  }
}

/// Opens the feedback sheet, about [passage] when one is given.
Future<void> showFeedbackSheet(
  BuildContext context, {
  FeedbackPassage? passage,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => FeedbackSheet(passage: passage),
);

/// Writes a feedback message: its kind, the reader's words, the passage it
/// is about, and (if the reader agrees) a few app details. The message is
/// then opened in the reader's own mail app, addressed to [feedbackEmail],
/// where they see it and send it themselves. The app has no Internet
/// access and sends nothing on its own. Without a mail app the message is
/// copied, to paste anywhere.
class FeedbackSheet extends ConsumerStatefulWidget {
  const FeedbackSheet({this.passage, super.key});

  final FeedbackPassage? passage;

  @override
  ConsumerState<FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends ConsumerState<FeedbackSheet> {
  late FeedbackKind _kind = widget.passage == null
      ? FeedbackKind.idea
      : FeedbackKind.content;
  final _message = TextEditingController();
  bool _details = true;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  /// The details appended when the reader agrees: nothing personal, only
  /// what helps to reproduce a problem.
  List<String> _detailLines(AppLocalizations l10n) {
    final format = DisplayFormatter.of(context);
    final version = ref.watch(appVersionProvider).value;
    final manifest = ref.watch(contentManifestProvider).value;
    final theme = switch (ref.watch(themeModeProvider)) {
      ThemeMode.system => l10n.themeShortSystem,
      ThemeMode.light => l10n.themeShortLight,
      ThemeMode.dark => l10n.themeShortDark,
    };
    final size = ref.watch(readingTextSizeProvider).round();
    return [
      if (version != null) l10n.feedbackDetailVersion(version),
      if (manifest != null) l10n.feedbackDetailContent(manifest.contentVersion),
      l10n.feedbackDetailSystem(_system()),
      l10n.feedbackDetailDisplay(theme, format.integer(size)),
    ];
  }

  /// The platform's name only: the version string Dart reports on Android
  /// is a build code, which means nothing to the reader who sends it.
  static String _system() => switch (defaultTargetPlatform) {
    TargetPlatform.android => 'Android',
    TargetPlatform.iOS => 'iOS',
    final other => other.name,
  };

  String _subject(AppLocalizations l10n) =>
      '${feedbackKindLabel(l10n, _kind)} — ${l10n.feedbackSubject}';

  String _body(AppLocalizations l10n) {
    final passage = widget.passage;
    return [
      _message.text.trim(),
      if (passage != null) ...[
        '',
        '— ${l10n.feedbackAboutPassage}: ${passage.origin}',
        '«${passage.text}»',
      ],
      if (_details) ...[
        '',
        '— ${l10n.feedbackDetailsHeading}',
        ..._detailLines(l10n),
      ],
    ].join('\n');
  }

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final subject = _subject(l10n);
    final body = _body(l10n);
    Haptics.selection(context);
    var opened = false;
    try {
      opened = await ref.read(mailLauncherProvider)(
        FeedbackTile.mailto(subject: subject, body: body),
      );
    } on Exception {
      // No handler, or no plugin: fall back to copying the message.
      opened = false;
    }
    if (!opened) {
      await Clipboard.setData(
        ClipboardData(text: '$feedbackEmail\n$subject\n\n$body'),
      );
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.feedbackMessageCopied(feedbackEmail))),
      );
    }
    if (mounted) navigator.pop();
  }

  Future<void> _copyAddress() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(const ClipboardData(text: feedbackEmail));
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.feedbackAddressCopied(feedbackEmail))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colors = SuhbaColors.of(context);
    final passage = widget.passage;
    final dim = textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim);

    return Padding(
      // Above the keyboard while the message is typed.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(l10n.feedbackTitle, style: textTheme.titleLarge),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(l10n.feedbackSheetIntro, style: dim),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.feedbackKindLabel,
              style: SuhbaTextStyles.of(context).kicker,
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final kind in FeedbackKind.values)
                  ChoiceChip(
                    label: Text(feedbackKindLabel(l10n, kind)),
                    selected: _kind == kind,
                    onSelected: (_) {
                      Haptics.selection(context);
                      setState(() => _kind = kind);
                    },
                  ),
              ],
            ),
            if (passage != null) ...[
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: colors.surfaceAlt,
                  border: Border.all(color: colors.line),
                  borderRadius: const BorderRadius.all(AppRadii.sm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${l10n.feedbackAboutPassage}: ${passage.origin}',
                      style: SuhbaTextStyles.of(context).kicker,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      passage.text,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _message,
              minLines: 4,
              maxLines: 8,
              maxLength: 2000,
              // The limit only guards against pasted walls of text; a
              // counter would be noise.
              buildCounter:
                  (
                    _, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) => null,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l10n.feedbackMessageLabel,
                hintText: l10n.feedbackMessageHint,
                alignLabelWithHint: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(AppRadii.md),
                ),
              ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _details,
              onChanged: (v) => setState(() => _details = v),
              title: Text(l10n.feedbackIncludeDetails),
              subtitle: Text(_detailLines(l10n).join('، '), style: dim),
            ),
            const SizedBox(height: AppSpacing.sm),
            FilledButton.icon(
              icon: const Icon(Icons.send_outlined),
              label: Text(l10n.feedbackSend),
              onPressed: _message.text.trim().isEmpty ? null : _send,
            ),
            const SizedBox(height: AppSpacing.xs),
            TextButton.icon(
              icon: const Icon(Icons.copy_outlined),
              label: Text('${l10n.feedbackCopyAddress}: $feedbackEmail'),
              onPressed: _copyAddress,
            ),
          ],
        ),
      ),
    );
  }
}
