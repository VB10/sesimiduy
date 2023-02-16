import 'package:json_annotation/json_annotation.dart';
import 'package:sesimiduy/product/utility/firebase/time_parser.dart';

abstract class BaseModel {
  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? createdAt = DateTime.now();
  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? updatedAt = DateTime.now();
}
