import 'package:json_annotation/json_annotation.dart';
import 'package:sesimiduy/product/utility/firebase/time_parser.dart';

abstract class BaseModel {
  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  DateTime? createdAt = DateTime.now();
  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  DateTime? updatedAt = DateTime.now();
}
