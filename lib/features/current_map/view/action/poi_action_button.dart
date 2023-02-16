import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/current_map/model/marker_models.dart';
import 'package:sesimiduy/features/current_map/view/dropdown/filter_dropdown.dart';
import 'package:sesimiduy/features/login/service/map_service.dart';
import 'package:sesimiduy/product/enums/poi_types.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/size/index.dart';

import 'package:sesimiduy/product/utility/state/app_provider.dart';

class PoiActionButton extends ConsumerWidget {
  const PoiActionButton({
    required this.onSelected,
    super.key,
    this.icon,
    this.onSelectedPolyLine,
  });
  final AsyncValueSetter<Set<ProductMarker>> onSelected;
  final BitmapDescriptor? icon;
  final ValueSetter<Set<Polyline>>? onSelectedPolyLine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilterDropDown(
      onSelected: (category) async {
        if (category == null) return;
        final markers = await MapService().fetchCategoryPOI(category);
        final type = PoiTypes.matchFromString(category.categoryType);

        final userPosition = ref.read(AppProvider.provider).position;
        if (userPosition == null) {
          await ref.read(AppProvider.provider.notifier).checkMapsPermission();
        }
        await onSelected.call(
          markers
              .map(
                (e) => ProductMarker(
                  e.id,
                  e.name,
                  e.location?.latitude,
                  e.location?.longitude,
                  onTap: () {
                    final userPosition =
                        ref.read(AppProvider.provider).position;
                    if (userPosition == null) return;
                    if (onSelectedPolyLine == null) return;
                    if (e.location == null || e.id.isNullOrEmpty) return;
                    onSelectedPolyLine?.call({
                      Polyline(
                        polylineId: PolylineId(e.id!),
                        endCap: Cap.roundCap,
                        startCap: Cap.roundCap,
                        jointType: JointType.round,
                        points: [
                          LatLng(userPosition.latitude, userPosition.longitude),
                          LatLng(e.location!.latitude, e.location!.longitude),
                        ],
                        color: ColorsCustom.sambacus,
                        width: IconSize.xSmall.value.toInt(),
                      ),
                    });
                  },
                  icon: type == null
                      ? icon
                      : BitmapDescriptor.defaultMarkerWithHue(
                          type.getDecoration().hue,
                        ),
                ),
              )
              .toSet(),
        );
      },
    );
  }
}
