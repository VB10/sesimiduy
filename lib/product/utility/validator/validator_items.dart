import 'package:easy_localization/easy_localization.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';

class ValidatorItems {
  const ValidatorItems(this.text);

  static const int phoneLength = 16;

  final String? text;

  String? get validateFullName {
    return text.isNotNullOrNoEmpty ? null : LocaleKeys.validation_fullName.tr();
  }

  String? get validatePhoneNumber {
    return (text?.phoneFormatValue.isNotNullOrNoEmpty ?? false) &&
            text!.length == phoneLength
        ? null
        : LocaleKeys.validation_phoneNumber.tr();
  }

  String? get validateAddress {
    return text.isNotNullOrNoEmpty ? null : LocaleKeys.validation_address.tr();
  }
}

class ValidateGenericItems<T> {
  const ValidateGenericItems(this.item);

  final T? item;

  String? get validateDropDown {
    return item != null ? null : LocaleKeys.validation_needs.tr();
  }
}
