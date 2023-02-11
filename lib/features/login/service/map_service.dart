import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sesimiduy/product/model/poi_category.dart';
import 'package:sesimiduy/product/model/poi_model.dart';
import 'package:sesimiduy/product/model/want_help_model.dart';

import 'package:sesimiduy/product/utility/firebase/collection_enums.dart';

// TODO: try catch
class MapService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Set<Poi>> fetchCategoryPOI(PoiCategory category) async {
    try {
      final snapshot = await _db
          .collection(CollectionEnums.poi_list.name)
          .where('category', isEqualTo: category.id)
          .withConverter<Poi>(
            fromFirestore: (snapshot, options) {
              return Poi.fromFirestore(snapshot);
            },
            toFirestore: (value, options) => value.toJson(),
          )
          .get();
      return snapshot.docs.map((e) => e.data()).toSet();
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
        return {};
      }
      return {};
    }
  }

  Future<List<WantHelpModel>?> fetchUsersWants() async {
    try {
      final snapshot = await _db
          .collection(CollectionEnums.wantHelp.name)
          .withConverter<WantHelpModel>(
            fromFirestore: (snapshot, options) {
              return WantHelpModel.fromFirestore(snapshot);
            },
            toFirestore: (value, options) => value.toJson(),
          )
          .get();

      return snapshot.docs.map((e) => e.data()).toList();
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
    return null;
  }
}
