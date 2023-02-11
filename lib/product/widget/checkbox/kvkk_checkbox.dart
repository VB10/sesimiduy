// ignore_for_file: always_put_required_named_parameters_first, inference_failur

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sesimiduy/product/extension/string_lang_extension.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_horizontal_spacer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class KVKKCheckBox extends StatelessWidget {
  const KVKKCheckBox({
    super.key,
    required this.isAccepted,
    required this.onAccepted,
  });
  final bool isAccepted;
  final void Function(bool value) onAccepted;

  @override
  Widget build(BuildContext context) {
    const kvkkURL =
        'https://kvkk.gov.tr/yayinlar/K%C4%B0%C5%9E%C4%B0SEL%20VER%C4%B0LER%C4%B0N%20KORUNMASI%20KANUNU%20VE%20UYGULAMASI.pdf';

    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: isAccepted,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (value) {
                onAccepted(value ?? false);
              },
            ),
          ),
          const HorizontalSpace.xxSmall(),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  text: LocaleKeys.kvkk.locale,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _navigate(context, kvkkURL);
                    },
                  children: [
                    TextSpan(
                      text: LocaleKeys.kvkkReadApproved.locale,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, String kvkkUrl) {
    Navigator.push(
      context,
      // ignore: inference_failure_on_instance_creation
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
            body: SfPdfViewer.network(kvkkUrl),
          );
        },
      ),
    );
  }
}
