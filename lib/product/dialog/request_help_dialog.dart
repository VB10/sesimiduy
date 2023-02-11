// ignore_for_file: always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/extension/string_lang_extension.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/items.dart';
import 'package:sesimiduy/product/model/request_help_form.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/firebase/collection_enums.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/builder/responsive_builder.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';

class RequestHelpDialog extends StatefulWidget {
  const RequestHelpDialog({super.key});

  @override
  State<RequestHelpDialog> createState() => _RequestHelpDialogState();
}

class _RequestHelpDialogState extends State<RequestHelpDialog>
    with _RequestTextEditingMixin {
  void onComplete() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_autoCompleteText.value.isEmpty) return;

    context.pop<RequestHelpForm>(
      RequestHelpForm(
        _fullNameController.text,
        _phoneNumberController.text.phoneFormatValue,
        _addressController.text,
        items?.id ?? '',
        _autoCompleteText.value,
        isAccepted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const PagePadding.all(),
      child: ResponsiveBuilder(
        builder: (windowSize) {
          return SizedBox(
            width: windowSize.isMobile ? null : context.dynamicWidth(.5),
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
                    const VerticalSpace.standard(),
                    const _Header(),
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
                      onSelected: (value) {
                        _autoCompleteText.value = value.name ?? '';
                        items = value;
                      },
                      onTextChange: (value) {
                        items = null;
                        _autoCompleteText.value = value;
                      },
                    ),
                    const VerticalSpace.standard(),
                    _kvkkCheckBox(),
                    const VerticalSpace.standard(),
                    const _CustomDivider(),
                    const VerticalSpace.standard(),
                    ValueListenableBuilder<bool>(
                      valueListenable: _activeButtonValue,
                      builder: (
                        BuildContext context,
                        bool activeState,
                        Widget? child,
                      ) {
                        return ValueListenableBuilder<String>(
                          valueListenable: _autoCompleteText,
                          builder: (
                            BuildContext context,
                            String autoCompleteState,
                            Widget? child,
                          ) {
                            return _ActionButton(
                              onPressed: onComplete,
                              isEnabled: autoCompleteState.isNotEmpty &&
                                  activeState &&
                                  isAccepted,
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
          );
        },
      ),
    );
  }

  KVKKCheckBox _kvkkCheckBox() {
    return KVKKCheckBox(
      isAccepted: isAccepted,
      onAccepted: (value) {
        setState(() {
          isAccepted = value;
        });
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({this.isEnabled = false, required this.onPressed});
  final bool isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: ActiveButton(
        onPressed: !isEnabled ? null : onPressed.call,
        label: LocaleKeys.askForHelp.locale,
      ),
    );
  }
}

class _NeedsComboBox extends StatelessWidget {
  const _NeedsComboBox({required this.onSelected, required this.onTextChange});
  final ValueChanged<Items> onSelected;
  final ValueChanged<String> onTextChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.hintNameNeed.locale,
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
              if (snapshot.hasError) {
                return Text(snapshot.data.toString());
              }
              final data = snapshot.data;
              return Autocomplete<Items>(
                onSelected: onSelected.call,
                displayStringForOption: (option) => option.name ?? '',
                optionsBuilder: (textEditingValue) {
                  onTextChange.call(textEditingValue.text);
                  return (data?.docs ?? []).map((e) => e.data()).where(
                        (element) =>
                            element.name?.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase(),
                                ) ??
                            false,
                      );
                },
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
        hintText: LocaleKeys.addressHint.locale,
        labelText: LocaleKeys.address.locale,
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
        labelText: LocaleKeys.phoneNumber.locale,
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
        hintText: LocaleKeys.nameAndSurname.locale,
        labelText: LocaleKeys.nameAndSurname.locale,
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
        LocaleKeys.personNeedsHelp.locale,
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
            LocaleKeys.needHelp.locale,
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

mixin _RequestTextEditingMixin on State<RequestHelpDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final ValueNotifier<bool> _activeButtonValue = ValueNotifier(false);
  final ValueNotifier<String> _autoCompleteText = ValueNotifier('');
  Items? items;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isAccepted = false;

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
  }
}
