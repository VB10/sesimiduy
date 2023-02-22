import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/current_map/view/dropdown/filter_dropdown.dart';
import 'package:sesimiduy/features/login/service/map_service.dart';
import 'package:sesimiduy/product/enums/poi_types.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/utility/maps/polyline_helper.dart';
import 'package:sesimiduy/product/utility/state/app_provider.dart';

class PoiActionButton extends ConsumerWidget {
  const PoiActionButton({
    required this.onSelected,
    super.key,
    this.icon,
    this.onSelectedPolyLine,
  });
  final AsyncValueSetter<Set<Marker>> onSelected;
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
          if (context.mounted) {
            await ref
                .read(AppProvider.provider.notifier)
                .checkMapsPermission(context);
          }

          return;
        }

        await onSelected.call(
          markers
              .map(
                (e) => Marker(
                  markerId: MarkerId(e.id ?? ''),
                  infoWindow: InfoWindow(
                    snippet: LocaleKeys.map_makeRoute.tr(),
                    title: e.name ?? '',
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
                  ),
                  position: LatLng(
                    e.location?.latitude ?? 0,
                    e.location?.longitude ?? 0,
                  ),
                  icon: type == null
                      ? icon ?? BitmapDescriptor.defaultMarker
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

/*
ProductMarker(
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
*/
