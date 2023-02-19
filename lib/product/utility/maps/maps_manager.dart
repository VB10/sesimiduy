import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sesimiduy/core/location_js.dart';
import 'package:sesimiduy/product/utility/dialog/permission_diallog.dart';

@immutable
class MapsManager {
  const MapsManager._();
  static final location = Location();
  static Future<void> checkPermission() async {
    PermissionStatus permissionGranted;
    bool serviceEnabled;

    await location.requestPermission();
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  static Future<LatLng?> determinePosition(BuildContext context) async {
    try {
      if (kIsWeb) {
        // ignore: unnecessary_lambdas
        getCurrentPosition(
          allowInterop((pos) {
            return () {
              print(pos.coords.latitude);
              print(pos.coords.longitude);
            };
          }),
        );
      }

      await checkPermission();
      final response = await location.getLocation();
      if (response.latitude == null) throw Exception('Map is not enabled');
      return LatLng(response.latitude!, response.longitude!);
    } catch (e) {
      await PermissionDialog(context).show();

      return null;
    }
  }
}
