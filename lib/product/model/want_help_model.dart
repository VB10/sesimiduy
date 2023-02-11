// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'want_help_model.g.dart';

@JsonSerializable()
class WantHelpModel {
  final String? adress;
  final String? deviceId;
  final String? fullName;
  final String? phoneNumber;
  @JsonKey(fromJson: _geoPointConvertJson, toJson: _geoPointConvertJson)
  final GeoPoint? location;
  WantHelpModel({
    this.adress,
    this.deviceId,
    this.fullName,
    this.phoneNumber,
    this.location,
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
    return WantHelpModel.fromJson(data);
  }


  Map<String, dynamic> toJson() => _$WantHelpModelToJson(this);

  WantHelpModel copyWith({
    String? adress,
    String? deviceId,
    String? fullName,
    String? phoneNumber,
    GeoPoint? location,
  }) {
    return WantHelpModel(
      adress: adress ?? this.adress,
      deviceId: deviceId ?? this.deviceId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
    );
  }

  static GeoPoint? _geoPointConvertJson(GeoPoint? geoPoint) {
    return geoPoint;
  }
}
