import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_help_form.g.dart';

@immutable
@JsonSerializable()
class RequestHelpForm {
  const RequestHelpForm({
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.categoryId,
    this.newCategoryName,
    this.location,
  });

  final String fullName;
  final String phoneNumber;
  final String address;
  final String categoryId;
  final String? newCategoryName;
  @JsonKey(fromJson: _geoPointConvertJson, toJson: _geoPointConvertJson)
  final GeoPoint? location;

  Map<String, dynamic> toJson() => _$RequestHelpFormToJson(this);

  static GeoPoint? _geoPointConvertJson(GeoPoint? geoPoint) {
    return geoPoint;
  }
}
