import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        fontFamily: 'LINE_Seed_JP',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
