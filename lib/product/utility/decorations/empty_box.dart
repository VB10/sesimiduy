import 'package:flutter/material.dart';

class EmptyBox extends SizedBox {
  const EmptyBox({super.key, super.height, super.width});

  const EmptyBox.smallHeight({super.key}) : super(height: 8);
  const EmptyBox.middleHeight({super.key}) : super(height: 16);
  const EmptyBox.largeHeight({super.key}) : super(height: 24);
}
