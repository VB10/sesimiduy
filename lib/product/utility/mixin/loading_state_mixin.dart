import 'package:flutter/material.dart';

mixin LoadingState<T extends StatefulWidget> on State<T> {
  bool isLoading = false;
  void changeLoading({bool forceUI = true}) {
    if (!mounted) return;
    isLoading = !isLoading;
    if (!forceUI) return;
    setState(() {});
  }
}
