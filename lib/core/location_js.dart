@JS('navigator.geolocation') // navigator.geolocation namespace
library jslocation; // library name can be whatever you want

import 'package:js/js.dart';

@JS('getCurrentPosition') // Accessing method getCurrentPosition from Geolocation API
external void getCurrentPosition(
    Function Function(GeolocationPosition pos) success);

@JS()
@anonymous
class GeolocationCoordinates {
  external factory GeolocationCoordinates(
      {double latitude,
      double longitude,
      double altitude,
      double accuracy,
      double altitudeAccuracy,
      double heading,
      double speed});
  external double get latitude;
  external double get longitude;
  external double get altitude;
  external double get accuracy;
  external double get altitudeAccuracy;
  external double get heading;
  external double get speed;
}

@JS()
@anonymous
class GeolocationPosition {
  external factory GeolocationPosition({GeolocationCoordinates coords});
  external GeolocationCoordinates get coords;
}
