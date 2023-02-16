// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_help_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryHelpForm _$DeliveryHelpFormFromJson(Map<String, dynamic> json) =>
    DeliveryHelpForm(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      numberPlate: json['numberPlate'] as String,
      toPlaceId: json['toPlaceId'] as int,
      fromPlace: json['fromPlace'] as String,
      toPlace: json['toPlace'] as String,
      createdAt: FirebaseTimeParser.datetimeFromTimestamp(
          json['createdAt'] as Timestamp?),
      updatedAt: FirebaseTimeParser.datetimeFromTimestamp(
          json['updatedAt'] as Timestamp?),
      companyName: json['companyName'] as String,
      isCompany: json['isCompany'] as bool,
      madeByCityId: json['madeByCityId'] as int,
      madeByCityName: json['madeByCityName'] as String,
      deviceId: json['deviceId'] as String,
      collectedItems: (json['collectedItems'] as List<dynamic>)
          .map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      carType: json['carType'] as int? ?? 1,
    );

Map<String, dynamic> _$DeliveryHelpFormToJson(DeliveryHelpForm instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'companyName': instance.companyName,
      'isCompany': instance.isCompany,
      'madeByCityId': instance.madeByCityId,
      'madeByCityName': instance.madeByCityName,
      'phoneNumber': instance.phoneNumber,
      'carType': instance.carType,
      'numberPlate': instance.numberPlate,
      'deviceId': instance.deviceId,
      'fromPlace': instance.fromPlace,
      'toPlace': instance.toPlace,
      'toPlaceId': instance.toPlaceId,
      'collectedItems': instance.collectedItems.map((e) => e.toJson()).toList(),
      'createdAt': FirebaseTimeParser.dateTimeToTimestamp(instance.createdAt),
      'updatedAt': FirebaseTimeParser.dateTimeToTimestamp(instance.updatedAt),
    };
