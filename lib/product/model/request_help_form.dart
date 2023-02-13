import 'package:cloud_firestore/cloud_firestore.dart';
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
class RequestHelpForm {
  RequestHelpForm({
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
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
  )
  DateTime? startedDate = DateTime.now(), updatedDate = DateTime.now();

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
}
