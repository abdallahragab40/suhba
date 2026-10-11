import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/design_system/widgets/reliability_badge.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

/// Context → sequence → outcome, as numbered steps joined by a line. Each
/// step expands to its detail and sources; a step whose place in the order
/// is not settled says so in words and with a dashed connector.
class SequenceExplainer extends StatelessWidget {
  const SequenceExplainer({
    required this.steps,
    required this.places,
    required this.provisional,
    required this.onCitations,
    this.onOpenPlace,
    super.key,
  });

  final List<SequenceStep> steps;
  final Map<String, HistoricalPlace> places;
  final bool provisional;
  final void Function(List<Citation>, Reliability) onCitations;
  final ValueChanged<HistoricalPlace>? onOpenPlace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, step) in steps.indexed)
          _Step(
            number: i + 1,
            step: step,
            place: step.placeId == null ? null : places[step.placeId],
            last: i == steps.length - 1,
            provisional: provisional,
            onCitations: onCitations,
            onOpenPlace: onOpenPlace,
          ),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.number,
    required this.step,
    required this.place,
    required this.last,
    required this.provisional,
    required this.onCitations,
    required this.onOpenPlace,
  });

  final int number;
  final SequenceStep step;
  final HistoricalPlace? place;
  final bool last;
  final bool provisional;
  final void Function(List<Citation>, Reliability) onCitations;
  final ValueChanged<HistoricalPlace>? onOpenPlace;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final place = this.place;
    final date = step.date;

    // The connector is drawn behind the row, so the row can size to its
    // content (an expansion tile has no reliable intrinsic height).
    return Stack(
      children: [
        if (!last)
          PositionedDirectional(
            start: 19,
            top: 32,
            bottom: 0,
            width: 2,
            child: CustomPaint(
              painter: _Connector(
                color: colors.line,
                dashed: step.orderUncertain,
              ),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  ExcludeSemantics(
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: step.orderUncertain ? null : colors.accent,
                        border: Border.all(color: colors.accent, width: 2),
                      ),
                      child: Text(
                        format.integer(number),
                        style: textTheme.labelLarge?.copyWith(
                          color: step.orderUncertain
                              ? colors.accentText
                              : Theme.of(context).colorScheme.surface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.md,
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text(
                      step.title.of(context),
                      style: textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      [
                        l10n.sequenceStep(format.integer(number)),
                        if (date != null) format.historicalDate(date),
                        ?place?.name.of(context),
                        if (step.orderUncertain) l10n.sequenceOrderUncertain,
                      ].join(' · '),
                      style: SuhbaTextStyles.of(context).kicker,
                    ),
                    children: [
                      Text(
                        step.text.of(context),
                        style: SuhbaTextStyles.of(context).reading,
                      ),
                      Row(
                        children: [
                          if (step.reliability != Reliability.established)
                            Flexible(
                              child: ReliabilityBadge(
                                step.reliability,
                                provisional: provisional,
                              ),
                            ),
                          if (step.citations.isNotEmpty)
                            CitationMarker(
                              count: step.citations.length,
                              onPressed: () =>
                                  onCitations(step.citations, step.reliability),
                            ),
                          const Spacer(),
                          if (place != null && onOpenPlace != null)
                            TextButton.icon(
                              onPressed: () => onOpenPlace!(place),
                              icon: const Icon(Icons.place_outlined),
                              label: Text(place.name.of(context)),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Connector extends CustomPainter {
  _Connector({required this.color, required this.dashed});

  final Color color;
  final bool dashed;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    final x = size.width / 2;
    if (!dashed) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      return;
    }
    for (var y = 0.0; y < size.height; y += 9) {
      canvas.drawLine(Offset(x, y), Offset(x, y + 5), paint);
    }
  }

  @override
  bool shouldRepaint(_Connector old) =>
      old.color != color || old.dashed != dashed;
}
