// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sesimiduy/product/model/items.dart';
import 'package:sesimiduy/product/utility/firebase/time_parser.dart';

part 'delivery_help_form.g.dart';

@immutable
@JsonSerializable(
  explicitToJson: true,
)
class DeliveryHelpForm extends Equatable {
  final String fullName;
  final String companyName;
  final bool isCompany;
  final int madeByCityId;
  final String madeByCityName;
  final String phoneNumber;
  final int carType;
  final String numberPlate;
  final String deviceId;
  final String fromPlace;
  final String toPlace;
  final int toPlaceId;
  final List<Items> collectedItems;

  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
  )
  final DateTime? createdAt;
  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
  )
  final DateTime? updatedAt;

  const DeliveryHelpForm({
    required this.fullName,
    required this.phoneNumber,
    required this.numberPlate,
    required this.toPlaceId,
    required this.fromPlace,
    required this.toPlace,
    required this.createdAt,
    required this.updatedAt,
    required this.companyName,
    required this.isCompany,
    required this.madeByCityId,
    required this.madeByCityName,
    required this.deviceId,
    required this.collectedItems,
    this.carType = 1,
  });

  Map<String, dynamic> toJson() => _$DeliveryHelpFormToJson(this);

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      fullName,
      companyName,
      isCompany,
      madeByCityId,
      madeByCityName,
      phoneNumber,
      carType,
      numberPlate,
      deviceId,
      fromPlace,
      toPlace,
      toPlaceId,
      createdAt ?? DateTime.now(),
      updatedAt ?? DateTime.now(),
    ];
  }

  DeliveryHelpForm copyWith({
    String? fullName,
    String? companyName,
    bool? isCompany,
    int? madeByCityId,
    String? madeByCityName,
    String? phoneNumber,
    int? carType,
    String? numberPlate,
    String? collectItem,
    String? collectItemId,
    String? deviceId,
    String? fromPlace,
    String? toPlace,
    int? toPlaceId,
    List<Items>? collectedItems,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeliveryHelpForm(
      fullName: fullName ?? this.fullName,
      companyName: companyName ?? this.companyName,
      isCompany: isCompany ?? this.isCompany,
      madeByCityId: madeByCityId ?? this.madeByCityId,
      madeByCityName: madeByCityName ?? this.madeByCityName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      carType: carType ?? this.carType,
      numberPlate: numberPlate ?? this.numberPlate,
      deviceId: deviceId ?? this.deviceId,
      fromPlace: fromPlace ?? this.fromPlace,
      toPlace: toPlace ?? this.toPlace,
      toPlaceId: toPlaceId ?? this.toPlaceId,
      collectedItems: collectedItems ?? this.collectedItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
