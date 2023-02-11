import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';

enum VehicleTypes implements ProductDropDownModel {
  car('Araba'),
  truck('Tır'),
  motorcycle('Motorsiklet');

  final String title;
  const VehicleTypes(this.title);
  @override
  String get name => title;
}

extension VehicleTypesExtension on VehicleTypes {
  int get index => VehicleTypes.values.indexOf(this) + 1;
}
