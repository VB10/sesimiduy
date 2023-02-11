// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_help_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestHelpForm _$RequestHelpFormFromJson(Map<String, dynamic> json) =>
    RequestHelpForm(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      categoryId: json['categoryId'] as String,
      newCategoryName: json['newCategoryName'] as String?,
      location:
          RequestHelpForm._geoPointConvertJson(json['location'] as GeoPoint?),
    );

Map<String, dynamic> _$RequestHelpFormToJson(RequestHelpForm instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'categoryId': instance.categoryId,
      'newCategoryName': instance.newCategoryName,
      'location': RequestHelpForm._geoPointConvertJson(instance.location),
    };
