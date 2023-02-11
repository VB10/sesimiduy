import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sesimiduy/features/current_map/view/bottom_page_view.dart';
import 'package:sesimiduy/features/current_map/view/button/toggle_button.dart';
import 'package:sesimiduy/features/current_map/view/dropdown/filter_dropdown.dart';
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
  PageController controller = PageController(
    viewportFraction: 0.3,
  );
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    markerHelpIcon = await _getBytesFromAsset(
      ImageConstants.mapHelp,
      WidgetSizes.spacingL.toInt(),
    );
    markerCarIcon = await _getBytesFromAsset(
      ImageConstants.mapCarHelp,
      WidgetSizes.spacingL.toInt(),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsCustom.sambacus,
        title: FittedBox(child: Text(LocaleKeys.login_currentMap.tr())),
        titleSpacing: 0,
        centerTitle: false,
        actions: const [FilterDropDown()],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
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
          const ToggleButton(),
          Positioned(
            bottom: WidgetSizes.spacingL,
            right: 0,
            left: 0,
            height: WidgetSizes.spacingXxl8 * 3,
            child: SafeArea(
              child: BottomPageView(),
            ),
          ),
        ],
      ),
    );
  }
}

mixin _ByteMapHelper on State<CurrentMapView> {
  BitmapDescriptor? markerHelpIcon;
  BitmapDescriptor? markerCarIcon;

  Future<BitmapDescriptor> _getBytesFromAsset(String path, int width) async {
    final loadedFile = await DefaultAssetBundle.of(context).load(path);
    final bytes = loadedFile.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes);
  }
}
