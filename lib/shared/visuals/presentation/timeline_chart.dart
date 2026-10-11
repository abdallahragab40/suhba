import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/domain/historical_date.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/visuals/presentation/resolved_visual.dart';

/// Where [date] ends on the Hijri time line (see `HistoricalDate.sortKey`):
/// the end of a range, otherwise the date itself.
double? endKey(HistoricalDate date) {
  final end = date.hijriYearEnd;
  if (date.precision == DatePrecision.range && end != null) {
    final era = date.endEra ?? date.era;
    return era == HijriEra.beforeHijra ? -end.toDouble() : end - 1.0;
  }
  final gEnd = date.gregorianYearEnd;
  if (date.precision == DatePrecision.range && gEnd != null) {
    return (gEnd - 622) / 0.970224;
  }
  return date.sortKey;
}

/// A vertical time line on which distance is time: marks sit at their
/// dates, not at equal steps, so crowded and empty years look as they
/// were. Labels that would overlap are pushed down and joined to their
/// true place on the axis by a leader line. Ranges are drawn as spans,
/// approximate dates as hollow markers, and undated records are listed
/// after the axis rather than placed anywhere on it.
class TimelineChart extends StatelessWidget {
  const TimelineChart({required this.marks, required this.onOpen, super.key});

  final List<TimelineMark> marks;
  final ValueChanged<TimelineMark> onOpen;

  static const _axisInset = 44.0;
  static const _labelGap = 6.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final kicker = SuhbaTextStyles.of(context).kicker;
    final scaler = MediaQuery.textScalerOf(context);
    final rtl = Directionality.of(context) == TextDirection.rtl;

    final dated = [
      for (final m in marks)
        if (m.date.sortKey != null && !m.date.isUnknown) m,
    ];
    final undated = [
      for (final m in marks)
        if (m.date.sortKey == null || m.date.isUnknown) m,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final labelWidth = width - _axisInset - AppSpacing.md;

        // Measure every label, so positions can avoid overlaps.
        double heightOf(TimelineMark m) {
          double measure(String text, TextStyle? style) {
            final painter = TextPainter(
              text: TextSpan(text: text, style: style),
              textDirection: Directionality.of(context),
              textScaler: scaler,
            )..layout(maxWidth: labelWidth);
            return painter.height;
          }

          final h =
              measure(format.historicalDate(m.date), kicker) +
              measure(m.title.of(context), textTheme.titleSmall) +
              AppSpacing.xs;
          return math.max(h, kMinInteractiveDimension);
        }

        final heights = [for (final m in dated) heightOf(m)];
        if (dated.isEmpty) {
          return _Undated(marks: undated, onOpen: onOpen);
        }
        final keys = [for (final m in dated) m.date.sortKey!];
        final ends = [for (final m in dated) endKey(m.date) ?? m.date.sortKey!];
        final minKey = keys.reduce(math.min);
        final maxKey = [...keys, ...ends].reduce(math.max);
        final span = math.max(1.0, maxKey - minKey);
        final axisLength = math.max(
          360.0,
          heights.fold<double>(0, (a, h) => a + h + _labelGap) * 0.9,
        );
        const top = AppSpacing.md;
        double yOf(double key) => top + (key - minKey) / span * axisLength;

        final labelTops = <double>[];
        var next = 0.0;
        for (var i = 0; i < dated.length; i++) {
          final want = yOf(keys[i]) - heights[i] / 2;
          final y = math.max(want, next);
          labelTops.add(y);
          next = y + heights[i] + _labelGap;
        }
        final chartHeight = math.max(top + axisLength + AppSpacing.md, next);

        // Every tenth Hijri year on either side of the Hijrah, and the
        // Hijrah itself (key 0 is the year 1 AH).
        final ticks = <(double, String)>[
          for (var bh = 10; -bh >= minKey; bh += 10)
            if (-bh <= maxKey)
              (
                yOf(-bh.toDouble()),
                l10n.dateBeforeHijraYear(format.integer(bh)),
              ),
          for (var ah = 10; ah - 1 <= maxKey; ah += 10)
            if (ah - 1 >= minKey)
              (yOf(ah - 1.0), l10n.dateHijriYear(format.integer(ah))),
        ];
        final hijrah = minKey <= 0 && maxKey >= 0 ? yOf(0) : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: chartHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ExcludeSemantics(
                      child: CustomPaint(
                        painter: _AxisPainter(
                          rtl: rtl,
                          axisInset: _axisInset,
                          axisTop: top,
                          axisLength: axisLength,
                          points: [
                            for (var i = 0; i < dated.length; i++)
                              (
                                yOf(keys[i]),
                                yOf(ends[i]),
                                labelTops[i] + heights[i] / 2,
                                dated[i].date.precision ==
                                        DatePrecision.approx ||
                                    dated[i].date.precision ==
                                        DatePrecision.range,
                              ),
                          ],
                          ticks: ticks,
                          hijrah: hijrah,
                          hijrahLabel: l10n.timelineHijrahMark,
                          axisColor: colors.line,
                          markColor: colors.accent,
                          textStyle: kicker,
                          textScaler: scaler,
                        ),
                      ),
                    ),
                  ),
                  for (var i = 0; i < dated.length; i++)
                    PositionedDirectional(
                      top: labelTops[i],
                      start: _axisInset + AppSpacing.md,
                      end: 0,
                      height: heights[i],
                      child: _MarkLabel(
                        mark: dated[i],
                        onTap: () => onOpen(dated[i]),
                      ),
                    ),
                ],
              ),
            ),
            if (undated.isNotEmpty) _Undated(marks: undated, onOpen: onOpen),
          ],
        );
      },
    );
  }
}

