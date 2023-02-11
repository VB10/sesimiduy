// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poi _$PoiFromJson(Map<String, dynamic> json) => Poi(
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      location: Poi._geoPointConvertJson(json['location'] as GeoPoint?),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$PoiToJson(Poi instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'id': instance.id,
      'name': instance.name,
      'location': Poi._geoPointConvertJson(instance.location),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
