import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';

enum PoiTypes {
  pharmacy('map-container-pharmacy'),
  gathering('map-gathering-list'),
  vet('map-data-vet'),
  food('map-food-items'),
  hospital('map-hospital-list'),
  evacuation('map-evacuation-points'),
  accommodation('map-city-accommodation');

  final String value;
  const PoiTypes(this.value);

  static PoiTypes? matchFromString(String? value) {
    if (value == null) return null;
    return PoiTypes.values.firstWhereOrNull((e) => e.value == value);
  }

  PoiDecoration getDecoration() {
    switch (this) {
      case PoiTypes.pharmacy:
        return PoiDecoration(BitmapDescriptor.hueCyan);
      case PoiTypes.gathering:
        return PoiDecoration(BitmapDescriptor.hueOrange);
      case PoiTypes.vet:
        return PoiDecoration(BitmapDescriptor.hueBlue);
      case PoiTypes.food:
        return PoiDecoration(BitmapDescriptor.hueAzure);
      case PoiTypes.hospital:
        return PoiDecoration(BitmapDescriptor.hueRed);
      case PoiTypes.evacuation:
        return PoiDecoration(BitmapDescriptor.hueYellow);
      case PoiTypes.accommodation:
        return PoiDecoration(BitmapDescriptor.hueGreen);
    }
  }
}

class PoiDecoration {
  PoiDecoration(this.hue);

  final double hue;
}
