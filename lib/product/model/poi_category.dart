import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';

part 'poi_category.g.dart';

@JsonSerializable()
class PoiCategory with ProductDropDownModel, EquatableMixin {
  PoiCategory({
    required this.name,
    this.id,
    this.categoryType,
  });
  factory PoiCategory.fromJson(Map<String, dynamic> json) =>
      _$PoiCategoryFromJson(json);
  factory PoiCategory.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) throw Exception('Data is null');
    return PoiCategory.fromJson(data).copyWith(id: snapshot.id);
  }

  final String? id;
  @override
  final String? name;
  final String? categoryType;

  PoiCategory fromJson(Map<String, dynamic> json) {
    return _$PoiCategoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PoiCategoryToJson(this);
  }

  PoiCategory copyWith({
    String? id,
    String? name,
    String? categoryType,
  }) {
    return PoiCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryType: categoryType ?? this.categoryType,
    );
  }

  @override
  String toString() {
    return 'PoiCategory(id: $id, itemName: $name)';
  }

  @override
  List<Object?> get props => [id, name, categoryType];
}
