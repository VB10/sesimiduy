import 'package:cloud_firestore/cloud_firestore.dart';

enum CollectionEnums {
  items;

  CollectionReference<Map<String, dynamic>> get collection {
    return FirebaseFirestore.instance.collection(name);
  }
}
