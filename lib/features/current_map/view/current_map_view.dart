import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/current_map/provider/map_provider.dart';
import 'package:sesimiduy/features/current_map/view/action/poi_action_button.dart';
import 'package:sesimiduy/features/current_map/view/bottom_page_view.dart';
import 'package:sesimiduy/features/login/service/map_service.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/size/index.dart';

class CurrentMapView extends ConsumerStatefulWidget {
  const CurrentMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CurrentMapViewState();
}

class _CurrentMapViewState extends ConsumerState<CurrentMapView> {
  late final StateNotifierProvider<MapProvider, MapState> mapProvider;
  late final MapService service;
  @override
  void initState() {
    super.initState();
    service = MapService();
    mapProvider = StateNotifierProvider((ref) => MapProvider(service: service));
    ref.read(mapProvider.notifier).init(context).whenComplete(
          () => ref.read(mapProvider.notifier).fetchRequestPOI(context),
        );
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
            onSelected: (value) async {
              await ref
                  .read(mapProvider.notifier)
                  .updatePoiWithIconCheck(value, context);
              final position = value.firstOrNull?.position;

              if (position == null) return;

              ref.read(mapProvider.notifier).changeMapView(
                    GeoPoint(
                      position.latitude,
                      position.longitude,
                    ),
                  );
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Consumer(
            builder: (context, widgetRef, child) {
              final selectedCategoriesItems =
                  ref.watch(mapProvider).selectedMarkers ?? {};
              final requestedMarkers =
                  ref.watch(mapProvider).requestMarkers ?? {};

              return GoogleMap(
                onMapCreated: (controller) {
                  ref.read(mapProvider.notifier).setController(controller);
                },
                markers: Set.from(
                  selectedCategoriesItems.toList() + requestedMarkers.toList(),
                ),
                initialCameraPosition: initialCameraPosition,
              );
            },
          ),
          Positioned(
            bottom: WidgetSizes.spacingL,
            right: 0,
            left: 0,
            height: WidgetSizes.spacingXxl8 * 3,
            child: SafeArea(
              child: BottomPageView(
                wantedItems: ref.watch(mapProvider).wanteds ?? [],
                mapProvider: ref.read(mapProvider.notifier),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CameraPosition get initialCameraPosition => const CameraPosition(
        target: AppConstants.defaultLocation,
        zoom: AppConstants.defaultMapZoom,
      );
}
