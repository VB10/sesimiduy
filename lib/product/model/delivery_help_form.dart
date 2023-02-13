// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sesimiduy/product/utility/firebase/time_parser.dart';

part 'delivery_help_form.g.dart';

@immutable
@JsonSerializable()
class DeliveryHelpForm {
  final String fullName;
  final String companyName;
  final bool isCompany;
  final int madeByCityId;
  final String madeByCityName;
  final String phoneNumber;
  final int carType;
  final String numberPlate;
  final String collectItem;
  final String collectItemId;
  final String deviceId;
  final String fromPlace;
  final String toPlace;
  final int toPlaceId;

  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
  )
  DateTime? createdAt = DateTime.now(), updatedAt = DateTime.now();
  DeliveryHelpForm({
    required this.fullName,
    required this.phoneNumber,
    required this.numberPlate,
    required this.toPlaceId,
    required this.fromPlace,
    required this.toPlace,
    required this.companyName,
    required this.isCompany,
    required this.madeByCityId,
    required this.madeByCityName,
    required this.collectItem,
    required this.collectItemId,
    required this.deviceId,
    this.carType = 1,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$DeliveryHelpFormToJson(this);


}
