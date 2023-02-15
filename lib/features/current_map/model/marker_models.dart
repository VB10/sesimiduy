import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/model/want_help_model.dart';

class ProductMarker extends Marker {
  ProductMarker(
    String? id,
    String? info,
    double? lat,
    double? lang, {
    required VoidCallback? onTap,
    BitmapDescriptor? icon,
  }) : super(
          infoWindow: InfoWindow(
            title: info ?? '',
            snippet: LocaleKeys.map_makeRoute.tr(),
            onTap: onTap,
          ),
          markerId: MarkerId(id ?? id.hashCode.toString()),
          position: LatLng(
            lat ?? 0.0,
            lang ?? 0.0,
          ),
          icon: icon ?? BitmapDescriptor.defaultMarker,
        );

  factory ProductMarker.fromWantedHelpModel(
    WantHelpModel e,
    VoidCallback? onTap,
  ) {
    return ProductMarker(
      e.id,
      e.fullName,
      e.location?.latitude,
      e.location?.longitude,
      onTap: onTap,
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
