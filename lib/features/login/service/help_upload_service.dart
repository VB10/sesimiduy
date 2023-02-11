import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartal/kartal.dart';

import '../../../product/model/request_help_form.dart';

class HelpUploadService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> createHelpCall({required RequestHelpForm helpForm}) async {
    try {
      var formJson = helpForm.toJson();
      if (helpForm.categoryId.isEmpty &&
          !helpForm.newCategoryName.isNotNullOrNoEmpty) {
        throw Exception('Hata : Kategory ID ve Kategori ismi boş bırakılamaz!');
      }
      if (helpForm.categoryId.isEmpty) {
        var categoryRef = db.collection('items').doc();
        await categoryRef.set({'name': helpForm.newCategoryName});
        formJson['categoryId'] = categoryRef.id;
      }
      var helpCallRef = db.collection('wantHelpTwo').doc();
      await helpCallRef.set(formJson);
      return true;
    } catch (e) {
      return false;
    }
  }
}
