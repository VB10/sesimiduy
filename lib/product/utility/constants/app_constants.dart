import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String kWeb = 'kWeb';

@immutable
class AppConstants {
  const AppConstants._();
  static const int kZero = 0;
  static const int kOne = 1;
  static const int kTwo = 2;
  static const int kThree = 3;
  static const int kFour = 4;

  static const double defaultMapZoom = 14;
  static const defaultLocation = LatLng(37.579609, 36.946812);
}
