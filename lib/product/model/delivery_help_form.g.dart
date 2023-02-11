// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_help_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryHelpForm _$DeliveryHelpFormFromJson(Map<String, dynamic> json) =>
    DeliveryHelpForm(
      fullName: json['fullName'] as String,
      driverName: json['driverName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      vehicleType: json['vehicleType'] as String? ?? 'Araba',
      carPlate: json['carPlate'] as String,
      fromPlace: json['fromPlace'] as String,
      toPlace: json['toPlace'] as String,
      item: Items.fromJson(json['item'] as Map<String, dynamic>),
      createdAt: _datetimeFromTimestamp(json['createdAt'] as Timestamp?),
      updatedAt: _datetimeFromTimestamp(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$DeliveryHelpFormToJson(DeliveryHelpForm instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'driverName': instance.driverName,
      'phoneNumber': instance.phoneNumber,
      'vehicleType': instance.vehicleType,
      'carPlate': instance.carPlate,
      'fromPlace': instance.fromPlace,
      'toPlace': instance.toPlace,
      'item': instance.item,
      'createdAt': _dateTimeToTimestamp(instance.createdAt),
      'updatedAt': _dateTimeToTimestamp(instance.updatedAt),
    };
