// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poi_model.g.dart';

@JsonSerializable()
class Poi with EquatableMixin {
  Poi({
    this.categoryId,
    this.categoryName,
    this.id,
    this.name,
    this.location,
    this.latitude,
    this.longitude,
  });
  factory Poi.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('Data is null');
    }
    final model = Poi.fromJson(data);
    return model.copyWith(
      id: snapshot.id,
      location: GeoPoint(
        double.tryParse(model.latitude ?? '') ?? 0,
        double.tryParse(model.longitude ?? '') ?? 0,
      ),
    );
  }

  factory Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);
  final String? categoryId;
  final String? categoryName;
  final String? id;
  final String? name;
  @JsonKey(fromJson: _geoPointConvertJson, toJson: _geoPointConvertJson)
  final GeoPoint? location;
  final String? latitude;
  final String? longitude;

  static GeoPoint? _geoPointConvertJson(GeoPoint? geoPoint) {
    return geoPoint;
  }

  Poi fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);

  Map<String, dynamic> toJson() => _$PoiToJson(this);

  Poi copyWith({
    String? categoryId,
    String? categoryName,
    String? id,
    String? name,
    GeoPoint? location,
  }) {
    return Poi(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        categoryId,
        categoryName,
        location,
      ];
}
