import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'manager/app_router.dart';
import 'utility/localization_utils.dart';

part './app_start.dart';

Future<void> main() async {
  final _appStart = _AppStart();
  await _appStart.init();
  runApp(EasyLocalization(
      supportedLocales: LocalizatonLocales.init.supportedLocales,
      path: _appStart
          ._localizationAssetPath, // <-- change the path of the translation files
      fallbackLocale: LocalizatonLocales.init.rawValue,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
