import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';

class NeedsModel with ProductDropDownModel {
  NeedsModel(this.title);

  final String title;

  @override
  String get name => title.toString();
}
