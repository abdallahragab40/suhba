import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/radii.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/l10n/generated/app_localizations.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/presentation/content_text.dart';

/// The label of a relation, read as "[to] is [label] of [from]".
String relationLabel(AppLocalizations l10n, RelationType type) =>
    switch (type) {
      RelationType.father => l10n.relationFather,
      RelationType.mother => l10n.relationMother,
      RelationType.child => l10n.relationChild,
      RelationType.spouse => l10n.relationSpouse,
      RelationType.sibling => l10n.relationSibling,
      RelationType.relative => l10n.relationRelative,
      RelationType.teacher => l10n.relationTeacher,
      RelationType.student => l10n.relationStudent,
      RelationType.brotherhood => l10n.relationBrotherhood,
      RelationType.companion => l10n.relationCompanion,
    };

/// A person's name as shown in visuals, with the honorific the catalog
/// gives them (ﷺ for the Prophet).
String personName(
  BuildContext context,
  PersonRef ref,
  Map<String, Person> people,
) {
  final name = ref.displayName.of(context);
  final person = ref.personId == null ? null : people[ref.personId];
  return person?.honorific == PersonHonorific.prophet ? '$name ﷺ' : name;
}

/// Named people joined by sourced relations. The most connected person is
/// in the centre and the others around them; each line is labelled with
/// its relation and has an arrow towards the person it describes. Nobody
/// is ranked by size or colour, and there are no portraits.
class RelationshipDiagram extends StatelessWidget {
  const RelationshipDiagram({
    required this.edges,
    required this.people,
    this.height = 340,
    super.key,
  });

  final List<RelationEdge> edges;
  final Map<String, Person> people;
  final double height;

  static String _key(PersonRef r) =>
      r.companionId != null ? 'c:${r.companionId}' : 'p:${r.personId}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SuhbaColors.of(context);
    final nodes = <String, PersonRef>{};
    final degree = <String, int>{};
    for (final e in edges) {
      for (final r in [e.from, e.to]) {
        nodes.putIfAbsent(_key(r), () => r);
        degree.update(_key(r), (n) => n + 1, ifAbsent: () => 1);
      }
    }
    final ordered = nodes.keys.toList()
      ..sort((a, b) => degree[b]!.compareTo(degree[a]!));

    return ExcludeSemantics(
      child: SizedBox(
        height: height,
        child: CustomPaint(
          painter: _DiagramPainter(
            hub: ordered.first,
            ring: ordered.skip(1).toList(),
            names: {
              for (final MapEntry(:key, :value) in nodes.entries)
                key: personName(context, value, people),
            },
            edges: [
              for (final e in edges)
                (_key(e.from), _key(e.to), relationLabel(l10n, e.type)),
            ],
            textStyle: Theme.of(context).textTheme.labelLarge!,
            edgeStyle: Theme.of(context).textTheme.labelSmall!,
            textScaler: MediaQuery.textScalerOf(
              context,
            ).clamp(maxScaleFactor: 1.3),
            line: colors.line,
            accent: colors.accent,
            node: colors.surfaceAlt,
            onNode: Theme.of(context).colorScheme.onSurface,
            surface: Theme.of(context).colorScheme.surface,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _DiagramPainter extends CustomPainter {
  _DiagramPainter({
    required this.hub,
    required this.ring,
    required this.names,
    required this.edges,
    required this.textStyle,
    required this.edgeStyle,
    required this.textScaler,
    required this.line,
    required this.accent,
    required this.node,
    required this.onNode,
    required this.surface,
  });

  final String hub;
  final List<String> ring;
  final Map<String, String> names;
  final List<(String, String, String)> edges;
  final TextStyle textStyle;
  final TextStyle edgeStyle;
  final TextScaler textScaler;
  final Color line;
  final Color accent;
  final Color node;
  final Color onNode;
  final Color surface;

  @override
  void paint(Canvas canvas, Size size) {
    final centre = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 44;
    final at = <String, Offset>{hub: centre};
    for (var i = 0; i < ring.length; i++) {
      // Start at the top and go round.
      final a = -math.pi / 2 + i * 2 * math.pi / math.max(ring.length, 1);
      at[ring[i]] = centre + Offset(math.cos(a), math.sin(a)) * radius;
    }

    TextPainter text(String s, TextStyle style, double maxWidth) => TextPainter(
      text: TextSpan(text: s, style: style),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      textScaler: textScaler,
      maxLines: 2,
    )..layout(maxWidth: maxWidth);

    final boxes = <String, Rect>{};
    for (final MapEntry(:key, :value) in at.entries) {
      final t = text(names[key]!, textStyle.copyWith(color: onNode), 112);
      boxes[key] = Rect.fromCenter(
        center: value,
        width: t.width + 20,
        height: t.height + 14,
      );
    }

    final stroke = Paint()
      ..color = line
      ..strokeWidth = 1.5;
    for (final (from, to, label) in edges) {
      final a = at[from]!;
      final b = at[to]!;
      canvas.drawLine(a, b, stroke);
      // The arrow points at the person the relation describes.
      final tip = _edgePoint(boxes[to]!, a, b);
      final dir = (b - a).direction;
      final arrow = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(
          tip.dx - 9 * math.cos(dir - 0.45),
          tip.dy - 9 * math.sin(dir - 0.45),
        )
        ..lineTo(
          tip.dx - 9 * math.cos(dir + 0.45),
          tip.dy - 9 * math.sin(dir + 0.45),
        )
        ..close();
      canvas.drawPath(arrow, Paint()..color = accent);
      final mid = Offset.lerp(a, b, 0.55)!;
      final t = text(label, edgeStyle.copyWith(color: onNode), 96);
      final r = Rect.fromCenter(
        center: mid,
        width: t.width + 10,
        height: t.height + 4,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(6)),
        Paint()..color = surface,
      );
      t.paint(canvas, r.topLeft + const Offset(5, 2));
    }

    for (final MapEntry(:key, value: box) in boxes.entries) {
      final rrect = RRect.fromRectAndRadius(box, AppRadii.sm);
      canvas.drawRRect(rrect, Paint()..color = node);
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = key == hub ? accent : line
          ..style = PaintingStyle.stroke
          ..strokeWidth = key == hub ? 2 : 1,
      );
      final t = text(names[key]!, textStyle.copyWith(color: onNode), 112);
      t.paint(canvas, box.center - Offset(t.width / 2, t.height / 2));
    }
  }

  /// Where the line from [a] to [b] meets [box] (around [b]).
  Offset _edgePoint(Rect box, Offset a, Offset b) {
    final d = b - a;
    if (d.distance == 0) return b;
    final tx = d.dx == 0 ? double.infinity : (box.width / 2) / d.dx.abs();
    final ty = d.dy == 0 ? double.infinity : (box.height / 2) / d.dy.abs();
    final t = math.min(tx, ty);
    return b - d * t;
  }

  @override
  bool shouldRepaint(_DiagramPainter old) =>
      old.edges != edges || old.names != names || old.line != line;
}
