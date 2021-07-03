import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocationK {
  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  double determineDistanceBetweenTwoLocations(Position p) {
    return Geolocator.distanceBetween(
        // static address for minia university
        28.1183,
        30.7400,
        p.latitude,
        p.longitude);
  }

  Future<String> determineLocationName(Position p) async {
    Coordinates c = Coordinates(p.latitude, p.longitude);

    var address = await Geocoder.local.findAddressesFromCoordinates(c);
    String cityName = address.first.addressLine;
    return cityName;
  }
}
