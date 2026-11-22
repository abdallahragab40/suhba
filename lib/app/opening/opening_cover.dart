import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/design_system/tokens/motion.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/widgets/brand_loader.dart';
import 'package:suhba/core/design_system/widgets/brand_mark.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/providers.dart';

/// Whether the opening screen is shown; off in widget tests, which have
/// their own test of it.
final openingCoverEnabledProvider = Provider<bool>((ref) => true);

/// Whether what Home opens on has loaded, or failed (Home then says so).
final appReadyProvider = Provider<bool>(
  (ref) => [
    ref.watch(contentManifestProvider),
    ref.watch(companionIndexProvider),
    ref.watch(storyIndexProvider),
    ref.watch(seerahIndexProvider),
  ].every((value) => value.hasValue || value.hasError),
);

/// The size of the mark's disc, as Android 12+ draws its splash icon.
const openingMarkSize = 160.0;

/// The opening screen: the launch screen's mark, in the same place, with a
/// gold line running under it until the content has loaded; then it fades
/// into the app. It continues the system's launch screen, so the reader
/// sees one screen from the tap to Home.
class OpeningCover extends ConsumerStatefulWidget {
  const OpeningCover({required this.child, super.key});

  final Widget child;

  /// Past this, the cover lifts whatever is still loading; Home has its own
  /// placeholders.
  static const maximum = Duration(seconds: 6);

  /// The line appears only if loading takes longer than this, so a quick
  /// start shows no flicker.
  static const lineDelay = Duration(milliseconds: 400);

  static const fade = Duration(milliseconds: 350);

  @override
  ConsumerState<OpeningCover> createState() => _OpeningCoverState();
}

class _OpeningCoverState extends ConsumerState<OpeningCover> {
  late bool _shown = ref.read(openingCoverEnabledProvider);
  bool _lifting = false;
  bool _line = false;
  Timer? _lineTimer, _maximumTimer;

  @override
  void initState() {
    super.initState();
    if (!_shown) return;
    _lineTimer = Timer(OpeningCover.lineDelay, () {
      if (mounted) setState(() => _line = true);
    });
    _maximumTimer = Timer(OpeningCover.maximum, _lift);
  }

  @override
  void dispose() {
    _lineTimer?.cancel();
    _maximumTimer?.cancel();
    super.dispose();
  }

  void _lift() {
    if (!mounted || _lifting) return;
    _lineTimer?.cancel();
    _maximumTimer?.cancel();
    final instant =
        AppMotion.resolve(context, OpeningCover.fade) == Duration.zero;
    setState(() {
      _lifting = true;
      if (instant) _shown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_shown && !_lifting && ref.watch(appReadyProvider)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _lift());
    }
    // The app keeps its place in the tree whether or not the cover is
    // over it, so lifting the cover never rebuilds it.
    return Stack(
      fit: StackFit.expand,
      children: [
        ExcludeSemantics(excluding: _shown, child: widget.child),
        if (_shown)
          AnimatedOpacity(
            opacity: _lifting ? 0 : 1,
            duration: OpeningCover.fade,
            curve: Curves.easeOut,
            onEnd: () {
              if (mounted) setState(() => _shown = false);
            },
            child: _Cover(
              line:
                  _line &&
                  !_lifting &&
                  !MediaQuery.disableAnimationsOf(context),
            ),
          ),
      ],
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.line});

  final bool line;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      label: l10n.loadingApp,
      container: true,
      child: ColoredBox(
        // Always the light page, as the launch screen is.
        color: Palette.paper,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const ExcludeSemantics(
              child: BrandMark(
                size: openingMarkSize,
                layout: BrandMarkLayout.disc,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, openingMarkSize / 2 + 40),
              child: AnimatedOpacity(
                opacity: line ? 1 : 0,
                duration: AppMotion.resolve(context, AppMotion.medium),
                child: line
                    ? const ExcludeSemantics(
                        child: BrandLoader(
                          width: 72,
                          color: Palette.gold,
                          trackColor: Palette.goldWash,
                        ),
                      )
                    : const SizedBox(height: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
