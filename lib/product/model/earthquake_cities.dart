import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kartal/kartal.dart';
import 'package:kartal/src/utility/bundle/i_network_model.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';

part 'earthquake_cities.g.dart';

@JsonSerializable()
class EarthquakeCities extends INetworkModel<EarthquakeCities>
    with ProductDropDownModel, EquatableMixin {
  EarthquakeCities({this.id, this.name});

  @JsonKey(name: 'plaka')
  final int? id;
  @override
  @JsonKey(name: 'il_adi')
  final String? name;

  static Future<List<EarthquakeCities>> fromAssets() async {
    final fileItems = await BundleDecoder(FileProductConstants.earthquakeCities)
        .crackBundle<EarthquakeCities, List<EarthquakeCities>>(
      model: EarthquakeCities(),
    );
    return fileItems ?? [];
  }

  @override
  EarthquakeCities fromJson(Map<String, dynamic> json) {
    return _$EarthquakeCitiesFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() => null;

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
