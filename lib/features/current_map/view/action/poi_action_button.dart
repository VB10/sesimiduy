import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/current_map/model/marker_models.dart';
import 'package:sesimiduy/features/current_map/view/dropdown/filter_dropdown.dart';
import 'package:sesimiduy/features/login/service/map_service.dart';
import 'package:sesimiduy/product/enums/poi_types.dart';
import 'package:sesimiduy/product/utility/dialog/permission_diallog.dart';
import 'package:sesimiduy/product/utility/maps/polyline_helper.dart';
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
          if (kIsWeb && context.mounted) {
            await PermissionDialog(context).show();
          }
          await ref.read(AppProvider.provider.notifier).checkMapsPermission();
          return;
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
                    if (onSelectedPolyLine == null) return;
                    if (e.location == null || e.id.isNullOrEmpty) return;
                    onSelectedPolyLine?.call({
                      PolyLineHelper.make(
                        id: e.id!,
                        userPosition: LatLng(
                          userPosition.latitude,
                          userPosition.longitude,
                        ),
                        target: LatLng(
                          e.location!.latitude,
                          e.location!.longitude,
                        ),
                      )
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
