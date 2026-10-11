import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/design_system/tokens/motion.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';
import 'package:suhba/core/design_system/widgets/citation_marker.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/design_system/widgets/reliability_badge.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/format/display_formatter.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/core/result/failure.dart';
import 'package:suhba/features/sources/presentation/citation_sheet.dart';
import 'package:suhba/features/timeline/domain/timeline_grouping.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';
import 'package:suhba/shared/content/providers.dart';

/// A companion's full timeline (S06): an era strip to jump through the
/// years, then the entries grouped by era, each linked to its biography
/// section and historical event.
class TimelinePage extends ConsumerWidget {
  const TimelinePage({required this.companionId, super.key});

  final String companionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final companion = ref.watch(companionProvider(companionId));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          companion.value == null
              ? l10n.timelineTitle
              : '${l10n.timelineTitle} — ${companion.value!.name.of(context)}',
        ),
      ),
      body: switch (companion) {
        AsyncData(:final value) when value.timeline.isEmpty => EmptyState(
          icon: Icons.timeline,
          title: l10n.timelineTitle,
        ),
        AsyncData(:final value) => _Timeline(companion: value),
        AsyncError(error: NotFoundFailure()) => EmptyState(
          icon: Icons.person_search_outlined,
          title: l10n.companionNotFound,
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(companionProvider(companionId)),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 8),
        ),
      },
    );
  }
}

class _Timeline extends StatefulWidget {
  const _Timeline({required this.companion});

  final Companion companion;

  @override
  State<_Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<_Timeline> {
  final _keys = <String, GlobalKey>{};

  GlobalKey _keyFor(String id) => _keys.putIfAbsent(id, GlobalKey.new);

  void _jumpTo(String id) {
    final target = _keys[id]?.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: AppMotion.resolve(context, AppMotion.long),
      curve: AppMotion.easeStandard,
      alignment: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = widget.companion;
    final provisional = !c.review.isApproved;
    final groups = groupTimeline(c.timeline);
    final ordered = [for (final (_, entries) in groups) ...entries];

    String eraName(TimelineEra era) => switch (era) {
      TimelineEra.preIslam => l10n.eraPreIslam,
      TimelineEra.makkan => l10n.eraMakkan,
      TimelineEra.madinan => l10n.eraMadinan,
      TimelineEra.afterProphet => l10n.eraAfterProphet,
    };

    // Lazy-free: the list is short, and every entry needs a live key for the
    // era strip to scroll to it.
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EraStrip(entries: ordered, onSelected: (e) => _jumpTo(e.id)),
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.readingMaxWidth,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.gutter,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (provisional) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: DraftBadge(preliminary: c.review.isPreliminary),
                      ),
                    ],
                    for (var g = 0; g < groups.length; g++) ...[
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: AppSpacing.lg,
                          bottom: AppSpacing.sm,
                        ),
                        child: SectionHeader(
                          index: g + 1,
                          kicker: l10n.eraKicker,
                          title: eraName(groups[g].$1),
                        ),
                      ),
                      for (final entry in groups[g].$2)
                        TimelineEntryTile(
                          key: _keyFor(entry.id),
                          entry: entry,
                          companionId: c.id,
                          provisional: provisional,
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// One entry: the date large on the start side, then the title, summary,
/// reliability, sources and links to the section and the event.
class TimelineEntryTile extends ConsumerWidget {
  const TimelineEntryTile({
    required this.entry,
    required this.companionId,
    required this.provisional,
    super.key,
  });

  final TimelineEvent entry;
  final String companionId;
  final bool provisional;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final t = entry;
    final event = t.eventId == null
        ? null
        : ref.watch(eventsProvider).value?[t.eventId];
    final greg = t.date.gregorianYear;

    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        bottom: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(
            color: t.eventId != null ? colors.accent : colors.line,
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            format.historicalDate(t.date, withGregorian: false),
            style: textTheme.headlineSmall?.copyWith(
              color: t.eventId != null ? colors.accentText : null,
            ),
          ),
          if (greg != null && t.date.hijriYear != null)
            Text(
              l10n.dateGregorianYear(format.integer(greg)),
              style: SuhbaTextStyles.of(context).kicker,
            ),
          const SizedBox(height: AppSpacing.xxs),
          Text(t.title.of(context), style: textTheme.titleMedium),
          if (t.summary case final s?)
            Text(
              s.of(context),
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceDim),
            ),
          if (event != null)
            Text(
              l10n.timelineEvent(event.name.of(context)),
              style: SuhbaTextStyles.of(context).kicker,
            ),
          Row(
            children: [
              Flexible(
                child: ReliabilityBadge(
                  t.reliability,
                  provisional: provisional,
                ),
              ),
              if (t.citations.isNotEmpty)
                CitationMarker(
                  count: t.citations.length,
                  onPressed: () => showCitationSheet(
                    context,
                    citations: t.citations,
                    reliability: t.reliability,
                    provisional: provisional,
                  ),
                ),
            ],
          ),
          if (t.sectionId case final sectionId?)
            TextButton.icon(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              icon: const Icon(Icons.menu_book_outlined, size: 18),
              label: Text(l10n.timelineOpenSection),
              onPressed: () =>
                  context.push(AppRoutes.section(companionId, sectionId)),
            ),
        ],
      ),
    );
  }
}

/// A sideways strip with one marker per entry, in date order: filled gold
/// for entries tied to a historical event, dashed for approximate dates.
/// Tapping a marker scrolls to its entry.
class EraStrip extends StatelessWidget {
  const EraStrip({required this.entries, required this.onSelected, super.key});

  final List<TimelineEvent> entries;
  final ValueChanged<TimelineEvent> onSelected;

  @override
  Widget build(BuildContext context) {
    final format = DisplayFormatter.of(context);
    final colors = SuhbaColors.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final e in entries)
            Semantics(
              button: true,
              label:
                  '${format.historicalDate(e.date, withGregorian: false)}، '
                  '${e.title.of(context)}',
              excludeSemantics: true,
              child: InkWell(
                onTap: () => onSelected(e),
                borderRadius: BorderRadius.circular(8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 64,
                    minHeight: 48,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xxs),
                    child: Column(
                      children: [
                        CustomPaint(
                          size: const Size.square(20),
                          painter: _MarkerPainter(
                            color: e.eventId != null
                                ? colors.accent
                                : colors.onSurfaceDim,
                            filled: e.eventId != null,
                            dashed: isImpreciseDate(e.date),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          format.historicalDate(e.date, withGregorian: false),
                          style: SuhbaTextStyles.of(context).kicker,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MarkerPainter extends CustomPainter {
  _MarkerPainter({
    required this.color,
    required this.filled,
    required this.dashed,
  });

  final Color color;
  final bool filled;
  final bool dashed;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 1;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke;
    if (!dashed || filled) {
      canvas.drawCircle(center, radius, paint);
      return;
    }
    const dashes = 10;
    const sweep = math.pi / dashes;
    final rect = Rect.fromCircle(center: center, radius: radius);
    for (var i = 0; i < dashes; i++) {
      canvas.drawArc(rect, i * 2 * sweep, sweep, false, paint);
    }
  }

  @override
  bool shouldRepaint(_MarkerPainter old) =>
      old.color != color || old.filled != filled || old.dashed != dashed;
}
