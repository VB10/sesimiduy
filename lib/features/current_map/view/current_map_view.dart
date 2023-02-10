import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
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
  final List<bool> _selectedOptions = <bool>[true, false];

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    markerHelpIcon = await _getBytesFromAsset(
        ImageConstants.mapHelp, WidgetSizes.spacingL.toInt());
    markerCarIcon = await _getBytesFromAsset(
        ImageConstants.mapCarHelp, WidgetSizes.spacingL.toInt());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsCustom.sambacus,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(LocaleKeys.login_currentMap.tr()), FilterDropDown()],
        ),
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
          ToggleButtons(
            children: [
              Padding(
                padding: PagePadding.horizontalLowSymmetric(),
                child: Text('Option1'),
              ),
              Padding(
                padding: PagePadding.horizontalLowSymmetric(),
                child: Text('Option2'),
              ),
            ],
            isSelected: _selectedOptions,
            onPressed: (int index) {
              setState(() {
                for (var i = 0; i < _selectedOptions.length; i++) {
                  _selectedOptions[i] = i == index;
                }
              });
            },
            selectedColor: ColorsCustom.white,
            fillColor: ColorsCustom.sambacus,
            borderRadius: context.lowBorderRadius,
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

class FilterDropDown extends StatelessWidget {
  FilterDropDown({super.key});
  final filterItems = ['item1', 'item2', 'item3', 'item4'];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: ColorsCustom.sambacus,
        items: filterItems
            .map(
              (e) => DropdownMenuItem(
                  value: e,
                  onTap: () {},
                  child: Text(
                    e,
                    style: const TextStyle(color: ColorsCustom.white),
                  )),
            )
            .toList(),
        onChanged: (value) {},
        value: filterItems.first,
      ),
    );
  }
}
