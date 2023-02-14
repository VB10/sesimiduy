// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

enum CollectionEnums {
  items,
  poi_list,
  wantHelp,
  sendHelp,
  poi_category,
  wantHelpItems,
  completeArrived;

  CollectionReference<Map<String, dynamic>> get collection {
    return FirebaseFirestore.instance.collection(name);
  }
}
