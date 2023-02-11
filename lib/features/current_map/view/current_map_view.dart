import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sesimiduy/features/current_map/provider/map_provider.dart';
import 'package:sesimiduy/features/current_map/view/action/poi_action_button.dart';
import 'package:sesimiduy/features/current_map/view/bottom_page_view.dart';
import 'package:sesimiduy/features/current_map/view/button/toggle_button.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/index.dart';

class CurrentMapView extends ConsumerStatefulWidget {
  const CurrentMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CurrentMapViewState();
}

class _CurrentMapViewState extends ConsumerState<CurrentMapView>
    with _ByteMapHelper {
  late final StateNotifierProvider<MapProvider, MapState> mapProvider;

  @override
  void initState() {
    super.initState();
    mapProvider = StateNotifierProvider((ref) => MapProvider());
    ref.read(mapProvider.notifier).init(context);
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
          PoiActionButton(
            icon: ref.watch(mapProvider).markerHelpIcon,
            onSelected: (value) async {
              await ref
                  .read(mapProvider.notifier)
                  .updatePoiWithIconCheck(value, context);
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            markers: ref.watch(mapProvider).selectedMarkers ?? {},
            initialCameraPosition: const CameraPosition(
              target: AppConstants.defaultLocation,
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
  // BitmapDescriptor? markerHelpIcon;
  // BitmapDescriptor? markerCarIcon;

  Future<BitmapDescriptor> _getBytesFromAsset(String path, int width) async {
    final loadedFile = await DefaultAssetBundle.of(context).load(path);
    final bytes = loadedFile.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes);
  }
}

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
