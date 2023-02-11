// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoiCategory _$PoiCategoryFromJson(Map<String, dynamic> json) => PoiCategory(
      name: json['name'] as String?,
      id: json['id'] as String?,
      categoryType: json['categoryType'] as String?,
    );

Map<String, dynamic> _$PoiCategoryToJson(PoiCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryType': instance.categoryType,
    };
