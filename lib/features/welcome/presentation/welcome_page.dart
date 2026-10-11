import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';
import 'package:siyar_sahaba/core/design_system/tokens/motion.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/design_system/widgets/brand_mark.dart';
import 'package:siyar_sahaba/core/design_system/widgets/scene_backdrop.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/welcome/presentation/welcome_controller.dart';

/// The welcome screens shown on the first launch only: what the app is,
/// the Seerah, the Companions, and the method (sources, reliability and
/// review). Skippable at any point; finishing or skipping hides them for
/// good. Drawn on Madinah green with the app's landscape scenes.
class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  final _controller = PageController();
  var _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finish() => ref.read(welcomeProvider.notifier).finish();

  void _next(int count) {
    if (_page == count - 1) {
      _finish();
      return;
    }
    _controller.nextPage(
      duration: AppMotion.resolve(context, AppMotion.long),
      curve: AppMotion.easeStandard,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final pages = [
      _WelcomeContent(
        scene: SceneKind.nightDesert,
        kicker: l10n.welcome1Kicker,
        title: l10n.appTitle,
        body: l10n.welcome1Body,
        showMark: true,
      ),
      _WelcomeContent(
        scene: SceneKind.mountains,
        kicker: l10n.welcome2Kicker,
        title: l10n.welcome2Title,
        body: l10n.welcome2Body,
      ),
      _WelcomeContent(
        scene: SceneKind.oasis,
        kicker: l10n.welcome3Kicker,
        title: l10n.welcome3Title,
        body: l10n.welcome3Body,
      ),
      _WelcomeContent(
        scene: SceneKind.sea,
        kicker: l10n.welcome4Kicker,
        title: l10n.welcome4Title,
        body: l10n.welcome4Body,
      ),
    ];
    final last = _page == pages.length - 1;

    return Theme(
      data: AppTheme.feature,
      child: Builder(
        builder: (context) {
          final scheme = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: Palette.green,
            body: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      child: AnimatedOpacity(
                        opacity: last ? 0 : 1,
                        duration: AppMotion.resolve(context, AppMotion.short),
                        child: TextButton(
                          onPressed: last ? null : _finish,
                          child: Text(l10n.welcomeSkip),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (i) => setState(() => _page = i),
                      children: pages,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.gutter,
                      AppSpacing.md,
                      AppSpacing.gutter,
                      AppSpacing.lg,
                    ),
                    child: Row(
                      children: [
                        Semantics(
                          label: l10n.welcomePageLabel(
                            format.integer(_page + 1),
                            format.integer(pages.length),
                          ),
                          child: ExcludeSemantics(
                            child: Row(
                              children: [
                                for (var i = 0; i < pages.length; i++)
                                  AnimatedContainer(
                                    duration: AppMotion.resolve(
                                      context,
                                      AppMotion.medium,
                                    ),
                                    margin: const EdgeInsetsDirectional.only(
                                      end: AppSpacing.xxs,
                                    ),
                                    width: i == _page ? 22 : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: i == _page
                                          ? Palette.goldOnInk
                                          : scheme.outlineVariant,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () => _next(pages.length),
                          child: Text(
                            last ? l10n.welcomeStart : l10n.welcomeNext,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WelcomeContent extends StatelessWidget {
  const _WelcomeContent({
    required this.scene,
    required this.kicker,
    required this.title,
    required this.body,
    this.showMark = false,
  });

  final SceneKind scene;
  final String kicker;
  final String title;
  final String body;
  final bool showMark;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final styles = SahabaTextStyles.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            maxWidth: AppSpacing.readingMaxWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: 240,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SceneBackdrop(kind: scene),
                      if (showMark)
                        const Align(
                          alignment: Alignment(0, -0.35),
                          child: ExcludeSemantics(child: BrandMark(size: 260)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                kicker,
                style: styles.kicker.copyWith(color: Palette.goldOnInk),
              ),
              const SizedBox(height: AppSpacing.xs),
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: textTheme.displaySmall?.copyWith(color: Palette.paper),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(body, style: styles.reading.copyWith(color: Palette.paper)),
            ],
          ),
        ),
      ),
    );
  }
}
