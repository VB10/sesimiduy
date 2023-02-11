// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sesimiduy/product/model/items.dart';

part 'want_help_model.g.dart';

@JsonSerializable()
class WantHelpModel extends Equatable {
  final String? id;
  final String? address;
  final String? deviceId;
  final String? fullName;
  final String? phoneNumber;
  final List<Items>? categories;
  @JsonKey(fromJson: _geoPointConvertJson, toJson: _geoPointConvertJson)
  final GeoPoint? location;
  const WantHelpModel({
    this.address,
    this.deviceId,
    this.fullName,
    this.phoneNumber,
    this.location,
    this.id,
    this.categories,
  });

  factory WantHelpModel.fromJson(Map<String, dynamic> json) =>
      _$WantHelpModelFromJson(json);
  factory WantHelpModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('Data is null');
    }
    return WantHelpModel.fromJson(data).copyWith(
      id: snapshot.id,
    );
  }

  Map<String, dynamic> toJson() => _$WantHelpModelToJson(this);

  WantHelpModel copyWith({
    String? id,
    String? address,
    String? deviceId,
    String? fullName,
    String? phoneNumber,
    List<Items>? categories,
    GeoPoint? location,
  }) {
    return WantHelpModel(
      id: id ?? this.id,
      address: address ?? this.address,
      deviceId: deviceId ?? this.deviceId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      categories: categories ?? this.categories,
      location: location ?? this.location,
    );
  }

  static GeoPoint? _geoPointConvertJson(GeoPoint? geoPoint) => geoPoint;

  @override
  List<Object?> get props {
    return [
      id,
      address,
      deviceId,
      fullName,
      phoneNumber,
      location,
      categories,
    ];
  }
}
