import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/model/delivery_help_form.dart';
import 'package:sesimiduy/product/model/request_help_form.dart';
import 'package:http/http.dart' as http;

class HelpUploadService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> createHelpCall({required RequestHelpForm helpForm}) async {
    try {
      final formJson = helpForm.toJson();
      if (helpForm.categoryId.isEmpty &&
          !helpForm.newCategoryName.isNotNullOrNoEmpty) {
        throw Exception('Hata : Kategory ID ve Kategori ismi boş bırakılamaz!');
      }
      if (helpForm.categoryId.isEmpty) {
        final categoryRef = db.collection('items').doc();
        await categoryRef.set({'name': helpForm.newCategoryName});
        formJson['categoryId'] = categoryRef.id;
      }
      final helpCallRef = db.collection('wantHelpTwo').doc();
      await helpCallRef.set(formJson);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createDeliveryCall({
    required DeliveryHelpForm deliveryForm,
  }) async {
    try {
      final json = deliveryForm.toJson();
      await db.collection('sendHelpTwo').doc().set(json);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> jsonImport() async {
    try {
      var response = await http
          .get(Uri.parse('https://cdn.afetbilgi.com/maps/latest.json'));
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      var currentBaseJsonList = json["map_data"] as List<dynamic>;
      var currentBaseJson = currentBaseJsonList.first as Map<String, dynamic>;
      var currentPoiJsonList = currentBaseJson['data'] as List<dynamic>;
      print('${currentPoiJsonList.length} kayıt yükleniyor.');
      for (var i = 0; i < currentPoiJsonList.length; i++) {
        await db
            .collection('poi_list')
            .doc()
            .set(currentPoiJsonList[i] as Map<String, dynamic>);
        print('${i + 1}/${currentPoiJsonList.length}');
      }
    } catch (e) {
      print(e);
    }
  }
}
