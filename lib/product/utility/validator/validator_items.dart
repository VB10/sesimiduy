import 'package:easy_localization/easy_localization.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';

class ValidatorItems<T> {
  const ValidatorItems(this.text);

  static const int phoneLength = 10;

  final String? text;

  String? get validateFullName {
    return text.isNotNullOrNoEmpty ? null : LocaleKeys.validation_fullName.tr();
  }

  String? get validatePhoneNumber {
    return (text?.phoneFormatValue.isNotNullOrNoEmpty ?? false)
        ? null
        : LocaleKeys.validation_phoneNumber.tr();
  }

  String? get validateAdress {
    return text.isNotNullOrNoEmpty ? null : LocaleKeys.validation_address.tr();
  }
}

class ValidatoGenericItems<T> {
  const ValidatoGenericItems(this.item);

  final T? item;

  String? get validateDropDown {
    return item != null ? null : LocaleKeys.validation_needs.tr();
  }
}
