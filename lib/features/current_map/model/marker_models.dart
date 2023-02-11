import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sesimiduy/product/model/want_help_model.dart';

class ProductMarker extends Marker {
  ProductMarker(
    String? id,
    String? info,
    double? lat,
    double? lang, {
    BitmapDescriptor? icon,
  }) : super(
          infoWindow: InfoWindow(title: info ?? ''),
          markerId: MarkerId(id ?? id.hashCode.toString()),
          position: LatLng(
            lat ?? 0.0,
            lang ?? 0.0,
          ),
          icon: icon ?? BitmapDescriptor.defaultMarker,
        );

  factory ProductMarker.fromWantedHelpModel(WantHelpModel e) {
    return ProductMarker(
      e.id,
      e.fullName,
      e.location?.latitude,
      e.location?.longitude,
    );
  }
}

class RequestHelpMarker extends Marker {
  RequestHelpMarker(
    String? id,
    String? info,
    double? lat,
    double? lang,
    BitmapDescriptor? icon,
  ) : super(
          icon: icon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: info ?? ''),
          markerId: MarkerId(id ?? id.hashCode.toString()),
          position: LatLng(
            lat ?? 0.0,
            lang ?? 0.0,
          ),
        );
}
