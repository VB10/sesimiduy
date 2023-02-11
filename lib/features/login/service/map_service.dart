import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sesimiduy/product/model/poi_category.dart';
import 'package:sesimiduy/product/model/poi_model.dart';

class MapService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Set<Poi>> fetchPOI(PoiCategory category) async {
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
}
