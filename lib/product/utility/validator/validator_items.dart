import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/extension/string_lang_extension.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';

class ValidatorItems {
  const ValidatorItems(this.text);

  static const int phoneLength = 16;

  static const bool kvkk = false;

  final String? text;

  String? get validateFullName {
    return text.isNotNullOrNoEmpty
        ? null
        : LocaleKeys.validation_fullName.locale;
  }

  String? get validatePhoneNumber {
    return (text?.phoneFormatValue.isNotNullOrNoEmpty ?? false) &&
            text!.length == phoneLength
        ? null
        : LocaleKeys.validation_phoneNumber.locale;
  }

  String? get validateAddress {
    return text.isNotNullOrNoEmpty
        ? null
        : LocaleKeys.validation_address.locale;
  }

  String? get validatePlate {
    return text.isNotNullOrNoEmpty ? null : LocaleKeys.validation_plate.locale;
  }
}

class ValidateGenericItems<T> {
  const ValidateGenericItems(this.item);

  final T? item;

  String? get validateDropDown {
    return item != null ? null : LocaleKeys.validation_needs.locale;
  }
}
