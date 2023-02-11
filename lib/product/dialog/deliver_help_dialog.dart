// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/city_model.dart';
import 'package:sesimiduy/product/model/delivery_help_form.dart';
import 'package:sesimiduy/product/model/help_type.dart';
import 'package:sesimiduy/product/model/items.dart';
import 'package:sesimiduy/product/model/vehicle_types.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/firebase/collection_enums.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/builder/responsive_builder.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/combo_box/labeled_product_combo_box.dart';
import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_horizontal_spacer.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';

import 'package:sesimiduy/product/widget/checkbox/kvkk_checkbox.dart';

class DeliverHelpDialog extends StatefulWidget {
  const DeliverHelpDialog({super.key});

  @override
  State<DeliverHelpDialog> createState() => _DeliverHelpDialogState();
}

class _DeliverHelpDialogState extends State<DeliverHelpDialog>
    with _OperationMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const PagePadding.all(),
      child: Form(
        autovalidateMode: autovalidateMode,
        onChanged: () {
          stateNotifier.value = _formKey.currentState?.validate() ?? false;
        },
        key: _formKey,
        child: ResponsiveBuilder(
          builder: (windowSize) {
            return SizedBox(
              width: windowSize.isMobile ? null : context.dynamicWidth(0.5),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _Header(),
                    const _CustomDivider(),
                    const VerticalSpace.xSmall(),
                    _HelpTypeSelectionRow(
                      _helpType,
                      onChanged: _change,
                    ),
                    const VerticalSpace.standard(),
                    const _SubHeader(),
                    const VerticalSpace.standard(),
                    _NameTextField(
                      _helpType == HelpType.personal,
                      controller: _nameController,
                    ),
                    const VerticalSpace.standard(),
                    _DriverNameField(controller: _driverNameController),
                    const VerticalSpace.standard(),
                    _PhoneField(controller: _phoneController),
                    const VerticalSpace.standard(),
                    _DriverInfos(
                      carPlateNumberController: _carPlateNumberController,
                      vehicleTypeController: _vehicleTypeController,
                    ),
                    const VerticalSpace.standard(),
                    _DestinationInfos(
                      fromController: fromController,
                      toController: toController,
                    ),
                    const VerticalSpace.standard(),
                    _CarriedItems(
                      onChanged: (value) {
                        itemNotifier.value = value;
                      },
                    ),
                    const VerticalSpace.standard(),
                    const _CustomDivider(),
                    const VerticalSpace.standard(),
                    KvkkCheckBox(autovalidateMode),
                    _ActionButton(
                      notifier: itemNotifier,
                      stateNotifier: stateNotifier,
                      onPressed: () async {
                        final request = await returnRequestItem();
                        Navigator.pop<DeliveryHelpForm>(context, request);
                      },
                    ),
                    const VerticalSpace.small(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _change(HelpType type) => setState(() => _helpType = type);
}

class _CarriedItems extends StatelessWidget {
  const _CarriedItems({required this.onChanged});
  final ValueChanged<Items?> onChanged;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CollectionEnums.items.collection
          .withConverter<Items>(
            fromFirestore: (snapshot, options) => Items.fromFirestore(snapshot),
            toFirestore: (value, options) => value.toJson(),
          )
          .get(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Items>> snapshot) =>
          Padding(
        padding: const PagePadding.horizontalSymmetric(),
        child: LabeledProductComboBox<Items>(
          labelText: LocaleKeys.carriedItems.tr(),
          items: snapshot.data?.docs.map((e) => e.data()).toList() ?? [],
          onChanged: onChanged.call,
          hintText: LocaleKeys.youMaySelectMultiple.tr(),
          validator: (text) =>
              ValidateGenericItems<Items>(text).validateDropDown,
        ),
      ),
    );
  }
}

class _DriverInfos extends StatelessWidget {
  const _DriverInfos({
    required this.carPlateNumberController,
    required this.vehicleTypeController,
  });

  final TextEditingController carPlateNumberController;

  final TextEditingController vehicleTypeController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: kIsWeb
          ? Row(
              children: [
                Expanded(
                  child: _VehicleDropDown(
                    controller: vehicleTypeController,
                  ),
                ),
                const HorizontalSpace.standard(),
                Expanded(
                  child: _CarPlateNumberTextField(
                    controller: carPlateNumberController,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                _VehicleDropDown(controller: vehicleTypeController),
                const VerticalSpace.standard(),
                _CarPlateNumberTextField(controller: carPlateNumberController),
              ],
            ),
    );
  }
}

class _DestinationInfos extends StatelessWidget {
  const _DestinationInfos({
    required this.toController,
    required this.fromController,
  });
  final TextEditingController toController;
  final TextEditingController fromController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: kIsWeb
          ? Row(
              children: [
                Expanded(
                  child: _DestinationFromField(controller: fromController),
                ),
                const HorizontalSpace.standard(),
                Expanded(child: _DestinationToField(controller: toController)),
              ],
            )
          : Column(
              children: [
                _DestinationFromField(controller: fromController),
                const VerticalSpace.standard(),
                _DestinationToField(controller: toController),
              ],
            ),
    );
  }
}

