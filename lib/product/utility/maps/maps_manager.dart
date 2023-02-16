import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

@immutable
class MapsManager {
  const MapsManager._();

  static Future<void> checkPermission() async {
    if (kIsWeb) {
      await Geolocator.checkPermission();
      return;
    }
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
  }

  static Future<Position> determinePosition() async {
    await checkPermission();
    return Geolocator.getCurrentPosition();
  }
}
