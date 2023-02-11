// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'want_help_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WantHelpModel _$WantHelpModelFromJson(Map<String, dynamic> json) =>
    WantHelpModel(
      adress: json['adress'] as String?,
      deviceId: json['deviceId'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      location:
          WantHelpModel._geoPointConvertJson(json['location'] as GeoPoint?),
    );

Map<String, dynamic> _$WantHelpModelToJson(WantHelpModel instance) =>
    <String, dynamic>{
      'adress': instance.adress,
      'deviceId': instance.deviceId,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'location': WantHelpModel._geoPointConvertJson(instance.location),
    };
