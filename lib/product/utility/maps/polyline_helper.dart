import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/size/icon_size.dart';

@immutable
class PolyLineHelper {
  const PolyLineHelper._();
  static Polyline make({
    required String id,
    required LatLng userPosition,
    required LatLng target,
  }) {
    return Polyline(
      polylineId: PolylineId(id),
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      jointType: JointType.round,
      points: [
        userPosition,
        target,
      ],
      color: ColorsCustom.sambacus,
      width: IconSize.xSmall.value.toInt(),
    );
  }
}
