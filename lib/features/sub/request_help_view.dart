import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';

import 'package:sesimiduy/core/enums/core_locale.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/items.dart';
import 'package:sesimiduy/product/model/request_help_form.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/regex_types.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/firebase/collection_enums.dart';
import 'package:sesimiduy/product/utility/maps/maps_manager.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/checkbox/info_checkbox.dart';
import 'package:sesimiduy/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:sesimiduy/product/widget/dropdown/language_dropdown.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';
import 'package:sesimiduy/product/widget/textfield/items_text_field.dart';

class RequestHelpView extends StatefulWidget {
  const RequestHelpView({super.key});

  @override
  State<RequestHelpView> createState() => _RequestHelpViewState();
}

class _RequestHelpViewState extends State<RequestHelpView>
    with _RequestTextEditingMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.needHelp.tr()),
        backgroundColor: ColorsCustom.sambacus,
        actions: [
          LanguageDropDown(
            value: CoreLocale.fromLocale(context.locale),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                onChanged: () {
                  _activeButtonValue.value =
                      _formKey.currentState?.validate() ?? false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _CustomDivider(),
                    const VerticalSpace.standard(),
                    const _SubHeader(),
                    const VerticalSpace.standard(),
                    _FullNameField(_fullNameController),
                    const VerticalSpace.standard(),
                    _PhoneNumberField(_phoneNumberController),
                    const VerticalSpace.standard(),
                    _AddressField(_addressController),
                    const VerticalSpace.standard(),
                    _NeedsComboBox(
                      onSuggestionChanges: (value) {
                        _items.value = value.toList();
                      },
                    ),
                    const VerticalSpace.standard(),
                    const _CustomDivider(),
                    KvkkCheckBox(_autovalidateMode),
                    InfoCheckBox(_autovalidateMode),
                    const VerticalSpace.standard(),
                    ValueListenableBuilder<bool>(
                      valueListenable: _activeButtonValue,
                      builder: (
                        BuildContext context,
                        bool activeState,
                        Widget? child,
                      ) {
                        return ValueListenableBuilder<List<Items>>(
                          valueListenable: _items,
                          builder: (
                            BuildContext context,
                            List<Items> autoCompleteState,
                            Widget? child,
                          ) {
                            return _ActionButton(
                              onPressed: onComplete,
                              isEnabled:
                                  autoCompleteState.isNotEmpty && activeState,
                            );
                          },
                        );
                      },
                    ),
                    const VerticalSpace.standard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    this.isEnabled = false,
    required this.onPressed,
  });
  final bool isEnabled;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: ActiveButton(
        onPressed: !isEnabled ? null : onPressed.call,
        label: LocaleKeys.askForHelp.tr(),
      ),
    );
  }
}

class _NeedsComboBox extends StatelessWidget {
  const _NeedsComboBox({
    required this.onSuggestionChanges,
  });

  final ValueChanged<List<Items>> onSuggestionChanges;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.hintNameNeed.tr(),
            style: context.textTheme.bodySmall,
          ),
          FutureBuilder(
            future: CollectionEnums.items.collection.withConverter<Items>(
              fromFirestore: (snapshot, options) {
                return Items.fromFirestore(snapshot);
              },
              toFirestore: (value, options) {
                return value.toJson();
              },
            ).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return const SizedBox();
              final data = snapshot.data;

              return ItemsTextField(
                onSelected: onSuggestionChanges,
                needItems: data?.docs.map((e) => e.data()).toList() ?? [],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AddressField extends StatelessWidget {
  const _AddressField(TextEditingController addressController)
      : _addressController = addressController;

  final TextEditingController _addressController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: LocaleKeys.addressHint.tr(),
        labelText: LocaleKeys.address.tr(),
        isMultiline: true,
        controller: _addressController,
        validator: (value) => ValidatorItems(value).validateAddress,
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField(TextEditingController phoneNumberController)
      : _phoneNumberController = phoneNumberController;

  final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: _phoneNumberController,
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
  const _FullNameField(TextEditingController fullNameController)
      : _fullNameController = fullNameController;

  final TextEditingController _fullNameController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: _fullNameController,
        keyboardType: TextInputType.name,
        formatters: [
          FilteringTextInputFormatter.deny(RegExp('[0-9]')),
        ],
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

mixin _RequestTextEditingMixin on State<RequestHelpView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _autovalidateMode = AutovalidateMode.onUserInteraction;

  final ValueNotifier<bool> _activeButtonValue = ValueNotifier(false);
  final ValueNotifier<List<Items>> _items = ValueNotifier([]);
  Items? items;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
  }

  Future<void> onComplete() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_items.value.isEmpty) return;
    final isValid =
        RegexTypes.firstAndLastName.hasMatch(_fullNameController.text);
    if (!isValid) {
      showInSnackBar(
        'LocaleKeys.validation_surname.tr()',
        context,
      );
      return;
    }
    final data = await MapsManager.determinePosition();
    if (!mounted) return;
    showInSnackBar(
      LocaleKeys.helpRequestCreated.tr(),
      context,
    );

    await context.pop<RequestHelpForm>(
      RequestHelpForm(
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text.phoneFormatValue,
        address: _addressController.text,
        categoryId: items?.id ?? '',
        categories: _items.value,
        location: GeoPoint(data.latitude, data.longitude),
        startedDate: DateTime.now(),
        updatedDate: DateTime.now(),
      ),
    );
  }

  void showInSnackBar(String title, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        backgroundColor: ColorsCustom.sambacus,
        showCloseIcon: true,
        closeIconColor: Colors.white,
      ),
    );
  }
}
