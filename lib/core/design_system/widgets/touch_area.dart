import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A small control whose touch and screen-reader area is at least
/// [minSize] square, centred on it, without taking that space in layout.
///
/// For marks set inside a line of text (a [WidgetSpan]): the glyph stays
/// the size of a letter, so the line keeps its height, while the target
/// still meets the 48 × 48 guideline. Taps inside the larger area go to
/// [child] as if they landed on it.
///
/// The semantics node (a button with [label] and [onTap]) is this widget's
/// own, so its rectangle is the larger area; [child]'s semantics are
/// excluded.
class TouchArea extends SingleChildRenderObjectWidget {
  const TouchArea({
    required this.label,
    required this.onTap,
    required super.child,
    this.minSize = 48,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final double minSize;

  @override
  RenderTouchArea createRenderObject(BuildContext context) =>
      RenderTouchArea(label, onTap, minSize, Directionality.of(context));

  @override
  void updateRenderObject(BuildContext context, RenderTouchArea renderObject) {
    renderObject
      ..label = label
      ..onTap = onTap
      ..minSize = minSize
      ..textDirection = Directionality.of(context);
  }
}

class RenderTouchArea extends RenderProxyBox {
  RenderTouchArea(this._label, this._onTap, this._minSize, this._textDirection);

  String _label;
  set label(String value) {
    if (value == _label) return;
    _label = value;
    markNeedsSemanticsUpdate();
  }

  VoidCallback _onTap;
  set onTap(VoidCallback value) {
    _onTap = value;
    markNeedsSemanticsUpdate();
  }

  double _minSize;
  set minSize(double value) {
    if (value == _minSize) return;
    _minSize = value;
    markNeedsSemanticsUpdate();
  }

  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (value == _textDirection) return;
    _textDirection = value;
    markNeedsSemanticsUpdate();
  }

  /// Keeps a clamped point strictly inside the child (`Size.contains`
  /// excludes the far edges).
  static const _edge = 0.001;

  /// The touch area in local coordinates: at least [_minSize] square,
  /// centred on the child.
  Rect get touchRect {
    final dx = math.max(0, (_minSize - size.width) / 2).toDouble();
    final dy = math.max(0, (_minSize - size.height) / 2).toDouble();
    return Rect.fromLTRB(-dx, -dy, size.width + dx, size.height + dy);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (!touchRect.contains(position)) return false;
    // Hand the child a point inside it, so its own gesture handling fires.
    final inside = Offset(
      position.dx.clamp(0.0, size.width - _edge),
      position.dy.clamp(0.0, size.height - _edge),
    );
    hitTestChildren(result, position: inside);
    result.add(BoxHitTestEntry(this, position));
    return true;
  }

  @override
  Rect get semanticBounds => touchRect;

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..isButton = true
      ..label = _label
      ..textDirection = _textDirection
      ..onTap = _onTap;
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    // The child is drawn, not described: this node speaks for it.
  }
}
