import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';
import 'package:suhba/shared/visuals/presentation/schematic_map.dart';

/// D8 (review F21): on the Hijrah route, every station can be told apart
/// on first view, and the route still goes south before it goes north.
void main() {
  HistoricalPlace place(String id, double lat, double lon) => HistoricalPlace(
    id: id,
    name: LocalizedText(ar: id),
    kind: PlaceKind.city,
    location: GeoPoint(lat: lat, lon: lon, precision: GeoPrecision.identified),
    summary: const LocalizedText(ar: '-'),
    reliability: Reliability.established,
    citations: const [],
    review: const ReviewInfo(status: ReviewStatus.draft),
  );

  // The coordinates in content/places.json.
  final hijrah = [
    place('makkah', 21.4225, 39.8262),
    place('ghar-thawr', 21.3772, 39.8497),
    place('quba', 24.4393, 39.6172),
    place('madinah', 24.4672, 39.6112),
  ];

  for (final width in [288.0, 361.0, 700.0]) {
    test('the four stations stand apart at $width dp', () {
      final layout = MapLayout.of(hijrah, Size(width, 360));
      final at = layout.positions;
      for (var i = 0; i < hijrah.length; i++) {
        for (var j = i + 1; j < hijrah.length; j++) {
          final d = (at[hijrah[i].id]! - at[hijrah[j].id]!).distance;
          expect(
            d,
            greaterThanOrEqualTo(MapLayout.minSeparation - 0.01),
            reason: '${hijrah[i].id}–${hijrah[j].id}',
          );
        }
      }
      // Bearings are kept: Thawr south of Makkah, Quba south of Madinah.
      expect(at['ghar-thawr']!.dy, greaterThan(at['makkah']!.dy));
      expect(at['quba']!.dy, greaterThan(at['madinah']!.dy));
      expect(layout.spread, isTrue);
      for (final o in at.values) {
        expect((Offset.zero & Size(width, 360)).contains(o), isTrue);
      }
    });
  }

  test('places already apart are not moved, and no note is shown', () {
    final apart = [hijrah[0], hijrah[3]];
    final layout = MapLayout.of(apart, const Size(361, 360));
    expect(layout.spread, isFalse);
    final d =
        (layout.positions['makkah']! - layout.positions['madinah']!).distance;
    expect(d, greaterThan(200));
  });

  test('places at the same point are set around a circle', () {
    final same = [place('a', 21, 39), place('b', 21, 39), place('c', 24, 39)];
    final at = MapLayout.of(same, const Size(361, 360)).positions;
    expect(
      (at['a']! - at['b']!).distance,
      greaterThanOrEqualTo(MapLayout.minSeparation - 0.01),
    );
    expect(math.min(at['a']!.dy, at['b']!.dy), greaterThan(at['c']!.dy));
  });
}
