import 'package:feature_architecture_template/utils/router/router.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
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
