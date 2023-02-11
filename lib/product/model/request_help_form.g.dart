// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_help_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestHelpForm _$RequestHelpFormFromJson(Map<String, dynamic> json) =>
    RequestHelpForm(
      json['fullName'] as String,
      json['phoneNumber'] as String,
      json['address'] as String,
      json['categoryId'] as String,
      json['newCategoryName'] as String?,
      json['isKVKKAccepted'] as bool,
    );

Map<String, dynamic> _$RequestHelpFormToJson(RequestHelpForm instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'categoryId': instance.categoryId,
      'newCategoryName': instance.newCategoryName,
      'isKVKKAccepted': instance.isKVKKAccepted,
    };
