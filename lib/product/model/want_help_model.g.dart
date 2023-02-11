// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'want_help_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WantHelpModel _$WantHelpModelFromJson(Map<String, dynamic> json) =>
    WantHelpModel(
      address: json['address'] as String?,
      deviceId: json['deviceId'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      location:
          WantHelpModel._geoPointConvertJson(json['location'] as GeoPoint?),
      id: json['id'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WantHelpModelToJson(WantHelpModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'deviceId': instance.deviceId,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'categories': instance.categories,
      'location': WantHelpModel._geoPointConvertJson(instance.location),
    };
