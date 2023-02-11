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
      createdAt: DeliveryHelpForm._datetimeFromTimestamp(
          json['createdAt'] as Timestamp?),
      updatedAt: DeliveryHelpForm._datetimeFromTimestamp(
          json['updatedAt'] as Timestamp?),
      companyName: json['companyName'] as String,
      isCompany: json['isCompany'] as bool,
      madeByCityId: json['madeByCityId'] as int,
      madeByCityName: json['madeByCityName'] as String,
      collectItem: json['collectItem'] as String,
      collectItemId: json['collectItemId'] as String,
      deviceId: json['deviceId'] as String,
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
      'collectItem': instance.collectItem,
      'collectItemId': instance.collectItemId,
      'deviceId': instance.deviceId,
      'fromPlace': instance.fromPlace,
      'toPlace': instance.toPlace,
      'toPlaceId': instance.toPlaceId,
      'createdAt': DeliveryHelpForm._dateTimeToTimestamp(instance.createdAt),
      'updatedAt': DeliveryHelpForm._dateTimeToTimestamp(instance.updatedAt),
    };
