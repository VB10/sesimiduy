import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sesimiduy/product/utility/dialog/permission_diallog.dart';

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

  static Future<Position?> determinePosition(BuildContext context) async {
    try {
      await checkPermission();
      return Geolocator.getCurrentPosition();
    } catch (e) {
      await PermissionDialog(context).show();

      return null;
    }
  }
}
