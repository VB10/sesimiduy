import 'package:flutter/material.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';

class ProductCheckbox extends FormField<bool> {
  ProductCheckbox({
    required Widget title,
    required FormFieldSetter<bool> onSaved,
    required FormFieldValidator<bool> validator,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return ListTile(
              leading: Checkbox(
                value: state.value,
                onChanged: state.didChange,
              ),
              dense: state.hasError,
              horizontalTitleGap: AppConstants.kZero.toDouble(),
              title: title,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? 'Base error',
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  : null,
            );
          },
        );
}
