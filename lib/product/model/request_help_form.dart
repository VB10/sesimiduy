// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sesimiduy/product/model/items.dart';
import 'package:sesimiduy/product/utility/firebase/geo_parser.dart';
import 'package:sesimiduy/product/utility/firebase/time_parser.dart';

part 'request_help_form.g.dart';

@immutable
@JsonSerializable(
  explicitToJson: true,
)
class RequestHelpForm extends Equatable {
  const RequestHelpForm({
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.categoryId,
    required this.categories,
    this.location,
    this.startedDate,
    this.updatedDate,
  });
  @JsonKey(
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
  )
  final DateTime? startedDate;
  final DateTime? updatedDate;

  final String fullName;
  final String phoneNumber;
  final String address;
  final String categoryId;
  @JsonKey(
    fromJson: GeoParser.geoPointConvertJson,
    toJson: GeoParser.geoPointConvertJson,
  )
  final GeoPoint? location;

  final List<Items> categories;

  Map<String, dynamic> toJson() => _$RequestHelpFormToJson(this);

  @override
  List<Object?> get props {
    return [
      updatedDate,
      fullName,
      phoneNumber,
      address,
      categoryId,
      location,
      categories,
    ];
  }

  RequestHelpForm copyWith({
    DateTime? startedDate,
    DateTime? updatedDate,
    String? fullName,
    String? phoneNumber,
    String? address,
    String? categoryId,
    GeoPoint? location,
    List<Items>? categories,
  }) {
    return RequestHelpForm(
      startedDate: startedDate ?? this.startedDate,
      updatedDate: updatedDate ?? this.updatedDate,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      categoryId: categoryId ?? this.categoryId,
      location: location ?? this.location,
      categories: categories ?? this.categories,
    );
  }
}
