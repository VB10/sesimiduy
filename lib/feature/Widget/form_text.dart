import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? initialValue;
  final bool? isRequired;
  final void Function(String value)? onChange;
  final String? Function(String?)? validator;
  final Iterable<String>? autoFillHints;
  final bool? enabled;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final TextStyle? labelStyle;
  final InputDecoration? decoration;
  final bool hasInitialSize;
  final size = 10;
  const CustomTextFormField({
    Key? key,
    this.textController,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.maxLines,
    this.initialValue,
    this.isReadOnly = false,
    this.onChange,
    this.isRequired,
    this.onTap,
    this.enabled,
    this.inputFormatters,
    this.autoFillHints,
    this.obscureText = false,
    this.labelStyle,
    this.decoration,
    this.validator,
    this.hasInitialSize = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: context.dynamicHeight(0.08),
      child: TextFormField(
        obscureText: obscureText,
        maxLines: maxLines,
        cursorColor: context.colorScheme.primary,
        keyboardType: keyboardType,
        initialValue: initialValue,
        textCapitalization: TextCapitalization.none,
        onChanged: onChange,
        onTap: onTap,
        enabled: enabled,
        readOnly: isReadOnly,
        inputFormatters: inputFormatters,
        controller: textController,
        autofillHints: autoFillHints ?? [AutofillHints.name],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        style: context.textTheme.titleMedium?.copyWith(
          color: context.colorScheme.secondary,
        ),
        decoration: decoration ?? _buildTextFieldDecoration(context),
      ),
    );
  }

  InputDecoration _buildTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: outlineInputBorder(context),
        disabledBorder: outlineInputBorder(context),
        focusedBorder: outlineInputBorder(context),
        label: labelText != null
            ? Text.rich(TextSpan(
                text: labelText,
                children: [
                  TextSpan(
                      text: "içerik texts",
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.error,
                      ))
                ],
              ))
            : null,
        labelStyle: labelStyle ??
            context.textTheme.titleSmall?.copyWith(
                color: context.appTheme.buttonTheme.colorScheme?.shadow),
        border: outlineInputBorder(context),
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: context.colorScheme.onTertiary,
        ));
  }

  OutlineInputBorder outlineInputBorder(BuildContext context) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: context.colorScheme.outline,
          width: context.dynamicWidth(0.2),
        ),
        borderRadius: context.lowBorderRadius,
      );
}
