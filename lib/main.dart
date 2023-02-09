import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sesimiduy/core/init/core_localize.dart';
import 'package:sesimiduy/features/login/view/login_view.dart';
import 'package:sesimiduy/product/app_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final coreLocalize = CoreLocalize();

  runApp(
    EasyLocalization(
      supportedLocales: coreLocalize.supportedItems,
      path: coreLocalize.initialPath, // <-- change the path of the translation files
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: AppBuilder.build,
      home: const LoginView(),
    );
  }
}
