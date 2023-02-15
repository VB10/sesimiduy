import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/model/delivery_help_form.dart';
import 'package:sesimiduy/product/model/request_help_form.dart';
import 'package:sesimiduy/product/model/want_help_migrate.dart';
import 'package:sesimiduy/product/utility/firebase/collection_enums.dart';
import 'package:http/http.dart' as http;

class HelpUploadService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> createHelpCall({required RequestHelpForm helpForm}) async {
    if (helpForm.categories.isNullOrEmpty) {
      throw Exception('Category is empty');
    }

    final helpCallRef = CollectionEnums.wantHelp.collection.doc();
    await helpCallRef.set(helpForm.toJson());

    final wantHelpItemDoc = CollectionEnums.wantHelpItems.collection.doc();

    await Future.wait(
      helpForm.categories.map((e) {
        return wantHelpItemDoc.set(
          WantHelpMigrate(
            itemId: e.id,
            wantHelpId: helpCallRef.id,
          ).toJson(),
        );
      }),
    );

    return true;
  }

  Future<bool> createDeliveryCall(
      {required DeliveryHelpForm deliveryForm, List<String>? itemList}) async {
    try {
      final json = deliveryForm.toJson();
      final List<String> itemUrls = [];
      for (var i = 0; i < (itemList?.length ?? 0); i++) {
        var response = await db
            .collection('items')
            .where('name', isEqualTo: itemList![i])
            .get();
        if (response.size > 0) {
          itemUrls.add(response.docs.first.id);
        } else {
          var itemRef = db.collection('items').doc();
          await itemRef.set({"name": itemList[i]});
          itemUrls.add(itemRef.id);
        }
      }
      await CollectionEnums.sendHelp.collection.doc().set(json);
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
      var json =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      var currentBaseJsonList = json["map_data"] as List<dynamic>;
      print('${currentBaseJsonList.length} kategori bulundu.');
      for (var j = 0; j < currentBaseJsonList.length; j++) {
        print('Kategori $j/${currentBaseJsonList.length}');
        var currentBaseJson = currentBaseJsonList[j] as Map<String, dynamic>;
        var currentBaseCategoryType = currentBaseJson['type'] as String;
        var currentBaseCategoryId = '';
        final categoryResponse = await db
            .collection('poi_category')
            .where('categoryType', isEqualTo: currentBaseCategoryType)
            .get();
        if (categoryResponse.size > 0) {
          currentBaseCategoryId = categoryResponse.docs.first.id;
        } else {
          var newCategoryRef = db.collection('poi_category').doc();
          await newCategoryRef.set({"categoryType": currentBaseCategoryType});
          currentBaseCategoryId = newCategoryRef.id;
        }
        var currentPoiJsonList = currentBaseJson['data'] as List<dynamic>;
        print('${currentPoiJsonList.length} kayıt yükleniyor.');
        for (var i = 0; i < currentPoiJsonList.length; i++) {
          var uploadingData = currentPoiJsonList[i] as Map<String, dynamic>;
          uploadingData['category'] = currentBaseCategoryId;
          await db.collection('poi_list').doc().set(uploadingData);
          print('${i + 1}/${currentPoiJsonList.length}');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
