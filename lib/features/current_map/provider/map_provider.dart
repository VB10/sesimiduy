// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sesimiduy/features/current_map/model/marker_models.dart';
import 'package:sesimiduy/features/login/service/map_service.dart';
import 'package:sesimiduy/product/model/want_help_model.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';

class MapProvider extends StateNotifier<MapState> with _ByteMapHelper {
  MapProvider({required this.service}) : super(const MapState());

  final MapService service;

  void updateName(Set<ProductMarker> productMarkers) {
    state = state.copyWith(selectedMarkers: productMarkers);
  }

  Future<void> init(BuildContext context) async {
    final helpIcon = await _getBytesFromAsset(
      ImageConstants.mapHelp,
      WidgetSizes.spacingL.toInt(),
      context,
    );
    // ignore: use_build_context_synchronously
    if (!context.mounted) return;
    final carIcon = await _getBytesFromAsset(
      ImageConstants.mapCarHelp,
      WidgetSizes.spacingL.toInt(),
      context,
    );

    state = state.copyWith(markerCarIcon: carIcon, markerHelpIcon: helpIcon);
  }

  Future<void> updatePoiWithIconCheck(
    Set<ProductMarker> value,
    BuildContext context,
  ) async {
    var selectedValues = value;

    if (value.isEmpty) {
      return;
    }
    if (value.any(
      (element) => element.icon == BitmapDescriptor.defaultMarker,
    )) {
      await init(context);
      selectedValues = selectedValues
          .map(
            (e) => e,
          )
          .toSet();
    }

    state = state.copyWith(selectedMarkers: selectedValues);
  }

  void updatePoi(Set<ProductMarker> value) {
    state = state.copyWith(selectedMarkers: value);
  }

  Future<void> fetchRequestPOI(BuildContext context) async {
    final wanteds = await service.fetchUsersWants();
    if (wanteds == null) return;

    state = state.copyWith(
      wanteds: wanteds,
      requestMarkers: wanteds
          .map(
            ProductMarker.fromWantedHelpModel,
          )
          .toSet(),
    );

    changeMapView(wanteds.first.location);
  }

  void setController(GoogleMapController controller) {
    state = state.copyWith(googleMapController: controller);
  }

  void changeMapView(GeoPoint? model) {
    if (model == null) return;
    state.googleMapController?.animateCamera(
      CameraUpdate.newLatLng(
        CameraPosition(
          target: LatLng(
            model.latitude,
            model.longitude,
          ),
          zoom: AppConstants.defaultMapZoom,
        ).target,
      ),
    );
  }
}

@immutable
class MapState extends Equatable {
  const MapState({
    this.title,
    this.selectedMarkers,
    this.markerHelpIcon,
    this.markerCarIcon,
    this.requestMarkers,
    this.wanteds,
    this.googleMapController,
  });

  final String? title;
  final Set<Marker>? selectedMarkers;
  final Set<Marker>? requestMarkers;
  final List<WantHelpModel>? wanteds;
  final BitmapDescriptor? markerHelpIcon;
  final BitmapDescriptor? markerCarIcon;

  final GoogleMapController? googleMapController;
  @override
  List<Object?> get props => [
        title,
        selectedMarkers,
        markerHelpIcon,
        markerCarIcon,
        requestMarkers,
        wanteds,
        googleMapController
      ];

  MapState copyWith({
    String? title,
    Set<Marker>? selectedMarkers,
    Set<Marker>? requestMarkers,
    List<WantHelpModel>? wanteds,
    BitmapDescriptor? markerHelpIcon,
    BitmapDescriptor? markerCarIcon,
    GoogleMapController? googleMapController,
  }) {
    return MapState(
      title: title ?? this.title,
      selectedMarkers: selectedMarkers ?? this.selectedMarkers,
      requestMarkers: requestMarkers ?? this.requestMarkers,
      wanteds: wanteds ?? this.wanteds,
      markerHelpIcon: markerHelpIcon ?? this.markerHelpIcon,
      markerCarIcon: markerCarIcon ?? this.markerCarIcon,
      googleMapController: googleMapController ?? this.googleMapController,
    );
  }

  Set<ProductMarker> get allMarkers {
    return Set<ProductMarker>.from(
      (selectedMarkers?.toList() ?? []) + (requestMarkers?.toList() ?? []),
    );
  }
}

mixin _ByteMapHelper on StateNotifier<MapState> {
  Future<BitmapDescriptor> _getBytesFromAsset(
    String path,
    int width,
    BuildContext context,
  ) async {
    final loadedFile = await DefaultAssetBundle.of(context).load(path);
    final bytes = loadedFile.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes);
  }
}
