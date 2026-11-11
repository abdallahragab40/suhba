import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/share/share_service.dart';
import 'package:suhba/features/sources/presentation/passage_card.dart';

class ShareCardSheet extends ConsumerStatefulWidget {
  const ShareCardSheet({
    required this.excerpt,
    required this.origin,
    required this.sources,
    required this.footer,
    this.notice,
    super.key,
  });
  final String excerpt, origin, sources, footer;
  final String? notice;
  @override
  ConsumerState<ShareCardSheet> createState() => _ShareCardSheetState();
}

class _ShareCardSheetState extends ConsumerState<ShareCardSheet> {
  final _card = GlobalKey();
  PassageCardSize _size = PassageCardSize.square;
  bool? _dark;
  bool _busy = false;
  bool _failed = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dark = _dark ?? Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.shareCardTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                for (final size in PassageCardSize.values)
                  ChoiceChip(
                    label: Text(
                      size == PassageCardSize.square
                          ? l10n.shareCardSquare
                          : l10n.shareCardStory,
                    ),
                    selected: _size == size,
                    onSelected: _busy
                        ? null
                        : (_) => setState(() => _size = size),
                  ),
                FilterChip(
                  label: Text(l10n.shareCardDark),
                  selected: dark,
                  onSelected: _busy
                      ? null
                      : (value) => setState(() => _dark = value),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // The boundary keeps its exact canvas even on narrow phones. FittedBox
            // scales the preview, while toImage exports the original 360×height.
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RepaintBoundary(
                key: _card,
                child: PassageCard(
                  excerpt: widget.excerpt,
                  origin: widget.origin,
                  sources: widget.sources,
                  footer: widget.footer,
                  notice: widget.notice,
                  size: _size,
                  dark: dark,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_failed) Text(l10n.shareCardFailed),
            Builder(
              builder: (button) => FilledButton.icon(
                icon: const Icon(Icons.ios_share),
                label: Text(l10n.shareCardAction),
                onPressed: _busy
                    ? null
                    : () async {
                        final origin = shareOriginOf(button);
                        final service = ref.read(shareServiceProvider);
                        setState(() {
                          _busy = true;
                          _failed = false;
                        });
                        try {
                          final bytes = await capturePassageCard(_card);
                          await service.shareFile(
                            bytes,
                            fileName: 'suhba-${_size.name}.png',
                            mimeType: 'image/png',
                            subject: widget.origin,
                            origin: origin,
                          );
                        } on Object {
                          if (mounted) setState(() => _failed = true);
                        } finally {
                          if (mounted) setState(() => _busy = false);
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
