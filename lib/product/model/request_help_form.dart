// ignore_for_file: avoid_positional_boolean_parameters

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
    this.isKVKKAccepted,
  );

  final String fullName;
  final String phoneNumber;
  final String address;
  final String categoryId;
  final String? newCategoryName;
  final bool isKVKKAccepted;

  Map<String, dynamic> toJson() => _$RequestHelpFormToJson(this);
}
