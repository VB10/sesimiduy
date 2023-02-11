import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/model/delivery_help_form.dart';
import 'package:sesimiduy/product/model/request_help_form.dart';
import 'package:sesimiduy/product/model/want_help_migrate.dart';
import 'package:sesimiduy/product/utility/firebase/collection_enums.dart';

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
          ).tojson(),
        );
      }),
    );

    return true;
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
}
