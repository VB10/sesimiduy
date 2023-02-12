import 'package:flutter/material.dart';

class CustomRectangleBorder extends RoundedRectangleBorder {
  const CustomRectangleBorder({
    super.side = BorderSide.none,
    super.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });
}
