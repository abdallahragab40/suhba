import 'dart:math' as math;

import 'package:suhba/shared/content/domain/atlas.dart';

/// The two cities a visitor is likely to be in, by their place ids.
enum HolyCity {
  madinah('madinah'),
  makkah('makkah');

  const HolyCity(this.placeId);

  final String placeId;
}

/// How far from a city's recorded point a place still counts as being in
/// or near it: Quba, Uhud and al-Baqi' for Madinah; Hira, Thawr and Arafat
/// for Makkah.
const nearCityKm = 30.0;

/// Beyond this, the reader is not visiting the city, so their position
/// does not order its places.
const visitingRadiusKm = 50.0;

/// The great-circle distance in kilometres between two points.
double distanceKm(double lat1, double lon1, double lat2, double lon2) {
  const earthRadiusKm = 6371.0;
  double rad(double deg) => deg * math.pi / 180;
  final dLat = rad(lat2 - lat1);
  final dLon = rad(lon2 - lon1);
  final a =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(rad(lat1)) *
          math.cos(rad(lat2)) *
          math.pow(math.sin(dLon / 2), 2);
  return 2 * earthRadiusKm * math.asin(math.sqrt(a));
}

double _between(HistoricalPlace a, HistoricalPlace b) =>
    distanceKm(a.location.lat, a.location.lon, b.location.lat, b.location.lon);

/// The city [place] is in or near, or null. A city is never near itself
/// or another city.
HolyCity? holyCityOf(
  HistoricalPlace place,
  Map<String, HistoricalPlace> places,
) {
  if (place.kind == PlaceKind.city) return null;
  for (final city in HolyCity.values) {
    final centre = places[city.placeId];
    if (centre != null && _between(place, centre) <= nearCityKm) return city;
  }
  return null;
}

/// The places in or near [city] (the city itself left out), nearest to
/// [from] first: the reader's position, or the city's recorded point when
/// there is none.
List<HistoricalPlace> placesIn(
  HolyCity city,
  Map<String, HistoricalPlace> places, {
  ({double lat, double lon})? from,
}) {
  final centre = places[city.placeId];
  if (centre == null) return const [];
  final origin = from ?? (lat: centre.location.lat, lon: centre.location.lon);
  double away(HistoricalPlace p) =>
      distanceKm(origin.lat, origin.lon, p.location.lat, p.location.lon);
  return [
    for (final p in places.values)
      if (holyCityOf(p, places) == city) p,
  ]..sort((a, b) => away(a).compareTo(away(b)));
}

/// The city the reader is visiting, or null when they are in neither.
HolyCity? cityAt(
  ({double lat, double lon}) position,
  Map<String, HistoricalPlace> places,
) {
  for (final city in HolyCity.values) {
    final centre = places[city.placeId];
    if (centre != null &&
        distanceKm(
              position.lat,
              position.lon,
              centre.location.lat,
              centre.location.lon,
            ) <=
            visitingRadiusKm) {
      return city;
    }
  }
  return null;
}
