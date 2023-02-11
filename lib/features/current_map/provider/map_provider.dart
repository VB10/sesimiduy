// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod/riverpod.dart';

import 'package:sesimiduy/features/current_map/view/current_map_view.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';

class MapProvider extends StateNotifier<MapState> with _ByteMapHelper {
  MapProvider() : super(const MapState());

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
    if (value.any(
      (element) => element.icon == BitmapDescriptor.defaultMarker,
    )) {
      await init(context);
      selectedValues = selectedValues
          .map(
            (e) => e
              ..copyWith(
                iconParam: state.markerHelpIcon,
              ),
          )
          .toSet();
    }

    state = state.copyWith(selectedMarkers: selectedValues);
  }

  void updatePoi(Set<ProductMarker> value) {
    state = state.copyWith(selectedMarkers: value);
  }
}

@immutable
class MapState extends Equatable {
  const MapState({
    this.title,
    this.selectedMarkers,
    this.markerHelpIcon,
    this.markerCarIcon,
  });

  final String? title;
  final Set<Marker>? selectedMarkers;
  final BitmapDescriptor? markerHelpIcon;
  final BitmapDescriptor? markerCarIcon;
  @override
  List<Object?> get props =>
      [title, selectedMarkers, markerHelpIcon, markerCarIcon];

  MapState copyWith({
    String? title,
    Set<Marker>? selectedMarkers,
    BitmapDescriptor? markerHelpIcon,
    BitmapDescriptor? markerCarIcon,
  }) {
    return MapState(
      title: title ?? this.title,
      selectedMarkers: selectedMarkers ?? this.selectedMarkers,
      markerHelpIcon: markerHelpIcon ?? this.markerHelpIcon,
      markerCarIcon: markerCarIcon ?? this.markerCarIcon,
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
