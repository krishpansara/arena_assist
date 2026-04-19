import 'package:geolocator/geolocator.dart';

enum StadiumZone {
  northStand,
  southStand,
  eastStand,
  westStand,
  outside
}

class ZoneMapper {
  // Approximate center of Wankhede stadium
  static const double _centerLat = 18.9388;
  static const double _centerLng = 72.8258;

  /// Returns the stadium zone based on the given latitude and longitude.
  /// Distance greater than ~150 meters is considered outside.
  static StadiumZone getZoneFromLocation(double latitude, double longitude) {
    // Distance in meters from center
    double distance = Geolocator.distanceBetween(
      _centerLat, _centerLng, latitude, longitude);

    if (distance > 150) {
      return StadiumZone.outside;
    }

    // Determine zone based on coordinate offsets
    double dLat = latitude - _centerLat;
    double dLng = longitude - _centerLng;

    if (dLat > dLng.abs()) {
       return StadiumZone.northStand;
    } else if (dLat < -dLng.abs()) {
       return StadiumZone.southStand;
    } else if (dLng > dLat.abs()) {
       return StadiumZone.eastStand;
    } else {
       return StadiumZone.westStand;
    }
  }

  static String zoneToString(StadiumZone zone) {
    switch (zone) {
      case StadiumZone.northStand:
        return 'northStand';
      case StadiumZone.southStand:
        return 'southStand';
      case StadiumZone.eastStand:
        return 'eastStand';
      case StadiumZone.westStand:
        return 'westStand';
      case StadiumZone.outside:
        return 'outside';
    }
  }
}
