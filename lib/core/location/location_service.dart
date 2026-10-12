import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

/// Why the reader's position could not be read.
enum LocationProblem {
  /// Location services are off on the device.
  serviceOff,

  /// The reader declined this time; asking again may succeed.
  denied,

  /// Declined for good; only the device settings can allow it now.
  deniedForever,

  /// Allowed, but no position came back.
  failed,
}

/// The reader's position, or why there is none.
sealed class LocationResult {
  const LocationResult();
}

final class LocationFound extends LocationResult {
  const LocationFound(this.lat, this.lon);

  final double lat;
  final double lon;
}

final class LocationUnavailable extends LocationResult {
  const LocationUnavailable(this.problem);

  final LocationProblem problem;
}

/// Reads the reader's approximate position, on request only. It stays on
/// the device: the app neither stores nor sends it.
abstract interface class LocationService {
  /// Asks for permission when needed, then reads a coarse position.
  Future<LocationResult> currentPosition();

  /// Opens the app's page in the device settings, where a permanently
  /// denied permission can be allowed.
  Future<void> openSettings();
}

class PlatformLocationService implements LocationService {
  const PlatformLocationService();

  @override
  Future<LocationResult> currentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return _problem(LocationProblem.serviceOff);
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      switch (permission) {
        case LocationPermission.denied:
          return _problem(LocationProblem.denied);
        case LocationPermission.deniedForever:
          return _problem(LocationProblem.deniedForever);
        case LocationPermission.whileInUse ||
            LocationPermission.always ||
            LocationPermission.unableToDetermine:
          break;
      }
      final p = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 20),
        ),
      );
      return LocationFound(p.latitude, p.longitude);
    } on Exception {
      return _problem(LocationProblem.failed);
    }
  }

  @override
  Future<void> openSettings() => Geolocator.openAppSettings();

  static LocationResult _problem(LocationProblem p) => LocationUnavailable(p);
}

/// Overridden in tests with a fixed position or problem.
final locationServiceProvider = Provider<LocationService>(
  (ref) => const PlatformLocationService(),
);
