// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_help_form.g.dart';

@immutable
@JsonSerializable()
class DeliveryHelpForm {
  final String fullName;
  final String companyName;
  final bool isCompany;
  final int madeByCityId;
  final String madeByCityName;
  final String driverName;
  final String phoneNumber;
  final int carType;
  final String numberPlate;
  final String collectItem;
  final String collectItemId;
  final String deviceId;
  final String fromPlace;
  final String toPlace;

  @JsonKey(toJson: _dateTimeToTimestamp, fromJson: _datetimeFromTimestamp)
  final DateTime? createdAt, updatedAt;
  const DeliveryHelpForm({
    required this.fullName,
    required this.driverName,
    required this.phoneNumber,
    required this.numberPlate,
    required this.fromPlace,
    required this.toPlace,
    required this.createdAt,
    required this.updatedAt,
    required this.companyName,
    required this.isCompany,
    required this.madeByCityId,
    required this.madeByCityName,
    required this.collectItem,
    required this.collectItemId,
    required this.deviceId,
    this.carType = 1,
  });

  Map<String, dynamic> toJson() => _$DeliveryHelpFormToJson(this);

  @override
  String toString() {
    return 'DeliveryHelpForm(fullName: $fullName, driverName: $driverName, phoneNumber: $phoneNumber, vehicleType: $carType, carPlate: $numberPlate, fromPlace: $fromPlace, toPlace: $toPlace, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

DateTime? _datetimeFromTimestamp(Timestamp? timestamp) {
  return timestamp != null
      ? DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch)
      : null;
}

Timestamp? _dateTimeToTimestamp(DateTime? datetime) {
  return datetime != null ? Timestamp.fromDate(datetime) : null;
}
