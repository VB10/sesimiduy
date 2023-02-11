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
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
