import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sesimiduy/product/extension/string_lang_extension.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/utility/size/index.dart';

class CurrentMapView extends StatefulWidget {
  const CurrentMapView({super.key});

  @override
  State<CurrentMapView> createState() => _CurrentMapViewState();
}

class _CurrentMapViewState extends State<CurrentMapView> with _ByteMapHelper {
  static const _defaultLocation = LatLng(37.579609, 36.946812);
  static const _defaultLocationIST = LatLng(40.5333232, 31.0325468);

  @override
  void initState() {
    super.initState();
    Future.wait([
      _getBytesFromAsset(ImageConstants.mapHelp, WidgetSizes.spacingL.toInt()),
      _getBytesFromAsset(
        ImageConstants.mapCarHelp,
        WidgetSizes.spacingL.toInt(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsCustom.sambacus,
        title: Text(LocaleKeys.login_currentMap.locale),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _defaultLocation,
          zoom: AppConstants.defaultMapZoom,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId(
              '${_defaultLocation.latitude + _defaultLocation.longitude}',
            ),
            points: const [
              _defaultLocation,
              _defaultLocationIST,
            ],
            width: 4,
            color: ColorsCustom.sambacus,
          ),
        },
        markers: {
          Marker(
            markerId: MarkerId('${_defaultLocation.latitude}'),
            position: _defaultLocation,
            draggable: true,
            onDragEnd: (value) {},
            icon: markerHelpIcon ?? BitmapDescriptor.defaultMarker,
          ),
          Marker(
            markerId: MarkerId('${_defaultLocationIST.latitude}'),
            position: _defaultLocationIST,
            onDragEnd: (value) {},
            icon: markerCarIcon ?? BitmapDescriptor.defaultMarker,
          ),
        },
      ),
    );
  }
}

mixin _ByteMapHelper on State<CurrentMapView> {
  BitmapDescriptor? markerHelpIcon;
  BitmapDescriptor? markerCarIcon;

  Future<void> _getBytesFromAsset(String path, int width) async {
    final loadedFile = await DefaultAssetBundle.of(context).load(path);
    final bytes = loadedFile.buffer.asUint8List();
    setState(() {
      markerHelpIcon = BitmapDescriptor.fromBytes(bytes);
    });
  }
}
