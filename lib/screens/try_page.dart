import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../core/init/language/locale_keys.g.dart';
import '../manager/alert_dialog_manager.dart';
import '../widgets/custom_input_paramters_widget.dart';
import '../widgets/need_list_dropdown_widget.dart';

class TryPage extends StatefulWidget {
  const TryPage({super.key});

  @override
  State<TryPage> createState() => _TryPageState();
}

class _TryPageState extends State<TryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.needHelp.tr(),
            ),
            ElevatedButton(
                onPressed: () {
                  AlertDialogManager.instance.showForm(
                    context,
                    LocaleKeys.needHelp.tr(),
                    _formBody(context),
                  );
                },
                child: Text("FORM AÇ"))
          ],
        ),
      ),
    );
  }

  Column _formBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const Text("Yardımcı ihtiyacı olan kişinin"),
        CustomInputParameter(
          labelText: LocaleKeys.nameAndSurname.tr(),
          hintText: LocaleKeys.nameAndSurname.tr(),
        ),
        CustomInputParameter(
          labelText: LocaleKeys.phoneNumber.tr(),
          hintText: "+09",
        ),
        CustomInputParameter(
          labelText: LocaleKeys.address.tr(),
          hintText: LocaleKeys.hintNameAdress.tr(),
        ),
        Text(LocaleKeys.hintNameNeed.tr()),
        CitySelectDropdown(
          items: const ["ss"],
          onChanged: (String? model) {},
          tittleText: "Seçiniz",
        ),
        SizedBox(
            width: context.width * 1,
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Yardım İste")))
      ],
    );
  }
}
