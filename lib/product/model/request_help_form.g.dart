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
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: GeoParser.geoPointConvertJson(json['location'] as GeoPoint?),
      startedDate: FirebaseTimeParser.datetimeFromTimestamp(
          json['startedDate'] as Timestamp?,),
      updatedDate: FirebaseTimeParser.datetimeFromTimestamp(
          json['updatedDate'] as Timestamp?,),
    );

Map<String, dynamic> _$RequestHelpFormToJson(RequestHelpForm instance) =>
    <String, dynamic>{
      'startedDate': instance.startedDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'categoryId': instance.categoryId,
      'location': GeoParser.geoPointConvertJson(instance.location),
      'categories': instance.categories.map((e) => e.toJson()).toList(),
    };
