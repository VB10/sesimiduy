import 'dart:async';

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
    final currentSelectedItems = helpForm.categories.toList();
    final addedNewItemList =
        currentSelectedItems.where((element) => element.id.isNullOrEmpty);

    if (addedNewItemList.isNotEmpty) {
      final itemCollection = CollectionEnums.items.collection;
      await Future.forEach(addedNewItemList, (element) async {
        final newCollectionItem = await itemCollection.add(element.toJson());

        final index = currentSelectedItems.indexOf(element);
        if (index < 0) return;
        currentSelectedItems[index] =
            element.copyWith(id: newCollectionItem.id);
      });
    }

    final helpCollection = CollectionEnums.wantHelp.collection;
    final newHelpItem = await helpCollection
        .add(helpForm.copyWith(categories: currentSelectedItems).toJson());

    final wantHelpItemDoc = CollectionEnums.wantHelpItems.collection.doc();

    unawaited(
      Future.wait(
        helpForm.categories.map((e) {
          return wantHelpItemDoc.set(
            WantHelpMigrate(
              itemId: e.id,
              wantHelpId: newHelpItem.id,
            ).toJson(),
          );
        }),
      ),
    );

    return true;
  }

  Future<bool> createDeliveryCall({
    required DeliveryHelpForm deliveryForm,
  }) async {
    final currentSelectedItems = deliveryForm.collectedItems.toList();
    final addedNewItemList =
        currentSelectedItems.where((element) => element.id.isNullOrEmpty);

    if (addedNewItemList.isNotEmpty) {
      final itemCollection = CollectionEnums.items.collection;
      await Future.forEach(addedNewItemList, (element) async {
        final newCollectionItem = await itemCollection.add(element.toJson());

        final index = currentSelectedItems.indexOf(element);
        if (index < 0) return;
        currentSelectedItems[index] =
            element.copyWith(id: newCollectionItem.id);
      });
    }

    final response = await CollectionEnums.sendHelp.collection.add(
      deliveryForm.copyWith(collectedItems: currentSelectedItems).toJson(),
    );
    return response.id.isNotNullOrNoEmpty;
  }
}
