import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sesimiduy/core/enums/core_locale.dart';
import 'package:sesimiduy/core/init/core_localize.dart';
import 'package:sesimiduy/features/login/view/login_view.dart';
import 'package:sesimiduy/firebase_options.dart';
import 'package:sesimiduy/product/app_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final coreLocalize = CoreLocalize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: coreLocalize.supportedItems,
      path: coreLocalize.initialPath,
      startLocale: CoreLocale.tr.locale,
      useOnlyLangCode: true,
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: AppBuilder.build,
      home: const LoginView(),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  //Added because page view was not scrolling via mouse in web
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
