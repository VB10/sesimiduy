import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/complete_package.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/builder/responsive_builder.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';

class CompletedDialog extends StatefulWidget {
  const CompletedDialog({super.key});

  @override
  State<CompletedDialog> createState() => _CompletedDialogState();
}

class _CompletedDialogState extends State<CompletedDialog>
    with CompletedDialogMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const PagePadding.all(),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        onChanged: () {
          _activeButtonValue.value = _formKey.currentState?.validate() ?? false;
        },
        child: CompleteDialogContext(
          child: ResponsiveBuilder(
            builder: (windowSize) {
              return SizedBox(
                width: windowSize.isMobile ? null : context.dynamicWidth(0.3),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _Header(),
                      const _CustomDivider(),
                      const VerticalSpace.standard(),
                      const _NameTextField(),
                      const VerticalSpace.standard(),
                      const _NameArrivedUserTextField(),
                      const VerticalSpace.standard(),
                      const _PhoneField(),
                      const VerticalSpace.standard(),
                      const _PlateTextField(),
                      const VerticalSpace.standard(),
                      const _AddressField(),
                      KvkkCheckBox(autovalidateMode),
                      _ActionButton(
                        formKey: _formKey,
                        activeButtonValue: _activeButtonValue,
                      ),
                      const VerticalSpace.small(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AddressField extends StatelessWidget {
  const _AddressField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: CompleteDialogContext.of(context).addressController,
        validator: (value) => ValidatorItems(value).validateAddress,
        labelText: LocaleKeys.address.tr(),
        isMultiline: true,
        hintText: LocaleKeys.addressHint.tr(),
      ),
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
            LocaleKeys.delivered.tr(),
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.formKey,
    required this.activeButtonValue,
  });
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> activeButtonValue;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: activeButtonValue,
      builder: (
        BuildContext context,
        bool activeState,
        Widget? child,
      ) {
        return Padding(
          padding: const PagePadding.horizontalSymmetric(),
          child: ActiveButton(
            label: LocaleKeys.deliver.tr(),
            onPressed: !activeState
                ? null
                : () {
                    if (formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop<CompletePackage>(
                        CompleteDialogContext.of(context).model,
                      );
                      showInSnackBar(LocaleKeys.wasDelivered.tr(), context);
                    }
                  },
          ),
        );
      },
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

class _PhoneField extends StatelessWidget {
  const _PhoneField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: StringConstants.phoneHint,
        formatters: [InputFormatter.instance.phoneFormatter],
        labelText: LocaleKeys.phoneNumber.tr(),
        validator: (text) => ValidatorItems(text).validatePhoneNumber,
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: CompleteDialogContext.of(context).nameController,
        hintText: LocaleKeys.nameAndSurname.tr(),
        labelText: LocaleKeys.nameAndSurname.tr(),
        validator: (value) => ValidatorItems(value).validateFullName,
      ),
    );
  }
}

class _NameArrivedUserTextField extends StatelessWidget {
  const _NameArrivedUserTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: CompleteDialogContext.of(context).nameArrivedController,
        hintText: LocaleKeys.completeDialog_nameDelivered.tr(),
        labelText: LocaleKeys.completeDialog_nameDelivered.tr(),
        validator: (value) => ValidatorItems(value).validateFullName,
      ),
    );
  }
}

class _PlateTextField extends StatelessWidget {
  const _PlateTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: CompleteDialogContext.of(context).plateController,
        hintText: LocaleKeys.plate.tr(),
        labelText: LocaleKeys.plate.tr(),
        validator: (value) => ValidatorItems(value).validatePlate,
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

mixin CompletedDialogMixin on State<CompletedDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final autovalidateMode = AutovalidateMode.onUserInteraction;

  final ValueNotifier<bool> _activeButtonValue = ValueNotifier(false);
}

class CompleteDialogContext extends InheritedWidget {
  CompleteDialogContext({
    required super.child,
    this.isKVKKRead = false,
    super.key,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameArrivedController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final bool isKVKKRead;

  void dispose() {
    nameController.dispose();
    nameArrivedController.dispose();
    phoneController.dispose();
    plateController.dispose();
    addressController.dispose();
  }

  CompletePackage get model => CompletePackage(
        fullName: nameController.text,
        deliveredFullName: nameArrivedController.text,
        deliveredPhone: phoneController.text,
        deliveredCarPlate: plateController.text,
        deliveredAddress: addressController.text,
      );

  static CompleteDialogContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CompleteDialogContext>();
  }

  static CompleteDialogContext of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No CompleteDialogContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CompleteDialogContext oldWidget) => true;
}
