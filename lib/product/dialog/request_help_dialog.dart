import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';

class RequestHelpDialog extends StatelessWidget {
  RequestHelpDialog({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const PagePadding.all(),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SizedBox(height: WidgetSizes.spacingM),
              _Header(),
              _CustomDivider(),
              SizedBox(height: WidgetSizes.spacingM),
              _SubHeader(),
              SizedBox(height: WidgetSizes.spacingM),
              _FullNameField(),
              SizedBox(height: WidgetSizes.spacingM),
              _PhoneNumberField(),
              SizedBox(height: WidgetSizes.spacingM),
              _AddressField(),
              SizedBox(height: WidgetSizes.spacingM),
              _NeedsComboBox(),
              SizedBox(height: WidgetSizes.spacingM),
              _CustomDivider(),
              SizedBox(height: WidgetSizes.spacingM),
              _ActionButton(),
              SizedBox(height: WidgetSizes.spacingM),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: ActiveButton(
        onPressed: () {},
        label: LocaleKeys.askForHelp.tr(),
      ),
    );
  }
}

class _NeedsComboBox extends StatelessWidget {
  const _NeedsComboBox();

  @override
  Widget build(BuildContext context) {
    final list = List.generate(10, (index) => '$index');
    // FirebaseDatabase.instance.ref('items/').get().then((value) {
    //   print('$value');
    // });
    final users = FirebaseFirestore.instance.collection('users').get();

    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: users,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {},
    );
    return const Text('snapshot.data.toString()');

    //   return FutureBuilder(
    //     future: FirebaseDatabase.instance.ref('items').get(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError ||
    //           snapshot.connectionState != ConnectionState.active) {
    //         return Text(snapshot.data.toString());
    //       }

    //       return Padding(
    //         padding: const PagePadding.horizontalSymmetric(),
    //         child: Autocomplete(
    //           onSelected: (option) {},
    //           optionsBuilder: (textEditingValue) {
    //             return list
    //                 .where((element) => element.contains(textEditingValue.text));
    //           },
    //         ),
    //       );
    //     },
    //   );
    //   return Padding(
    //     padding: const PagePadding.horizontalSymmetric(),
    //     child: Autocomplete(
    //       onSelected: (option) {},
    //       optionsBuilder: (textEditingValue) {
    //         return list
    //             .where((element) => element.contains(textEditingValue.text));
    //       },
    //     ),
    //   );
    // }
  }
}

class FirebaseDatabase {}

class _AddressField extends StatelessWidget {
  const _AddressField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: LocaleKeys.addressHint.tr(),
        labelText: LocaleKeys.address.tr(),
        isMultiline: true,
        validator: (value) => ValidatorItems(value).validateAddress,
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: StringConstants.phoneHint,
        formatters: [InputFormatter.instance.phoneFormatter],
        validator: (value) => ValidatorItems(value).validatePhoneNumber,
        keyboardType: TextInputType.phone,
        labelText: LocaleKeys.phoneNumber.tr(),
      ),
    );
  }
}

class _FullNameField extends StatelessWidget {
  const _FullNameField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: LocaleKeys.nameAndSurname.tr(),
        labelText: LocaleKeys.nameAndSurname.tr(),
        validator: (value) => ValidatorItems(value).validateFullName,
      ),
    );
  }
}

class _SubHeader extends StatelessWidget {
  const _SubHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Text(
        LocaleKeys.personNeedsHelp.tr(),
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorsCustom.lightGray,
      thickness: AppConstants.kOne.toDouble(),
      height: AppConstants.kZero.toDouble(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Row(
        children: [
          Text(
            LocaleKeys.needHelp.tr(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.navigation.pop();
            },
            icon: const Icon(Icons.close),
            iconSize: WidgetSizes.spacingXxl,
          )
        ],
      ),
    );
  }
}

extension RequestHelpDialogExtension on RequestHelpDialog {
  Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return this;
      },
    );
  }
}
