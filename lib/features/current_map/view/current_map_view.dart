import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sesimiduy/features/current_map/view/bottom_page_view.dart';
import 'package:sesimiduy/features/current_map/view/button/toggle_button.dart';
import 'package:sesimiduy/features/current_map/view/dropdown/filter_dropdown.dart';
import 'package:sesimiduy/features/login/service/map_service.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/index.dart';

class CurrentMapView extends StatefulWidget {
  const CurrentMapView({super.key});

  @override
  State<CurrentMapView> createState() => _CurrentMapViewState();
}

class _CurrentMapViewState extends State<CurrentMapView> with _ByteMapHelper {
  static const _defaultLocation = LatLng(37.579609, 36.946812);
  static const _defaultLocationIST = LatLng(40.5333232, 31.0325468);

  Set<Marker> _selectedMarkers = {};

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
        actions: [
          FilterDropDown(
            onSelected: (category) async {
              if (category == null) return;
              final markers = await MapService().fetchPOI(category);
              setState(() {
                _selectedMarkers = markers
                    .map(
                      (e) => ProductMarker(
                        e.id,
                        e.name,
                        e.location?.latitude,
                        e.location?.longitude,
                      ),
                    )
                    .toSet();
              });
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            markers: _selectedMarkers,
            initialCameraPosition: const CameraPosition(
              target: _defaultLocation,
              zoom: AppConstants.defaultMapZoom,
            ),
          ),
          const Padding(
            padding: PagePadding.allLow(),
            child: ToggleButton(),
          ),
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

class ProductMarker extends Marker {
  ProductMarker(String? id, String? info, double? lat, double? lang)
      : super(
          infoWindow: InfoWindow(title: info ?? ''),
          markerId: MarkerId(id ?? id.hashCode.toString()),
          position: LatLng(
            lat ?? 0.0,
            lang ?? 0.0,
          ),
        );
}
