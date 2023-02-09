import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/dialog/request_help_dialog.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';

class CustomInputParameter extends StatelessWidget {
  const CustomInputParameter({
    super.key,
    required this.labelText,
    required this.hintText,
  });
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.verticalPaddingLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText ?? '',
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
          ),
          context.emptySizedHeightBoxLow,
          SizedBox(
            height: context.dynamicHeight(0.06),
            child: TextFormField(
              cursorColor: context.colorScheme.onSurface,
              decoration: InputDecoration(
                contentPadding: context.paddingLow,
                enabledBorder: OutlineInputBorder(
                  borderRadius: context.lowBorderRadius,
                  borderSide: BorderSide(color: context.colorScheme.onSurface),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: context.lowBorderRadius,
                  borderSide: BorderSide(color: context.colorScheme.onSurface),
                ),
                border: OutlineInputBorder(
                  borderRadius: context.lowBorderRadius,
                  borderSide: BorderSide(
                    color: context.colorScheme.outline,
                    width: context.dynamicWidth(0.1),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TextString {
  static const labelTextName = 'Adı Soyadı';
  static const hintNameText = 'Adı Soyadı';
  static const labelTextPhone = 'Telefon Numarası';
  static const labelTextAdress = 'Adresi';

  static const hintNamePhone = 'Adı Soyadı';
  static const hintNameAdress = 'Cad.,Mah.,Sokak';
  static const hintNameNeed = 'Neye İhtiyacınız Var?';
}

class CitySelectDropdown extends StatefulWidget {
  CitySelectDropdown({
    super.key,
    this.selectedItems,
    required this.tittleText,
    required this.items,
    required this.onChanged,
  });

  List<String> items = ['Çaşdaşke', 'Celalke', 'Beyzake'];
  final String? selectedItems;
  final String tittleText;

  final void Function(String? model) onChanged;

  @override
  State<CitySelectDropdown> createState() => _CitySelectDropdownState();
}

class _CitySelectDropdownState extends State<CitySelectDropdown> {
  String? _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems;
  }

  @override
  void _changeSelectItems(String? data) {
    // servisten çekildiği zaman model dönen degisikler
    setState(() {
      _selectedItems = data;
    });
    widget.onChanged(data);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedItems,
      onChanged: _changeSelectItems,
      hint: Text(widget.tittleText),
      items: widget.items.map((e) {
        return DropdownMenuItem(value: e, child: Text(e.toString()));
      }).toList(),
    );
  }
}

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
                const RequestHelpDialog().show(context);
              },
              child: const Text('FORM AÇ'),
            )
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
        const Text('Yardımcı ihtiyacı olan kişinin'),
        CustomInputParameter(
          labelText: LocaleKeys.nameAndSurname.tr(),
          hintText: LocaleKeys.nameAndSurname.tr(),
        ),
        CustomInputParameter(
          labelText: LocaleKeys.phoneNumber.tr(),
          hintText: '+09',
        ),
        CustomInputParameter(
          labelText: LocaleKeys.address.tr(),
          hintText: LocaleKeys.hintNameAdress.tr(),
        ),
        Text(LocaleKeys.hintNameNeed.tr()),
        CitySelectDropdown(
          items: const ['ss'],
          onChanged: (String? model) {},
          tittleText: 'Seçiniz',
        ),
        SizedBox(
          width: context.width * 1,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Yardım İste'),
          ),
        )
      ],
    );
  }
}

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key, required this.title, required this.context, required this.content});
  final BuildContext context;
  final Widget content;
  final String title;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: context.textTheme.titleSmall),
          InkWell(
            onTap: () async {
              // context.router.pop();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: widget.content,
    );
  }
}

class AlertDialogManager {
  AlertDialogManager(this.context);
  final BuildContext context;

  void showForm(String title, Widget body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          context: context,
          title: title,
          content: body,
        );
      },
    );
  }
}
