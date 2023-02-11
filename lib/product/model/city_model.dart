import 'package:equatable/equatable.dart';
import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';

class CityModel with ProductDropDownModel, EquatableMixin {
  CityModel(this.name);

  @override
  final String name;

  @override
  List<Object?> get props => [name];
}
