import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items.g.dart';

@JsonSerializable()
class Items {
  Items({this.id, this.name});
  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  factory Items.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('Data is null');
    }
    return Items.fromJson(data).copyWith(id: snapshot.id);
  }

  final String? id;
  final String? name;
  Items fromJson(Map<String, dynamic> json) {
    return _$ItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ItemsToJson(this);
  }

  Items copyWith({
    String? id,
    String? name,
  }) {
    return Items(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
