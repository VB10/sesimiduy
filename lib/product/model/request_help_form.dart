import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_help_form.g.dart';

@immutable
@JsonSerializable()
class RequestHelpForm {
  const RequestHelpForm(
    this.fullName,
    this.phoneNumber,
    this.address,
    this.categoryId,
    this.newCategoryName,
  );

  final String fullName;
  final String phoneNumber;
  final String address;
  final String categoryId;
  final String? newCategoryName;

  Map<String, dynamic> toJson() => _$RequestHelpFormToJson(this);
}
