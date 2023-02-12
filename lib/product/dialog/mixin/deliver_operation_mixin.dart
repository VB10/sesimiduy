// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/dialog/deliver_help_dialog.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/cities.dart';
import 'package:sesimiduy/product/model/delivery_help_form.dart';
import 'package:sesimiduy/product/model/help_type.dart';
import 'package:sesimiduy/product/model/items.dart';
import 'package:sesimiduy/product/model/vehicle_types.dart';

mixin DeliverOperationMixin on State<DeliverHelpDialog> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final autovalidateMode = AutovalidateMode.onUserInteraction;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController carPlateNumberController =
      TextEditingController();

  final TextEditingController vehicleTypeController = TextEditingController();

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  ValueNotifier<Items?> itemNotifier = ValueNotifier(null);
  ValueNotifier<bool> stateNotifier = ValueNotifier(false);
  HelpType helpType = HelpType.personal;
  List<City> cities = [];
  City? selectedToCity;
  City? selectedFromCity;

  @override
  void initState() {
    super.initState();
    City.fromAssets().then((value) {
      setState(() {
        cities = value;
      });
    });
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

  void changeHelpType(HelpType type) => setState(() => helpType = type);
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    stateNotifier.dispose();
    itemNotifier.dispose();
    carPlateNumberController.dispose();
    vehicleTypeController.dispose();
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  bool get isCompany => helpType == HelpType.business;

  Future<DeliveryHelpForm?> returnRequestItem() async {
    if (itemNotifier.value == null) return null;
    final deviceID = await DeviceUtility.instance.getUniqueDeviceId();
    return DeliveryHelpForm(
      deviceId: deviceID,
      madeByCityId: selectedFromCity?.id ?? 0,
      madeByCityName: fromController.text,
      isCompany: isCompany,
      fullName: nameController.text,
      toPlaceId: selectedToCity?.id ?? 0,
      phoneNumber: phoneController.text.phoneFormatValue,
      numberPlate: carPlateNumberController.text,
      carType: vehicleTypeController.text.isNullOrEmpty
          ? VehicleTypes.car.index
          : VehicleTypes.values
              .firstWhere((e) => e.name == vehicleTypeController.text)
              .index,
      fromPlace: selectedFromCity?.name ?? '',
      toPlace: selectedToCity?.name ?? '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      collectItem: itemNotifier.value?.name ?? '',
      collectItemId: itemNotifier.value?.id ?? '',
      companyName: isCompany ? nameController.text : '',
    );
  }
}
