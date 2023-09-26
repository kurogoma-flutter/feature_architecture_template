import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'core/router/router.dart';
import 'features/component/color.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: CustomColor.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: CustomColor.transparent,
        highlightColor: CustomColor.transparent,
        splashColor: CustomColor.transparent,
        fontFamily: 'LINE_Seed_JP',
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
