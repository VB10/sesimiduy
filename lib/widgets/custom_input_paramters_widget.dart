import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

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
