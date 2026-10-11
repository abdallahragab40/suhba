import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/shared/content/domain/passage_position.dart';

/// The frame shared by the section and chapter readers: a quiet app bar
/// (with [actions], e.g. reading settings), a thin gold progress line that
/// follows the scroll, and a body capped at a comfortable reading width.
///
/// The whole passage is laid out at once (a passage is a few screens), so
/// the scroll extent, and therefore the reading fraction, is exact.
///
/// Blocks wrapped in a [ReaderAnchor] let the reader save and restore a
/// position as "block i, x% into it". That survives text-size and
/// orientation changes, which move every block: when the layout changes,
/// the block that was at the top of the screen stays there.
class ReaderScaffold extends StatefulWidget {
  const ReaderScaffold({
    required this.title,
    required this.children,
    this.actions = const [],
    this.initialPosition,
    this.onProgress,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final List<Widget> actions;

  /// Where to reopen the passage. Null while unknown; the reader is
  /// restored once, as soon as it is known, unless the user already
  /// scrolled.
  final PassagePosition? initialPosition;

  /// Called with the position as the user scrolls.
  final ValueChanged<PassagePosition>? onProgress;

  @override
  State<ReaderScaffold> createState() => ReaderScaffoldState();
}

class ReaderScaffoldState extends State<ReaderScaffold> {
  final _controller = ScrollController();
  final _anchors = _AnchorRegistry();
  bool _restored = false;
  bool _userScrolled = false;
  bool _dragging = false;

  /// The anchor at the top of the screen, kept across layout changes.
  PassagePosition? _current;
  double? _lastExtent;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_report);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Whether the whole passage fits on the screen (nothing to scroll).
  bool get fitsOnScreen =>
      _controller.hasClients &&
      _controller.position.hasContentDimensions &&
      _controller.position.maxScrollExtent <= 0;

  double? get _fraction {
    if (!_controller.hasClients) return null;
    final position = _controller.position;
    if (!position.hasContentDimensions) return null;
    final max = position.maxScrollExtent;
    return max <= 0 ? 1 : (position.pixels / max).clamp(0, 1);
  }

  /// The current position: the fraction, and the anchored block at the top
  /// of the screen with how far into it.
  PassagePosition? currentPosition() {
    final fraction = _fraction;
    if (fraction == null) return null;
    final top = _controller.position.pixels;
    for (final (index, box) in _anchors.boxes()) {
      final start = _scrollOffsetOf(box);
      if (start == null) continue;
      // Above the first block (the title area): no block to anchor to.
      if (start > top + 0.5) break;
      final height = box.size.height;
      if (start + height > top) {
        return PassagePosition(
          fraction: fraction,
          blockIndex: index,
          blockOffset: height <= 0
              ? 0
              : ((top - start) / height).clamp(0, 1).toDouble(),
        );
      }
    }
    return PassagePosition(fraction: fraction);
  }

  /// The scroll offset that puts [box]'s top at the top of the viewport.
  double? _scrollOffsetOf(RenderBox box) {
    if (!box.attached || !box.hasSize) return null;
    final viewport = RenderAbstractViewport.maybeOf(box);
    return viewport?.getOffsetToReveal(box, 0).offset;
  }

  /// The scroll offset for [position]: its anchor if that block is here,
  /// else its fraction.
  double? _offsetFor(PassagePosition position) {
    if (!_controller.hasClients) return null;
    final metrics = _controller.position;
    if (!metrics.hasContentDimensions) return null;
    final max = metrics.maxScrollExtent;
    if (position.hasAnchor) {
      final box = _anchors.boxFor(position.blockIndex!);
      final start = box == null ? null : _scrollOffsetOf(box);
      if (start != null) {
        return (start + position.blockOffset! * box!.size.height).clamp(0, max);
      }
    }
    return position.fraction.clamp(0, 1) * max;
  }

  /// Scrolls to [fraction] (0–1) of the passage.
  void jumpToFraction(double fraction) =>
      jumpToPosition(PassagePosition(fraction: fraction));

  /// Scrolls to [position], e.g. when the reader asks to return to an
  /// older position or to start again.
  void jumpToPosition(PassagePosition position) {
    final offset = _offsetFor(position);
    if (offset == null) return;
    _userScrolled = true;
    _controller.jumpTo(offset);
    _current = currentPosition();
  }

  void _report() {
    if (!_dragging && !_userScrolled) return;
    final position = currentPosition();
    if (position == null) return;
    _current = position;
    if (_userScrolled) widget.onProgress?.call(position);
  }

  void _restoreWhenReady() {
    final target = widget.initialPosition;
    if (_restored || target == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _restored || !_controller.hasClients) return;
      if (!_controller.position.hasContentDimensions) return;
      _restored = true;
      if (_userScrolled || (target.fraction <= 0 && !target.hasAnchor)) {
        return;
      }
      final offset = _offsetFor(target);
      if (offset != null) _controller.jumpTo(offset);
      _current = target;
    });
  }

  /// After a layout change (text size, rotation), bring the block that was
  /// at the top of the screen back there.
  bool _onMetrics(ScrollMetricsNotification n) {
    final extent = n.metrics.maxScrollExtent;
    final previous = _lastExtent;
    _lastExtent = extent;
    final keep = _current;
    if (previous == null || previous == extent || keep == null || _dragging) {
      return false;
    }
    if (!keep.hasAnchor) return false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _dragging) return;
      final offset = _offsetFor(keep);
      if (offset != null && (offset - _controller.offset).abs() > 1) {
        _controller.jumpTo(offset);
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _restoreWhenReady();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: widget.actions,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: ReadingProgressBar(controller: _controller),
        ),
      ),
      body: NotificationListener<ScrollMetricsNotification>(
        onNotification: _onMetrics,
        child: NotificationListener<ScrollNotification>(
          onNotification: (n) {
            if (n is ScrollStartNotification && n.dragDetails != null) {
              _dragging = true;
            } else if (n is ScrollEndNotification) {
              _dragging = false;
            } else if (n is UserScrollNotification &&
                n.direction != ScrollDirection.idle) {
              _userScrolled = true;
            }
            return false;
          },
          child: _AnchorScope(
            registry: _anchors,
            child: Scrollbar(
              controller: _controller,
              child: SingleChildScrollView(
                controller: _controller,
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.gutter,
                  AppSpacing.md,
                  AppSpacing.gutter,
                  AppSpacing.xxl,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: AppSpacing.readingMaxWidth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.children,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Marks block [index] of a passage so a [ReaderScaffold] can anchor
/// reading positions to it. Outside a reader it does nothing.
class ReaderAnchor extends StatefulWidget {
  const ReaderAnchor({required this.index, required this.child, super.key});

  final int index;
  final Widget child;

  @override
  State<ReaderAnchor> createState() => _ReaderAnchorState();
}

class _ReaderAnchorState extends State<ReaderAnchor> {
  _AnchorRegistry? _registry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final registry = context
        .dependOnInheritedWidgetOfExactType<_AnchorScope>()
        ?.registry;
    if (registry != _registry) {
      _registry?.remove(widget.index, this);
      _registry = registry?..add(widget.index, this);
    }
  }

  @override
  void didUpdateWidget(ReaderAnchor old) {
    super.didUpdateWidget(old);
    if (old.index != widget.index) {
      _registry
        ?..remove(old.index, this)
        ..add(widget.index, this);
    }
  }

  @override
  void dispose() {
    _registry?.remove(widget.index, this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _AnchorRegistry {
  final _byIndex = <int, State<ReaderAnchor>>{};

  void add(int index, State<ReaderAnchor> anchor) => _byIndex[index] = anchor;

  void remove(int index, State<ReaderAnchor> anchor) {
    if (_byIndex[index] == anchor) _byIndex.remove(index);
  }

  RenderBox? boxFor(int index) {
    final object = _byIndex[index]?.context.findRenderObject();
    return object is RenderBox ? object : null;
  }

  /// Laid-out anchors in block order.
  Iterable<(int, RenderBox)> boxes() sync* {
    for (final index in _byIndex.keys.toList()..sort()) {
      final box = boxFor(index);
      if (box != null) yield (index, box);
    }
  }
}

class _AnchorScope extends InheritedWidget {
  const _AnchorScope({required this.registry, required super.child});

  final _AnchorRegistry registry;

  @override
  bool updateShouldNotify(_AnchorScope old) => old.registry != registry;
}

/// How far through the text the reader is, as a 2 dp gold line.
class ReadingProgressBar extends StatelessWidget {
  const ReadingProgressBar({required this.controller, super.key});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final colors = SuhbaColors.of(context);
    return ExcludeSemantics(
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          var progress = 0.0;
          if (controller.hasClients &&
              controller.position.hasContentDimensions) {
            final max = controller.position.maxScrollExtent;
            progress = max <= 0 ? 1 : (controller.offset / max).clamp(0, 1);
          }
          return LinearProgressIndicator(
            value: progress,
            minHeight: 2,
            color: colors.accent,
            backgroundColor: colors.line,
          );
        },
      ),
    );
  }
}
