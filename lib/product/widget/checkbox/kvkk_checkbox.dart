import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/docs_constants.dart';
import 'package:sesimiduy/product/widget/checkbox/product_checkbox.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class KvkkCheckBox extends StatelessWidget {
  const KvkkCheckBox(this.autovalidateMode, {super.key});
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return ProductCheckbox(
      autovalidateMode: autovalidateMode,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: LocaleKeys.kvkk.tr(),
              style: const TextStyle(
                color: ColorsCustom.sambacus,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _navigate(context);
                },
            ),
            TextSpan(
              text: LocaleKeys.kvkkReadApproved.tr(),
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onSaved: (value) {},
      validator: (value) {
        return value != null && value == true
            ? null
            : LocaleKeys.validation_kvkk.tr();
      },
    );
  }

  void _navigate(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: SfPdfViewer.asset(DocsConstants.kvkk),
          );
        },
      ),
    );
  }
}