class _MarkLabel extends StatelessWidget {
  const _MarkLabel({required this.mark, required this.onTap});

  final TimelineMark mark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final format = DisplayFormatter.of(context);
    final date = format.historicalDate(mark.date);
    final title = mark.title.of(context);
    return Semantics(
      button: true,
      label: '$date، $title',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: SuhbaTextStyles.of(context).kicker),
              Text(title, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _Undated extends StatelessWidget {
  const _Undated({required this.marks, required this.onOpen});

  final List<TimelineMark> marks;
  final ValueChanged<TimelineMark> onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.timelineUndated, style: SuhbaTextStyles.of(context).kicker),
          for (final m in marks)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.help_outline),
              title: Text(m.title.of(context)),
              subtitle: Text(l10n.dateUnknown),
              onTap: () => onOpen(m),
            ),
        ],
      ),
    );
  }
}

class _AxisPainter extends CustomPainter {
  _AxisPainter({
    required this.rtl,
    required this.axisInset,
    required this.axisTop,
    required this.axisLength,
    required this.points,
    required this.ticks,
    required this.hijrah,
    required this.hijrahLabel,
    required this.axisColor,
    required this.markColor,
    required this.textStyle,
    required this.textScaler,
  });

  final bool rtl;
  final double axisInset;
  final double axisTop;
  final double axisLength;

  /// Per mark: axis y, axis y of its end (ranges), label centre y, and
  /// whether its date is approximate or a span.
  final List<(double, double, double, bool)> points;
  final List<(double, String)> ticks;
  final double? hijrah;
  final String hijrahLabel;
  final Color axisColor;
  final Color markColor;
  final TextStyle textStyle;
  final TextScaler textScaler;

  @override
  void paint(Canvas canvas, Size size) {
    // The axis sits on the reading-start side (right in Arabic).
    final x = rtl ? size.width - axisInset : axisInset;
    final labelEdge = rtl ? x - AppSpacing.md + 2 : x + AppSpacing.md - 2;
    final axis = Paint()
      ..color = axisColor
      ..strokeWidth = 2;
    canvas.drawLine(Offset(x, axisTop), Offset(x, axisTop + axisLength), axis);

    void label(String text, double y, {bool strong = false}) {
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: textStyle.copyWith(
            fontSize: 10,
            color: strong ? markColor : textStyle.color,
            fontWeight: strong ? FontWeight.w800 : null,
          ),
        ),
        textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
        textScaler: textScaler.clamp(maxScaleFactor: 1.3),
      )..layout(maxWidth: axisInset - 6);
      final dx = rtl ? x + 6 : x - 6 - painter.width;
      painter.paint(canvas, Offset(dx, y - painter.height / 2));
    }

    for (final (y, text) in ticks) {
      canvas.drawLine(Offset(x - 4, y), Offset(x + 4, y), axis);
      label(text, y);
    }
    if (hijrah case final y?) {
      canvas.drawLine(
        Offset(x - 8, y),
        Offset(x + 8, y),
        Paint()
          ..color = markColor
          ..strokeWidth = 2,
      );
      label(hijrahLabel, y, strong: true);
    }

    final leader = Paint()
      ..color = axisColor
      ..strokeWidth = 1;
    final fill = Paint()..color = markColor;
    final hollow = Paint()
      ..color = markColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (final (y, endY, labelY, approximate) in points) {
      if (endY > y + 1) {
        canvas.drawLine(
          Offset(x, y),
          Offset(x, endY),
          Paint()
            ..color = markColor.withValues(alpha: 0.55)
            ..strokeWidth = 6
            ..strokeCap = StrokeCap.round,
        );
      }
      canvas.drawLine(Offset(x, y), Offset(labelEdge, labelY), leader);
      canvas.drawCircle(Offset(x, y), 5, approximate ? hollow : fill);
    }
  }

  @override
  bool shouldRepaint(_AxisPainter old) =>
      old.points != points ||
      old.rtl != rtl ||
      old.axisColor != axisColor ||
      old.markColor != markColor;
}
