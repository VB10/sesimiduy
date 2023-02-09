import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../Widget/need_list_dropdown.dart';
import '../../Widget/string_text.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: context.paddingHigh,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: context.paddingNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("YARDIM İSTİYORUM"),
                    Icon(
                      Icons.close,
                    )
                  ],
                ),
                const Divider(),
                const Text("Yardımcı ihtiyacı olan kişinin"),
                const CustomInputParameter(
                  labelText: TextString.labelTextName,
                  hintText: TextString.hintNameText,
                ),
                const CustomInputParameter(
                  labelText: TextString.labelTextPhone,
                  hintText: "+09",
                ),
                const CustomInputParameter(
                  labelText: TextString.labelTextAdress,
                  hintText: TextString.hintNameText,
                ),
                const Text(TextString.hintNameNeed),
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
            ),
          ),
        ),
      ),
    );
  }
}

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
            labelText ?? "",
            style: context.textTheme.bodyMedium
                ?.copyWith(color: context.colorScheme.onSurface),
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
                      borderSide:
                          BorderSide(color: context.colorScheme.onSurface)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: context.lowBorderRadius,
                      borderSide:
                          BorderSide(color: context.colorScheme.onSurface)),
                  border: OutlineInputBorder(
                    borderRadius: context.lowBorderRadius,
                    borderSide: BorderSide(
                      color: context.colorScheme.outline,
                      width: context.dynamicWidth(0.1),
                    ),
                  )),
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
