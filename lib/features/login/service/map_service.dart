import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sesimiduy/product/model/poi_category.dart';
import 'package:sesimiduy/product/model/poi_model.dart';
import 'package:sesimiduy/product/model/want_help_model.dart';

class MapService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Set<Poi>> fetchCategoryPOI(PoiCategory category) async {
    try {
      final snapshot = await db
          .collection('poi')
          .where('categoryId', isEqualTo: category.id)
          .get();
      final poi = snapshot.docs.map((e) => Poi.fromJson(e.data())).toSet();
      return poi;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
        return {};
      }
      return {};
    }
  }

  Future<Set<WantHelpModel>> fetchRequestPOIs() async {
    try {
      final snapshot = await db.collection('wantHelpTwo').get();
      final wanteds =
          snapshot.docs.map((e) => WantHelpModel.fromJson(e.data())).toSet();
      return wanteds;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
        return {};
      }
      return {};
    }
  }
}
