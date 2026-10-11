import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/palette.dart';
import 'package:siyar_sahaba/core/design_system/tokens/radii.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';
import 'package:siyar_sahaba/core/format/display_formatter.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/shared/content/domain/atlas.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';

/// A schematic map of [places], with an optional journey ([route]).
///
/// Geography is never mirrored: north is up and east is right whatever the
/// text direction, while labels stay Arabic. Positions come from each
/// place's recorded point; approximate and uncertain sites are drawn
/// differently from identified ones, and route legs whose path is not
/// known are dashed. It can be zoomed; the place list that accompanies it
/// is the accessible equivalent.
class SchematicMap extends StatefulWidget {
  const SchematicMap({
    required this.places,
    required this.onOpenPlace,
    this.route = const [],
    this.height = 360,
    this.interactive = true,
    super.key,
  });

  final List<HistoricalPlace> places;
  final List<RouteLeg> route;
  final ValueChanged<HistoricalPlace> onOpenPlace;
  final double height;

  /// Whether it can be zoomed and panned. Off inside a scrolling passage,
  /// where panning would fight the page's scrolling.
  final bool interactive;

  @override
  State<SchematicMap> createState() => _SchematicMapState();
}

class _SchematicMapState extends State<SchematicMap> {
  final _transform = TransformationController();

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  void _zoom(double factor) {
    final current = _transform.value.getMaxScaleOnAxis();
    final next = (current * factor).clamp(1.0, 4.0);
    final size = context.size;
    if (size == null) return;
    final centre = Offset(size.width / 2, widget.height / 2);
    // Scale about the centre of the view.
    final focal = _transform.toScene(centre);
    _transform.value = Matrix4.identity()
      ..translateByDouble(centre.dx, centre.dy, 0, 1)
      ..scaleByDouble(next, next, 1, 1)
      ..translateByDouble(-focal.dx, -focal.dy, 0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SahabaColors.of(context);
    final byId = {for (final p in widget.places) p.id: p};
    final route = [
      for (final leg in widget.route)
        if (byId[leg.fromPlaceId] case final from?)
          if (byId[leg.toPlaceId] case final to?) (from, to, leg),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(AppRadii.md),
          child: SizedBox(
            height: widget.height,
            child: Stack(
              children: [
                Semantics(
                  label: l10n.mapSemantics(
                    format.integer(widget.places.length),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final size = Size(constraints.maxWidth, widget.height);
                      final projection = _Projection.fit(widget.places, size);
                      // Geography is not mirrored in RTL.
                      final map = Directionality(
                        textDirection: TextDirection.ltr,
                        child: SizedBox.fromSize(
                          size: size,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: _MapPainter(
                                    places: widget.places,
                                    route: route,
                                    projection: projection,
                                    textStyle: SahabaTextStyles.of(
                                      context,
                                    ).kicker.copyWith(color: Palette.paper),
                                    textScaler: MediaQuery.textScalerOf(
                                      context,
                                    ).clamp(maxScaleFactor: 1.4),
                                  ),
                                ),
                              ),
                              for (final p in widget.places)
                                Positioned.fromRect(
                                  rect: Rect.fromCircle(
                                    center: projection.offsetOf(p.location),
                                    radius: kMinInteractiveDimension / 2,
                                  ),
                                  child: ExcludeSemantics(
                                    child: Tooltip(
                                      message: p.name.of(context),
                                      child: InkResponse(
                                        radius: kMinInteractiveDimension / 2,
                                        onTap: () => widget.onOpenPlace(p),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                      return widget.interactive
                          ? InteractiveViewer(
                              transformationController: _transform,
                              maxScale: 4,
                              child: map,
                            )
                          : map;
                    },
                  ),
                ),
                if (widget.interactive)
                  PositionedDirectional(
                    end: AppSpacing.xs,
                    bottom: AppSpacing.xs,
                    child: Column(
                      children: [
                        _ZoomButton(
                          icon: Icons.add,
                          tooltip: l10n.mapZoomIn,
                          onPressed: () => _zoom(1.5),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        _ZoomButton(
                          icon: Icons.remove,
                          tooltip: l10n.mapZoomOut,
                          onPressed: () => _zoom(1 / 1.5),
                        ),
                      ],
                    ),
                  ),
                PositionedDirectional(
                  start: AppSpacing.xs,
                  top: AppSpacing.xs,
                  child: ExcludeSemantics(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.green.withValues(alpha: 0.7),
                        borderRadius: const BorderRadius.all(AppRadii.sm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.north,
                            size: 14,
                            color: Palette.goldOnInk,
                          ),
                          Text(
                            l10n.mapNorth,
                            style: SahabaTextStyles.of(
                              context,
                            ).kicker.copyWith(color: Palette.goldOnInk),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.xxs,
          children: [
            _Legend(
              symbol: _LegendSymbol.identified,
              label: l10n.mapLegendIdentified,
            ),
            _Legend(
              symbol: _LegendSymbol.approximate,
              label: l10n.mapLegendApproximate,
            ),
            _Legend(
              symbol: _LegendSymbol.uncertain,
              label: l10n.mapLegendUncertain,
            ),
            if (route.isNotEmpty)
              _Legend(
                symbol: _LegendSymbol.dashed,
                label: l10n.mapApproximatePath,
              ),
          ],
        ),
        Text(
          l10n.mapSchematicNote,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
        ),
      ],
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      tooltip: tooltip,
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}

enum _LegendSymbol { identified, approximate, uncertain, dashed }

class _Legend extends StatelessWidget {
  const _Legend({required this.symbol, required this.label});

  final _LegendSymbol symbol;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = SahabaColors.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(
          child: CustomPaint(
            size: const Size(22, 14),
            painter: _LegendPainter(symbol, colors.accentText),
          ),
        ),
        const SizedBox(width: AppSpacing.xxs),
        Flexible(
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}

class _LegendPainter extends CustomPainter {
  _LegendPainter(this.symbol, this.color);

  final _LegendSymbol symbol;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    switch (symbol) {
      case _LegendSymbol.dashed:
        _dashed(
          canvas,
          Offset(0, c.dy),
          Offset(size.width, c.dy),
          Paint()
            ..color = color
            ..strokeWidth = 2,
        );
      case _:
        _marker(canvas, c, symbol.index, color, 5);
    }
  }

  @override
  bool shouldRepaint(_LegendPainter old) =>
      old.symbol != symbol || old.color != color;
}

/// Identified: filled dot. Approximate: hollow dot. Uncertain: hollow dot
/// in a dashed ring. Distinguished by shape, not colour alone.
void _marker(Canvas canvas, Offset c, int kind, Color color, double r) {
  final stroke = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  switch (kind) {
    case 0:
      canvas.drawCircle(c, r, Paint()..color = color);
    case 1:
      canvas.drawCircle(c, r, stroke);
    default:
      canvas.drawCircle(c, r - 1, stroke);
      const dashes = 10;
      for (var i = 0; i < dashes; i += 2) {
        final a = i * 2 * math.pi / dashes;
        canvas.drawArc(
          Rect.fromCircle(center: c, radius: r + 4),
          a,
          math.pi / dashes,
          false,
          stroke..strokeWidth = 1.5,
        );
      }
  }
}

void _dashed(Canvas canvas, Offset a, Offset b, Paint paint) {
  const dash = 6.0;
  const gap = 5.0;
  final total = (b - a).distance;
  if (total == 0) return;
  final dir = (b - a) / total;
  for (var d = 0.0; d < total; d += dash + gap) {
    canvas.drawLine(a + dir * d, a + dir * math.min(d + dash, total), paint);
  }
}

/// Equirectangular projection fitted to the places, with the longitude
/// scaled by the cosine of the mean latitude so shapes stay true.
class _Projection {
  _Projection(this._origin, this._scale, this._offset, this._cos);

  factory _Projection.fit(List<HistoricalPlace> places, Size size) {
    if (places.isEmpty) return _Projection(Offset.zero, 1, Offset.zero, 1);
    final lats = [for (final p in places) p.location.lat];
    final lons = [for (final p in places) p.location.lon];
    final meanLat = lats.reduce((a, b) => a + b) / lats.length;
    final cos = math.cos(meanLat * math.pi / 180);
    final minX = lons.reduce(math.min) * cos;
    final maxX = lons.reduce(math.max) * cos;
    final minLat = lats.reduce(math.min);
    final maxLat = lats.reduce(math.max);
    // Room for labels around the edges.
    const pad = 56.0;
    final spanX = math.max(maxX - minX, 0.05);
    final spanY = math.max(maxLat - minLat, 0.05);
    final scale = math.min(
      (size.width - 2 * pad) / spanX,
      (size.height - 2 * pad) / spanY,
    );
    final used = Size(spanX * scale, spanY * scale);
    final offset = Offset(
      (size.width - used.width) / 2,
      (size.height - used.height) / 2,
    );
    return _Projection(Offset(minX, maxLat), scale, offset, cos);
  }

  final Offset _origin;
  final double _scale;
  final Offset _offset;
  final double _cos;

  Offset offsetOf(GeoPoint p) =>
      _offset +
      Offset(
        (p.lon * _cos - _origin.dx) * _scale,
        (_origin.dy - p.lat) * _scale,
      );
}

class _MapPainter extends CustomPainter {
  _MapPainter({
    required this.places,
    required this.route,
    required this.projection,
    required this.textStyle,
    required this.textScaler,
  });

  final List<HistoricalPlace> places;
  final List<(HistoricalPlace, HistoricalPlace, RouteLeg)> route;
  final _Projection projection;
  final TextStyle textStyle;
  final TextScaler textScaler;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..color = Palette.greenAlt);
    // A faint graticule, so the map reads as a map.
    final grid = Paint()
      ..color = Palette.lineOnGreen
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 48) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (var y = 0.0; y < size.height; y += 48) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final gold = Paint()
      ..color = Palette.goldOnInk
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    for (final (from, to, leg) in route) {
      final a = projection.offsetOf(from.location);
      final b = projection.offsetOf(to.location);
      if (leg.approximate) {
        _dashed(canvas, a, b, gold);
      } else {
        canvas.drawLine(a, b, gold);
      }
      _arrow(canvas, a, b, gold);
    }

    // Labels avoid every marker as well as each other.
    final placed = <Rect>[
      for (final p in places)
        Rect.fromCircle(center: projection.offsetOf(p.location), radius: 7),
    ];
    for (final p in places) {
      final c = projection.offsetOf(p.location);
      _marker(canvas, c, p.location.precision.index, Palette.goldOnInk, 6);
      final painter = TextPainter(
        text: TextSpan(text: p.name.ar, style: textStyle),
        textDirection: TextDirection.rtl,
        textScaler: textScaler,
      )..layout();
      // Try right of the marker, then left, above and below, so labels do
      // not overlap one another.
      final candidates = [
        Offset(c.dx + 10, c.dy - painter.height / 2),
        Offset(c.dx - 10 - painter.width, c.dy - painter.height / 2),
        Offset(c.dx - painter.width / 2, c.dy - 10 - painter.height),
        Offset(c.dx - painter.width / 2, c.dy + 10),
      ];
      Offset? at;
      for (final o in candidates) {
        final r = (o & painter.size).inflate(2);
        if (!placed.any(r.overlaps) &&
            rect.contains(r.topLeft) &&
            rect.contains(r.bottomRight)) {
          at = o;
          break;
        }
      }
      // No free spot: the marker stays unlabelled rather than covered;
      // its name is in the list and on its tooltip.
      if (at == null) continue;
      placed.add((at & painter.size).inflate(2));
      final bg = RRect.fromRectAndRadius(
        (at & painter.size).inflate(3),
        const Radius.circular(4),
      );
      canvas.drawRRect(
        bg,
        Paint()..color = Palette.green.withValues(alpha: 0.75),
      );
      painter.paint(canvas, at);
    }
  }

  void _arrow(Canvas canvas, Offset a, Offset b, Paint paint) {
    final mid = Offset.lerp(a, b, 0.55)!;
    final angle = (b - a).direction;
    const len = 8.0;
    final path = ui.Path()
      ..moveTo(mid.dx, mid.dy)
      ..lineTo(
        mid.dx - len * math.cos(angle - 0.5),
        mid.dy - len * math.sin(angle - 0.5),
      )
      ..moveTo(mid.dx, mid.dy)
      ..lineTo(
        mid.dx - len * math.cos(angle + 0.5),
        mid.dy - len * math.sin(angle + 0.5),
      );
    canvas.drawPath(
      path,
      Paint()
        ..color = paint.color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(_MapPainter old) =>
      old.places != places || old.route != route || old.textStyle != textStyle;
}
