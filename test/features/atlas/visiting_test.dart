import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/features/atlas/domain/visiting.dart';
import 'package:suhba/shared/content/domain/atlas.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

HistoricalPlace _p(String id, double lat, double lon, [PlaceKind? kind]) =>
    HistoricalPlace(
      id: id,
      name: LocalizedText(ar: id),
      kind: kind ?? PlaceKind.other,
      location: GeoPoint(
        lat: lat,
        lon: lon,
        precision: GeoPrecision.identified,
      ),
      summary: const LocalizedText(ar: ''),
      reliability: Reliability.established,
      citations: const [],
      review: const ReviewInfo(status: ReviewStatus.draft),
    );

void main() {
  final places = {
    for (final p in [
      _p('madinah', 24.4672, 39.6112, PlaceKind.city),
      _p('makkah', 21.4225, 39.8262, PlaceKind.city),
      _p('quba', 24.4393, 39.6172),
      _p('uhud', 24.5, 39.6125),
      _p('al-baqi', 24.467, 39.6168),
      _p('badr', 23.7333, 38.7667),
      _p('arafat', 21.3549, 39.9842),
    ])
      p.id: p,
  };

  test('distances between real places', () {
    // Madinah to Makkah is about 340 km as the crow flies.
    final km = distanceKm(24.4672, 39.6112, 21.4225, 39.8262);
    expect(km, inInclusiveRange(330, 350));
    expect(distanceKm(24.4672, 39.6112, 24.4672, 39.6112), 0);
  });

  test('a site belongs to the city it is in or near', () {
    expect(holyCityOf(places['al-baqi']!, places), HolyCity.madinah);
    expect(holyCityOf(places['arafat']!, places), HolyCity.makkah);
    expect(holyCityOf(places['badr']!, places), isNull);
    // A city is not a site of itself.
    expect(holyCityOf(places['madinah']!, places), isNull);
  });

  test("a city's sites, nearest its centre first", () {
    expect(
      [for (final p in placesIn(HolyCity.madinah, places)) p.id],
      ['al-baqi', 'quba', 'uhud'],
    );
  });

  test("a city's sites, nearest the reader first", () {
    // Standing at the foot of Uhud.
    expect(
      [
        for (final p in placesIn(
          HolyCity.madinah,
          places,
          from: (lat: 24.499, lon: 39.6125),
        ))
          p.id,
      ],
      ['uhud', 'al-baqi', 'quba'],
    );
  });

  test('the city the reader is in', () {
    expect(cityAt((lat: 24.47, lon: 39.61), places), HolyCity.madinah);
    expect(cityAt((lat: 21.42, lon: 39.83), places), HolyCity.makkah);
    // Cairo.
    expect(cityAt((lat: 30.04, lon: 31.24), places), isNull);
  });
}
