// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sesimiduy/product/model/base/base_firebase_model.dart';
import 'package:sesimiduy/product/model/base/base_model.dart';

import 'package:sesimiduy/product/utility/firebase/time_parser.dart';

part 'complete_package.g.dart';

@JsonSerializable()
class CompletePackage extends BaseModel with EquatableMixin, BaseFirebaseModel {
  CompletePackage({
    required this.fullName,
    required this.deliveredFullName,
    required this.deliveredPhone,
    required this.deliveredAddress,
    required this.deliveredCarPlate,
  });

  final String fullName;
  final String deliveredFullName;
  final String deliveredPhone;
  final String deliveredAddress;
  final String deliveredCarPlate;
  @override
  List<Object> get props {
    return [
      fullName,
      deliveredFullName,
      deliveredPhone,
      deliveredAddress,
      deliveredCarPlate,
    ];
  }

  @override
  Map<String, dynamic> toJson() => _$CompletePackageToJson(this);
}