class _DestinationFromField extends StatelessWidget {
  const _DestinationFromField({required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return LabeledProductComboBox<CityModel>(
      labelText: LocaleKeys.labelFromCity.tr(),
      items: [
        CityModel('ankara'),
        CityModel('istanbul'),
      ],
      hintText: LocaleKeys.hintPickCity.tr(),
      onChanged: (value) {
        if (value != null) {
          controller.text = value.name;
        }
      },
      validator: (item) =>
          ValidateGenericItems<ProductDropDownModel>(item).validateDropDown,
    );
  }
}

class _DestinationToField extends StatelessWidget {
  const _DestinationToField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return LabeledProductComboBox<CityModel>(
      labelText: LocaleKeys.labelToCity.tr(),
      items: [
        CityModel('ankara'),
        CityModel('istanbul'),
      ],
      hintText: LocaleKeys.hintPickCity.tr(),
      onChanged: (value) {
        if (value != null) {
          controller.text = value.name;
        }
      },
      validator: (item) =>
          ValidateGenericItems<ProductDropDownModel>(item).validateDropDown,
    );
  }
}

class _CarPlateNumberTextField extends StatelessWidget {
  const _CarPlateNumberTextField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return LabeledProductTextField(
      controller: controller,
      labelText: LocaleKeys.labelVehiclePlate.tr(),
      validator: (text) => ValidatorItems(text).validateAddress,
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.notifier,
    required this.stateNotifier,
    required this.onPressed,
  });

  final ValueNotifier<Items?> notifier;
  final ValueNotifier<bool> stateNotifier;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: ValueListenableBuilder(
        valueListenable: stateNotifier,
        builder: (context, stateValue, child) {
          return ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, value, child) => ActiveButton(
              label: LocaleKeys.sendHelp.tr(),
              onPressed: value == null || !stateValue ? null : onPressed,
            ),
          );
        },
      ),
    );
  }
}

class _VehicleDropDown extends StatelessWidget {
  const _VehicleDropDown({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return LabeledProductComboBox<VehicleTypes>(
      labelText: LocaleKeys.labelVehicleType.tr(),
      items: VehicleTypes.values,
      onChanged: (value) {
        controller.text = value?.name ?? VehicleTypes.car.name;
      },
      initialItem: VehicleTypes.car,
      hintText: VehicleTypes.car.title.tr(),
      validator: (item) =>
          ValidateGenericItems<VehicleTypes>(item).validateDropDown,
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller});

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: controller,
        hintText: StringConstants.phoneHint,
        formatters: [InputFormatter.instance.phoneFormatter],
        labelText: LocaleKeys.labelDriverPhone.tr(),
        validator: (text) => ValidatorItems(text).validatePhoneNumber,
      ),
    );
  }
}

