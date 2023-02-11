import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class FirebaseTimeParser {
  const FirebaseTimeParser._();
  static DateTime? datetimeFromTimestamp(Timestamp? timestamp) {
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch)
        : null;
  }

  static Timestamp? dateTimeToTimestamp(DateTime? datetime) {
    return datetime != null ? Timestamp.fromDate(datetime) : null;
  }
}
