import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_platform_interface/src/types/bitmap.dart';
import 'package:sesimiduy/features/current_map/model/marker_models.dart';
import 'package:sesimiduy/features/current_map/view/dropdown/filter_dropdown.dart';
import 'package:sesimiduy/features/login/service/map_service.dart';

class PoiActionButton extends StatelessWidget {
  const PoiActionButton({
    required this.onSelected,
    super.key,
    this.icon,
  });
  final AsyncValueSetter<Set<ProductMarker>> onSelected;
  final BitmapDescriptor? icon;

  @override
  Widget build(BuildContext context) {
    return FilterDropDown(
      onSelected: (category) async {
        if (category == null) return;
        final markers = await MapService().fetchCategoryPOI(category);
        await onSelected.call(
          markers
              .map(
                (e) => ProductMarker(
                  e.id,
                  e.name,
                  e.location?.latitude,
                  e.location?.longitude,
                  icon: icon,
                ),
              )
              .toSet(),
        );
      },
    );
  }
}