class _DriverNameField extends StatelessWidget {
  const _DriverNameField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: controller,
        hintText: LocaleKeys.nameAndSurname.tr(),
        labelText: LocaleKeys.labelDriverName.tr(),
        validator: (text) => ValidatorItems(text).validateFullName,
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField(this.isPersonal, {required this.controller});

  final bool isPersonal;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        controller: controller,
        hintText: LocaleKeys.nameAndSurname.tr(),
        labelText: isPersonal
            ? LocaleKeys.nameAndSurname.tr()
            : LocaleKeys.labelCompanyName.tr(),
        validator: (value) => ValidatorItems(value).validateFullName,
      ),
    );
  }
}

class _HelpTypeSelectionRow extends StatelessWidget {
  const _HelpTypeSelectionRow(this.selection, {required this.onChanged});

  final HelpType selection;
  final ValueChanged<HelpType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SelectionButton(
            label: LocaleKeys.personalHelp.tr(),
            isSelected: selection == HelpType.personal,
            onPressed: () => onChanged(HelpType.personal),
          ),
          const HorizontalSpace.xSmall(),
          _SelectionButton(
            label: LocaleKeys.companyHelp.tr(),
            isSelected: selection == HelpType.business,
            onPressed: () => onChanged(HelpType.business),
          ),
        ],
      ),
    );
  }
}

class _SelectionButton extends StatelessWidget {
  const _SelectionButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const PagePadding.all(),
          side: BorderSide(
            color:
                isSelected ? ColorsCustom.braziliante : ColorsCustom.lightGray,
          ),
        ),
        onPressed: onPressed,
        child: FittedBox(
          child: Text(
            label,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
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
            LocaleKeys.goingtoHelp.tr(),
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

class _SubHeader extends StatelessWidget {
  const _SubHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Text(
        LocaleKeys.hintSubHeader.tr(),
      ),
    );
  }
}

extension DeliverHelpDialogExtension on DeliverHelpDialog {
  Future<T?> show<T>(BuildContext context) {
    return showDialog<T?>(
      context: context,
      builder: (context) => this,
    );
  }
}

mixin _OperationMixin on State<DeliverHelpDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final autovalidateMode = AutovalidateMode.onUserInteraction;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _carPlateNumberController =
      TextEditingController();

  final TextEditingController _vehicleTypeController = TextEditingController();

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  ValueNotifier<Items?> itemNotifier = ValueNotifier(null);
  ValueNotifier<bool> stateNotifier = ValueNotifier(false);
  HelpType _helpType = HelpType.personal;

  @override
  void dispose() {
    _nameController.dispose();
    _driverNameController.dispose();
    _phoneController.dispose();
    _carPlateNumberController.dispose();
    _vehicleTypeController.dispose();
    fromController.dispose();
    toController.dispose();

    super.dispose();
  }

  bool get isCompany => _helpType == HelpType.business;

  Future<DeliveryHelpForm?> returnRequestItem() async {
    if (itemNotifier.value == null) return null;
    final deviceID = await DeviceUtility.instance.getUniqueDeviceId();
    return DeliveryHelpForm(
      deviceId: deviceID,
      madeByCityId: 1,
      madeByCityName: fromController.text,
      isCompany: isCompany,
      fullName: !isCompany ? _nameController.text : '',
      driverName: _driverNameController.text,
      phoneNumber: _phoneController.text.phoneFormatValue,
      numberPlate: _carPlateNumberController.text,
      carType: _vehicleTypeController.text.isNullOrEmpty
          ? VehicleTypes.car.index
          : VehicleTypes.values
              .firstWhere((e) => e.name == _vehicleTypeController.text)
              .index,
      fromPlace: fromController.text,
      toPlace: toController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      collectItem: itemNotifier.value?.name ?? '',
      collectItemId: itemNotifier.value?.id ?? '',
      companyName: isCompany ? _nameController.text : '',
    );
  }
}
