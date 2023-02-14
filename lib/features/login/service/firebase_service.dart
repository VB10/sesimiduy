import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sesimiduy/product/model/base/base_firebase_model.dart';

import 'package:sesimiduy/product/utility/firebase/collection_enums.dart';

@immutable
class FirebaseService {
  Future<void> set<T extends BaseFirebaseModel>({
    required T model,
    required CollectionEnums path,
  }) async {
    try {
      await path.collection.doc().set(model.toJson());
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
