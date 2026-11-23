import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/app/router/app_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/motion.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/brand_mark.dart';
import 'package:suhba/core/design_system/widgets/scene_backdrop.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/welcome/presentation/welcome_controller.dart';
import 'package:suhba/shared/content/providers.dart';

/// The welcome screens shown on the first launch: what the app is, the
/// Seerah, the Companions, journeys, and the method (sources, reliability
/// and review). After the upgrade from 1.0 only the journeys page shows,
/// once. Skippable at any point; finishing or skipping hides them for
/// good. Drawn on Madinah green with the app's landscape scenes.
class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key, this.mode = WelcomeMode.full});

  final WelcomeMode mode;

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
    final isDraft = ref.watch(contentManifestProvider).value?.isDraft ?? true;
    final journeys = _WelcomeContent(
      scene: SceneKind.nightDesert,
      kicker: widget.mode == WelcomeMode.whatsNew
          ? l10n.welcomeWhatsNewKicker
          : l10n.welcomeJourneysKicker,
      title: l10n.welcomeJourneysTitle,
      body: l10n.welcomeJourneysBody,
    );
    final pages = widget.mode == WelcomeMode.whatsNew
        ? [journeys]
        : [
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
            journeys,
            _WelcomeContent(
              scene: SceneKind.sea,
              kicker: l10n.welcome4Kicker,
              title: l10n.welcome4Title,
              body: isDraft ? l10n.welcome4Body : l10n.welcome4BodyPublished,
            ),
          ];
    final last = _page == pages.length - 1;

    return Theme(
      data: AppTheme.feature,
      child: Builder(
        builder: (context) {
          final scheme = Theme.of(context).colorScheme;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            // Light status bar text on the green.
            value: SystemUiOverlayStyle.light,
            child: Scaffold(
              backgroundColor: Palette.green,
              body: SafeArea(
                // On tablets the screens keep a reading width, centred,
                // with the controls beneath them rather than in the corners.
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth:
                          AppSpacing.readingMaxWidth + 2 * AppSpacing.gutter,
                    ),
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
                              duration: AppMotion.resolve(
                                context,
                                AppMotion.short,
                              ),
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
                              if (pages.length > 1)
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
                                            margin:
                                                const EdgeInsetsDirectional.only(
                                                  end: AppSpacing.xxs,
                                                ),
                                            width: i == _page ? 22 : 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: i == _page
                                                  ? Palette.goldOnInk
                                                  : scheme.outlineVariant,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              const Spacer(),
                              // A new reader's first journey (E4): the
                              // journey the content orders first.
                              if (last && widget.mode != WelcomeMode.whatsNew)
                                if (ref
                                        .watch(journeysProvider)
                                        .value
                                        ?.firstOrNull
                                    case final start?)
                                  // Flexible: at large text sizes on a small
                                  // phone the label wraps instead of pushing
                                  // the row past the screen edge.
                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        end: AppSpacing.xs,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          // The router is not mounted while
                                          // these screens cover the app; a
                                          // push now would replace Home rather
                                          // than open above it. Push once the
                                          // next frame has brought it back.
                                          final router = ref.read(
                                            appRouterProvider,
                                          );
                                          _finish();
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                (_) => router.push<void>(
                                                  AppRoutes.journey(start.id),
                                                ),
                                              );
                                        },
                                        child: Text(
                                          l10n.welcomeStartHereTour,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
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
                ),
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
    final styles = SuhbaTextStyles.of(context);
    final art = ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: LayoutBuilder(
        builder: (context, box) => box.maxHeight <= 0
            ? const SizedBox.shrink()
            : Stack(
                fit: StackFit.expand,
                children: [
                  SceneBackdrop(kind: scene),
                  if (showMark)
                    Align(
                      alignment: const Alignment(0, -0.35),
                      child: ExcludeSemantics(
                        // The mark keeps its proportion to the scene as
                        // the scene shrinks on a short screen.
                        child: BrandMark(
                          size: box.maxHeight * 260 / _ArtAboveText.maxArt,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
    final text = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(kicker, style: styles.kicker.copyWith(color: Palette.goldOnInk)),
        const SizedBox(height: AppSpacing.xs),
        Semantics(
          header: true,
          child: Text(
            title,
            style: textTheme.displaySmall?.copyWith(color: Palette.paper),
            textScaler: AppTypography.displayScaler(context),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(body, style: styles.reading.copyWith(color: Palette.paper)),
      ],
    );
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        child: _ArtAboveText(
          viewportHeight: constraints.maxHeight,
          art: art,
          text: text,
        ),
      ),
    );
  }
}

/// The scene above the words, sized from the room the words leave: up to
/// [maxArt] tall, and left out when less than [minArt] is free, so on a
/// short screen or at a large text size the words come first and are
/// seen without scrolling. When everything fits, the two are centred in
/// [viewportHeight]; when the words alone do not, they start at the top
/// and the page scrolls.
class _ArtAboveText extends MultiChildRenderObjectWidget {
  _ArtAboveText({
    required this.viewportHeight,
    required Widget art,
    required Widget text,
  }) : super(children: [art, text]);

  final double viewportHeight;

  static const maxArt = 240.0;
  static const minArt = 120.0;
  static const gap = AppSpacing.xl;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderArtAboveText(viewportHeight);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderArtAboveText renderObject,
  ) => renderObject.viewportHeight = viewportHeight;
}

class _ArtParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderArtAboveText extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ArtParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ArtParentData> {
  _RenderArtAboveText(this._viewportHeight);

  double _viewportHeight;
  set viewportHeight(double value) {
    if (value == _viewportHeight) return;
    _viewportHeight = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ArtParentData) {
      child.parentData = _ArtParentData();
    }
  }

  @override
  void performLayout() {
    final art = firstChild!;
    final text = childAfter(art)!;
    final width = constraints.maxWidth;
    text.layout(BoxConstraints.tightFor(width: width), parentUsesSize: true);
    final textHeight = text.size.height;
    final room = _viewportHeight - textHeight - _ArtAboveText.gap;
    final artHeight = room >= _ArtAboveText.minArt
        ? math.min(room, _ArtAboveText.maxArt)
        : 0.0;
    art.layout(BoxConstraints.tightFor(width: width, height: artHeight));
    final above = artHeight > 0 ? artHeight + _ArtAboveText.gap : 0.0;
    final content = above + textHeight;
    size = constraints.constrain(
      Size(width, math.max(content, _viewportHeight)),
    );
    final top = math.max(0.0, (size.height - content) / 2);
    (art.parentData! as _ArtParentData).offset = Offset(0, top);
    (text.parentData! as _ArtParentData).offset = Offset(0, top + above);
  }

  @override
  void paint(PaintingContext context, Offset offset) =>
      defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}
