// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sesimiduy/product/model/items.dart';

part 'delivery_help_form.g.dart';

@immutable
@JsonSerializable()
class DeliveryHelpForm {
  final String fullName;
  final String driverName;
  final String phoneNumber;
  final String vehicleType;
  final String carPlate;
  final String fromPlace;
  final String toPlace;
  final Items item;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DeliveryHelpForm({
    required this.fullName,
    required this.driverName,
    required this.phoneNumber,
    this.vehicleType = 'Araba',
    required this.carPlate,
    required this.fromPlace,
    required this.toPlace,
    required this.item,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$DeliveryHelpFormToJson(this);

  @override
  String toString() {
    return 'DeliveryHelpForm(fullName: $fullName, driverName: $driverName, phoneNumber: $phoneNumber, vehicleType: $vehicleType, carPlate: $carPlate, fromPlace: $fromPlace, toPlace: $toPlace, item: $item, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
