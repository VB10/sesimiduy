import 'package:json_annotation/json_annotation.dart';
import 'package:sesimiduy/product/utility/firebase/time_parser.dart';

class BaseModel {
  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
  )
  DateTime? createdAt;
  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
  )
  DateTime? updatedAt;
}
