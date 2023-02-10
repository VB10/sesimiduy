import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/help_type.dart';
import 'package:sesimiduy/product/model/vehicle_types.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/combo_box/labeled_product_combo_box.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_horizontal_spacer.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';

class DeliverHelpDialog extends StatefulWidget {
  const DeliverHelpDialog({super.key});

  @override
  State<DeliverHelpDialog> createState() => _DeliverHelpDialogState();
}

class _DeliverHelpDialogState extends State<DeliverHelpDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  HelpType _helpType = HelpType.personal;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const PagePadding.all(),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
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
              _NameTextField(_helpType == HelpType.personal),
              const VerticalSpace.standard(),
              const _DriverNameField(),
              const VerticalSpace.standard(),
              const _PhoneField(),
              const VerticalSpace.standard(),
              const _VehicleDropDown(),
              const VerticalSpace.standard(),
              const _CustomDivider(),
              const VerticalSpace.standard(),
              const _ActionButton(),
              const VerticalSpace.small(),
            ],
          ),
        ),
      ),
    );
  }

  void _change(HelpType type) {
    setState(() {
      _helpType = type;
    });
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: ActiveButton(
        label: LocaleKeys.sendHelp.tr(),
        onPressed: () {},
      ),
    );
  }
}

class _VehicleDropDown extends StatelessWidget {
  const _VehicleDropDown();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductComboBox<VehicleTypes>(
        labelText: LocaleKeys.labelVehicleType.tr(),
        items: VehicleTypes.values,
        onChanged: (_) {},
        initialItem: VehicleTypes.car,
        hintText: VehicleTypes.car.title.tr(),
        validator: (item) =>
            ValidateGenericItems<VehicleTypes>(item).validateDropDown,
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
        labelText: LocaleKeys.labelDriverPhone.tr(),
        validator: (text) => ValidatorItems(text).validatePhoneNumber,
      ),
    );
  }
}

class _DriverNameField extends StatelessWidget {
  const _DriverNameField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: LocaleKeys.nameAndSurname.tr(),
        labelText: LocaleKeys.labelDriverName.tr(),
        validator: (text) => ValidatorItems(text).validateFullName,
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField(this.isPersonal);

  final bool isPersonal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
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
  Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return this;
      },
    );
  }
}
